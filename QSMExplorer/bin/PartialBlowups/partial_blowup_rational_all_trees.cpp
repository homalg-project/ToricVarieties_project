// A program to compute the number of root bundles on certain partial blowups of certain nodal curves

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

#include "Auxilliary/handle_input.cpp"
#include "Auxilliary/compute_graph_information.cpp"
#include "Auxilliary/tree_like_computations.cpp"
#include "Auxilliary/combinatorics.cpp"


// guard for thread-safe operations
boost::mutex myGuard;

// include root counter
bool display_more_details = false;
#include "RationalRootCounter/rootCounter-v2.cpp"

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
    
    std::vector<int> vertices, degrees, genera;
    std::vector<std::vector<int>> edges;
    int number_vertices, genus, root, number_threads, h0Min, h0Max;
    bool display_details;
    std::string input_string = argv[1];
    parse_input(input_string, number_vertices, vertices, degrees, genera, edges, genus, root, number_threads, h0Min, h0Max, display_details);
    
    
    // ######################################
    // ##### (2) Consistency check
    // ######################################
    
    consistency_check(genus, genera, degrees, root, h0Min, h0Max, number_threads);
    
    
    // ######################################
    // ##### 3. Compute additional information
    // ######################################
    
    int b1 = betti_number(edges);
    boost::multiprecision::int128_t geo_mult = (boost::multiprecision::int128_t) (pow(root, b1));
    int lower_bound = (int) (std::accumulate(degrees.begin(),degrees.end(),0)/root) - genus + 1;
    
    

    // ######################################
    // ##### 3. Compute root bundles
    // ######################################
        
    // count roots in the desired interval
    std::vector<std::vector<boost::multiprecision::int128_t>> n_exact, n_lower_bound;
    for (int h0_value = h0Min; h0_value <= h0Max; h0_value++){
        
        // Are we below the lower bound? -> Answer is trivial
        if (h0_value < lower_bound){
            std::vector<boost::multiprecision::int128_t> result(edges.size()+1,0);
            n_exact.push_back(result);
            n_lower_bound.push_back(result);
            continue;
        }
        
        // Initialize variables to capture result
        std::vector<boost::multiprecision::int128_t> results_exact, results_lower_bound;
        
        // Iterate over the number of edges
        for (int i = 0; i <= edges.size(); i++){
            
            // In how many ways can we leave i nodes in the curve?
            std::vector<std::vector<int>> combinations = get_combinations_of_indices_to_pick(i, edges.size());
            
            // Initialize variables to capture result
            boost::multiprecision::int128_t sum_exact_result, sum_lower_bound;
            sum_exact_result = sum_lower_bound = 0;
            
            // Iterate over all possibilities
            for (int j = 0; j < combinations.size(); j++){
                
                // Identify nodal_edges and resolved_edges
                std::vector<int> positions_no_blowup = combinations[j];
                sort(positions_no_blowup.begin(), positions_no_blowup.end(), std::greater<int>());
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
                std::vector<boost::multiprecision::int128_t> results = parallel_root_counter(genus, degrees, resolved_edges, nodal_edges, root, graph_stratification, edge_numbers, h0_value, number_threads);
                
                // Update results
                sum_exact_result += (boost::multiprecision::int128_t) (geo_mult * results[0]);
                sum_lower_bound += (boost::multiprecision::int128_t) (geo_mult * results[1]);
                
            }
            
            // Remember result from leaving exactly i nodes
            results_exact.push_back(sum_exact_result);
            results_lower_bound.push_back(sum_lower_bound);
            
        }
        
        // Remember results
        n_exact.push_back(results_exact);
        n_lower_bound.push_back(results_lower_bound);
        
    }
    
    // print result
    if (display_details){
        
        // print the exact numbers
        std::cout << "\n";
        for (int j = 0; j <= edges.size(); j++){
            std::cout << j << ":\t";
            for (int i = 0; i <= h0Max - h0Min; i++){
                std::cout << n_exact[i][j] << "\t" << n_lower_bound[i][j] << "\t";
            }
            std::cout << "\n";
        }
        
        // print the totals
        boost::multiprecision::int128_t counter;
        std::cout << "Total:\t";
        for (int i = 0; i <= h0Max - h0Min; i++){
            counter = (boost::multiprecision::int128_t) 0;
            for (int j = 0; j <= edges.size(); j++){
                counter += n_exact[i][j];
            }
            std::cout << counter << "\t";
            counter = (boost::multiprecision::int128_t) 0;
            for (int j = 0; j <= edges.size(); j++){
                counter += n_lower_bound[i][j];
            }
            std::cout << counter << "\t";
        }
        std::cout << "\n\n";
        
        // compute the total number of roots
        boost::multiprecision::int128_t total_number_roots = (boost::multiprecision::int128_t) (pow(root, 2 * genus));
        
        // print the percentages
        using LongFloat=boost::multiprecision::cpp_bin_float_quad;
        for (int j = 0; j <= edges.size(); j++){
            std::cout << j << ":\t";
            for (int i = 0; i <= h0Max - h0Min; i++){
                LongFloat r1 = LongFloat(100) * LongFloat(n_exact[i][j]) / LongFloat(total_number_roots);
                LongFloat r2 = LongFloat(100) * LongFloat(n_lower_bound[i][j]) / LongFloat(total_number_roots);
                std::cout << std::setprecision(3) << r1 << "\t" << std::setprecision(3) << r2 << "\t";
            }
            std::cout << "\n";
        }

        // print the totals
        std::cout << "Total:\t";
        LongFloat percentage_counter;
        for (int i = 0; i <= h0Max - h0Min; i++){
            percentage_counter = 0;
            for (int j = 0; j <= edges.size(); j++){
                percentage_counter += LongFloat(100) * LongFloat(n_exact[i][j]) / LongFloat(total_number_roots);
            }
            std::cout << std::setprecision(3) << percentage_counter << "\t";
                        percentage_counter = 0;
            for (int j = 0; j <= edges.size(); j++){
                percentage_counter += LongFloat(100) * LongFloat(n_lower_bound[i][j]) / LongFloat(total_number_roots);
            }
            std::cout << std::setprecision(3) << percentage_counter << "\t";
        }
        std::cout << "\n\n";
    
    }
    
    // set up variables to write to the result file
    std::ofstream ofile;
    std::string full_path = argv[0];
    std::string dir_path = full_path.substr(0, full_path.find_last_of("."));
    
    // save the result to a dummy file next to main.cpp, so gap can read it out and display intermediate process details
    ofile.open( dir_path + "/result.txt" );
    ofile << "[[";
    for (int i = 0; i < n_exact.size(); i ++){
        ofile << "[";
        for (int j = 0; j < n_exact[i].size()-1; j++){
            ofile << n_exact[i][j] << " ,";
        }
        ofile << n_exact[i][n_exact[i].size()-1] << "],\n";
    }
    ofile << "],\n[";
    for (int i = 0; i < n_lower_bound.size(); i ++){
        ofile << "[";
        for (int j = 0; j < n_lower_bound[i].size()-1; j++){
            ofile << n_lower_bound[i][j] << " ,";
        }
        ofile << n_lower_bound[i][n_lower_bound[i].size()-1] << "],\n";
    }
    ofile << "]];";
    ofile.close();
    
    // return success
    return 0;
    
}
