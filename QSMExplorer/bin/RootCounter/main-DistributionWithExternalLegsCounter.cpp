// A program to compute the number of minimal limit roots on full blowups of nodal curves

#include <algorithm>
#include<iostream>
#include<fstream>
#include <sstream> 
#include <vector>
#include <thread>
#include <functional>
#include <mutex>
#include <chrono>
#include <stack>
#include "WDiagram.h"
#include "RootDistributionWithExternalLegsCounter.cpp"

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
    // (9) h0 target
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
    int limit = input[ 2 * numberVertices + 2 + 2 * numberEdges + 2 * numberExternalEdges + 4 ];
        
    // check if curve class and bundle class are of correct length
    if ( ( genus < 0 ) ){
        std::cout << "Genus must not be negative.\n";
        return -1;
    }
    if ( ( root <= 1 ) ){
        std::cout << "Root must be at least 2.\n";
        return -1;
    }
    
    // construct diagram
    WeightedDiagramWithExternalLegs dia = WeightedDiagramWithExternalLegs( vertices, degrees, genera, edges, external_legs, external_weights, genus, root );
    
    // count root distribution
    std::vector<unsigned long long int> n;
    if ( number_threads > 0 ){
        n = countRootDistribution( dia, number_threads, limit );
    }
    else{
        n = countRootDistribution( dia, limit );
    }
    
    // save the result to a dummy file next to main.cpp, so gap can read it out
    std::ofstream ofile;
    std::string file_path = __FILE__;
    std::string dir_path = file_path.substr(0, file_path.rfind("/"));
    ofile.open( dir_path + "/result.txt" );
    for ( int i = 0; i < n.size(); i ++ ){
        ofile << n[ i ] << std::endl;
    }
    ofile.close();
        
    // return success
    return 0;
    
}
