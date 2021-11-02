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
#include <boost/algorithm/string.hpp>

// guards for thread-safe operations
boost::mutex myGuard, myGuard2;

#include "PrintData.cpp"
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
    
    
    // (1) Read in all outfluxes and distributions
    // (1) Read in all outfluxes and distributions

    // (1.1) Initialize variables
    std::vector<std::vector<unsigned long long int>> outfluxes_H1, outfluxes_H2;
    std::vector<std::vector<boost::multiprecision::int128_t>> dist_H1, dist_H2;
    
    // (1.2) Read data
    std::string full_path = argv[ 0 ];
    std::string dir_path = full_path.substr(0, full_path.find_last_of("."));    
    std::string line;
    unsigned long long int num;
    boost::multiprecision::int128_t precise_num;
    std::ifstream infileF1(dir_path+"/f1.txt");
    while (std::getline(infileF1, line))
    {
        boost::erase_all(line, ",");
        std::istringstream iss(line);
        std::vector<long long unsigned int> flux;
        while (iss >> num){flux.push_back(num);}
        outfluxes_H1.push_back(flux);
    }
    std::ifstream infileF2(dir_path+"/f2.txt");
    while (std::getline(infileF2, line))
    {
        boost::erase_all(line, ",");
        std::istringstream iss(line);
        std::vector<long long unsigned int> flux;
        while (iss >> num){flux.push_back(num);}
        outfluxes_H2.push_back(flux);
    }
    std::ifstream infileD1(dir_path+"/d1.txt");
    while (std::getline(infileD1, line))
    {
        boost::erase_all(line, ",");
        std::istringstream iss(line);
        std::vector<boost::multiprecision::int128_t> dist;
        while (iss >> precise_num){dist.push_back(precise_num);}
        dist_H1.push_back(dist);
    }
    std::ifstream infileD2(dir_path+"/d2.txt");
    while (std::getline(infileD2, line))
    {
        boost::erase_all(line, ",");
        std::istringstream iss(line);
        std::vector<boost::multiprecision::int128_t> dist;
        while (iss >> precise_num){dist.push_back(precise_num);}
        dist_H2.push_back(dist);
    }
    
    // (1.3) Find minimum on H2
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
    
    // (1.4) Inform what we have achieved
    if ( display_details ){
        std::cout << "\n\n";
        std::cout << "Non-trivial outfluxes H1: " << outfluxes_H1.size() << ", " << dist_H1.size() << "\n";
        std::cout << "Non-trivial outfluxes H2: " << outfluxes_H2.size() << ", " << dist_H2.size() << "\n";
        std::cout << "Global minimum on H2: " << min_H2 << "\n";
        std::cout << "Now piece the local data together... \n\n";
    }
    
    // (2) Piece the data together
    // (2) Piece the data together
    
    std::chrono::steady_clock::time_point begin = std::chrono::steady_clock::now();
    
    // (2.0) Check for degenerate case
    std::vector<boost::multiprecision::int128_t> final_dist( h0Max + 1, 0 );
    if ( ( outfluxes_H1.size() > 0 ) and ( outfluxes_H2.size() > 0 ) ){
        
        // (2.1) Initialize variables
        std::vector<int> legs_per_component_halved( legs_per_component );
        for ( int i = 0; i < legs_per_component.size(); i++ ){
            legs_per_component_halved[ i ] = legs_per_component[ i ] / 2;
        }
        
        // (2.2) Perform scan
        std::vector<int> status( number_threads, 0 );
        boost::thread_group threadList2;
        if ( number_threads > 1 ){
            
            // distribute tasks to threads
            boost::multiprecision::int128_t total_number_tasks = ( boost::multiprecision::int128_t ) ( outfluxes_H1.size() * ( outfluxes_H1.size() + 1 ) / 2 );
            boost::multiprecision::int128_t average_number_tasks = total_number_tasks / number_threads;
            int start = 0;
            int stop;
            for ( int i = 0; i < number_threads; i++)
            {
                
                // initialize variables
                int pos = start - 1;
                boost::multiprecision::int128_t tasks = 0;
                
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
        
    }
    
    // (2.3) Take time
    std::chrono::steady_clock::time_point end = std::chrono::steady_clock::now();
    
    
    // (3) Print result
    // (3) Print result
    if ( display_details ){
        std::cout << "\n\n";
        std::cout << "##############\n";
        std::cout << "Found root distribution:\n";
        std::cout << "##############\n";
        for ( int i = 0; i < final_dist.size(); i++ ){
            std::cout << "H0 = " << i << ":\t" << final_dist[ i ] << "\n";
        }
        std::cout << "\n";
        std::cout << "Time for run: " << std::chrono::duration_cast<std::chrono::seconds>(end - begin).count() << "[s]\n\n";
    }
    std::ofstream ofile;
    //std::string full_path = argv[ 0 ];
    //std::string dir_path = full_path.substr(0, full_path.find_last_of("."));
    ofile.open( dir_path + "/result.txt" );
    ofile << "[ ";
    for ( int i = 0; i < final_dist.size() - 1; i ++ ){
        ofile << final_dist[ i ] << " ,";
    }
    ofile << final_dist[ final_dist.size() - 1 ] << " ];";
    ofile.close();
    
    // (4) Signal success
    // (4) Signal success
    return 0; 
    
}
