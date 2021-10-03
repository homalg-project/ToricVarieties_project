// A program to compute the number of minimal limit roots on full blowups of nodal curves

#include <chrono>
#include <fstream>
#include<iostream>
#include <map>
#include <mutex>
#include <sstream> 
#include <thread>
#include <vector>

#include "Partitions.cpp"
#include "Read.cpp"


// Optimizations for speedup
#pragma GCC optimize("Ofast")
#pragma GCC target("avx,avx2,fma")


// guard watching modifications of final_dist
std::mutex myMutexFlex;
void UpdateDistribution( std::vector<unsigned long long int>& distribution, std::vector<unsigned long long int> & s )
{
    
    std::lock_guard<std::mutex> guard(myMutexFlex);
    for ( int i = 0; i < s.size(); i ++ ){
        distribution[ i ] = distribution[ i ] + s[ i ];
    }
    
}


// function to be run in thread
void compute_distribution( 
        std::vector<std::vector<int>> external_fluxes_proper_H1,
        std::vector<std::vector<int>> external_fluxes_proper_H2,
        std::vector<std::vector<unsigned long long int>> dist_H1_proper,
        std::vector<std::vector<unsigned long long int>> dist_H2_proper,
        int number_components, std::vector<int> legs_per_component, int root, std::vector<unsigned long long int> & final_dist, int start, int stop ){
    
    // form maps
    std::map<std::vector<int>, std::vector<unsigned long long int>> mapH1;
    for ( int i = 0; i < external_fluxes_proper_H1.size(); i ++ ){
        mapH1.insert( std::make_pair( external_fluxes_proper_H1[ i ], dist_H1_proper[ i ] ) );
    }
    
    // start loop <- main routine
    std::vector<int> f1, f2, f3;
    std::vector<unsigned long long int> d1, d2, d3;
    std::vector<unsigned long long int> res( 31, 0 );
    /*for ( int b = 0; b < res.size(); b++ ){
        res[ b ] = 0;
        std::cout << res[ b ] << ", ";
    }
    std::cout << res.size() << "\n";*/
    int progress = 0;
    
    for ( int i = start; i <= stop; i++ ){

        // (1) inform about progress
        if ( progress < int ( 100 * ( i - start ) / ( stop - start ) ) ){
            progress = int ( 100 * ( i - start ) / ( stop - start ) );
            std::cout << "i = " << i << " (" << progress << "%)\n";
        }

        // (2) loops over H2 fluxes
        for ( int j = 0; j < external_fluxes_proper_H2.size(); j++ ){
            
            // (3) form flux f3
            std::vector<int> f3;
            for ( int c = 0; c < number_components; c++ ){
                f3.push_back( (int) ( ( 3 *  legs_per_component[ c ] * root ) / 2 - external_fluxes_proper_H1[ i ][ c ] - external_fluxes_proper_H2[ j ][ c ] ) );
            }
            
            // (4) skip if this does not define a "good" flux or distribution is trivial
            if ( mapH1.find( f3 ) != mapH1.end() ){

                // (5) find combinatorics factor
                unsigned long long int factor = 1;
                for ( int c = 0; c < number_components; c++ ){
                    factor = factor * comb_factor( external_fluxes_proper_H1[ i ][ c ], external_fluxes_proper_H2[ j ][ c ], (int) ( legs_per_component[ c ] / 2 ), root );
                }
                //std::cout << "Computed combinatorial factor: " << factor << "\n";
                
                // (6) identify contribution
                d1 = dist_H1_proper[ i ];
                d2 = dist_H2_proper[ j ];
                d3 = mapH1[ f3 ];
                for ( int a1 = 0; a1 < d1.size(); a1++ ){
                    for ( int a2 = 0; a2 < d2.size(); a2++ ){
                        for ( int a3 = 0; a3 < d3.size(); a3++ ){
                            if ( ( d1[ a1 ] != 0 ) && ( d2[ a2 ] != 0 ) && ( d3[ a3 ] != 0 ) ){
                                res[ a1 + a2 + a3 ] = res[ a1 + a2 + a3 ] + factor * d1[ a1 ] * d2[ a2 ] * d3[ a3 ];
                                /*for ( int b = 0; b <res.size(); b++ ){
                                    std::cout << res[ b ] << ", ";
                                }
                                std::cout << res.size() << "\n";*/
                            }
                        }
                    }
                }
            }
            
            // inform about status in j-loop
            //std::cout << "j = " << j << " out of " << external_fluxes_proper_H2.size() << "\n";
            
        }
        
        // inform about status in i-loop
        /*std::cout << "i = " << i << " out of " << stop << "\n";
        for ( int b = 0; b <res.size(); b++ ){
            std::cout << res[ b ] << ", ";
        }
        std::cout << res.size() << "\n";*/
        
    }

    // update the final distribution found
    UpdateDistribution( final_dist, res );

    std::cout << "Thread complete. Found distribution: (";
    for ( int b = 0; b <res.size(); b++ ){
        std::cout << res[ b ] << ", ";
    }
    std::cout << ")\n\n";
    
}



