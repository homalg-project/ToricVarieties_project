// A program to compute the number of minimal limit roots on full blowups of nodal curves

#include<algorithm>
#include <chrono>
#include <fstream>
#include <functional>
#include<iostream>
#include <map>
#include <mutex>
#include <sstream> 
#include <thread>
#include <vector>

#include "Read.cpp"
#include "Partitions.cpp"
#include "HiggsDistributionCounter.cpp"

// Optimizations for speedup
#pragma GCC optimize("Ofast")
#pragma GCC target("avx,avx2,fma")


// The main routine
int main(int argc, char* argv[]) {

    // (1) Set constants
    int number_threads = 1;
    int root = 12;
    std::vector<int> legs_per_component = { 2,4,4,2 };
    int number_components = legs_per_component.size();
    std::vector<unsigned long long int> final_dist( 31, 0 );
    
    // (2) Read data
    std::vector<std::vector<unsigned long long int>> outfluxes;
    ReadData( outfluxes, "Data/Fluxes.txt" );
    std::vector<std::vector<unsigned long long int>> dist_H1;
    ReadData( dist_H1, "Data/H1.txt" );
    std::vector<std::vector<unsigned long long int>> dist_H2;
    ReadData( dist_H2, "Data/H2.txt" );
    std::cout << "Read data:\n";
    std::cout << "Total outfluxes: " << outfluxes.size() << "\n";
    std::cout << "Total distributions on H1: " << dist_H1.size() << "\n";
    std::cout << "Total distributions on H2: " << dist_H2.size() << "\n\n";
        
    // (3) Filter out trivial data
    std::vector<std::vector<unsigned long long int>> outfluxes_H1filtered, outfluxes_H2filtered;
    std::vector<std::vector<unsigned long long int>> dist_H1filtered, dist_H2filtered;
    for ( int i = 0; i < outfluxes.size(); i++ ){
        
        if ( dist_H1[ i ].size() > 1 ){
            outfluxes_H1filtered.push_back( outfluxes[ i ] );
            dist_H1filtered.push_back( dist_H1[ i ] );
        }
        
        if ( dist_H2[ i ].size() > 1 ){
            outfluxes_H2filtered.push_back( outfluxes[ i ] );
            dist_H2filtered.push_back( dist_H2[ i ] );
        }
        
    }
    std::cout << "Filtered -- found non-trivial data:\n";
    std::cout << "H1: " << outfluxes_H1filtered.size() << "\n";
    std::cout << "H2: " << outfluxes_H2filtered.size() << "\n\n";
    
    // (4) Partition workload to threads
    int package_size = outfluxes_H1filtered.size() / number_threads;
    std::vector<std::thread> threadList;
    int start, stop;
    for (int i = 0; i < number_threads; i++)
    {

        // Find start and stop position for thread
        start = i * package_size;
        if ( i < number_threads - 1 ){ stop = ( i + 1 ) * package_size - 1; }
        else{ stop = (int) outfluxes_H1filtered.size() -1; }
        
        // Signal that we start this thread
        std::cout << "Start thread " << i << "\n";
        
        // Start the thread
        compute_distribution( outfluxes_H1filtered, outfluxes_H2filtered, dist_H1filtered, dist_H2filtered, number_components, legs_per_component, root, std::ref( final_dist ), start, stop );
        //threadList.push_back( std::thread( compute_distribution, outfluxes_H1filtered, outfluxes_H2filtered, dist_H1filtered, dist_H2filtered, number_components, legs_per_component, root, std::ref( final_dist ), start, stop ) );
        
    }
    
    // (5) Wait for threads to complete
    std::for_each(threadList.begin(),threadList.end(), std::mem_fn(&std::thread::join));
    
    // (6) Print result
    std::cout << "##############\n";
    std::cout << "Found root distribution:\n";
    std::cout << "##############\n";
    for ( int i = 0; i < final_dist.size(); i++ ){
        std::cout << "H0 = " << i << ":\t" << final_dist[ i ] << "\n";
    }
    
    // (7) Signal success
    return 0;
    
}
