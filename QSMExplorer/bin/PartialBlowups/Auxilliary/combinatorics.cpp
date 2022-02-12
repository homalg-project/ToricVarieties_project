// (1) Calculate numbers of ways in which we can pick number_of_elements_to_pick from number_of_elements
// (1) Calculate numbers of ways in which we can pick number_of_elements_to_pick from number_of_elements
// (1) Calculate numbers of ways in which we can pick number_of_elements_to_pick from number_of_elements

std::vector<std::vector<int>> get_combinations_of_indices_to_pick(std::size_t number_of_elements_to_pick, std::size_t number_of_elements)
{
    
    // initialize container for result
    std::vector<std::vector<int>> combinations;
    
    // compute the combinations
    if (number_of_elements == number_of_elements_to_pick){
        std::vector<int> v(number_of_elements);
        std::iota(std::begin(v), std::end(v), 0);
        combinations = {v};
    }
    else{
        assert(number_of_elements > number_of_elements_to_pick);
        std::vector<bool> pick_element_n(number_of_elements_to_pick, true);
        pick_element_n.insert(pick_element_n.end(), number_of_elements - number_of_elements_to_pick, 0);        
        do{
            std::vector<int> combination;
            for(int i = 0; i < number_of_elements; ++i){
                if (pick_element_n[i]) combination.push_back(i);
            }
            combinations.push_back(combination);
        } while (std::prev_permutation(pick_element_n.begin(), pick_element_n.end()));
    }
    
    // return result
    return combinations;
    
}


// (2) Compute partitions of an integer N into a sum of n integers with specified minima and maxima.
// (2) Compute partitions of an integer N into a sum of n integers with specified minima and maxima.
// (2) Compute partitions of an integer N into a sum of n integers with specified minima and maxima.

void comp_partitions(
        const int & N,
        const int & n,
        const std::vector<int> & minima,
        const std::vector<int> & maxima,
        std::vector<std::vector<int>> & partitions){
    
    // Only one value to set?
    if(n == 1) {
        if (minima[0] <= N and N <= maxima[0]){
            partitions.push_back({N});
        }
        return;
    }
    
    // Create stack
    struct SnapShotStruct {
        std::vector<int> p;
    };
    std::stack<SnapShotStruct> snapshotStack;
    
    // Add first snapshot
    SnapShotStruct currentSnapshot;
    currentSnapshot.p = {};
    snapshotStack.push(currentSnapshot);
    
    // Run...
    while(!snapshotStack.empty())
    {
        
        // pick the top snapshot and delete it from the stack
        currentSnapshot= snapshotStack.top();
        snapshotStack.pop();
        
        // current sum
        int current_sum = std::accumulate(currentSnapshot.p.begin(), currentSnapshot.p.end(), 0);

        // position at which we add
        int pos = currentSnapshot.p.size();            
        
        // there are at least two more values to be set
        if (pos < n-1){
        
            // Compute min and max for this placement
            int max = maxima[pos];
            if (N - current_sum < max ){
                max = N - current_sum;
            }
            
            // Iterate over these values
            for (int i = minima[pos]; i <= max; i++){
                std::vector<int> new_partition = currentSnapshot.p;
                new_partition.push_back(i);
                SnapShotStruct newSnapshot;
                newSnapshot.p = new_partition;
                snapshotStack.push(newSnapshot);
            }
            
        }
        
        // only one more value to be set
        else if ((pos == n-1) && (minima[pos] <= N - current_sum) && (N - current_sum <= maxima[pos])){
            std::vector<int> new_partition = currentSnapshot.p;
            new_partition.push_back(N - current_sum);
            partitions.push_back(new_partition);
        }
        
    }
    
}


// (3) Compute partitions of an integer N including possible boundary conditions.
// (3) Compute partitions of an integer N including possible boundary conditions.
// (3) Compute partitions of an integer N including possible boundary conditions.

