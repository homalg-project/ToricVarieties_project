// (1) Compute partitions of an integer N into a sum of n integers with specified minima and maxima.
// (1) Compute partitions of an integer N into a sum of n integers with specified minima and maxima.
// (1) Compute partitions of an integer N into a sum of n integers with specified minima and maxima.

// Task: Given an integer N, partition it into a sum of n integers w_1,...,w_n. The k-th integer w_n can have values minima[k] <= k <= maxima[k].


#include <unordered_map>
#include <chrono>

// Create a customer Key struct for lookup in our hash table
// define equivalence 
struct customKey {
    int N;
    int n;
    std::vector<int> minima;
    std::vector<int> maxima;

    bool operator==(const customKey &other) const {
        return (N == other.N && n == other.n && minima == other.minima && maxima == other.maxima);
    }
};

// Create a custom key hasher for our table

struct KeyHasher {
    std::size_t operator()(const customKey& k) const {
        using std::size_t;
        using std::hash;
        using std::string;

        std::size_t h1 = std::hash<int>()(k.N);
        std::size_t h2 = std::hash<int>()(k.n);
        std::size_t h3 = k.minima.size();
        std::size_t h4 = k.maxima.size();

        for (auto &i : k.minima) {
            h3 ^= i + 0x9e3779b9 + (h3 << 6) + (h3 >> 2);
        }

        for (auto &i : k.maxima) {
            h4 ^= i + 0x9e3779b9 + (h4 << 6) + (h4 >> 2);
        }

        return h1^h2^h3^h4;

    }
};


// Create our hash table for recording these combinations

std::unordered_map<customKey, std::vector<std::vector<int>>, KeyHasher> hashTable = {};
auto total_time = 0;
auto original_time = 0;
auto hashing_time = 0;
int i = 0;

void comp_partitions(
        const int & N,
        const int & n,
        const std::vector<int> & minima,
        const std::vector<int> & maxima,
        std::vector<std::vector<int>> & partitions){
    

    //createCustomKey

    customKey k;
    k.N = N;
    k.n = n;
    k.minima = minima;
    k.maxima = maxima;
    std::vector<std::vector<int>> part;

    //std::cout << "Time taken for retrieving functions: " << total_time << "\n";
    //std::cout << "Time taken for old functions: " << original_time << "\n";
    //std::cout << "Time taken for hasing functions: " << hashing_time << "\n";
    //std::cout << "Old function ran: " << i << "\n";


    // Only one value to set?
    if(n == 1) {
        if (minima[0] <= N and N <= maxima[0]){
            partitions.push_back({N});
        }
        return;
    } else if (hashTable.count(k) !=0) {
        //auto start = std::chrono::high_resolution_clock::now();
        //std::cout << "\nUsing existing hashtable: " << i;
        //std::cout << "\nSize of hashTable: " << hashTable.size();
        //indicates our key is already in the table, let's fish it out!

        std::vector<std::vector<int>> ret = hashTable[k];
        for (auto i : ret){
            partitions.push_back(i);
        }

        //auto end = std::chrono::high_resolution_clock::now();
        //auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
        //total_time+=(duration.count());

        
        return;

    } else {
        auto startO = std::chrono::high_resolution_clock::now();
        i+=1;
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
                part.push_back(new_partition);

                //auto endO = std::chrono::high_resolution_clock::now();
                //auto durationO = std::chrono::duration_cast<std::chrono::microseconds>(endO - startO);
                //original_time+=(durationO.count());
                

                //add new vectors to hashtable
                //auto start = std::chrono::high_resolution_clock::now();
                
                //std::vector<std::vector<int>> newV = partitions;
                
                hashTable[k] = part;
                //auto end = std::chrono::high_resolution_clock::now();
                //auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
                //hashing_time+=(duration.count());



            }
            
        }
    }

    
}


// (2) Compute partitions of an integer N including possible boundary conditions.
// (2) Compute partitions of an integer N including possible boundary conditions.
// (2) Compute partitions of an integer N including possible boundary conditions.

// This works for any tree-like blowup and is used for this particular purpose.
void comp_partitions_with_nodes(const int & N,
                                                    const int & n,
                                                    const std::vector<std::vector<int>> & resolved_edges,
                                                    const std::vector<std::vector<int>> & nodal_edges,
                                                    const std::vector<int> & genera,
                                                    std::vector<std::vector<int>> & partitions,
                                                    std::vector<bool> & lower_bounds)
{
    
    // Compute all partitions with "naive" total sum ranging between N and N + nodal_edges.size()
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


// (3) Compute number of partitions of an integer f.
// (3) Compute number of partitions of an integer f.
// (3) Compute number of partitions of an integer f.

// Task: Compute the number of partitions of an integer f into n integers w1, ... ,wn with values 1 <= w1, ..., wn < r.
// Careful: THE ORDER DOES MATTER!

boost::multiprecision::int128_t partition_helper(const int & f,
                                                                            const int & n,
                                                                            const int & r,
                                                                            std::vector<std::vector<boost::multiprecision::int128_t>> & memory)
{
    
    // initialize the counter
    boost::multiprecision::int128_t count = (boost::multiprecision::int128_t) 0;
    
    // Valid value for f?
    if (f < 1){
        return 0;
    }
    
    // Valid value for n?
    if (n < 1){
        return 0;
    }
    
    // Only one value to set? Check if we have a partition
    if(n == 1){
        if ((1<= f)&&(f<r)){
            return (boost::multiprecision::int128_t) 1;
        }
        else{
            return (boost::multiprecision::int128_t) 0;
        }
    }
    
    // Pick values and make recursive call
    for (int i = 1; i < r; i++){
        if (1 <= f-i){
            if (memory[f-i][n-1] = -1){
                memory[f-i-1][n-1-1] = partition_helper(f - i, n-1, r, memory);
            }
            count = count + memory[f-i-1][n-1-1];
        }
    }
    
    // return final result
    return count;    
}

boost::multiprecision::int128_t number_partitions(
        const int & f,
        const int & n,
        const int & r)
{
    
    // We recursively compute number_partitions(f-i, n-1, r).
    // This means the first argument can range between 1 and f.
    // The second argument can range between 1 and n.
    // -> At most, we have to perform f * n computations.
    // Cache them to speed up the computation!
    
    // Initialize memory and start computation
    std::vector<std::vector<boost::multiprecision::int128_t>> memory(f, std::vector<boost::multiprecision::int128_t>(n, (boost::multiprecision::int128_t) -1)); 
    return partition_helper(f, n, r, memory);
    
}