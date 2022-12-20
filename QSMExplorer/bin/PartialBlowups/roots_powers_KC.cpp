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

boost::mutex myGuard, myGuard2, myGuard3;
bool display_more_details = false;
bool display_unsorted_setups = false;
std::vector<std::vector<std::vector<int>>> unsorted;

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
    int genus, root, number_threads, h0Min, h0Max, numNodesMin, numNodesMax;
    bool display_details;
    std::string input_string = argv[1];
    parse_simple_input(input_string, degrees, genera, edges, genus, root, number_threads, h0Min, h0Max, numNodesMin, numNodesMax, display_details);
    
    
    // ######################################
    // ##### (2) Consistency check
    // ######################################
    
    consistency_check(genus, genera, degrees, edges, root, h0Min, h0Max, numNodesMin, numNodesMax, number_threads);
    
    // ######################################
    // ##### 3. Compute root bundles
    // ######################################
        
    // count roots in the desired interval
    std::chrono::steady_clock::time_point before = std::chrono::steady_clock::now();
    int lower_bound = (int) (std::accumulate(degrees.begin(),degrees.end(),0)/root) - genus + 1;
    int index = 0;
    boost::multiprecision::int128_t n_exact, n_lower_bound;
    for (int h0_value = 0; h0_value <= h0Max; h0_value++){
        
        // Reset counters
        std::vector<boost::multiprecision::int128_t> results_exact, results_lower_bound;        
        
        // Are we above the lower bound? -> Answer could be non-trivial trivial
        if (h0_value >= lower_bound){
            iterator(edges, degrees, genera, genus, root, h0_value, numNodesMin, numNodesMax, number_threads, results_exact, results_lower_bound);
        }
        
        // Compute the total number of roots found
        n_exact = 0;
        n_lower_bound = 0;
        for (int i = 0; i < results_exact.size(); i++){
            n_exact += results_exact[i];
            n_lower_bound += results_lower_bound[i];
        }
        
        // Is the result non-trivial?
        if ((n_exact != 0) || (n_lower_bound != 0)){
            // Stop loop for improved performance
            // NOTE: This means that no check for "total number of roots found?" will be conducted!
            index = h0_value;
            break;
        }
        
    }
    std::chrono::steady_clock::time_point after = std::chrono::steady_clock::now();
    
    // ######################################
    // ##### 4. Return the result
    // ######################################
    
    return_simple_result(n_exact, n_lower_bound, index, root, genus);
    return 0;
    
}
