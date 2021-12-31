#include "combinatorics.cpp"


// Thread-safe addition to the result
void UpdateCountThreadSafe(boost::multiprecision::int128_t & central, boost::multiprecision::int128_t & change)
{    
    boost::mutex::scoped_lock lock(myGuard);
    central = central + change;
    if (display_details){
        std::cout << "Worker complete: " << change << "\n";
    }
}


// Worker thread for parallel run
void worker(
                                const std::vector<int> degrees,
                                const std::vector<int> genera,
                                const std::vector<std::vector<int>> edges,
                                const int root,
                                const std::vector<std::vector<std::vector<int>>> graph_stratification,
                                const std::vector<int> edge_numbers,
                                const std::vector<std::vector<int>> outfluxes,
                                const std::vector<std::vector<int>> partitions,
                                boost::multiprecision::int128_t & sum )
{
    
    // save total number of roots found
    boost::multiprecision::int128_t total = 0;
    
    // count weight assignments
    struct comb_data{
        std::vector<int> flux;
        int k;
        boost::multiprecision::int128_t mult;
    };
    for (int i = 0; i < outfluxes.size(); i++){
        
        // create stack
        std::stack<comb_data> snapshotStack;
        
        // add first snapshot
        comb_data currentSnapshot;
        currentSnapshot.flux = outfluxes[i];
        currentSnapshot.k = 0;
        currentSnapshot.mult = (boost::multiprecision::int128_t) 1;
        snapshotStack.push(currentSnapshot);
        
        // Run...
        while(!snapshotStack.empty())
        {
        
            // pick the top snapshot and delete it from the stack
            currentSnapshot= snapshotStack.top();
            snapshotStack.pop();
            
            // action required...
            if (currentSnapshot.k < graph_stratification.size()){
                
                // gather data
                int N = currentSnapshot.flux[currentSnapshot.k];
                int n = graph_stratification[currentSnapshot.k][0].size();
                std::vector<int> minima, maxima;
                for (int j = 0; j < n; j++){
                    int vertex_number = graph_stratification[currentSnapshot.k][0][j];
                    int number_of_attached_edges = graph_stratification[currentSnapshot.k][1][j];
                    int remaining_edges = graph_stratification[currentSnapshot.k][2][j];
                    int min = number_of_attached_edges;
                    int f_other = currentSnapshot.flux[vertex_number];
                    if (min < number_of_attached_edges * root - (f_other - remaining_edges)){
                        min = number_of_attached_edges * root - (f_other - remaining_edges);
                    }
                    int max = number_of_attached_edges * (root-1);
                    minima.push_back(min);
                    maxima.push_back(max);
                }
                
                // compute flux_partitions
                if (N == 0 && n == 0){
                    
                    // all weights set, just increase k
                    comb_data newSnapshot;
                    newSnapshot.flux = currentSnapshot.flux;
                    newSnapshot.mult = currentSnapshot.mult;
                    newSnapshot.k = currentSnapshot.k + 1;
                    snapshotStack.push(newSnapshot);
                    
                }
                else{
                    
                    // not all weights are determined -> iterate over flux_partitions
                    std::vector<std::vector<int>> flux_partitions;
                    comp_partitions(N, n, minima, maxima, flux_partitions);
                
                    // create new snapshots
                    std::vector<int> number_of_edges = graph_stratification[currentSnapshot.k][1];
                    for(int j = 0; j < flux_partitions.size(); j++){
                    
                        // create data of new snapshot (in particular the number of subpartitions)
                        boost::multiprecision::int128_t mult = currentSnapshot.mult;
                        std::vector<int> new_flux(currentSnapshot.flux.begin(), currentSnapshot.flux.end());
                        new_flux[currentSnapshot.k] = 0;
                        for (int a = 0; a < n; a++){
                            int index = graph_stratification[currentSnapshot.k][0][a];
                            new_flux[index] = new_flux[index] - (root * graph_stratification[currentSnapshot.k][1][a] - flux_partitions[j][a]);
                            mult = mult * number_partitions(flux_partitions[j][a], number_of_edges[a], root);
                        }
                    
                        // add snapshot
                        comb_data newSnapshot;
                        newSnapshot.flux = new_flux;
                        newSnapshot.mult = mult;
                        newSnapshot.k = currentSnapshot.k + 1;
                        snapshotStack.push(newSnapshot);
                        
                    }
                    
                }
                
            }
            // no action required -> increase total
            else{
                boost::multiprecision::int128_t mult = currentSnapshot.mult;
                for (int j = 0; j < genera.size(); j++){
                    if ((genera[j] == 1) and (partitions[i][j] == 0)){
                        mult = mult * (boost::multiprecision::int128_t) (root * root - 1);
                    }
                    if ((genera[j] == 1) and (partitions[i][j] > 0)){
                        mult = mult * (boost::multiprecision::int128_t) (root * root);
                    }
                }
                total += mult;
            }
            
        }
        
    }
    
    // Update result
    UpdateCountThreadSafe(sum, total);
    
}



