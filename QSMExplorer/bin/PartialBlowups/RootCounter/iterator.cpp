// (1) Compute number of root bundles
// (1) Compute number of root bundles
// (1) Compute number of root bundles

void compute_root_bundles(const std::vector<std::vector<int>> & edges,
                                            const std::vector<int> & degrees,
                                            const std::vector<int> & genera,
                                            const int & genus,
                                            const int & root,
                                            const int & h0_value, 
                                            const int & number_threads,
                                            const std::vector<int> & positions_no_blowup,
                                            boost::multiprecision::int128_t & sum_exact_result,
                                            boost::multiprecision::int128_t & sum_lower_bound)
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
    std::vector<boost::multiprecision::int128_t> results = parallel_root_counter(genus, degrees, genera, resolved_edges, nodal_edges, root, graph_stratification, edge_numbers, h0_value, number_threads);
    
    // Update results
    sum_exact_result += (boost::multiprecision::int128_t) (results[0]);
    sum_lower_bound += (boost::multiprecision::int128_t) (results[1]);    
    
}


// (2) Iterate over partial blowups
// (2) Iterate over partial blowups
// (2) Iterate over partial blowups

void iterator(const std::vector<std::vector<int>> & edges,
                     const std::vector<int> & degrees,
                     const std::vector<int> & genera,
                     const int & genus,
                     const int & root,
                     const int & h0_value, 
                     const int & number_threads,
                     std::vector<boost::multiprecision::int128_t> & results_exact,
                     std::vector<boost::multiprecision::int128_t> & results_lower_bound)
{
    
    // declare variable to capture results
    boost::multiprecision::int128_t sum_exact_result, sum_lower_bound;

    // snapshot stack
    struct SnapShotStruct{
        std::vector<int> combination;
    };
    
    // Iterate over combination of all partial blowups via stack
    for (int i = 0; i <= edges.size(); i++){
        
        // set values to zero
        sum_exact_result = sum_lower_bound = 0;
        
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
                compute_root_bundles(edges, degrees, genera, genus, root, h0_value, number_threads, currentSnapshot.combination, sum_exact_result, sum_lower_bound);
            }
            
        }
        
        // remember result from leaving i-nodes
        results_exact.push_back(sum_exact_result);
        results_lower_bound.push_back(sum_lower_bound);
        
    }

}
