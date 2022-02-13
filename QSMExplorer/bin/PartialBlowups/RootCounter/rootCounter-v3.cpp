// Thread-safe addition to the result
void UpdateCountThreadSafe(std::vector<boost::multiprecision::int128_t> & central,
                                                boost::multiprecision::int128_t & change_clear,
                                                boost::multiprecision::int128_t & change_unclear)
{
    boost::mutex::scoped_lock lock(myGuard);
    central[0] += change_clear;
    central[1] += change_unclear;
    if (display_more_details){
        std::cout << "Worker complete: " << change_clear << " (" << change_unclear << ")\n";
    }
}


// Worker thread for parallel run
void worker(            const std::vector<std::vector<int>> integer_data,
                                const std::vector<std::vector<int>> resolved_edges,
                                const std::vector<std::vector<int>> nodal_edges,
                                const int root,
                                const std::vector<std::vector<std::vector<int>>> graph_stratification,
                                const std::vector<std::vector<int>> outfluxes,
                                const std::vector<bool> lbs,
                                const std::vector<std::vector<int>> partitions,
                                std::vector<boost::multiprecision::int128_t> & sums)
{
    
    // identify data
    std::vector<int> degrees = integer_data[0];
    std::vector<int> genera = integer_data[1];
    std::vector<int> edge_numbers = integer_data[2];
    
    // determine number of local roots
    int number_elliptic_curves = std::count(genera.begin(), genera.end(), 1);
    boost::multiprecision::int128_t number_local_roots = (boost::multiprecision::int128_t) std::pow(root,2*number_elliptic_curves);
    
    // save total number of roots found
    boost::multiprecision::int128_t total_clear = 0;
    boost::multiprecision::int128_t total_unclear = 0;
    
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
                    int number_of_attached_resolved_edges = graph_stratification[currentSnapshot.k][1][j];
                    int remaining_resolved_edges = graph_stratification[currentSnapshot.k][2][j];
                    int min = number_of_attached_resolved_edges;
                    int f_other = currentSnapshot.flux[vertex_number];
                    if (min < number_of_attached_resolved_edges * root - (f_other - remaining_resolved_edges)){
                        min = number_of_attached_resolved_edges * root - (f_other - remaining_resolved_edges);
                    }
                    int max = number_of_attached_resolved_edges * (root-1);
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
                    std::vector<int> number_of_resolved_edges = graph_stratification[currentSnapshot.k][1];
                    for(int j = 0; j < flux_partitions.size(); j++){
                    
                        // create data of new snapshot (in particular the number of subpartitions)
                        boost::multiprecision::int128_t mult = currentSnapshot.mult;
                        std::vector<int> new_flux(currentSnapshot.flux.begin(), currentSnapshot.flux.end());
                        new_flux[currentSnapshot.k] = 0;
                        for (int a = 0; a < n; a++){
                            int index = graph_stratification[currentSnapshot.k][0][a];
                            new_flux[index] = new_flux[index] - (root * graph_stratification[currentSnapshot.k][1][a] - flux_partitions[j][a]);
                            mult = mult * number_partitions(flux_partitions[j][a], number_of_resolved_edges[a], root);
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
            // no action required -> we can increase the counted numbers
            else{
                
                // define variable to quantify is the setup could not be sorted completely
                bool unsorted_setup = false;
                
                // Case 1: We have computed merely a lower bound
                if (lbs[i]){
                    total_unclear = total_unclear + (boost::multiprecision::int128_t) currentSnapshot.mult * number_local_roots;
                    unsorted_setup = true;
                }
                
                // Case 2: We have perse not just a lower bound, but need to be more careful with (g = 1, d = 0).
                if (!lbs[i]){
                    
                    // Count number of bundles for which we identified h0 exactly.
                    boost::multiprecision::int128_t number_roots_with_determined_h0 = 1;
                    for (int j = 0; j < genera.size(); j++){
                        if ((genera[j] == 1) && (degrees[j] == outfluxes[i][j])){
                            number_roots_with_determined_h0 = number_roots_with_determined_h0 * (boost::multiprecision::int128_t) (root * root - 1);
                            unsorted_setup = true;
                        }
                        if ((genera[j] == 1) && (degrees[j] != outfluxes[i][j])){
                            number_roots_with_determined_h0 = number_roots_with_determined_h0 * (boost::multiprecision::int128_t) (root * root);
                        }
                    }
                    
                    // Update the record accordingly
                    total_clear = total_clear + (boost::multiprecision::int128_t) currentSnapshot.mult * number_roots_with_determined_h0;
                    total_unclear += (boost::multiprecision::int128_t) currentSnapshot.mult * (number_local_roots - number_roots_with_determined_h0);
                    
                }
                
                // display unsorted setup
                if (display_unsorted_setups and  unsorted_setup){
                    std::cout << "##################\n";
                    std::cout << "Could not sort the following:\n";
                    print_vector_of_vector("Nodal edges\n", nodal_edges);
                    print_vector("Genera: ", genera);
                    print_vector("Degrees: ", degrees);
                    print_vector("Fluxes: ", outfluxes[i]);
                    print_vector("Partition: ", partitions[i]);
                    std::cout << "##################\n\n";
                }
                
            }
            
        }
        
    }
    
    // Update result
    UpdateCountThreadSafe(sums, total_clear, total_unclear);
    
}



