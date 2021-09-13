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
#include "SpecialityChecker.cpp"

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
    // (1) #vertices (int)
    // (2) degrees (std::vector<int>)
    // (3) edges (std::vector<std::vector<int>>)
    // So expect the following input:
    // { #Vertices, degrees, #Edges, edge-information, threads }
    
    // convert the input data accordingly
    int numberVertices = input[ 0 ];
    std::vector<int> degrees;
    for ( int i = 1; i <= numberVertices; i++ ){
        degrees.push_back( input[ i ] );
    }
    int numberEdges = input[ numberVertices + 1 ];
    std::vector<std::vector<int>> edges;
    for ( int i = 0; i < numberEdges; i ++ ){
        std::vector<int> helper (2);
        int index = numberVertices + 2 + 2 * i;
        helper[ 0 ] = input[ index ];
        helper[ 1 ] = input[ index + 1 ];
        edges.push_back( helper );
    }
    int details = input[ numberVertices + 2 * numberEdges + 2 ];
    
    // special speciality
    bool special;
    bool display_details;
    if ( details < 0 ){
        display_details = false;
    }
    else
    {
        display_details = true;
    }
    special = checkSpeciality( degrees, edges, display_details );
    
    // save the result to a dummy file next to main.cpp, so gap can read it out
    std::ofstream ofile;
    std::string file_path = __FILE__;
    std::string dir_path = file_path.substr(0, file_path.rfind("/"));
    ofile.open( dir_path + "/result.txt" );
    if ( special ){
        ofile << "true" << std::endl;
    }
    else{
        ofile << "false" << std::endl;
    }
    ofile.close();
        
    // return success
    return 0;
    
}
