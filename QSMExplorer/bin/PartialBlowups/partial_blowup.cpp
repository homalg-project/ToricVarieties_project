// A program to compute the number of root bundles on partial blowups of certain nodal curves

#include <algorithm>
#include <cassert>
#include <chrono>
#include <functional>
#include<fstream>
#include<iostream>
#include <mutex>
#include <numeric>
#include <set>
#include <sstream>
#include <stack>
#include <thread>
#include <vector>

#include <boost/multiprecision/cpp_int.hpp>
#include <boost/thread/mutex.hpp>
#include <boost/thread/thread.hpp>
#include <boost/multiprecision/cpp_bin_float.hpp>

boost::mutex myGuard;
bool display_more_details = false;
bool display_unsorted_setups = false;

#include "Auxilliary/print_vectors.cpp"
#include "Auxilliary/handle_input.cpp"
#include "Auxilliary/return_result.cpp"
#include "Auxilliary/compute_graph_information.cpp"
#include "Auxilliary/tree_like_computations.cpp"
#include "Auxilliary/combinatorics.cpp"
#include "RootCounter/rootCounter-v3.cpp"
#include "RootCounter/iterator.cpp"

// Optimizations for speedup
#pragma GCC optimize("Ofast")
#pragma GCC target("avx,avx2,fma")

// The main routine
int main(int argc, char* argv[]) {
    
    
    // ######################################
    // ##### (0) Check if we have the correct number of arguments
    // ######################################
    
    if (argc != 2) {
        std::cout << "Error - number of arguments must be exactly 1 and not " << argc << "\n";
        std::cout << argv[ 0 ] << "\n";
        return 0;
    }
    
    
    // ######################################
    // ##### (1) Parse input
    // ######################################
    
    std::vector<int> degrees, genera;
    std::vector<std::vector<int>> edges;
    int genus, root, number_threads, h0Min, h0Max;
    bool display_details;
    std::string input_string = argv[1];
    parse_input(input_string, degrees, genera, edges, genus, root, number_threads, h0Min, h0Max, display_details);
    
    
    // ######################################
    // ##### (2) Consistency check
    // ######################################
    
    consistency_check(genus, genera, degrees, root, h0Min, h0Max, number_threads);
    
    
    // ######################################
    // ##### 3. Compute root bundles
    // ######################################
        
    // count roots in the desired interval
    std::chrono::steady_clock::time_point before = std::chrono::steady_clock::now();
    int lower_bound = (int) (std::accumulate(degrees.begin(),degrees.end(),0)/root) - genus + 1;
    std::vector<std::vector<boost::multiprecision::int128_t>> n_exact, n_lower_bound;
    for (int h0_value = h0Min; h0_value <= h0Max; h0_value++){
        
        // Are we below the lower bound? -> Answer is trivial
        if (h0_value < lower_bound){
            std::vector<boost::multiprecision::int128_t> result(edges.size()+1,0);
            n_exact.push_back(result);
            n_lower_bound.push_back(result);
            continue;
        }
        
        // Compute number of root bundles
        std::vector<boost::multiprecision::int128_t> results_exact, results_lower_bound;
        iterator(edges, degrees, genera, genus, root, h0_value, number_threads, results_exact, results_lower_bound);
        n_exact.push_back(results_exact);
        n_lower_bound.push_back(results_lower_bound);
        
    }
    std::chrono::steady_clock::time_point after = std::chrono::steady_clock::now();
    
    // ######################################
    // ##### 4. Return the result
    // ######################################
    
    return_result(argv[0], n_exact, n_lower_bound, edges.size(), genus, root, h0Min, h0Max, betti_number(edges), before, after, display_details);
    return 0;
    
}