// Count number of root bundles with prescribed number of sections
std::vector<boost::multiprecision::int128_t> parallel_root_counter(
                                const int genus,
                                const std::vector<int> degrees,
                                const std::vector<int> genera,
                                const std::vector<std::vector<int>> resolved_edges,
                                const std::vector<std::vector<int>> nodal_edges,
                                const int root,
                                const std::vector<std::vector<std::vector<int>>> graph_stratification,
                                const std::vector<int> edge_numbers,
                                const int & h0_value,
                                const int & thread_number)
{
  
    // (1) Partition h0
    // (1) Partition h0
    std::vector<std::vector<int>> partitions;
    std::vector<bool> lower_bounds;
    comp_partitions_with_nodes(h0_value, degrees.size(), resolved_edges, nodal_edges, genera, partitions, lower_bounds);
    
    
    // (2) Find fluxes corresponding to partitions
    // (2) Find fluxes corresponding to partitions
    struct flux_data{
        std::vector<int> flux;
    };
    std::vector<std::vector<int>> outfluxes;
    std::vector<bool> lbs;
    std::vector<std::vector<int>> h0_partitions;
    for (int i = 0; i < partitions.size(); i++){
        
        // create stack and first snapshot
        std::stack<flux_data> snapshotStack;
        flux_data currentSnapshot;
        currentSnapshot.flux = {};
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
                if (partitions[i][j] > 0){
                    int f = degrees[j] - root * partitions[i][j];
                    if (genera[j] == 0){
                        f += root;
                    }
                    if ((edge_numbers[j] <= f) && (f <= edge_numbers[j] * (root-1)) && ((degrees[j] - f) % root == 0)){
                        std::vector<int> new_flux = currentSnapshot.flux;
                        new_flux.push_back(f);
                        flux_data newSnapshot;
                        newSnapshot.flux = new_flux;
                        snapshotStack.push(newSnapshot);
                    }
                }
                
                // trivial h0:
                if (partitions[i][j] == 0){
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
                            snapshotStack.push(newSnapshot);
                        }
                    }
                }
            
            }
            // no more fluxes to be set --> add to list of fluxes if the sum of fluxes equals the number of resolved_edges * root (necessary and sufficient for non-zero number of weight assignments)
            else if (std::accumulate(currentSnapshot.flux.begin(),currentSnapshot.flux.end(),0) == root * resolved_edges.size()){
                outfluxes.push_back(currentSnapshot.flux);
                h0_partitions.push_back(partitions[i]);
                lbs.push_back(lower_bounds[i]);
            }
            
        }
    
    }
    
    
    // (3) Split the outfluxes into as many packages as determined by thread_number and start the threads
    // (3) Split the outfluxes into as many packages as determined by thread_number and start the threads
    std::chrono::steady_clock::time_point now = std::chrono::steady_clock::now();
    std::vector<boost::multiprecision::int128_t> sums = {0,0};
    std::vector<std::vector<int>> integer_data;
    integer_data.push_back(degrees);
    integer_data.push_back(genera);
    integer_data.push_back(edge_numbers);
    if (thread_number > 1){
        boost::thread_group threadList;
        int package_size = (int) outfluxes.size()/thread_number;
        if (display_more_details){
            std::cout << "Computing in " << thread_number << " parallel threads (average load: " << package_size << ")...\n";
        }
        for (int i = 0; i < thread_number; i++)
        {
            if (i < thread_number - 1){
                std::vector<std::vector<int>> partial_outfluxes(outfluxes.begin() + i * package_size, outfluxes.begin() + (i+1) * package_size);
                std::vector<bool> partial_lbs(lbs.begin() + i * package_size, lbs.begin() + (i+1) * package_size);
                std::vector<std::vector<int>> partial_h0_partitions(h0_partitions.begin() + i * package_size, h0_partitions.begin() + (i+1) * package_size);
                boost::thread *t = new boost::thread(worker, integer_data, resolved_edges, nodal_edges, root, graph_stratification, partial_outfluxes, partial_lbs, partial_h0_partitions, boost::ref(sums));
                threadList.add_thread(t);
            }
            else{
                std::vector<std::vector<int>> partial_outfluxes(outfluxes.begin() + i * package_size, outfluxes.end());
                std::vector<bool> partial_lbs(lbs.begin() + i * package_size, lbs.end());
                std::vector<std::vector<int>> partial_h0_partitions(h0_partitions.begin() + i * package_size, h0_partitions.end());
                boost::thread *t = new boost::thread(worker, integer_data, resolved_edges, nodal_edges, root, graph_stratification, partial_outfluxes, partial_lbs, partial_h0_partitions, boost::ref(sums));
                threadList.add_thread(t);
            }
        }
        threadList.join_all();
    }
    else if (thread_number == 1){
        if (display_more_details){
            std::cout << "Computing in one thread...\n";
        }
        worker(integer_data, resolved_edges, nodal_edges, root, graph_stratification, outfluxes, lbs, h0_partitions, boost::ref(sums));
    }
    std::chrono::steady_clock::time_point later = std::chrono::steady_clock::now();
    
    
    // (4) inform about the result
    // (4) inform about the result
    if (display_more_details){
        std::cout << "\nTime for run: " << std::chrono::duration_cast<std::chrono::seconds>(later - now).count() << "[s]\n";
        std::cout << "Total clear: " << sums[0] << "\n\n";
        std::cout << "Total unclear: " << sums[1] << "\n\n";
    }
    
    // (5) return the result
    std::vector<boost::multiprecision::int128_t> result = {sums[0], sums[1]};
    return result;
    
}
