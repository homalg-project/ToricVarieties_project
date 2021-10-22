// Thread-safe iterator over H1fluxes, guarded methods to update central variables and status_updater
// Thread-safe iterator over H1fluxes, guarded methods to update central variables and status_updater

void UpdateDistributionThreadSafe( std::vector<boost::multiprecision::int128_t>& central, std::vector<boost::multiprecision::int128_t> & change );
void UpdateStatusThreadSafe( std::vector<int>& central, std::vector<int> & change );
void compute_distribution(
        std::vector<std::vector<unsigned long long int>> outfluxes_H1filtered,
        std::vector<std::vector<unsigned long long int>> outfluxes_H2filtered,
        std::vector<std::vector<boost::multiprecision::int128_t>> dist_H1filtered,
        std::vector<std::vector<boost::multiprecision::int128_t>> dist_H2filtered,
        std::vector<int> legs_per_component_halved,
        std::vector<int> integer_data,
        std::vector<boost::multiprecision::int128_t> & final_dist,
        std::vector<int> & status
        );
void compute_diagonal_distribution(
        std::vector<std::vector<unsigned long long int>> outfluxes_H1filtered,
        std::vector<std::vector<unsigned long long int>> outfluxes_H2filtered,
        std::vector<std::vector<boost::multiprecision::int128_t>> dist_H1filtered,
        std::vector<std::vector<boost::multiprecision::int128_t>> dist_H2filtered,
        std::vector<int> legs_per_component_halved,
        std::vector<int> integer_data,
        std::vector<boost::multiprecision::int128_t> & final_dist,
        std::vector<int> & status
        );
void status_updater( std::vector<int> & status );


// Guarded methods
// Guarded methods
void UpdateDistributionThreadSafe( std::vector<boost::multiprecision::int128_t>& central, std::vector<boost::multiprecision::int128_t> & change )
{
    
    boost::mutex::scoped_lock lock(myGuard);
    for ( int i = 0; i < change.size(); i ++ ){
        central[ i ] = central[ i ] + change[ i ];
    }
    
}