// The main routine
int main(int argc, char* argv[]) {
    
    // set constants
    int root = 12;
    std::vector<int> legs_per_component = { 2,4,4,2 };
    int number_components = legs_per_component.size();
    std::vector<unsigned long long int> final_dist( 31 );
    int value = 0;
    std::fill( final_dist.begin(), final_dist.end(), value);
    int number_threads = 1;
    
    // read data
    std::vector<std::vector<int>> external_fluxes;
    ReadFluxes( external_fluxes );
    std::vector<std::vector<unsigned long long int>> dist_H1;
    ReadHi( dist_H1, 1 );
    std::vector<std::vector<unsigned long long int>> dist_H2;
    ReadHi( dist_H2, 2 );
    std::cout << "Read data:\n";
    std::cout << "Total external fluxes: " << external_fluxes.size() << "\n";
    std::cout << "Total distributions on H1: " << dist_H1.size() << "\n";
    std::cout << "Total distributions on H2: " << dist_H2.size() << "\n\n";
    
    // filter out trivial data
    std::vector<std::vector<int>> external_fluxes_proper_H1, external_fluxes_proper_H2;
    std::vector<std::vector<unsigned long long int>> dist_H1_proper, dist_H2_proper;
    for ( int i = 0; i < external_fluxes.size(); i++ ){
        
        if ( dist_H1[ i ].size() > 1 ){
            external_fluxes_proper_H1.push_back( external_fluxes[ i ] );
            dist_H1_proper.push_back( dist_H1[ i ] );
        }
        
        if ( dist_H2[ i ].size() > 1 ){
            external_fluxes_proper_H2.push_back( external_fluxes[ i ] );
            dist_H2_proper.push_back( dist_H2[ i ] );
        }
        
    }
    std::cout << "Filtered -- found non-trivial data:\n";
    std::cout << "H1: " << external_fluxes_proper_H1.size() << "\n";
    std::cout << "H2: " << external_fluxes_proper_H2.size() << "\n\n";
    
    // gather combinatorics data?
    
    // partition combinatorics to a number of threads
    int average_data_package_size = external_fluxes_proper_H1.size() / number_threads;
    std::vector<std::vector<int>> data_package_iterators( number_threads );
    for ( int i = 0; i < number_threads - 1; i ++ ){
        std::vector<int> dummy { i * average_data_package_size, ( i + 1 ) * average_data_package_size - 1 };
        data_package_iterators[ i ] = dummy;
    }
    std::vector<int> dummy { (number_threads - 1 ) * average_data_package_size, (int) external_fluxes_proper_H1.size() -1 };
    data_package_iterators[ number_threads - 1 ] = dummy;
    
    // start the threads
    /*std::vector<std::thread> threadList;
    for (int i = 0; i < number_threads; i++)
    {
        std::cout << "Start thread " << i << "\n";
        int start = data_package_iterators[ i ][ 0 ];
        int stop = data_package_iterators[ i ][ 1 ];        
        threadList.push_back( std::thread( compute_distribution, external_fluxes_proper_H1, external_fluxes_proper_H2, dist_H1_proper, dist_H2_proper, number_components, legs_per_component, root, std::ref( final_dist ), start, stop ) );
    }
    
    //compute_distribution( external_fluxes_proper_H1, external_fluxes_proper_H2, dist_H1_proper, dist_H2_proper, number_components, legs_per_component, root, std::ref( final_dist ), 0, external_fluxes_proper_H1.size() -1 );
    
    // Now wait for the results of the worker threads (i.e. call the join() function on each of the std::thread objects) and inform the user
    std::for_each(threadList.begin(),threadList.end(), std::mem_fn(&std::thread::join));*/
    
    // print final distribution
    std::cout << "Root_dist: ";
    for ( int i = 0; i < final_dist.size(); i++ ){
        std::cout << final_dist[ i ] << ", ";
    }
    std::cout << ")\n";

    
    // signal success
    return 0;
    
}

