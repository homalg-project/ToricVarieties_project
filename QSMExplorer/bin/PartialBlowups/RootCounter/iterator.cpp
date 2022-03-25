// (0) Thread-safe addition to the result
// (0) Thread-safe addition to the result
// (0) Thread-safe addition to the result

void UpdateCountsThreadSafe(std::vector<boost::multiprecision::int128_t> & central,
                                                 const std::vector<boost::multiprecision::int128_t> & changes)
{
    boost::mutex::scoped_lock lock(myGuard2);
    central[0] += (boost::multiprecision::int128_t) (changes[0]);
    central[1] += (boost::multiprecision::int128_t) (changes[1]);
}



// (1) Compute number of root bundles
// (1) Compute number of root bundles
// (1) Compute number of root bundles

void compute_root_bundles(const std::vector<std::vector<int>> & edges,
                                            const std::vector<int> & degrees,
                                            const std::vector<int> & genera,
                                            const int & genus,
                                            const int & root,
                                            const int & h0_value,
                                            const std::vector<int> & positions_no_blowup,
                                            const int number_sub_threads,
                                            std::vector<boost::multiprecision::int128_t> & sums)
{
    
    // Identify nodal_edges and resolved_edges
    std::vector<std::vector<int>> nodal_edges;
    std::vector<std::vector<int>> resolved_edges = edges;
    for (int k = 0; k < positions_no_blowup.size(); k++){
        nodal_edges.push_back(resolved_edges[positions_no_blowup[k]]);
        resolved_edges.erase(resolved_edges.begin()+positions_no_blowup[k]);
    }
    
    // Compute information about the graph formed from the resolved edges, i.e. the one at which we place weights
    std::vector<int> edge_numbers(degrees.size(),0);
    std::vector<std::vector<std::vector<int>>> graph_stratification;
    additional_graph_information(resolved_edges, edge_numbers, graph_stratification);
    
    // Compute number of roots
    int number = 1;
    std::vector<boost::multiprecision::int128_t> results = parallel_root_counter(genus, degrees, genera, resolved_edges, nodal_edges, root, graph_stratification, edge_numbers, h0_value, number);
    
    // Update results
    UpdateCountsThreadSafe(sums, results);
    
}



// (2) Iterate over combinations to compute root bundles
// (2) Iterate over combinations to compute root bundles
// (2) Iterate over combinations to compute root bundles

void runner(const std::vector<std::vector<int>> edges,
                    const std::vector<int> degrees,
                    const std::vector<int> genera,
                    const int genus,
                    const int root,
                    const int h0_value,
                    const std::vector<std::vector<int>> combinations,
                    const int number_sub_threads,
                    std::vector<boost::multiprecision::int128_t> & sums)
{
    
    for (int i = 0; i < combinations.size(); i++){
        compute_root_bundles(edges, degrees, genera, genus, root, h0_value, combinations[i], number_sub_threads, sums);
    }
    
}


// (3) Iterate over partial blowups
// (3) Iterate over partial blowups
// (3) Iterate over partial blowups

