// A program to compute the number of minimal limit roots on full blowups of nodal curves

#include <algorithm>
#include <chrono>
#include <functional>
#include<iostream>
#include <map>
#include <mutex>
#include <sstream>
#include <stack>
#include <thread>
#include <vector>
#include <boost/multiprecision/cpp_int.hpp>

// guard for thread-safe operations
std::mutex myMutexFlex;

#include "RootDistributionCounter.cpp"
#include "Scanner.cpp"
#include "Cartesian.cpp"
#include "Partitions.cpp"
#include "HiggsDistributionCounter.cpp"

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
    // So expect the following input:
    // { #Vertices, degrees, genera, #Edges, edge-information, genus, root, threads }
    
    // TODO Handle number of threads better!
    
    // convert the input data accordingly
    int numberVertices = input[ 0 ];
    std::vector<int> vertices( numberVertices );
    std::vector<int> degrees_H1( numberVertices );
    std::vector<int> degrees_H2( numberVertices );
    std::vector<int> genera( numberVertices );
    for ( int i = 1; i <= numberVertices; i++ ){
        vertices[ i - 1 ] = i - 1;
        degrees_H1[ i - 1 ] = input[ i ];
        degrees_H2[ i - 1] = input[ i + numberVertices ];
        genera[ i - 1 ] = input[ i + 2 * numberVertices ];
    }
    int numberEdges = input[ 3 * numberVertices + 1 ];
    std::vector<std::vector<int>> edges;
    for ( int i = 0; i < numberEdges; i ++ ){
        std::vector<int> helper (2);
        int index = 2 + 3 * numberVertices + 2 * i;
        helper[ 0 ] = input[ index ];
        helper[ 1 ] = input[ index + 1 ];
        edges.push_back( helper );
    }
    std::vector<int> legs_per_component;
    std::vector<int> external_legs;
    for ( int i = 0; i < numberVertices; i ++ ){
        legs_per_component.push_back( input[ 3 * numberVertices + 1 + 1 + 2 * numberEdges + i ] );
        for ( int j = 0; j < input[ 3 * numberVertices + 1 + 1 + 2 * numberEdges + i ]; j++ ){
            external_legs.push_back( i );
        }
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
    
    // Display what we obtained
    if ( display_details ){
        std:: cout << "\n";
        std:: cout << "Received the following data:\n";
        std:: cout << "----------------------------------------\n";
        std::cout << "Degrees H1: ";
        for ( int j = 0; j < degrees_H1.size(); j++ ){
            std::cout << degrees_H1[ j ] << ", ";
        }
        std::cout << "\n";
        std::cout << "Degrees H2: ";
        for ( int j = 0; j < degrees_H2.size(); j++ ){
            std::cout << degrees_H2[ j ] << ", ";
        }
        std::cout << "\n";
        std::cout << "Root: " << root << "\n";
        std::cout << "External legs: (";
        for ( int i = 0; i < external_legs.size() - 1; i++ ){
            std::cout << external_legs[ i ] << ", ";
        }
        std::cout << external_legs[ external_legs.size() - 1 ] << ")\n";
        std::cout << "Legs per component: (";
        for ( int i = 0; i < numberVertices; i++ ){
            std::cout << legs_per_component[ i ] << ", ";
        }
        std::cout << ")\n\n";
    }
    
    // Check if curve class and bundle class are of correct length
    if ( ( genus < 0 ) ){
        if ( display_details ){
            std::cout << "Genus must not be negative.\n";
        }
        return -1;
    }
    if ( ( root <= 1 ) ){
        if ( display_details ){
            std::cout << "Root must be at least 2.\n";
        }
        return -1;
    }
    if ( 0 > h0Max ){
        if ( display_details ){
            std::cout << "h0Max must not be negative.\n";
        }
        return -1;
    }
    
    if ( display_details ){
        std::cout << "Find minimal and maximal outfluxes...\n";
    }
    
    
    
    // (1) Construct all outfluxes values
    // (1) Construct all outfluxes values

    // measure time for complete operation
    std::chrono::steady_clock::time_point begin = std::chrono::steady_clock::now();
    
    int min_outflux, max_outflux;
    std::vector<std::vector<int>> outflux_values;
    for ( int i = 0; i < vertices.size(); i++ ){
        
        // find minimal and maximal outfluxes
        min_outflux = legs_per_component[ i ];
        max_outflux = legs_per_component[ i ] * ( root - 1 );
        if ( display_details ){
            std::cout << "Component " << i << ": (" << min_outflux << ", " << max_outflux << ")\n";
        }
        
        // construct the possible flux values explicitly
        std::vector<int> possible_values;
        for ( int j = 0; j < max_outflux - min_outflux + 1; j++ ){
            possible_values.push_back( min_outflux + j );
        }
        
        // and add this list of values to outflux_values
        outflux_values.push_back( possible_values );
    }
    std::cout << "\n";
    
    
    
    // (2) Cartesian product to identify all outflux values (and cast it into unsigned long long ints)
    // (2) Cartesian product to identify all outflux values (and cast it into unsigned long long ints)
    
    std::vector<std::vector<int>> cartesian = product( outflux_values );
    std::vector<std::vector<unsigned long long int>> all_outfluxes( cartesian.size() );
    for ( int i = 0; i < cartesian.size(); i++ ){
        std::vector<unsigned long long int> dummy( cartesian[ i ].size() );
        for ( int j = 0; j < cartesian[ i ].size(); j++ ){
            dummy[ j ] = (unsigned long long int ) cartesian[ i ][ j ];
        }
        all_outfluxes[ i ] = dummy;
    }
    
    
    // (3) Scan all outfluxes to compute "min-distributions"
    // (3) Scan all outfluxes to compute "min-distributions"
    if ( display_details ){
        std::cout << "Total number of outfluxes to be studied: " << all_outfluxes.size() << "\n\n";
        std::cout << "Perform scan in " << number_threads << " parallel threads...\n";
    }

    // (3.1) Prepare scan
    std::vector<std::vector<unsigned long long int>> outfluxes_H1, outfluxes_H2;
    std::vector<std::vector<unsigned long long int>> dist_H1, dist_H2;
    std::vector<int> status( number_threads );
    int h0MinUsed;
    for ( int i = 0; i < number_threads; i ++ ){
        status[ i ] = 0;
    }
    
    // (3.2) Partition workload and start threads
    int package_size = all_outfluxes.size() / number_threads;
    std::vector<std::thread> threadList;
    int start, stop;
    for (int i = 0; i < number_threads; i++)
    {

        // Find start and stop position for thread
        start = i * package_size;
        if ( i < number_threads - 1 ){ stop = ( i + 1 ) * package_size - 1; }
        else{ stop = (int) outfluxes_H1.size() -1; }
        
        // Start the worker threads
        threadList.push_back( std::thread(   FluxScanner, 
                                                                    all_outfluxes,
                                                                    std::ref( outfluxes_H1 ),
                                                                    std::ref( outfluxes_H2 ),
                                                                    std::ref( dist_H1 ),
                                                                    std::ref( dist_H2 ),
                                                                    start,
                                                                    stop,
                                                                    std::ref( status ),
                                                                    i,
                                                                    legs_per_component,
                                                                    root,
                                                                    vertices,
                                                                    degrees_H1,
                                                                    degrees_H2,
                                                                    genera,
                                                                    edges,
                                                                    external_legs,
                                                                    genus,
                                                                    number_threads,
                                                                    h0Max
                                                                    ) );
        
    }
    std::for_each(threadList.begin(),threadList.end(), std::mem_fn(&std::thread::join));
    
    // Inform what we have achieved
    std::chrono::steady_clock::time_point middle = std::chrono::steady_clock::now();
    if ( display_details ){
        std::cout << "\n\n";
        std::cout << "Outfluxes H1: " << outfluxes_H1.size() << ", " << dist_H1.size() << "\n";
        std::cout << "Outfluxes H2: " << outfluxes_H2.size() << ", " << dist_H2.size() << "\n";
        std::cout << "Time for run: " << std::chrono::duration_cast<std::chrono::seconds>(middle - begin).count() << "[s]\n\n";
        std::cout << "Now start to piece the local data together... \n\n";
    }
    
    // (4) Prepare to piece local data together
    std::vector<int> legs_per_component_halved( legs_per_component );
    for ( int i = 0; i < legs_per_component.size(); i++ ){
        legs_per_component_halved[ i ] = legs_per_component[ i ] / 2;
    }
    std::vector<unsigned long long int> final_dist( 3 * h0Max , 0 );
    
    // (5) Partition workload and start threads
    package_size = outfluxes_H1.size() / number_threads;
    std::vector<std::thread> threadList2;
    for (int i = 0; i < number_threads; i++)
    {

        // Find start and stop position for thread
        start = i * package_size;
        if ( i < number_threads - 1 ){ stop = ( i + 1 ) * package_size - 1; }
        else{ stop = (int) outfluxes_H1.size() -1; }
        
        // Start the worker threads
        threadList2.push_back( std::thread( compute_distribution,
                                                                    outfluxes_H1,
                                                                    outfluxes_H2,
                                                                    dist_H1,
                                                                    dist_H2,
                                                                    legs_per_component_halved,
                                                                    root,
                                                                    start,
                                                                    stop,
                                                                    std::ref( final_dist ),
                                                                    i,
                                                                    std::ref( status )
                                                                ) );
        
    }
    std::for_each(threadList2.begin(),threadList2.end(), std::mem_fn(&std::thread::join));
    
    // (6) Print result
    std::chrono::steady_clock::time_point end = std::chrono::steady_clock::now();
    std::cout << "##############\n";
    std::cout << "Found root distribution:\n";
    std::cout << "##############\n";
    for ( int i = 0; i < final_dist.size(); i++ ){
        std::cout << "H0 = " << i << ":\t" << final_dist[ i ] << "\n";
    }
    std::cout << "\n";
    std::cout << "Time for run: " << std::chrono::duration_cast<std::chrono::seconds>(end - middle).count() << "[s]\n\n";
    
    // (7) Signal success
    return 0;
    
}
