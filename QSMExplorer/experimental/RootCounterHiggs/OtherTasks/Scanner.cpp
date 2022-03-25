void UpdateCollectedData( std::vector<std::vector<unsigned long long int>>& collector1,
                                            std::vector<std::vector<boost::multiprecision::int128_t>>& collector2,
                                            std::vector<std::vector<unsigned long long int>> & change1,
                                            std::vector<std::vector<boost::multiprecision::int128_t>> & change2 )
{
    
    boost::mutex::scoped_lock lock(myGuard);
    for ( int i = 0; i < change1.size(); i++ ){
        collector1.push_back( change1[ i ] );
        collector2.push_back( change2[ i ] );
    }
    
}

void UpdateStatus( std::vector<int>& status, int thread_number, int progress )
{
    
    boost::mutex::scoped_lock lock(myGuard2);
    status[ thread_number ] = progress;
    std::string output = "Status [%]: (";
    int s = 0;
    for ( int i = 0; i < status.size(); i ++ ){
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
                                int thread_number
                )
{

    // (1) Extract the input data
    std::vector<int> degrees_H1( input[ 0 ] );
    std::vector<int> degrees_H2( input[ 0 ] );
    std::vector<int> genera( input[ 0 ] );
    for ( int i = 1; i <= input[ 0 ]; i++ ){
        degrees_H1[ i - 1 ] = input[ i ];
        degrees_H2[ i - 1] = input[ i + input[ 0 ] ];
        genera[ i - 1 ] = input[ i + 2 * input[ 0 ] ];
    }
    int numberEdges = input[ 3 * input[ 0 ] + 1 ];
    std::vector<std::vector<int>> edges;
    for ( int i = 0; i < numberEdges; i ++ ){
        int index = 2 + 3 * input[ 0 ] + 2 * i;
        std::vector<int> helper = { input[ index ], input[ index + 1 ] };
        edges.push_back( helper );
    }
    int genus = input[ 4 * input[ 0 ] + 2 * numberEdges + 2 ];
    int root = input[ 4 * input[ 0 ] + 2 * numberEdges + 3 ];
    int h0Max = input[ 4 * input[ 0 ] + 2 * numberEdges + 5 ];
    int progress = 0;

    // declare variable to be used momentarily
    std::vector<int> degrees(degrees_H1.size(), 0);
    bool zeros;
    
    // compute additional information about the graph
    std::vector<int> edge_numbers(degrees.size(),0);
    std::vector<std::vector<std::vector<int>>> graph_stratification;
    additional_graph_information(edges, edge_numbers, graph_stratification);
    
    // (2) Iterate
    std::vector<std::vector<unsigned long long int>> out1;
    std::vector<std::vector<unsigned long long int>> out2;
    std::vector<std::vector<boost::multiprecision::int128_t>> d1;
    std::vector<std::vector<boost::multiprecision::int128_t>> d2;
    for ( int i = 0; i < all_outfluxes.size(); i++ ){

        // (2.1) Compute total outflux and continue only if it is divisible by the root
        int total_flux = std::accumulate( all_outfluxes[i].begin(), all_outfluxes[i].end(), 0 );
        if ( total_flux % root == 0 ){
                    
            // (2.2) Choice for number of subthreads
            int number_sub_threads = 1;
            
            // (2.3) Compute root distribution on H1
            
            // reduce the degree by the outflux
            for (int j = 0; j < degrees_H1.size(); j++){
                degrees[j] = degrees_H1[j] - all_outfluxes[i][j];
            }
            
            std::vector<boost::multiprecision::int128_t> n1(h0Max + 1, 0);
            for (int i = 0; i <= h0Max; i++){
                n1[i] = parallel_root_counter(genus, degrees, genera, edges, root, graph_stratification, edge_numbers, i, number_sub_threads);
            }
            
            // Check if distribution is not trivial
            zeros = std::all_of( n1.begin(), n1.end(), [](boost::multiprecision::int128_t j) { return j==0; } );
            
            // Append if the result is not trivial
            if (!zeros){
                out1.push_back(all_outfluxes[i]);
                d1.push_back(n1);
            }
            
            // (2.4) Compute root distribution on H2
            
            // reduce the degree by the outflux
            for (int j = 0; j < degrees_H2.size(); j++){
                degrees[j] = degrees_H2[j] - all_outfluxes[i][j];
            }
            
            // compute number of roots
            std::vector<boost::multiprecision::int128_t> n2(h0Max + 1, 0);
            for (int i = 0; i <= h0Max; i++){
                n2[i] = parallel_root_counter(genus, degrees, genera, edges, root, graph_stratification, edge_numbers, i, number_sub_threads);
            }
            
            // Check if distribution is not trivial
            zeros = std::all_of( n2.begin(), n2.end(), [](boost::multiprecision::int128_t j) { return j==0; } );
            
            // Append if the result is not trivial
            if (!zeros){
                out2.push_back(all_outfluxes[i]);
                d2.push_back(n2);
            }
        
        }
    
        // (2.5) Display status
        if ( all_outfluxes.size() == 0 ){
            progress = 100;
            UpdateStatus( status, thread_number, progress );
        }
        else{
            if ( i * 100 / ( all_outfluxes.size() ) > progress ){
                progress = i * 100 / ( all_outfluxes.size() );
                UpdateStatus( status, thread_number, progress );
            }
        }
        
    }
    
    // (2.6) Update results
    UpdateCollectedData( outfluxes_H1, dist_H1, out1, d1 );
    UpdateCollectedData( outfluxes_H2, dist_H2, out2, d2 );
    UpdateStatus( status, thread_number, 100 );
    
}