void iterator(const std::vector<std::vector<int>> & edges,
                     const std::vector<int> & degrees,
                     const std::vector<int> & genera,
                     const int & genus,
                     const int & root,
                     const int & h0_value,
                     const int & numNodesMin,
                     const int & numNodesMax,
                     const int & total_number_threads,
                     std::vector<boost::multiprecision::int128_t> & results_exact,
                     std::vector<boost::multiprecision::int128_t> & results_lower_bound)
{
    
    // declare variable to capture results
    std::vector<boost::multiprecision::int128_t> sums;

    // snapshot stack
    struct SnapShotStruct{
        std::vector<int> combination;
    };
    
    // Iterate over combination of all partial blowups via stack
    for (int i = numNodesMin; i <= numNodesMax; i++){
        
        // initialize vector to capture all combinations
        std::vector<std::vector<int>> combinations;
        
        // set values to zero
        sums = {boost::multiprecision::int128_t(0),boost::multiprecision::int128_t(0)};
        
        // Initialize stack
        std::stack<SnapShotStruct> snapshotStack;
        SnapShotStruct currentSnapshot;
        currentSnapshot.combination = {};
        snapshotStack.push(currentSnapshot);
        
        // Run...
        while(!snapshotStack.empty())
        {
            
            // pick the top snapshot and delete it from the stack
            currentSnapshot= snapshotStack.top();
            snapshotStack.pop();
            
            // more values to be set
            if (currentSnapshot.combination.size() < i){
                
                if (currentSnapshot.combination.empty()){
                    for (int j = edges.size() - 1; j >= 0; j--){
                        SnapShotStruct newSnapshot;
                        newSnapshot.combination = {j};
                        snapshotStack.push(newSnapshot);
                    }
                }
                else{
                    int current_max = currentSnapshot.combination[currentSnapshot.combination.size() - 1];
                    if (currentSnapshot.combination.back() > 0){
                        for (int j = currentSnapshot.combination.back() - 1; j >=0; j--){
                            std::vector<int> new_combination = currentSnapshot.combination;
                            new_combination.push_back(j);
                            SnapShotStruct newSnapshot;
                            newSnapshot.combination = new_combination;
                            snapshotStack.push(newSnapshot);
                        }
                    }
                }
                
            }
            
            // no more values to be set -> compute roots
            if (currentSnapshot.combination.size() == i){
                combinations.push_back(currentSnapshot.combination);
            }
            
        }
        
        // distribute combinations onto threats
        if (total_number_threads > 1){
            
            // at least as many combinations as threads?
            if (combinations.size() >= total_number_threads){
            
                boost::thread_group threadList;
                int package_size = (int) combinations.size()/total_number_threads;
                int number_sub_threads = 1;
                if (display_more_details){
                    std::cout << "Computing in " << total_number_threads << " parallel threads (average load: " << package_size << ")...\n";
                }
                for (int i = 0; i < total_number_threads; i++)
                {
                    if (i < total_number_threads - 1){
                        std::vector<std::vector<int>> partial_combinations(combinations.begin() + i * package_size, combinations.begin() + (i+1) * package_size);
                        boost::thread *t = new boost::thread(runner, edges, degrees, genera, genus, root, h0_value, partial_combinations, number_sub_threads, boost::ref(sums));
                        threadList.add_thread(t);
                    }
                    else{
                        std::vector<std::vector<int>> partial_combinations(combinations.begin() + i * package_size, combinations.end());
                        boost::thread *t = new boost::thread(runner, edges, degrees, genera, genus, root, h0_value, partial_combinations, number_sub_threads, boost::ref(sums));
                        threadList.add_thread(t);
                    }
                }
                threadList.join_all();
                
            }
            
            // less combinations than threads?
            if (combinations.size() < total_number_threads){
                
                boost::thread_group threadList;
                int package_size = 1;
                int number_sub_threads = std::floor((total_number_threads - combinations.size())/combinations.size());
                if (display_more_details){
                    std::cout << "Computing in " << combinations.size() << " parallel threads (average load: " << package_size << ")...\n";
                }
                for (int i = 0; i < combinations.size(); i++)
                {
                    if (i < combinations.size() - 1){
                        std::vector<std::vector<int>> partial_combinations(combinations.begin() + i * package_size, combinations.begin() + (i+1) * package_size);
                        boost::thread *t = new boost::thread(runner, edges, degrees, genera, genus, root, h0_value, partial_combinations, number_sub_threads, boost::ref(sums));
                        threadList.add_thread(t);
                    }
                    else{
                        std::vector<std::vector<int>> partial_combinations(combinations.begin() + i * package_size, combinations.end());
                        boost::thread *t = new boost::thread(runner, edges, degrees, genera, genus, root, h0_value, partial_combinations, number_sub_threads, boost::ref(sums));
                        threadList.add_thread(t);
                    }
                }
                threadList.join_all();                
                
            }
            
        }
        else if (total_number_threads == 1){
            if (display_more_details){
                std::cout << "Computing in one thread...\n";
            }
            runner(edges, degrees, genera, genus, root, h0_value, combinations, total_number_threads, boost::ref(sums));
        }
        
        // remember result from leaving i-nodes
        results_exact.push_back(sums[0]);
        results_lower_bound.push_back(sums[1]);
        
    }

}
