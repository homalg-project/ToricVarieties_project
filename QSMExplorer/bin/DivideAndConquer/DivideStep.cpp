// A program to compute the number of minimal limit roots on full blowups of nodal curves

#include <algorithm>
#include <chrono>
#include <functional>
#include<fstream>
#include<iostream>
#include <map>
#include <mutex>
#include <sstream>
#include <stack>
#include <thread>
#include <vector>

#include <boost/multiprecision/cpp_int.hpp>
#include <boost/thread/mutex.hpp>
#include <boost/thread/thread.hpp>

// guards for thread-safe operations
boost::mutex myGuard, myGuard2;

#include "PrintData.cpp"
#include "RootDistributionCounter.cpp"
#include "Scanner.cpp"
#include "Cartesian.cpp"

// Optimizations for speedup
#pragma GCC optimize("Ofast")
#pragma GCC target("avx,avx2,fma")


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
    int number_threads = input[ 4 * numberVertices + 2 * numberEdges + 4 ];
    int h0Max = input[ 4 * numberVertices + 2 * numberEdges + 5 ];
    int details = input[ 4 * numberVertices + 2 * numberEdges + 6 ];
    bool display_details = true;
    if ( details < 0 ){
            display_details = false;
    }

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
    
    
    // (1) Construct all outfluxes values
    // (1) Construct all outfluxes values
    
    // (1.1) Construct all outfluxes
    
    // Take time at start of operation
    std::chrono::steady_clock::time_point begin = std::chrono::steady_clock::now();
    
    // Construct all outfluxes
    std::vector<std::vector<unsigned long long int>> all_outfluxes = constructAllOutfluxes( legs_per_component, root, display_details );
    
    // (1.2) Inform that we are about to scan over all outfluxes
    if ( display_details ){
        std::cout << "Total number of outfluxes to be studied: " << all_outfluxes.size() << "\n\n";
        std::cout << "Perform scan in " << number_threads << " parallel threads...\n";
    }

    // (1.3) Prepare variables
    std::vector<std::vector<unsigned long long int>> outfluxes_H1, outfluxes_H2;
    std::vector<std::vector<boost::multiprecision::int128_t>> dist_H1, dist_H2;
    std::vector<int> status( number_threads, 0 );
    boost::thread_group threadList;
    
    // (1.4) Perform the scan
    int package_size = all_outfluxes.size() / number_threads;
    for (int i = 0; i < number_threads; i++)
    {        
        if ( i < number_threads - 1 ){
            std::vector<std::vector<unsigned long long int>> scan_data( all_outfluxes.begin() + i * package_size, all_outfluxes.begin() + ( i + 1 ) * package_size );
            boost::thread *t = new boost::thread( FluxScanner, scan_data, boost::ref( outfluxes_H1 ),  boost::ref( outfluxes_H2 ),  boost::ref( dist_H1 ), boost::ref( dist_H2 ), boost::ref( status ), input, i );
            threadList.add_thread( t );
        }
        else{
            std::vector<std::vector<unsigned long long int>> scan_data( all_outfluxes.begin() + i * package_size, all_outfluxes.begin() + all_outfluxes.size() );
            boost::thread *t = new boost::thread( FluxScanner, scan_data, boost::ref( outfluxes_H1 ),  boost::ref( outfluxes_H2 ),  boost::ref( dist_H1 ), boost::ref( dist_H2 ), boost::ref( status ), input, i );
            threadList.add_thread( t );
        }
    }
    threadList.join_all();
    
    // (1.5) Find minimum on H2
    int min_H2 = h0Max;
    for ( int i = 0; i < dist_H2.size(); i++ ){
        int k = std::distance( std::begin( dist_H2[ i ] ), std::find_if( std::begin( dist_H2[ i ] ), std::end( dist_H2[ i ] ), [](boost::multiprecision::int128_t x) { return x != 0; }) );
        if ( k < min_H2 ){
            min_H2 = k;
        }
        if ( k = 0 ){
            min_H2 = k;
            break;
        }
    }
    
    // (1.6) Write intermediate results to files
    if ( display_details ){
        std::cout << "\n\n";
        std::cout << "Write results to files";    
    }
    
    std::string full_path = argv[ 0 ];
    std::string dir_path = full_path.substr(0, full_path.find_last_of("."));
    
    std::ofstream out_file;
    out_file.open( dir_path + "/f1.txt" );
    for ( int i = 0; i < outfluxes_H1.size(); i++ ){
        for ( int j = 0; j < outfluxes_H1[i].size() - 1; j ++ ){
            out_file << outfluxes_H1[i][j] << ", ";
        }
        out_file << outfluxes_H1[i][outfluxes_H1[i].size()-1] << "\n";
    }
    out_file.close();
    std::ofstream out_file2;
    out_file2.open( dir_path + "/f2.txt" );
    for ( int i = 0; i < outfluxes_H2.size(); i++ ){
        for ( int j = 0; j < outfluxes_H2[i].size() - 1; j ++ ){
            out_file2 << outfluxes_H2[i][j] << ", ";
        }
        out_file2 << outfluxes_H2[i][outfluxes_H2[i].size()-1] << "\n";
    }
    out_file.close();
    std::ofstream out_file3;
    out_file3.open( dir_path + "/d1.txt" );
    for ( int i = 0; i < dist_H1.size(); i++ ){
        for ( int j = 0; j < dist_H1[i].size() - 1; j ++ ){
            out_file3 << dist_H1[i][j] << ", ";
        }
        out_file3 << dist_H1[i][dist_H1[i].size()-1] << "\n";
    }
    out_file3.close();
    std::ofstream out_file4;
    out_file4.open( dir_path + "/d2.txt" );
    for ( int i = 0; i < dist_H2.size(); i++ ){
        for ( int j = 0; j < dist_H2[i].size() - 1; j ++ ){
            out_file4 << dist_H2[i][j] << ", ";
        }
        out_file4 << dist_H2[i][dist_H2[i].size()-1] << "\n";
    }
    out_file4.close();
    
    // (1.7) Take time after intermediate step
    std::chrono::steady_clock::time_point middle = std::chrono::steady_clock::now();
    
    // (1.8) Inform what we have achieved
    if ( display_details ){
        std::cout << "\n\n";
        std::cout << "Non-trivial outfluxes H1: " << outfluxes_H1.size() << ", " << dist_H1.size() << "\n";
        std::cout << "Non-trivial outfluxes H2: " << outfluxes_H2.size() << ", " << dist_H2.size() << "\n";
        std::cout << "Global minimum on H2: " << min_H2 << "\n";
        std::cout << "Time for run: " << std::chrono::duration_cast<std::chrono::seconds>(middle - begin).count() << "[s]\n\n";
    }
    
    // (2) Signal success
    // (2) Signal success
    return 0; 
    
}
