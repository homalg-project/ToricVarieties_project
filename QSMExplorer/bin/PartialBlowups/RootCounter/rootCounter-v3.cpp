// Thread-safe addition to the result
void UpdateCountThreadSafe(std::vector<boost::multiprecision::int128_t> & central,
                                                const boost::multiprecision::int128_t & change_clear,
                                                const boost::multiprecision::int128_t & change_unclear)
{
    boost::mutex::scoped_lock lock(myGuard);
    central[0] += change_clear;
    central[1] += change_unclear;
    if (display_more_details){
        std::cout << "Worker complete: " << change_clear << " (" << change_unclear << ")\n";
    }
}


// Thread-safe addition to the list of unsorted setups
void UpdateUnsortedThreadSafe(std::vector<std::vector<std::vector<int>>> & list_unsorted, const std::vector<std::vector<int>> & new_unsorted)
{
    boost::mutex::scoped_lock lock(myGuard3);
    if (std::find(std::begin(list_unsorted), std::end(list_unsorted), new_unsorted) == std::end(list_unsorted)) {    
        list_unsorted.push_back(new_unsorted);
    }
}


// Worker thread for parallel run
void worker(            const std::vector<int> degrees,
                                const std::vector<int> genera,
                                const std::vector<std::vector<int>> nodal_edges,
                                const int root,
                                const std::vector<std::vector<std::vector<int>>> graph_stratification,
                                const std::vector<std::vector<int>> outfluxes,
                                std::vector<boost::multiprecision::int128_t> & sums)
{
    
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
                minima.reserve(degrees.size());
                maxima.reserve(degrees.size());
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
                
                int dummy_h0;
                bool lbs_test;
                h0_on_nodal_curve(degrees, nodal_edges, genera, dummy_h0, lbs_test);
                
                
                // Case 1: We have computed merely a lower bound
                if (lbs_test){
                    total_unclear = total_unclear + (boost::multiprecision::int128_t) currentSnapshot.mult * number_local_roots;
                    unsorted_setup = true;
                }
                
                // Case 2: We have perse not just a lower bound, but need to be more careful with (g = 1, d = 0).
                if (!lbs_test){
                    
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
                
                // save unsorted setup
                if (display_unsorted_setups and unsorted_setup){
                    
                    // (1) Compute the normalized degrees
                    std::vector<int> normalized_degrees;
                    for (int j = 0; j < degrees.size(); j++){
                        if ((degrees[j] - outfluxes[i][j]) % root == 0){
                            normalized_degrees.push_back((int)((degrees[j] - outfluxes[i][j])/root));
                        }
                        else{
                            throw std::invalid_argument( "Something is seriously wrong!" );
                        }
                    }
                                        
                    // (2) Compute the connected components and save them (modulo removal of duplicates)
                    std::vector<std::vector<std::vector<int>>> edges_of_cc;
                    std::vector<std::vector<int>> degs_of_cc, gens_of_cc;
                    find_connected_components(nodal_edges, normalized_degrees, genera, edges_of_cc, degs_of_cc, gens_of_cc);
                    
                    // (3) Check which connected components could be sorted by our algorithms
                    for (int j = 0; j < edges_of_cc.size(); j++){
                        int h0_of_cc;
                        bool exact_result_for_cc;
                        h0_on_nodal_curve(degs_of_cc[j], edges_of_cc[j], gens_of_cc[j], h0_of_cc, exact_result_for_cc);
                        if (exact_result_for_cc){
                            std::vector<std::vector<int>> new_unsorted_setup;
                            new_unsorted_setup.push_back(gens_of_cc[j]);
                            new_unsorted_setup.push_back(degs_of_cc[j]);
                            new_unsorted_setup.push_back({h0_of_cc});
                            for (int k = 0; k < edges_of_cc[j].size(); k++){
                                new_unsorted_setup.push_back(edges_of_cc[j][k]);
                            }
                            UpdateUnsortedThreadSafe(unsorted, new_unsorted_setup);
                        }
                    }
                    
                }
            }
            
        }
        
    }
    
    // Update result
    UpdateCountThreadSafe(sums, total_clear, total_unclear);
    
}



// Count number of root bundles with prescribed number of sections
std::vector<boost::multiprecision::int128_t> parallel_root_counter(
                                const int & genus,
                                const std::vector<int> & degrees,
                                const std::vector<int> & genera,
                                const std::vector<std::vector<int>> & resolved_edges,
                                const std::vector<std::vector<int>> & nodal_edges,
                                const int & root,
                                const std::vector<std::vector<std::vector<int>>> & graph_stratification,
                                const std::vector<int> & edge_numbers,
                                const int & h0_value,
                                const int & thread_number)
{
  
    // (1) Partition h0
    // (1) Partition h0
    std::vector<std::vector<int>> partitions;
    comp_partitions_with_nodes(h0_value, degrees.size(), nodal_edges, genera, partitions);
    
    
    // (2) Find fluxes corresponding to partitions
    // (2) Find fluxes corresponding to partitions
    struct flux_data{
        std::vector<int> flux;
    };
    std::vector<std::vector<int>> outfluxes;
    outfluxes.reserve(partitions.size());
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
            }
            
        }
    
    }
    
    
    // (3) Split the outfluxes into as many packages as determined by thread_number and start the threads
    // (3) Split the outfluxes into as many packages as determined by thread_number and start the threads
    std::chrono::steady_clock::time_point now = std::chrono::steady_clock::now();
    std::vector<boost::multiprecision::int128_t> sums = {0,0};
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
                boost::thread *t = new boost::thread(worker, degrees, genera, nodal_edges, root, graph_stratification, partial_outfluxes, boost::ref(sums));
                threadList.add_thread(t);
            }
            else{
                std::vector<std::vector<int>> partial_outfluxes(outfluxes.begin() + i * package_size, outfluxes.end());
                boost::thread *t = new boost::thread(worker, degrees, genera, nodal_edges, root, graph_stratification, partial_outfluxes, boost::ref(sums));
                threadList.add_thread(t);
            }
        }
        threadList.join_all();
    }
    else if (thread_number == 1){
        if (display_more_details){
            std::cout << "Computing in one thread...\n";
        }
        worker(degrees, genera, nodal_edges, root, graph_stratification, outfluxes, boost::ref(sums));
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
