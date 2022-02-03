// A program to compute the number of minimal limit roots on full blowups of nodal curves

#include <algorithm>
#include <chrono>
#include <functional>
#include<fstream>
#include<iostream>
#include <mutex>
#include <numeric>
#include <sstream>
#include <stack>
#include <thread>
#include <vector>
#include <boost/multiprecision/cpp_int.hpp>
#include <boost/thread/mutex.hpp>
#include <boost/thread/thread.hpp>
#include <boost/multiprecision/cpp_bin_float.hpp>
#include "compute_graph_information.cpp"
#include "pick_elements.cpp"
#include "betti_number.cpp"

// guard for thread-safe operations
boost::mutex myGuard;

// include root counter
bool display_more_details = false;
#include "rootCounter-v2.cpp"

// Optimizations for speedup
#pragma GCC optimize("Ofast")
#pragma GCC target("avx,avx2,fma")

// The main routine
int main(int argc, char* argv[]) {
    
    // check if we have the correct number of arguments
    if (argc != 2) {
        std::cout << "Error - number of arguments must be exactly 1 and not " << argc << "\n";
        std::cout << argv[ 0 ] << "\n";
        return 0;
    }
    
    // parse input
    std::string myString = argv[1];
    std::stringstream iss( myString );
    std::vector<int> input;
    int number;
    while ( iss >> number ){
        input.push_back( number );
    }
    
    // Required input:
    // (1) vertices (std::vector<int>)
    // (2) degrees (std::vector<int>)
    // (3) genera (std::vector<int>)
    // (4) edges (std::vector<std::vector<int>>)
    // (5) external edges and their weights (std::vector<int>)
    // (6) genus (int)
    // (7) root (int)
    // (8) number of threads (int) - optional
    // (9) h0Min (int)
    // (10) h0_h0Max (int)
    // So expect the following input:
    // { #Vertices, degrees, genera, #Edges, edge-information, genus, root, threads }
    
    
    
    // ###################
    // ##### 1. Read Input #####
    // ###################
    
    // convert the input data accordingly
    int numberVertices = input[ 0 ];
    std::vector<int> vertices;
    std::vector<int> degrees;
    std::vector<int> genera;
    for ( int i = 1; i <= numberVertices; i++ ){
        vertices.push_back( i - 1 );
        degrees.push_back( input[ i ] );
        genera.push_back( input[ i + numberVertices ] );
    }
    int numberEdges = input[ 2 * numberVertices + 1 ];
    std::vector<std::vector<int>> edges;
    for ( int i = 0; i < numberEdges; i ++ ){
        std::vector<int> helper (2);
        int index = 2 + 2 * numberVertices + 2 * i;
        helper[ 0 ] = input[ index ];
        helper[ 1 ] = input[ index + 1 ];
        edges.push_back( helper );
    }
    int numberExternalEdges = input[ 2 * numberVertices + 1 + 1 + 2 * numberEdges ];
    std::vector<int> external_legs;
    std::vector<int> external_weights;
    for ( int i = 0; i < numberExternalEdges; i ++ ){
        int index = 2 * numberVertices + 1 + 1 + 2 * numberEdges + 1 + 2 * i;
        external_legs.push_back( input[ index ] );
        external_weights.push_back( input[ index + 1 ] );
    }
    int genus = input[ 2 * numberVertices + 2 + 2 * numberEdges + 2 * numberExternalEdges + 1 ];
    int root = input[ 2 * numberVertices + 2 + 2 * numberEdges + 2 * numberExternalEdges + 2 ];
    int number_threads = input[ 2 * numberVertices + 2 + 2 * numberEdges + 2 * numberExternalEdges + 3 ];
    int h0Min = input[ 2 * numberVertices + 2 + 2 * numberEdges + 2 * numberExternalEdges + 4 ];
    int h0Max = input[ 2 * numberVertices + 2 + 2 * numberEdges + 2 * numberExternalEdges + 5 ];
    int details = input[ 2 * numberVertices + 2 + 2 * numberEdges + 2 * numberExternalEdges + 6 ];
    bool display_details = false;
    if ( details >= 0 ){
        display_details = true;
    }
    
    // check input data for consistency and correctness
    if (genus < 0){
        if (display_details){
            std::cout << "Genus must not be negative.\n";
        }
        return -1;
    }
    if (root <= 1){
        if (display_details){
            std::cout << "Root must be at least 2.\n";
        }
        return -1;
    }
    if (h0Max < 0){
        if (display_details){
            std::cout << "h0Max must not be negative. Replaced by 0. \n";
        }
        h0Max = 0;
    }
    if (h0Min > h0Max){
        if (display_details){
            std::cout << "h0Min should not be larger than h0Max. Replaced by h0Max = " << h0Max << "\n";
        }
        h0Min = h0Max;
    }
    if (h0Min < 0){
        if (display_details){
            std::cout << "h0Min must not be negative. Replaced by 0\n";
        }
        h0Min = 0;
    }
    
    

    // ################################
    // ##### 2. Compute more information ########
    // ################################
    
    // take the external weights into account and adjust the degrees accordingly
    for (int i = 0; i < external_legs.size(); i++){
        degrees[external_legs[i]] -= external_weights[i];
    }
    
    // compute lower bound and adjust h0Min if necessary
    int lower_bound = (int) (std::accumulate(degrees.begin(),degrees.end(),0)/root) - genus + 1;
    if (h0Min < lower_bound && lower_bound >= 0){
        if (display_details){
            std::cout << "h0Min lower than estimated lower bound. Replaced by " << lower_bound << "\n";
        }
        h0Min = lower_bound;
    }
    
    // compute additional information about the graph
    std::vector<int> edge_numbers(degrees.size(),0);
    std::vector<std::vector<std::vector<int>>> graph_stratification;
    additional_graph_information(edges, edge_numbers, graph_stratification);
    
    // find the number of vertices
    std::vector<int> maxes;
    for (int i = 0; i < edges.size(); i++){
        maxes.push_back(*max_element(std::begin(edges[i]), std::end(edges[i])));
    }
    int v = *max_element(std::begin(maxes), std::end(maxes)) + 1;
    
    // compute the betti number
    int b1 = betti_number(v, edges);
    boost::multiprecision::int128_t geo_mult = (boost::multiprecision::int128_t) (pow(root, b1));
    
    
    

    // #################################
    // ##### 3. Count roots in desired interval #######
    // #################################
        
    // count roots in the desired interval
    std::vector<std::vector<boost::multiprecision::int128_t>> n_clear;
    std::vector<std::vector<boost::multiprecision::int128_t>> n_unclear;
    for (int h0_value = 0; h0_value < h0Min; h0_value++){
        std::vector<boost::multiprecision::int128_t> result(edges.size()+1,0);
        n_clear.push_back(result);
        n_unclear.push_back(result);
    }
    for (int h0_value = h0Min; h0_value <= h0Max; h0_value++){
        
        boost::multiprecision::int128_t total_clear = 0;
        boost::multiprecision::int128_t total_unclear = 0;
        std::vector<boost::multiprecision::int128_t> results_clear;
        std::vector<boost::multiprecision::int128_t> results_unclear;
        
        for (int i = 0; i <= edges.size(); i++){
            
            // identify the number of ways in which we can perform this number of non-blowups
            std::vector<std::vector<int>> combinations = get_combinations_of_indices_to_pick(i, edges.size());
            
            // initialize the number of roots found
            boost::multiprecision::int128_t sum_clear = 0;
            boost::multiprecision::int128_t sum_unclear = 0;
            
            // now iterate over all combinations
            for (int j = 0; j < combinations.size(); j++){
                
                // sort the positions of no blowup in descending order
                std::vector<int> positions_no_blowup = combinations[j];
                sort(positions_no_blowup.begin(), positions_no_blowup.end(), std::greater<int>());
                
                // prepare graph information
                std::vector<std::vector<int>> no_blowup_edges;
                std::vector<std::vector<int>> proper_edges = edges;
                std::vector<int> vertices_neighbouring_node;
                bool bc_clear = true;
                for (int k = 0; k < positions_no_blowup.size(); k++){
                    if ((genera[proper_edges[positions_no_blowup[k]][0]] > 0) || (genera[proper_edges[positions_no_blowup[k]][1]] > 0)){
                        bc_clear = false;
                    }
                    no_blowup_edges.push_back(proper_edges[positions_no_blowup[k]]);
                    vertices_neighbouring_node.push_back(proper_edges[positions_no_blowup[k]][0]);
                    vertices_neighbouring_node.push_back(proper_edges[positions_no_blowup[k]][1]);
                    proper_edges.erase(proper_edges.begin()+positions_no_blowup[k]);
                }
                
                // compute information about the graph
                std::vector<int> edge_numbers(degrees.size(),0);
                std::vector<std::vector<std::vector<int>>> graph_stratification;
                additional_graph_information(proper_edges, edge_numbers, graph_stratification);
                
                // implement restrictive condition on clear/non-clear boundary conditions:
                // only clear if all no-blowup-edges are disjoint
                
                // remove duplicate vertices if necessary
                sort(vertices_neighbouring_node.begin(), vertices_neighbouring_node.end());
                vertices_neighbouring_node.erase(unique(vertices_neighbouring_node.begin(),vertices_neighbouring_node.end() ), vertices_neighbouring_node.end());
                
                // check if any vertex neighbours two or more nodes
                for (int k = 0; k < vertices_neighbouring_node.size(); k++){
                    
                    // it is already known that the boundary conditions are not clear
                    if (bc_clear == false){
                        break;
                    }
                    
                    // otherwise count
                    int counter = 0;
                    for (int l = 0; l < no_blowup_edges.size(); l++){
                        if (no_blowup_edges[l][0] == vertices_neighbouring_node[k]){
                          counter++;
                        }
                        if (no_blowup_edges[l][1] == vertices_neighbouring_node[k]){
                          counter++;
                        }
                        if (counter > 1){
                            bc_clear = false;
                            break;
                        }
                    }
                    
                }
                
                // compute number of roots
                std::vector<boost::multiprecision::int128_t> results = parallel_root_counter(genus, degrees, genera, proper_edges, no_blowup_edges, root, graph_stratification, edge_numbers, h0_value, number_threads);
                
                // are the boundary conditions clear?
                if (bc_clear){
                    sum_clear += (boost::multiprecision::int128_t) (geo_mult * results[0]);
                    sum_unclear += (boost::multiprecision::int128_t) (geo_mult * results[1]);
                }
                else{
                    sum_unclear += (boost::multiprecision::int128_t) (geo_mult * results[0]);
                    sum_unclear += (boost::multiprecision::int128_t) (geo_mult * results[1]);
                }
                
            }
            
            // save the result
            total_clear += sum_clear;
            total_unclear += sum_unclear;
            results_clear.push_back(sum_clear);
            results_unclear.push_back(sum_unclear);
            
        }
        
        // add to results to be passed to gap
        n_clear.push_back(results_clear);
        n_unclear.push_back(results_unclear);
        
    }
    
    // set up variables to write to the result file
    std::ofstream ofile;
    std::string full_path = argv[ 0 ];
    std::string dir_path = full_path.substr(0, full_path.find_last_of("."));
    
    // print result
    if (display_details){
        
        // print the exact numbers
        std::cout << "\n";
        for (int j = 0; j <= edges.size(); j++){
            std::cout << j << ":\t";
            for (int i = h0Min; i <= h0Max; i++){
                std::cout << n_clear[i][j] << "\t" << n_unclear[i][j] << "\t";
            }
            std::cout << "\n";
        }
        
        // print the totals
        boost::multiprecision::int128_t counter;
        std::cout << "Total:\t";
        for (int i = h0Min; i <= h0Max; i++){
            counter = (boost::multiprecision::int128_t) 0;
            for (int j = 0; j <= edges.size(); j++){
                counter += n_clear[i][j];
            }
            std::cout << counter << "\t";
            counter = (boost::multiprecision::int128_t) 0;
            for (int j = 0; j <= edges.size(); j++){
                counter += n_unclear[i][j];
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
            for (int i = h0Min; i <= h0Max; i++){
                LongFloat r1 = LongFloat(100) * LongFloat(n_clear[i][j]) / LongFloat(total_number_roots);
                LongFloat r2 = LongFloat(100) * LongFloat(n_unclear[i][j]) / LongFloat(total_number_roots);
                std::cout << std::setprecision(3) << r1 << "\t" << std::setprecision(3) << r2 << "\t";
            }
            std::cout << "\n";
        }

        // print the totals
        std::cout << "Total:\t";
        LongFloat percentage_counter;
        for (int i = h0Min; i <= h0Max; i++){
            percentage_counter = 0;
            for (int j = 0; j <= edges.size(); j++){
                percentage_counter += LongFloat(100) * LongFloat(n_clear[i][j]) / LongFloat(total_number_roots);
            }
            std::cout << std::setprecision(3) << percentage_counter << "\t";
                        percentage_counter = 0;
            for (int j = 0; j <= edges.size(); j++){
                percentage_counter += LongFloat(100) * LongFloat(n_unclear[i][j]) / LongFloat(total_number_roots);
            }
            std::cout << std::setprecision(3) << percentage_counter << "\t";
        }
        
        // separate the print-out from other results
        std::cout << "\n\n";
    }
    
    // save the result to a dummy file next to main.cpp, so gap can read it out and display intermediate process details
    ofile.open( dir_path + "/result.txt" );
    ofile << "[[";
    for (int i = 0; i < n_clear.size(); i ++){
        ofile << "[";
        for (int j = 0; j < n_clear[i].size()-1; j++){
            ofile << n_clear[i][j] << " ,";
        }
        ofile << n_clear[i][n_clear[i].size()-1] << "],\n";
    }
    ofile << "],\n[";
    for (int i = 0; i < n_unclear.size(); i ++){
        ofile << "[";
        for (int j = 0; j < n_unclear[i].size()-1; j++){
            ofile << n_unclear[i][j] << " ,";
        }
        ofile << n_unclear[i][n_unclear[i].size()-1] << "],\n";
    }
    ofile << "]];";
    ofile.close();
    
    // return success
    return 0;
    
}