// Count number of root bundles with prescribed number of sections
boost::multiprecision::int128_t parallel_root_counter(
                                const int genus,
                                const std::vector<int> degrees,
                                const std::vector<int> genera,
                                const std::vector<std::vector<int>> edges,
                                const int root,
                                const std::vector<std::vector<std::vector<int>>> graph_stratification,
                                const std::vector<int> edge_numbers,
                                const int & h0_value,
                                const int & thread_number )
{
    
    // check input
    if (thread_number <= 0 or thread_number > 100){
        std::cout << "Corrupted input\n";
        return -1;
    }
    
    // check for degenerate case: h0_min > h0_value
    int total_degree = std::accumulate(degrees.begin(), degrees.end(), 0);
    if ((int)(total_degree/root) - genus + 1 > h0_value){
        return 0;
    }
    
    // check for degenerate case: all degrees negative
    if (std::all_of(degrees.begin(), degrees.end(), [](int j) { return j < 0; })){
        return 0;
    }
    
    // otherwise, check if the input data specifies a suitable number of threads
    if (thread_number <= 0 or thread_number > 100){
        std::cout << "Corrupted input\n";
        return -1;
    }
    
    // (1) Partition h0
    // (1) Partition h0
    std::vector<std::vector<int>> partitions;
    comp_partitions(h0_value, degrees.size(), std::vector<int>(degrees.size(),0), std::vector<int>(degrees.size(),h0_value), partitions);
    

    // (2) Find fluxes corresponding to partitions
    // (2) Find fluxes corresponding to partitions
    struct flux_data{
        std::vector<int> flux;
        std::vector<int> partition;
    };
    std::vector<std::vector<int>> outfluxes;
    std::vector<std::vector<int>> h0_partitions;
    for (int i = 0; i < partitions.size(); i++){
        
        // create stack
        std::stack<flux_data> snapshotStack;
        
        // add first snapshot
        flux_data currentSnapshot;
        currentSnapshot.flux = {};
        currentSnapshot.partition = partitions[i];
        snapshotStack.push(currentSnapshot);
        
        // Run...
        while(!snapshotStack.empty())
        {
        
            // pick the top snapshot and delete it from the stack
            currentSnapshot= snapshotStack.top();
            snapshotStack.pop();
            
            // any fluxes to be set?
            if (currentSnapshot.flux.size() < degrees.size()){
                
                // determine vertex for which we determine the outflux
                int j = currentSnapshot.flux.size();
                
                // non-trivial h0:
                if (currentSnapshot.partition[j] > 0){
                    int f = degrees[j] - root * currentSnapshot.partition[j];
                    if (genera[j] == 0){
                        f += root;
                    }
                    if ((edge_numbers[j] <= f) && (f <= edge_numbers[j] * (root-1)) && ((degrees[j] - f) % root == 0)){
                        std::vector<int> new_flux = currentSnapshot.flux;
                        new_flux.push_back(f);
                        flux_data newSnapshot;
                        newSnapshot.flux = new_flux;
                        newSnapshot.partition = currentSnapshot.partition;
                        snapshotStack.push(newSnapshot);
                    }
                }
                
                // trivial h0:
                if (currentSnapshot.partition[j] == 0){
                    int min_flux = degrees[j];
                    if (genera[j] == 0){
                        min_flux++;
                    }
                    if (min_flux < edge_numbers[j]){
                        min_flux = edge_numbers[j];
                    }
                    for (int k = min_flux; k <= edge_numbers[j]*(root-1); k++){
                        if ((degrees[j] - k) % root == 0){
                            std::vector<int> new_flux = currentSnapshot.flux;
                            new_flux.push_back(k);
                            flux_data newSnapshot;
                            newSnapshot.flux = new_flux;
                            newSnapshot.partition = currentSnapshot.partition;
                            snapshotStack.push(newSnapshot);
                        }
                    }
                }
            
            }
            // no more fluxes to be set --> add to list of fluxes if the sum of fluxes equals the number of edges * root (necessary and sufficient for non-zero number of weight assignments)
            else if (std::accumulate(currentSnapshot.flux.begin(),currentSnapshot.flux.end(),0) == root * edges.size()){
                outfluxes.push_back(currentSnapshot.flux);
                h0_partitions.push_back(currentSnapshot.partition);
            }
            
        }
    
    }
    
    
    // (3) Split the outfluxes into as many packages as determined by thread_number and start the threads
    // (3) Split the outfluxes into as many packages as determined by thread_number and start the threads
    std::chrono::steady_clock::time_point now = std::chrono::steady_clock::now();
    boost::multiprecision::int128_t sum = (boost::multiprecision::int128_t) 0;
    if (thread_number > 1){
        boost::thread_group threadList;
        int package_size = (int) outfluxes.size()/thread_number;
        if (display_details){
            std::cout << "Computing in " << thread_number << " parallel threads (average load: " << package_size << ")...\n";
        }
        for (int i = 0; i < thread_number; i++)
        {
            if (i < thread_number - 1){
                std::vector<std::vector<int>> partial_outfluxes(outfluxes.begin() + i * package_size, outfluxes.begin() + (i+1) * package_size);
                std::vector<std::vector<int>> partial_h0_partitions(h0_partitions.begin() + i * package_size, h0_partitions.begin() + (i+1) * package_size);
                boost::thread *t = new boost::thread(worker, degrees, genera, edges, root, graph_stratification, edge_numbers, partial_outfluxes, partial_h0_partitions, boost::ref(sum));
                threadList.add_thread(t);
            }
            else{
                std::vector<std::vector<int>> partial_outfluxes(outfluxes.begin() + i * package_size, outfluxes.end());
                std::vector<std::vector<int>> partial_h0_partitions(h0_partitions.begin() + i * package_size, h0_partitions.end());
                boost::thread *t = new boost::thread(worker, degrees, genera, edges, root, graph_stratification, edge_numbers, partial_outfluxes, partial_h0_partitions, boost::ref(sum));
                threadList.add_thread(t);
            }
        }
        threadList.join_all();
    }
    else if (thread_number == 1){
        if (display_details){
            std::cout << "Computing in one thread...\n";
        }
        worker(degrees, genera, edges, root, graph_stratification, edge_numbers, outfluxes, h0_partitions, boost::ref(sum));
    }
    std::chrono::steady_clock::time_point later = std::chrono::steady_clock::now();
    
    
    // (4) inform about the result
    // (4) inform about the result
    if (display_details){
        std::cout << "\nTime for run: " << std::chrono::duration_cast<std::chrono::seconds>(later - now).count() << "[s]\n";
        std::cout << "Total: " << sum << "\n\n";
    }
    return sum;
    
}
