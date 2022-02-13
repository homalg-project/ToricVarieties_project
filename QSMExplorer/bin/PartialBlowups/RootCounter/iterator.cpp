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
    
    // Iterate over the number of edges
    for (int i = 0; i <= edges.size(); i++){
        
        // In how many ways can we leave i nodes in the curve?
        std::vector<std::vector<int>> combinations;
        get_combinations_of_indices_to_pick(i, edges.size(), combinations);
        
        // Initialize variables to capture result
        boost::multiprecision::int128_t sum_exact_result, sum_lower_bound;
        sum_exact_result = sum_lower_bound = 0;
        
        // Iterate over all possibilities
        for (int j = 0; j < combinations.size(); j++){
            std::vector<int> positions_no_blowup = combinations[j];
            sort(positions_no_blowup.begin(), positions_no_blowup.end(), std::greater<int>());
            compute_root_bundles(edges, degrees, genera, genus, root, h0_value, number_threads, positions_no_blowup, sum_exact_result, sum_lower_bound);
        }
        
        // Remember result from leaving exactly i nodes
        results_exact.push_back(sum_exact_result);
        results_lower_bound.push_back(sum_lower_bound);
        
    }

}
