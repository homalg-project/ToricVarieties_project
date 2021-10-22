void UpdateCollectedData( std::vector<std::vector<unsigned long long int>>& collector1,
                                            std::vector<std::vector<boost::multiprecision::int128_t>>& collector2,
                                            std::vector<unsigned long long int> & change1,
                                            std::vector<boost::multiprecision::int128_t> & change2 )
{
    
    boost::mutex::scoped_lock lock(myGuard);
    collector1.push_back( change1 );
    collector2.push_back( change2 );
    
}

void UpdateStatus( std::vector<int>& status, int thread_number, int progress )
{
    
    boost::mutex::scoped_lock lock(myGuard2);
    status[ thread_number ] = progress;
    std::string output = "Status [%]: (";
    int s = 0;
    for ( int i = 0; i < status.size() - 1; i ++ ){
        s = s + status[ i ];
    }
    s = s / status.size();
    output = output + std::__cxx11::to_string( s ) + ")";
    std::cout << output << "\r" << std::flush;
    
}

void FluxScanner(    std::vector<std::vector<unsigned long long int>> all_outfluxes,
                                std::vector<std::vector<unsigned long long int>> & outfluxes_H1, 
                                std::vector<std::vector<unsigned long long int>> & outfluxes_H2,
                                std::vector<std::vector<boost::multiprecision::int128_t>> & dist_H1,
                                std::vector<std::vector<boost::multiprecision::int128_t>> & dist_H2,
                                std::vector<int> & status,
                                std::vector<int> input,
                                int thread_number,
                                std::vector<int> interval
                )
{

    // (1) Extract the input data
    std::vector<int> vertices( input[ 0 ] );
    std::vector<int> degrees_H1( input[ 0 ] );
    std::vector<int> degrees_H2( input[ 0 ] );
    std::vector<int> genera( input[ 0 ] );
    for ( int i = 1; i <= input[ 0 ]; i++ ){
        vertices[ i - 1 ] = i - 1;
        degrees_H1[ i - 1 ] = input[ i ];
        degrees_H2[ i - 1] = input[ i + input[ 0 ] ];
        genera[ i - 1 ] = input[ i + 2 * input[ 0 ] ];
    }
    int total_degree_H1 = std::accumulate( degrees_H1.begin(), degrees_H1.end(), 0 );
    int total_degree_H2 = std::accumulate( degrees_H2.begin(), degrees_H2.end(), 0 );
    int numberEdges = input[ 3 * input[ 0 ] + 1 ];
    std::vector<std::vector<int>> edges;
    for ( int i = 0; i < numberEdges; i ++ ){
        int index = 2 + 3 * input[ 0 ] + 2 * i;
        std::vector<int> helper = { input[ index ], input[ index + 1 ] };
        edges.push_back( helper );
    }
    std::vector<int> legs_per_component;
    std::vector<int> external_legs;
    for ( int i = 0; i < input[ 0 ]; i ++ ){
        legs_per_component.push_back( input[ 3 * input[ 0 ] + 1 + 1 + 2 * numberEdges + i ] );
        for ( int j = 0; j < input[ 3 * input[ 0 ] + 1 + 1 + 2 * numberEdges + i ]; j++ ){
            external_legs.push_back( i );
        }
    }
    int number_external_legs = std::accumulate( legs_per_component.begin(), legs_per_component.end(), 0 );
    int genus = input[ 4 * input[ 0 ] + 2 * numberEdges + 2 ];
    int root = input[ 4 * input[ 0 ] + 2 * numberEdges + 3 ];
    int h0Max = input[ 4 * input[ 0 ] + 2 * numberEdges + 5 ];
    int start = interval[ 0 ];
    int stop = interval[ 1 ];
    int number_sub_threads = 1;
    int h0MinUsed = 0;
    int progress = 0;
     
    // (2) Iterate
    for ( int i = start; i <= stop; i++ ){

        // (2.1) Compute total outflux
        int total_flux = std::accumulate( all_outfluxes[ i ].begin(), all_outfluxes[ i ].end(), 0 );
        
        // (2.2) Generate weights for the outflux
        std::vector<int> external_weights( number_external_legs );
        int iterator = 0;
        for ( int j = 0; j < legs_per_component.size(); j++ ){
            
            int flux_for_component = all_outfluxes[ i ][ j ];
            int leg_number = legs_per_component[ j ];
            int remaining_legs = leg_number;
            
            for ( int k = 0; k < leg_number; k++ ){
                external_weights[ iterator ] = flux_for_component / remaining_legs;
                flux_for_component = flux_for_component - ( flux_for_component / remaining_legs );
                remaining_legs = remaining_legs - 1;
                iterator = iterator + 1;
            }
            
        }
        
        // (2.3) Compute corresponding distribution on H1
        bool display = false;
        if ( ( total_degree_H1 - total_flux ) % root == 0 ){
            
            // Construct weighted H1-diagram
            WeightedDiagramWithExternalLegs dia_H1 = WeightedDiagramWithExternalLegs( vertices, degrees_H1, genera, edges, external_legs, external_weights, genus, root );
            
            // Only proceed if situation is not automatically degenerate
            h0MinUsed = dia_H1.get_h0_min();
            if ( h0Max >= h0MinUsed ){
                
                // Compute distribution
                std::vector<boost::multiprecision::int128_t> n( h0Max - h0MinUsed + 1, 0 );
                countRootDistribution( dia_H1, number_sub_threads, h0MinUsed, h0Max, n, display );
                
                // Check if distribution is not trivial
                bool zeros = std::all_of( n.begin(), n.end(), [](boost::multiprecision::int128_t j) { return j==0; } );
                
                // Append if the result is not trivial
                if ( ! zeros ){
                    
                    // Prepare result
                    std::vector<boost::multiprecision::int128_t> dist( h0Max + 1, 0 );
                    for ( int j = 0; j < n.size(); j++ ){
                        dist[ j + h0MinUsed ] = n[ j ];
                    }
                    
                    // And remember this result
                    UpdateCollectedData( outfluxes_H1, dist_H1, all_outfluxes[ i ], dist );
                    
                }
                
            }
        }
        
        // (2.4) Compute corresponding distribution on H2
        if ( ( total_degree_H2 - total_flux ) % root == 0 ){
            
            // Construct weighted H2-diagram
            WeightedDiagramWithExternalLegs dia_H2 = WeightedDiagramWithExternalLegs( vertices, degrees_H2, genera, edges, external_legs, external_weights, genus, root );
            
            // Only proceed if situation is not automatically degenerate
            h0MinUsed = dia_H2.get_h0_min();
            if ( h0Max >= h0MinUsed ){
                
                // Compute distribution
                std::vector<boost::multiprecision::int128_t> n( h0Max - h0MinUsed + 1, 0 );
                countRootDistribution( dia_H2, number_sub_threads, h0MinUsed, h0Max, n, display );
                
                // Check if distribution is not trivial
                bool zeros = std::all_of( n.begin(), n.end(), [](boost::multiprecision::int128_t j) { return j==0; } );
                
                // Append if the result is not trivial
                if ( ! zeros ){
                    
                    // Prepare distribution
                    std::vector<boost::multiprecision::int128_t> dist( h0Max + 1, 0 );
                    for ( int j = 0; j < n.size(); j++ ){
                        dist[ j + h0MinUsed ] = n[ j ];
                    }
                    
                    // And remember this result
                    UpdateCollectedData( outfluxes_H2, dist_H2, all_outfluxes[ i ], dist );
                
                }
            
            }
        
        }
    
        // (2.5) Display status
        if ( start == stop ){
            progress = 100;
            UpdateStatus( status, thread_number, progress );
        }
        else{
            if ( ( i - start ) * 100 / ( stop - start ) > progress ){
                progress = ( i - start ) * 100 / ( stop - start );
                UpdateStatus( status, thread_number, progress );
            }
        }
        
    }
    
    // Final update - scan thread is complete
    progress = 100;
    UpdateStatus( status, thread_number, progress );
    
}