void comp_partitions_without_blowups(
        const int & N,
        const int & n,
        const std::vector<std::vector<int>> no_blowup_edges,
        std::vector<std::vector<int>> & partitions){
        
        // Compute all partitions with "naive" total sum ranging between N and N + no_blowup_edges.size()
        std::vector<std::vector<int>> naive_partitions;
        for (int i = 0; i <= no_blowup_edges.size(); i++){
            comp_partitions(N+i, n, std::vector<int>(n,0), std::vector<int>(n,N+i), naive_partitions);
        }
        
        // Check boundary conditions for each naive partition
        for (int i = 0; i < naive_partitions.size(); i++){
            
            // now take the boundary conditions into account
            int conditions = 0;
            for (int j = 0; j < no_blowup_edges.size(); j++){
                if ((naive_partitions[i][no_blowup_edges[j][0]]>0) || (naive_partitions[i][no_blowup_edges[j][1]]>0)){
                    conditions++;
                }
            }
            
            // check if the total sum matches the desired value
            int total = std::accumulate(naive_partitions[i].begin(), naive_partitions[i].end(), 0);
            if (total - conditions == N){
                partitions.push_back(naive_partitions[i]);
            }
            
        }
        
}


// (4) Compute partitions of an integer N including possible boundary conditions.
// (4) Compute partitions of an integer N including possible boundary conditions.
// (4) Compute partitions of an integer N including possible boundary conditions.

// This works for any tree-like blowup and is used for this particular purpose.
void comp_partitions_with_nodes(const int & N,
                                                    const int & n,
                                                    const std::vector<std::vector<int>> & resolved_edges,
                                                    const std::vector<std::vector<int>> & nodal_edges,
                                                    const std::vector<int> & genera,
                                                    std::vector<std::vector<int>> & partitions,
                                                    std::vector<bool> & lower_bounds)
{
    
    // Compute all partitions wisth "naive" total sum ranging between N and N + nodal_edges.size()
    std::vector<std::vector<int>> naive_partitions;
    for (int i = 0; i <= nodal_edges.size(); i++){
        comp_partitions(N+i, n, std::vector<int>(n,0), std::vector<int>(n,N+i), naive_partitions);
    }
    
    // Check boundary conditions for each naive partition
    for (int i = 0; i < naive_partitions.size(); i++){
        
        // Find degrees corresponding to h0
        std::vector<int> degrees;
        for (int j = 0; j < genera.size(); j++){
            if (naive_partitions[i][j] > 0){
                if (genera[j] == 0){
                    degrees.push_back(naive_partitions[i][j]-1);
                }
                if (genera[j] == 1){
                    degrees.push_back(naive_partitions[i][j]);
                }
            }
            else{
                // On a g = 1 curve, h0 = 0 does not imply that d < 0.
                // Rather, we could also have a non-trivial d = 0 bundle.
                // Since we are currently only computing a lower bound, it should be ok to place -1.
                degrees.push_back(-1);
            }
        }
        
        // Compute h0 and if this is a lower bound
        int h0;
        bool lower_bound;
        h0_from_partial_blowups(degrees, resolved_edges, nodal_edges, genera, false, h0, lower_bound);
        
        // Check if ok and if so add to the list of results
        if (h0 == N){
            partitions.push_back(naive_partitions[i]);
            lower_bounds.push_back(lower_bound);
        }
    
    }
        
}


// (5) Compute number of partitions of an integer f.
// (5) Compute number of partitions of an integer f.
// (5) Compute number of partitions of an integer f.

// Task: Compute number of partitions of an integer f.
// Input: Integer f to be partitioned.
//           Integers r, n.
// Output: The number of partitions of f into a sum of exactly n integers w1, ... wn with 1 <= w1, ..., wn < r.
boost::multiprecision::int128_t number_partitions(
        const int & f,
        const int & n,
        const int & r)
{
    
    // initialize the counter
    boost::multiprecision::int128_t count = (boost::multiprecision::int128_t) 0;
    
    // Only one value to set? Check if we have a partition
    if(n == 1) {
        if ((1<= f)&&(f<r)){
            return (boost::multiprecision::int128_t) 1;
        }
        else{
            return (boost::multiprecision::int128_t) 0;
        }
    }
    
    // Pick values and make recursive call
    for (int i = 1; i < r; i++){
        count = count + number_partitions(f - i, n-1, r);
    }
    
    // return final result
    return count;    
}