void UpdateStatusThreadSafe( std::vector<int>& status, int progress, int pos )
{
    
    boost::mutex::scoped_lock lock(myGuard2);
    status[ pos ] = progress;
    std::string output = "Status [%]: (";    
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
        std::vector<std::vector<boost::multiprecision::int128_t>> dist_H1filtered,
        std::vector<std::vector<boost::multiprecision::int128_t>> dist_H2filtered,
        std::vector<int> legs_per_component_halved,
        std::vector<int> integer_data,
        std::vector<boost::multiprecision::int128_t> & final_dist,
        std::vector<int> & status ){
    
    // (0) Extract integer data
    int root = integer_data[ 0 ];
    int start = integer_data[ 1 ];
    int stop = integer_data[ 2 ];
    int thread_number = integer_data[ 3 ];
    int min_H2 = integer_data[ 4 ];
    
    // (1) Set variables
    std::vector<boost::multiprecision::int128_t> res( final_dist.size(), 0 );
    int progress = 0;
    int number_components = legs_per_component_halved.size();
    std::vector<unsigned long long int> f1, f2, f3;
    std::vector<boost::multiprecision::int128_t> d1, d2, d3;
    std::vector<int> change ( status.size(), 0 );
    
    // (1.1) Compute minima of H1 and H2 distributions
    std::vector<int> m1;
    for ( int i = 0; i < dist_H1filtered.size(); i++ ){
        m1.push_back( std::distance( std::begin( dist_H1filtered[ i ] ), std::find_if( std::begin( dist_H1filtered[ i ] ), std::end( dist_H1filtered[ i ] ), [](boost::multiprecision::int128_t x) { return x != 0; }) ) );
    }

    // (2) Form H2 map for quick access (-> Hash table)    
    std::map<std::vector<unsigned long long int>, std::vector<boost::multiprecision::int128_t>> mapH2;
    int m2;
    std::map<std::vector<unsigned long long int>, int> mapm2;
    for ( int i = 0; i < dist_H2filtered.size(); i++ ){
        mapH2.insert( std::make_pair( outfluxes_H2filtered[ i ], dist_H2filtered[ i ] ) );
        m2 = std::distance( std::begin( dist_H2filtered[ i ] ), std::find_if( std::begin( dist_H2filtered[ i ] ), std::end( dist_H2filtered[ i ] ), [](boost::multiprecision::int128_t x) { return x != 0; }) );
        mapm2.insert( std::make_pair( outfluxes_H2filtered[ i ], m2 ) );
    }
    
    // (3) Loop over H1-fluxes
    for ( int i = start; i <= stop; i++ ){
        
        // (3.1) Loop over H3 fluxes
        for ( int j = i+1; j < outfluxes_H1filtered.size(); j++ ){
            
            // (3.1.1) Only proceed if m1 + min_H2 + m3 does not exceed the prescribed h0 limit
            if ( m1[ i ] + min_H2 + m1[ j ] < res.size() ){
            
                // (3.1.2) Compute H2 flux f2
                std::vector<unsigned long long int> f2;
                for ( int c = 0; c < number_components; c++ ){
                    f2.push_back( (unsigned long long int) ( 3 *  legs_per_component_halved[ c ] * root - outfluxes_H1filtered[ i ][ c ] - outfluxes_H1filtered[ j ][ c ] ) );
                }
                
                // (3.1.3) Only proceed if H2 flux f2 has non-trivial distribution
                if ( mapH2.find( f2 ) != mapH2.end() ){
                    
                    // (3.1.5) only proceed if necessary
                    if ( m1[ i ] + mapm2[ f2 ] + m1[ j ] < res.size() ){
                        
                        // Compute combinatorial factor
                        boost::multiprecision::int128_t factor = 1;
                        for ( int c = 0; c < number_components; c++ ){
                            factor = factor * ( boost::multiprecision::int128_t ) comb_factor( outfluxes_H1filtered[ i ][ c ], f2[ c ], legs_per_component_halved[ c ], root );
                        }
                        
                        // Update resulting distribution
                        d1 = dist_H1filtered[ i ];
                        d2 = mapH2[ f2 ];
                        d3 = dist_H1filtered[ j ];
                        for ( int a1 = 0; a1 < d1.size(); a1++ ){
                            for ( int a2 = 0; a2 < d2.size(); a2++ ){
                                for ( int a3 = 0; a3 < d3.size(); a3++ ){
                                    if ( ( d1[ a1 ] != 0 ) && ( d2[ a2 ] != 0 ) && ( d3[ a3 ] != 0 ) && ( a1 + a2 + a3 < res.size() ) ){
                                        res[ a1 + a2 + a3 ] = res[ a1 + a2 + a3 ] + factor * (boost::multiprecision::int128_t ) d1[ a1 ] * (boost::multiprecision::int128_t) d2[ a2 ] * (boost::multiprecision::int128_t) d3[ a3 ];
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
        }
        
        // (3.2) Signal progress
        if ( start == stop ){
            progress = 100;
            UpdateStatusThreadSafe( status, progress, thread_number );
        }
        else{
            if ( progress < int ( 100 * ( i - start ) / ( stop - start ) ) ){
                progress = int ( 100 * ( i - start ) / ( stop - start ) );
                UpdateStatusThreadSafe( status, progress, thread_number );
            }
        }

    }
    
    // (4) Final steps - multiply by 2 (symmetry factor) and report results
    for ( int i = 0; i < res.size(); i++ ){
        res[ i ] = ( (boost::multiprecision::int128_t) 2 ) * res[ i ];
    }
    UpdateDistributionThreadSafe( final_dist, res );
        
}


// H1-diagonal-iterator
// H1-diagonal-iterator
void compute_diagonal_distribution( 
        std::vector<std::vector<unsigned long long int>> outfluxes_H1filtered,
        std::vector<std::vector<unsigned long long int>> outfluxes_H2filtered,
        std::vector<std::vector<boost::multiprecision::int128_t>> dist_H1filtered,
        std::vector<std::vector<boost::multiprecision::int128_t>> dist_H2filtered,
        std::vector<int> legs_per_component_halved,
        std::vector<int> integer_data,
        std::vector<boost::multiprecision::int128_t> & final_dist,
        std::vector<int> & status ){
    
    // (0) Extract integer data
    int root = integer_data[ 0 ];
    int start = integer_data[ 1 ];
    int stop = integer_data[ 2 ];
    int thread_number = integer_data[ 3 ];
    int min_H2 = integer_data[ 4 ];
    
    // (1) Set variables
    std::vector<boost::multiprecision::int128_t> res( final_dist.size(), 0 );
    int progress = 0;
    int number_components = legs_per_component_halved.size();
    std::vector<unsigned long long int> f1, f2, f3;
    std::vector<boost::multiprecision::int128_t> d1, d2, d3;
    std::vector<int> change ( status.size(), 0 );
    
    // (1.1) Compute minima of H1 and H2 distributions
    std::vector<int> m1;
    for ( int i = 0; i < dist_H1filtered.size(); i++ ){
        m1.push_back( std::distance( std::begin( dist_H1filtered[ i ] ), std::find_if( std::begin( dist_H1filtered[ i ] ), std::end( dist_H1filtered[ i ] ), [](boost::multiprecision::int128_t x) { return x != 0; }) ) );
    }
    
    // (2) Form H2 map for quick access (-> Hash table)    
    std::map<std::vector<unsigned long long int>, std::vector<boost::multiprecision::int128_t>> mapH2;
    int m2;
    std::map<std::vector<unsigned long long int>, int> mapm2;
    for ( int i = 0; i < dist_H2filtered.size(); i++ ){
        mapH2.insert( std::make_pair( outfluxes_H2filtered[ i ], dist_H2filtered[ i ] ) );
        m2 = std::distance( std::begin( dist_H2filtered[ i ] ), std::find_if( std::begin( dist_H2filtered[ i ] ), std::end( dist_H2filtered[ i ] ), [](boost::multiprecision::int128_t x) { return x != 0; }) );
        mapm2.insert( std::make_pair( outfluxes_H2filtered[ i ], m2 ) );
    }
    
    // (3) Identify total number of computations
    int total = stop - start + outfluxes_H1filtered.size();
    int count = 0;
    
    // (4) Loop over H1-fluxes
    for ( int i = start; i <= stop; i++ ){
        
        // (4.1) Loop over H3 fluxes
        for ( int j = i+1; j < outfluxes_H1filtered.size(); j++ ){
            
            // (4.1.1) Only proceed if m1 + min_H2 + m3 does not exceed the prescribed h0 limit
            if ( m1[ i ] + min_H2 + m1[ j ] < res.size() ){
            
                // (4.1.2) Compute H2 flux f2
                std::vector<unsigned long long int> f2;
                for ( int c = 0; c < number_components; c++ ){
                    f2.push_back( (unsigned long long int) ( 3 *  legs_per_component_halved[ c ] * root - outfluxes_H1filtered[ i ][ c ] - outfluxes_H1filtered[ j ][ c ] ) );
                }
                
                // (4.1.3) Only proceed if H2 flux f2 has non-trivial distribution
                if ( mapH2.find( f2 ) != mapH2.end() ){
                    
                    // (4.1.4) only proceed if necessary
                    if ( m1[ i ] + mapm2[ f2 ] + m1[ j ] < res.size() ){
                        
                        // Compute combinatorial factor
                        boost::multiprecision::int128_t factor = 1;
                        for ( int c = 0; c < number_components; c++ ){
                            factor = factor * ( boost::multiprecision::int128_t ) comb_factor( outfluxes_H1filtered[ i ][ c ], f2[ c ], legs_per_component_halved[ c ], root );
                        }
                        
                        // Update resulting distribution
                        d1 = dist_H1filtered[ i ];
                        d2 = mapH2[ f2 ];
                        d3 = dist_H1filtered[ j ];
                        for ( int a1 = 0; a1 < d1.size(); a1++ ){
                            for ( int a2 = 0; a2 < d2.size(); a2++ ){
                                for ( int a3 = 0; a3 < d3.size(); a3++ ){
                                    if ( ( d1[ a1 ] != 0 ) && ( d2[ a2 ] != 0 ) && ( d3[ a3 ] != 0 ) && ( a1 + a2 + a3 < res.size() ) ){
                                        res[ a1 + a2 + a3 ] = res[ a1 + a2 + a3 ] + factor * (boost::multiprecision::int128_t ) d1[ a1 ] * (boost::multiprecision::int128_t) d2[ a2 ] * (boost::multiprecision::int128_t) d3[ a3 ];
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
        }
        
        // (4.2) Signal progress
        count++;
        if ( progress < int ( 100 * count / total ) ){
                progress = int ( 100 * count / total );
                UpdateStatusThreadSafe( status, progress, thread_number );
        }

    }
    
    // (5) Multiply the results computed thus far by 2 (symmetry factor)
    for ( int i = 0; i < res.size(); i++ ){
        res[ i ] = ( (boost::multiprecision::int128_t) 2 ) * res[ i ];
    }
    
    // (6) Loop over diagonal (H1) fluxes: H3-flux = H1-flux
    for ( int i = 0; i <= outfluxes_H1filtered.size()-1; i++ ){
        
        // (6.1) Only proceed if necessary
        if ( m1[ i ] + min_H2 + m1[ i ] < res.size() ){
            
            // (6.2.1) Compute H2 flux f2
            std::vector<unsigned long long int> f2;
            for ( int c = 0; c < number_components; c++ ){
                f2.push_back( (unsigned long long int) ( 3 *  legs_per_component_halved[ c ] * root - outfluxes_H1filtered[ i ][ c ] - outfluxes_H1filtered[ i ][ c ] ) );
            }
            
            // (6.2.2) Only proceed if H2 flux f2 has non-trivial distribution
            if ( mapH2.find( f2 ) != mapH2.end() ){
                
                // (6.2.3) only proceed if necessary
                if ( m1[ i ] + mapm2[ f2 ] + m1[ i ] < res.size() ){
                    
                    // Compute combinatorial factor
                    boost::multiprecision::int128_t factor = 1;
                    for ( int c = 0; c < number_components; c++ ){
                        factor = factor * ( boost::multiprecision::int128_t ) comb_factor( outfluxes_H1filtered[ i ][ c ], f2[ c ], legs_per_component_halved[ c ], root );
                    }
                    
                    // Update resulting distribution
                    d1 = dist_H1filtered[ i ];
                    d2 = mapH2[ f2 ];
                    d3 = d1;
                    for ( int a1 = 0; a1 < d1.size(); a1++ ){
                        for ( int a2 = 0; a2 < d2.size(); a2++ ){
                            for ( int a3 = 0; a3 < d3.size(); a3++ ){
                                if ( ( d1[ a1 ] != 0 ) && ( d2[ a2 ] != 0 ) && ( d3[ a3 ] != 0 ) && ( a1 + a2 + a3 < res.size() ) ){
                                    res[ a1 + a2 + a3 ] = res[ a1 + a2 + a3 ] + factor * (boost::multiprecision::int128_t ) d1[ a1 ] * (boost::multiprecision::int128_t) d2[ a2 ] * (boost::multiprecision::int128_t) d3[ a3 ];
                                }
                            }
                        }
                    }
                }
            }
            
        }
        
        // (6.4) Signal progress
        count++;
        if ( progress < int ( 100 * count / total ) ){
                progress = int ( 100 * count / total );
                UpdateStatusThreadSafe( status, progress, thread_number );
        }
    
    }
    
    // (7) Final step - report result
    UpdateDistributionThreadSafe( final_dist, res );
    
}
