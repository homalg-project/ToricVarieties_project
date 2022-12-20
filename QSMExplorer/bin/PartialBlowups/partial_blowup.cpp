// A program to compute the number of root bundles on partial blowups of certain nodal curves

// Include standard functionality
#include <algorithm>
#include <cassert>
#include <chrono>
#include <functional>
#include <fstream>
#include <iostream>
#include <mutex>
#include <numeric>
#include <set>
#include <sstream>
#include <stack>
#include <thread>
#include <vector>

// Include functionality of boost
#include <boost/multiprecision/cpp_int.hpp>
#include <boost/thread/mutex.hpp>
#include <boost/thread/thread.hpp>
#include <boost/multiprecision/cpp_bin_float.hpp>
boost::mutex myGuard, myGuard2, myGuard3;

// Determine how the output looks like
bool display_more_details = false;
bool display_unsorted_setups = true;

// Set up vector to save unsorted setups
std::vector<std::vector<std::vector<int>>> unsorted;

// Include my specialized files
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
    
    std::vector<int> unsorted_degrees, unsorted_genera;
    std::vector<std::vector<int>> edges;
    int genus, root, number_threads, h0Min, h0Max, numNodesMin, numNodesMax;
    bool display_details;
    std::string input_string = argv[1];
    parse_input(input_string, unsorted_degrees, unsorted_genera, edges, genus, root, number_threads, h0Min, h0Max, numNodesMin, numNodesMax, display_details);
    
    
    // ######################################
    // ##### (2) Consistency check
    // ######################################
    
    consistency_check(genus, unsorted_genera, unsorted_degrees, edges, root, h0Min, h0Max, numNodesMin, numNodesMax, number_threads);
    
    
    // ######################################
    // ##### (3) Count root bundles
    // ######################################
    
    // count roots in the desired interval
    std::chrono::steady_clock::time_point before = std::chrono::steady_clock::now();
    int lower_bound = (int) (std::accumulate(unsorted_degrees.begin(),unsorted_degrees.end(),0)/root) - genus + 1;
    std::vector<std::vector<boost::multiprecision::int128_t>> n_exact, n_lower_bound;
    for (int h0_value = h0Min; h0_value <= h0Max; h0_value++){
        
        // Are we below the lower bound? -> Answer is trivial
        if (h0_value < lower_bound){
            std::vector<boost::multiprecision::int128_t> result(numNodesMax - numNodesMin + 1,0);
            n_exact.push_back(result);
            n_lower_bound.push_back(result);
            continue;
        }
        
        // Compute number of root bundles
        std::vector<boost::multiprecision::int128_t> results_exact, results_lower_bound;
        iterator(edges, unsorted_degrees, unsorted_genera, genus, root, h0_value, numNodesMin, numNodesMax, number_threads, results_exact, results_lower_bound);
        n_exact.push_back(results_exact);
        n_lower_bound.push_back(results_lower_bound);
        
    }
    std::chrono::steady_clock::time_point after = std::chrono::steady_clock::now();
    
    
    // ######################################
    // ##### (4) Print out unsorted setups
    // ######################################
    
    std::remove("UnsortedSetups.txt");
    std::ofstream MyFile("UnsortedSetups.txt");
    for (int i = 0; i < unsorted.size(); i++){
        
        // extract the data of the setup
        std::vector<int> unsorted_genera = unsorted[i][0];
        std::vector<int> unsorted_degrees = unsorted[i][1];
        int separate_h0 = unsorted[i][2][0];
        std::vector<std::vector<int>> nodal_edges_of_setup;
        for (int j = 3; j < unsorted[i].size(); j++){
            nodal_edges_of_setup.push_back(unsorted[i][j]);
        }
        
        MyFile << "##################\n";
        MyFile << "Nodal edges: [";
        for (int j = 0; j < nodal_edges_of_setup.size() - 1; j++){
            MyFile << "[" << std::to_string(nodal_edges_of_setup[j][0]) << ", " << std::to_string(nodal_edges_of_setup[j][1]) << "], ";
        }
        MyFile << "[" << std::to_string(nodal_edges_of_setup[nodal_edges_of_setup.size() - 1][0]) << ", " << std::to_string(nodal_edges_of_setup[nodal_edges_of_setup.size() - 1][1]) << "]]\n";
        
        MyFile << "Genera: [";
        for (int j = 0; j < unsorted_genera.size() - 1; j++){
            MyFile << std::to_string(unsorted_genera[j]) << ", ";
        }
        MyFile << std::to_string(unsorted_genera[unsorted_genera.size() - 1]) << "]\n";
        
        MyFile << "Degrees: [";
        for (int j = 0; j < unsorted_degrees.size() - 1; j++){
            MyFile << std::to_string(unsorted_degrees[j]) << ", ";
        }
        MyFile << std::to_string(unsorted_degrees[unsorted_degrees.size() - 1]) << "]\n";
        
        MyFile << "Separate h0: " << std::to_string(separate_h0) << "\n";
        
        MyFile << "##################\n\n";

    }
    MyFile.close();
    
    
    // ######################################
    // ##### (5) Return the result
    // ######################################
    
    return_result(argv[0], n_exact, n_lower_bound, numNodesMax - numNodesMin, numNodesMin, genus, root, h0Min, h0Max, betti_number(edges), before, after, display_details);
    return 0;
    
}
