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
#include "compute_graph_information.cpp"

// guard for thread-safe operations
boost::mutex myGuard;

// include root counter
bool display_details = false;
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
    
    // take the external weights into account and adjust the degrees accordingly
    for (int i = 0; i < external_legs.size(); i++){
        degrees[external_legs[i]] -= external_weights[i];
    }
    
    std::cout << "External legs: (";
    for (int i = 0; i < external_legs.size(); i++){
        std::cout << external_legs[i] << ",";
    }
    std::cout << ")\n";
    std::cout << "External weights: (";
    for (int i = 0; i < external_weights.size(); i++){
        std::cout << external_weights[i] << ",";
    }
    std::cout << ")\n";
    
    //std::cout << "Test0\n";
    
    // compute lower bound and adjust h0Min if necessary
    int lower_bound = (int) (std::accumulate(degrees.begin(),degrees.end(),0)/root) - genus + 1;
    if (h0Min != lower_bound){
        if (display_details){
            std::cout << "h0Min differs from estimated lower bound. Replaced by " << lower_bound << "\n";
        }
        h0Min = lower_bound;
    }
    
    /*std::cout << "Test1\n";
    std::cout << "Edges:\n";
    for (int i = 0; i < edges.size(); i++){
        std::cout << "(" << edges[i][0] << ", " << edges[i][1] << ")\n";
    }*/
    
    // compute additional information about the graph
    std::vector<int> edge_numbers(degrees.size(),0);
    std::vector<std::vector<std::vector<int>>> graph_stratification;
    additional_graph_information(edges, edge_numbers, graph_stratification);
    
    //std::cout << "Test2\n";
    
    // count roots in the desired interval
    std::vector<boost::multiprecision::int128_t> n(h0Max + 1, 0);
    for (int i = h0Min; i < n.size(); i++){
        n[i] = parallel_root_counter(genus, degrees, genera, edges, root, graph_stratification, edge_numbers, i, number_threads);
    }
    
    //std::cout << "Test3\n";
    
    // set up variables to write to the result file
    std::ofstream ofile;
    std::string full_path = argv[ 0 ];
    std::string dir_path = full_path.substr(0, full_path.find_last_of("."));
    
    // print result
    if (display_details){
        for ( int i = 0; i < n.size(); i ++ ){
            std::cout << "h0 = " << i << ": " << n[i] << "\n";
        }
    }
    
    // save the result to a dummy file next to main.cpp, so gap can read it out and display intermediate process details
    ofile.open( dir_path + "/result.txt" );
    ofile << "[ ";
    for (int i = 0; i < n.size() - 1; i ++){
        ofile << n[i] << " ,";
    }
    ofile << n[n.size() - 1] << " ];";
    ofile.close();
    
    // return success
    return 0;
    
}
