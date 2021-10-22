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

#include "RootDistributionCounter.cpp"
#include "Scanner.cpp"
#include "Cartesian.cpp"
#include "Partitions.cpp"
#include "HiggsDistributionCounter.cpp"

// Optimizations for speedup
#pragma GCC optimize("Ofast")
#pragma GCC target("avx,avx2,fma")


void print_data( std::vector<int> degrees_H1, std::vector<int> degrees_H2, int root, std::vector<int> external_legs, std::vector<int> legs_per_component ){
    
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
    for ( int i = 0; i < legs_per_component.size() - 1; i++ ){
        std::cout << legs_per_component[ i ] << ", ";
    }
    std::cout << legs_per_component[ legs_per_component.size() - 1 ] << ")\n\n";
    
}

// The main routine
int main(int argc, char* argv[]) {
    
    // Check if we have the correct number of arguments
    if (argc != 2) {
        std::cout << "Error - number of arguments must be exactly 1 and not " << argc << "\n";
        std::cout << argv[ 0 ] << "\n";
        return 0;
    }
    
    // Parse input
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
    
    // Convert the input data accordingly
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
    
    // Display what data we received
    if ( display_details ){
        print_data( degrees_H1, degrees_H2, root, external_legs, legs_per_component );
    }
    
    // Perform consistency checks
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
    // (1) Construct all outfluxes values
    
    // Take time for operation
    std::chrono::steady_clock::time_point begin = std::chrono::steady_clock::now();
    
    // Inform that we are about to construct all outfluxes
    if ( display_details ){
        std::cout << "Find minimal and maximal outfluxes...\n";
    }
    
    // Initialize variables
    int min_outflux, max_outflux;
    std::vector<std::vector<int>> outflux_values;
    
    // Perform scan
    for ( int i = 0; i < vertices.size(); i++ ){
        
        // Find minimal and maximal outfluxes
        min_outflux = legs_per_component[ i ];
        max_outflux = legs_per_component[ i ] * ( root - 1 );
        if ( display_details ){
            std::cout << "Component " << i << ": (" << min_outflux << ", " << max_outflux << ")\n";
        }
        
        // Construct the possible flux values explicitly
        std::vector<int> possible_values;
        for ( int j = 0; j < max_outflux - min_outflux + 1; j++ ){
            possible_values.push_back( min_outflux + j );
        }
        
        // And add this list of values to outflux_values
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
    std::vector<std::vector<boost::multiprecision::int128_t>> dist_H1, dist_H2;
    std::vector<int> status( number_threads, 0 );
    int package_size = all_outfluxes.size() / number_threads;
    boost::thread_group threadList;
    int start, stop;
    
    // (3.2) Partition workload and start threads
    for (int i = 0; i < number_threads; i++)
    {

        // Find start and stop position for thread
        std::vector<int> interval;
        interval.push_back( i * package_size );
        if ( i < number_threads - 1 ){
            interval.push_back( ( i + 1 ) * package_size - 1 );
        }
        else{
            interval.push_back( all_outfluxes.size() - 1 );
        }
        
        // Start thread
        boost::thread *t = new boost::thread( FluxScanner, all_outfluxes, boost::ref( outfluxes_H1 ),  boost::ref( outfluxes_H2 ),  boost::ref( dist_H1 ), boost::ref( dist_H2 ), boost::ref( status ), input, i, interval );
        threadList.add_thread( t );
        
    }
    threadList.join_all();
    
    // (3.3) Find global minimum of H2_fluxes
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
    
    // (3.4) Inform what we have achieved
    std::chrono::steady_clock::time_point middle = std::chrono::steady_clock::now();
    if ( display_details ){
        std::cout << "\n\n";
        std::cout << "Outfluxes H1: " << outfluxes_H1.size() << ", " << dist_H1.size() << "\n";
        std::cout << "Outfluxes H2: " << outfluxes_H2.size() << ", " << dist_H2.size() << "\n";
        std::cout << "Global minimum on H2: " << min_H2 << "\n";
        std::cout << "Time for run: " << std::chrono::duration_cast<std::chrono::seconds>(middle - begin).count() << "[s]\n\n";
        std::cout << "Now start to piece the local data together... \n\n";
    }
    
    // (4) Prepare to piece local data together
    std::vector<int> legs_per_component_halved( legs_per_component );
    for ( int i = 0; i < legs_per_component.size(); i++ ){
        legs_per_component_halved[ i ] = legs_per_component[ i ] / 2;
    }
    std::vector<boost::multiprecision::int128_t> final_dist( h0Max + 1, 0 );
    
    // (5) Partition workload and start threads
    boost::thread_group threadList2;
    for ( int i = 0; i < status.size(); i++ ){
        status[ i ] = 0;
    }
    if ( number_threads > 1 ){
        
        // distribute tasks to threads
        boost::multiprecision::int128_t total_number_tasks = ( boost::multiprecision::int128_t ) ( outfluxes_H1.size() * ( outfluxes_H1.size() + 1 ) / 2 );
        boost::multiprecision::int128_t average_number_tasks = total_number_tasks / number_threads;
        int start = 0;
        for ( int i = 0; i < number_threads; i++)
        {
            
            // initialize variables
            int pos = start - 1;
            int tasks = 0;
            
            if ( i < number_threads - 1 ){
                
                // identify stop position
                while ( tasks < average_number_tasks ){            
                    pos = pos + 1;
                    tasks = tasks + outfluxes_H1.size() - ( pos + 1 );
                }
                stop = pos;
                
                // start thread
                std::vector<int> integer_data = { root, start, stop, i, min_H2 };
                boost::thread *t = new boost::thread( compute_distribution, outfluxes_H1, outfluxes_H2, dist_H1, dist_H2, legs_per_component_halved, integer_data, std::ref( final_dist ), std::ref( status ) );
                threadList2.add_thread( t );
                
                // set start position for the following thread
                start = pos + 1;
                
            }
            else{
                
                // start last task, which includes scan over diagonal fluxes
                stop = outfluxes_H1.size() - 1;
                std::vector<int> integer_data = { root, start, stop, i, min_H2 };                
                boost::thread *t = new boost::thread( compute_diagonal_distribution, outfluxes_H1, outfluxes_H2, dist_H1, dist_H2, legs_per_component_halved, integer_data, std::ref( final_dist ), std::ref( status ) );
                threadList2.add_thread( t );
                
            }
            
        }
        threadList2.join_all();
        
    }
    else{
        
        std::vector<int> integer_data = { root, 0, (int) outfluxes_H1.size() - 1, 0 };
        compute_diagonal_distribution( outfluxes_H1, outfluxes_H2, dist_H1, dist_H2, legs_per_component_halved, integer_data, final_dist, status );
        
    }
    
    // (6) Print result
    std::chrono::steady_clock::time_point end = std::chrono::steady_clock::now();
    if ( display_details ){
        std::cout << "##############\n";
        std::cout << "Found root distribution:\n";
        std::cout << "##############\n";
        for ( int i = 0; i < final_dist.size(); i++ ){
            std::cout << "H0 = " << i << ":\t" << final_dist[ i ] << "\n";
        }
        std::cout << "\n";
        std::cout << "Time for run: " << std::chrono::duration_cast<std::chrono::seconds>(end - middle).count() << "[s]\n\n";
    }
    
    // (7) Save the result to a dummy file, so that gap can read it out and display the intermediate process details of the C++ run
    std::ofstream ofile;
    std::string full_path = argv[ 0 ];
    std::string dir_path = full_path.substr(0, full_path.find_last_of("."));
    ofile.open( dir_path + "/result.txt" );
    ofile << "[ ";
    for ( int i = 0; i < final_dist.size() - 1; i ++ ){
        ofile << final_dist[ i ] << " ,";
    }
    ofile << final_dist[ final_dist.size() - 1 ] << " ];";
    ofile.close();
    
    // (8) Signal success
    return 0; 
    
}
