// Thread-safe iterator over H1fluxes, guarded methods to update central variables and status_updater
// Thread-safe iterator over H1fluxes, guarded methods to update central variables and status_updater

void UpdateDistributionThreadSafe( std::vector<unsigned long long int>& central, std::vector<unsigned long long int> & change );
void UpdateStatusThreadSafe( std::vector<int>& central, std::vector<int> & change );
void compute_distribution(
        std::vector<std::vector<unsigned long long int>> outfluxes_H1filtered,
        std::vector<std::vector<unsigned long long int>> outfluxes_H2filtered,
        std::vector<std::vector<unsigned long long int>> dist_H1filtered,
        std::vector<std::vector<unsigned long long int>> dist_H2filtered,
        std::vector<int> legs_per_component_halved,
        int root,
        int start,
        int stop,
        std::vector<unsigned long long int> & final_dist,
        int thread_number,
        std::vector<int> & status
        );
void status_updater( std::vector<int> & status );


// Guarded methods
// Guarded methods
void UpdateDistributionThreadSafe( std::vector<unsigned long long int>& central, std::vector<unsigned long long int> & change )
{
    
    std::lock_guard<std::mutex> guard(myMutexFlex);
    for ( int i = 0; i < change.size(); i ++ ){
        central[ i ] = central[ i ] + change[ i ];
    }
    
}

void UpdateStatusThreadSafe( std::vector<int>& status, int progress, int pos )
{
    
    std::lock_guard<std::mutex> guard(myMutexFlex);
    status[ pos ] = progress;
    std::string output = "Status: (";    
    for ( int i = 0; i < status.size() - 1; i ++ ){
        output = output + std::__cxx11::to_string( status[ i ] ) + ", ";
    }
    output = output + std::__cxx11::to_string( status[ status.size() - 1 ] ) + ")";
    std::cout << output << "\r" << std::flush;
    
}


// H1-iterator
// H1-iterator
void compute_distribution( 
        std::vector<std::vector<unsigned long long int>> outfluxes_H1filtered,
        std::vector<std::vector<unsigned long long int>> outfluxes_H2filtered,
        std::vector<std::vector<unsigned long long int>> dist_H1filtered,
        std::vector<std::vector<unsigned long long int>> dist_H2filtered,
        std::vector<int> legs_per_component_halved,
        int root,
        int start,
        int stop,
        std::vector<unsigned long long int> & final_dist,
        int thread_number,
        std::vector<int> & status ){
        
    // (1) Set variables
    std::vector<unsigned long long int> res( 31, 0 );
    int progress = 0;
    int number_components = legs_per_component_halved.size();
    std::vector<unsigned long long int> f1, f2, f3;
    std::vector<unsigned long long int> d1, d2, d3;
    std::vector<int> change ( status.size(), 0 );
    
    // (2) Form H1 map for quick access (-> Hash table)
    std::map<std::vector<unsigned long long int>, std::vector<unsigned long long int>> mapH1;
    for ( int i = 0; i < outfluxes_H1filtered.size(); i ++ ){
        mapH1.insert( std::make_pair( outfluxes_H1filtered[ i ], dist_H1filtered[ i ] ) );
    }
    
    // (3) Loop over H1-fluxes
    for ( int i = start; i <= stop; i++ ){

        // (3.1) Signal progress
        if ( progress < int ( 100 * ( i - start ) / ( stop - start ) ) ){
            progress = int ( 100 * ( i - start ) / ( stop - start ) );
            UpdateStatusThreadSafe( status, progress, thread_number );
        }

        // (3.2) Loop over H2 fluxes
        for ( int j = 0; j < outfluxes_H2filtered.size(); j++ ){
            
            // (3.2.1) Compute H3 flux f3
            std::vector<unsigned long long int> f3;
            for ( int c = 0; c < number_components; c++ ){
                f3.push_back( (unsigned long long int) ( 3 *  legs_per_component_halved[ c ] * root - outfluxes_H1filtered[ i ][ c ] - outfluxes_H2filtered[ j ][ c ] ) );
            }
            
            // (3.2.2) Only proceed if H3 flux f3 has non-trivial distribution
            if ( mapH1.find( f3 ) != mapH1.end() ){

                // Compute combinatorial factor
                unsigned long long int factor = 1;
                for ( int c = 0; c < number_components; c++ ){
                    factor = factor * comb_factor( outfluxes_H1filtered[ i ][ c ], outfluxes_H2filtered[ j ][ c ], legs_per_component_halved[ c ], root );
                }
                
                // Update resulting distribution
                d1 = dist_H1filtered[ i ];
                d2 = dist_H2filtered[ j ];
                d3 = mapH1[ f3 ];
                for ( int a1 = 0; a1 < d1.size(); a1++ ){
                    for ( int a2 = 0; a2 < d2.size(); a2++ ){
                        for ( int a3 = 0; a3 < d3.size(); a3++ ){
                            if ( ( d1[ a1 ] != 0 ) && ( d2[ a2 ] != 0 ) && ( d3[ a3 ] != 0 ) ){
                                res[ a1 + a2 + a3 ] = res[ a1 + a2 + a3 ] + factor * d1[ a1 ] * d2[ a2 ] * d3[ a3 ];
                            }
                        }
                    }
                }
            }
            
        }
        
    }

    // (4) Update central distribution result
    UpdateDistributionThreadSafe( final_dist, res );
        
}
