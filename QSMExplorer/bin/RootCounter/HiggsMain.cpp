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

#include "RootDistributionCounter.cpp"
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
    // (1) vertices (std::vector<int>)
    // (2) degrees_H1 (std::vector<int>)
    // (3) degrees_H2 (std::vector<int>)
    // (4) genera (std::vector<int>)
    // (5) edges (std::vector<std::vector<int>>)
    // (6) external_legs (std::vector<int>)
    // (7) genus (int)
    // (8) root (int)
    // (9) number of threads (int) - optional
    // (10) h0Min (int)
    // (11) h0_h0Max (int)
    // So expect the following input:
    // { #Vertices, degrees, genera, #Edges, edge-information, genus, root, threads }
    
    // convert the input data accordingly
    int numberVertices = input[ 0 ];
    std::vector<int> vertices, degrees_H1, degrees_H2, genera;
    for ( int i = 1; i <= numberVertices; i++ ){
        vertices.push_back( i - 1 );
        degrees_H1.push_back( input[ i ] );
        degrees_H2.push_back( input[ i ] + numberVertices );
        genera.push_back( input[ i + 2 * numberVertices ] );
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
    int numberExternalEdges = input[ 3 * numberVertices + 1 + 1 + 2 * numberEdges ];
    std::vector<int> external_legs;
    for ( int i = 0; i < numberExternalEdges; i ++ ){
        external_legs.push_back( input[ 3 * numberVertices + 1 + 1 + 2 * numberEdges + 1 + i ] );
    }
    int genus = input[ 3 * numberVertices + 3 + 2 * numberEdges + numberExternalEdges + 1 ];
    int root = input[ 3 * numberVertices + 3 + 2 * numberEdges + numberExternalEdges + 2 ];
    int number_threads = input[ 3 * numberVertices + 3 + 2 * numberEdges + numberExternalEdges + 3 ];
    int h0Max = input[ 3 * numberVertices + 3 + 2 * numberEdges + numberExternalEdges + 4 ];
    int details = input[ 3 * numberVertices + 3 + 2 * numberEdges + numberExternalEdges + 5 ];
    bool display_details = true;
    if ( details < 0 ){
            display_details = false;
    }
    
    // find the number of legs per component
    std::sort( external_legs.begin(), external_legs.end() );
    std::vector<int> legs_per_component( vertices.size(), 0 );
    for ( int i = 0; i < external_legs.size(); i++ ){
        legs_per_component[ external_legs[ i ] ]++;
    }
    
    // check if curve class and bundle class are of correct length
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
    
    
    // (1) Construct all outfluxes values
    int min_outflux, max_outflux;
    std::vector<std::vector<int>> outflux_values;
    for ( int i = 0; i < vertices.size(); i++ ){
        
        // find minimal and maximal outfluxes
        min_outflux = legs_per_component[ i ];
        max_outflux = legs_per_component[ i ] * ( root - 1 );
        
        // construct the possible flux values explicitly
        std::vector<int> possible_values;
        for ( int j = 0; j < max_outflux - min_outflux + 1; j++ ){
            possible_values.push_back( min_outflux + j );
        }
        
        // and add this list of values to outflux_values
        outflux_values.push_back( possible_values );
    }
    
    
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
    
    // (3) Iterate over all outfluxes to gather data to be pieced together
    // TODO: Perform in parallel threads
    std::vector<std::vector<unsigned long long int>> outfluxes_H1, outfluxes_H2;
    std::vector<std::vector<unsigned long long int>> dist_H1, dist_H2;
    int h0MinUsed;
    for ( int i = 0; i < all_outfluxes.size(); i++ ){
        
        // (3.1) Generate weights for the outflux
        std::vector<int> external_weights( external_legs.size() );
        int iterator = 0;
        for ( int j = 0; j < vertices.size(); j++ ){
            
            int flux_for_component = all_outfluxes[ i ][ j ];
            int leg_number = legs_per_component[ j ];
            
            for ( int k = 0; k < leg_number; k++ ){
                external_weights[ iterator ] = flux_for_component / leg_number;
                flux_for_component = flux_for_component - ( flux_for_component / leg_number );
                leg_number = leg_number - 1;
            }
            
        }
        
        // (3.2) Construct weighted H1-diagram
        WeightedDiagramWithExternalLegs dia_H1 = WeightedDiagramWithExternalLegs( vertices, degrees_H1, genera, edges, external_legs, external_weights, genus, root );
        
        // (3.3) Only proceed if situation is not automatically degenerate
        h0MinUsed = dia_H1.get_h0_min();
        if ( h0Max >= h0MinUsed ){
            
            // Compute distribution
            std::vector<unsigned long long int> n( h0Max - h0MinUsed + 1, 0 );
            if ( number_threads > 0 ){
                countRootDistribution( dia_H1, number_threads, h0MinUsed, h0Max, n, display_details );
            }
            else{
                countRootDistribution( dia_H1, h0MinUsed, h0Max, n, display_details );
            }
            
            // Check if distribution is not trivial
            bool zeros = std::all_of( n.begin(), n.end(), [](int j) { return j==0; } );
            
            // Append if the result is not trivial
            if ( ! zeros ){
                
                // Prepare result
                std::vector<unsigned long long int> dist( h0Max + 1, 0 );
                for ( int j = 0; j < n.size(); j++ ){
                    dist[ j + h0MinUsed ] = n[ j ];
                }
                
                // And safe it
                outfluxes_H1.push_back( all_outfluxes[ i ] );
                dist_H1.push_back( dist );

            }
            
        }
        
        // (3.4) Construct weighted H2-diagram
        WeightedDiagramWithExternalLegs dia_H2 = WeightedDiagramWithExternalLegs( vertices, degrees_H2, genera, edges, external_legs, external_weights, genus, root );
        
        // (3.5) Only proceed if situation is not automatically degenerate
        h0MinUsed = dia_H2.get_h0_min();
        if ( h0Max >= h0MinUsed ){
            
            // Compute distribution
            std::vector<unsigned long long int> n( h0Max - h0MinUsed + 1, 0 );
            if ( number_threads > 0 ){
                countRootDistribution( dia_H2, number_threads, h0MinUsed, h0Max, n, display_details );
            }
            else{
                countRootDistribution( dia_H2, h0MinUsed, h0Max, n, display_details );
            }
            
            // Check if distribution is not trivial
            bool zeros = std::all_of( n.begin(), n.end(), [](int j) { return j==0; } );
            
            // Append if the result is not trivial
            if ( ! zeros ){
                
                // Prepare distribution
                std::vector<unsigned long long int> dist( h0Max + 1, 0 );
                for ( int j = 0; j < n.size(); j++ ){
                    dist[ j + h0MinUsed ] = n[ j ];
                }
                
                // And safe it
                outfluxes_H2.push_back( all_outfluxes[ i ] );
                dist_H2.push_back( dist );

            }
            
        }
        
    }
    
    // (4) Prepare to piece local data together
    int number_components = vertices.size();
    std::vector<int> legs_per_component_halved( legs_per_component );
    for ( int i = 0; i < legs_per_component.size(); i++ ){
        legs_per_component_halved[ i ] = legs_per_component[ i ] / 2;
    }
    std::vector<unsigned long long int> final_dist( 3 * h0Max , 0 );
    std::vector<int> status;
    if ( number_threads > 0 ){
        for ( int i = 0; i < number_threads; i++ ){
            status.push_back( 0 );
        }
    }
    else{
        status.push_back( 0 );
    }
    
    // (5) Partition workload to threads
    int package_size = outfluxes_H1.size() / number_threads;
    std::vector<std::thread> threadList;
    int start, stop;
    for (int i = 0; i < number_threads; i++)
    {

        // Find start and stop position for thread
        start = i * package_size;
        if ( i < number_threads - 1 ){ stop = ( i + 1 ) * package_size - 1; }
        else{ stop = (int) outfluxes_H1.size() -1; }
        
        // Signal that we start this thread
        std::cout << "Start thread " << i << "\n";
        
        // Start the worker threads
        threadList.push_back( std::thread(   compute_distribution, 
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
    
    // (6) Wait for all threads to complete
    std::for_each(threadList.begin(),threadList.end(), std::mem_fn(&std::thread::join));
    
    // (7) Print result
    std::cout << "##############\n";
    std::cout << "Found root distribution:\n";
    std::cout << "##############\n";
    for ( int i = 0; i < final_dist.size(); i++ ){
        std::cout << "H0 = " << i << ":\t" << final_dist[ i ] << "\n";
    }
    
    // (8) Signal success
    return 0;
    
}
