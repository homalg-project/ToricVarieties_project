// A program to compute the number of minimal limit roots on full blowups of nodal curves

#include <algorithm>
//#include <chrono>
#include <functional>
#include<fstream>
#include<iostream>
//#include <map>
//#include <mutex>
#include <numeric>
#include <sstream>
#include <stack>
//#include <thread>
#include <vector>
//#include <boost/multiprecision/cpp_int.hpp>
//#include <boost/thread/mutex.hpp>
//#include <boost/thread/thread.hpp>
#include "PrintData.cpp"
#include "Cartesian.cpp"

// The main routine
int main(int argc, char* argv[]) {

    // Required input:
    // (1) # vertices (int)
    // (2) degrees_H1 (std::vector<int>)
    // (3) degrees_H2 (std::vector<int>)
    // (4) genera (std::vector<int>)
    // (5) edges (std::vector<std::vector<int>>)
    // (6) legs_per_component (std::vector<int>)
    // (7) genus (int)
    // (8) root (int)
    // (9) number of threads (int) - optional
    // (10) h0_h0Max (int)
    // (11) details (int)
    
    // (0) Process received information
    // (0) Process received information
    
    // (0.1) Check if we have the correct number of arguments
    if (argc != 2) {
        std::cout << "Error - number of arguments must be exactly 1 and not " << argc << "\n";
        std::cout << argv[ 0 ] << "\n";
        return 0;
    }
    
    // (0.2) Parse input
    std::stringstream iss( argv[1] );
    std::vector<int> input;
    int number;
    while ( iss >> number ){
        input.push_back( number );
    }
    
    // (0.3) Read-off important data
    int numberVertices = input[ 0 ];
    int numberEdges = input[ 3 * numberVertices + 1 ];
    std::vector<int> legs_per_component;
    for ( int i = 0; i < numberVertices; i ++ ){
        legs_per_component.push_back( input[ 3 * numberVertices + 1 + 1 + 2 * numberEdges + i ] );
    }
    int genus = input[ 4 * numberVertices + 2 * numberEdges + 2 ];
    int root = input[ 4 * numberVertices + 2 * numberEdges + 3 ];
    int h0Max = input[ 4 * numberVertices + 2 * numberEdges + 5 ];
    int details = input[ 4 * numberVertices + 2 * numberEdges + 6 ];
    bool display_details = true;
    if ( details < 0 ){
            display_details = false;
    }
    std::vector<int> degrees_H1, degrees_H2;
    for ( int i = 0; i < numberVertices; i++ ){
        degrees_H1.push_back( input[ i + 1 ] );
        degrees_H2.push_back( input[ i + 1 + numberVertices ] );
    }
    int total_degree_H1 = std::accumulate(degrees_H1.begin(), degrees_H1.end(), 0);
    int total_degree_H2 = std::accumulate(degrees_H2.begin(), degrees_H2.end(), 0);
    
    // (0.4) Display received data and consistency checks
    if ( display_details ){
        print_data( input );
    }
    if ( ( genus < 0 ) ){
        if ( display_details ){ std::cout << "Genus must not be negative.\n"; }
        return -1;
    }
    if ( ( root <= 1 ) ){
        if ( display_details ){ std::cout << "Root must be at least 2.\n"; }
        return -1;
    }
    if ( 0 > h0Max ){
        if ( display_details ){ std::cout << "h0Max must not be negative.\n"; }
        return -1;
    }
    
    // (1) Construct all outfluxes
    // (1) Construct all outfluxes
    
    // Construct all outfluxes
    std::vector<std::vector<unsigned long long int>> all_outfluxes = constructAllOutfluxes( legs_per_component, root, display_details );
    
    // Identify good candidate fluxes for H1 and H2
    std::vector<std::vector<unsigned long long int>> outfluxes_H1;
    std::vector<std::vector<unsigned long long int>> outfluxes_H2;
    for (int i = 0; i < all_outfluxes.size(); i++){
        int total_flux = std::accumulate(all_outfluxes[i].begin(), all_outfluxes[i].end(), 0);
        if (( (int)((total_degree_H1 - total_flux)/root) - genus + 1 ) <= h0Max ){
            outfluxes_H1.push_back(all_outfluxes[i]);
        }
        if (( (int)((total_degree_H2 - total_flux)/root) - genus + 1 ) <= h0Max ){
            outfluxes_H2.push_back(all_outfluxes[i]);
        }
    }
    
    
    // (1.2) Inform that we have identified all outfluxes to be scanned and that they will be saved now
    if ( display_details ){
        std::cout << "Total number of outfluxes: " << all_outfluxes.size() << "\n\n";
        std::cout << "Candidates for H1: " << outfluxes_H1.size() << "\n\n";
        std::cout << "Candidates for H2: " << outfluxes_H2.size() << "\n\n";
        std::cout << "Write results to files";
    }

    // (1.3) Initialize variables
    std::string full_path = argv[ 0 ];
    std::string dir_path = full_path.substr(0, full_path.find_last_of("."));    
    std::ofstream out_file;
    
    // (1.4) Save outflux candidates for H1
    out_file.open( dir_path + "/outfluxes_H1.txt" );
    for ( int i = 0; i < outfluxes_H1.size(); i++ ){
        for ( int j = 0; j < outfluxes_H1[i].size() - 1; j ++ ){
            out_file << outfluxes_H1[i][j] << ",";
        }
        out_file << outfluxes_H1[i][outfluxes_H1[i].size()-1] << "\n";
    }
    out_file.close();

    // (1.5) Save outflux candidates for H1
    out_file.open( dir_path + "/outfluxes_H2.txt" );
    for ( int i = 0; i < outfluxes_H2.size(); i++ ){
        for ( int j = 0; j < outfluxes_H2[i].size() - 1; j ++ ){
            out_file << outfluxes_H2[i][j] << ",";
        }
        out_file << outfluxes_H2[i][outfluxes_H2[i].size()-1] << "\n";
    }
    out_file.close();

    // (2) Signal success
    // (2) Signal success
    return 0; 
    
}
