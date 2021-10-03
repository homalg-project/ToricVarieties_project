void UpdateDistribution( std::vector<unsigned long long int>& distribution, std::vector<unsigned long long int> & s );
void compute_distribution(
        std::vector<std::vector<unsigned long long int>> external_fluxes_proper_H1,
        std::vector<std::vector<unsigned long long int>> external_fluxes_proper_H2,
        std::vector<std::vector<unsigned long long int>> dist_H1_proper,
        std::vector<std::vector<unsigned long long int>> dist_H2_proper,
        std::vector<int> legs_per_component, int root, std::vector<unsigned long long int> & final_dist, int start, int stop );


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
        std::vector<std::vector<unsigned long long int>> external_fluxes_proper_H1,
        std::vector<std::vector<unsigned long long int>> external_fluxes_proper_H2,
        std::vector<std::vector<unsigned long long int>> dist_H1_proper,
        std::vector<std::vector<unsigned long long int>> dist_H2_proper,
        std::vector<int> legs_per_component, int root, std::vector<unsigned long long int> & final_dist, int start, int stop ){
    
    int number_components = legs_per_component.size();
    
    // form maps
    std::map<std::vector<unsigned long long int>, std::vector<unsigned long long int>> mapH1;
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
            std::vector<unsigned long long int> f3;
            for ( int c = 0; c < number_components; c++ ){
                f3.push_back( (unsigned long long int) ( ( 3 *  legs_per_component[ c ] * root ) / 2 - external_fluxes_proper_H1[ i ][ c ] - external_fluxes_proper_H2[ j ][ c ] ) );
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
