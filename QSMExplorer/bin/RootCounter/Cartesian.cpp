// Construct all outfluxes
std::vector<std::vector<unsigned long long int>> constructAllOutfluxes( std::vector<int>& legs_per_component, int root, bool display_details ) {
    std::vector<std::vector<unsigned long long int>> result;

    // inform about allow flux values on the 0th component
    if ( display_details ){
        std::cout << "Minimal and maximal outfluxes per component...\n";
        for ( int i = 0; i < legs_per_component.size(); i++ ){
            std::cout << "Component " << i << ": (" << legs_per_component[ i ] << ", " << legs_per_component[ i ] * ( root - 1 ) << ")\n";
        }
        std::cout << "\n";
    }
    
    // initiate the process by using all entries of lists[ 0 ]
    for ( int i = legs_per_component[ 0 ]; i <= legs_per_component[ 0 ] * ( root - 1 ); i++ ){
        result.push_back( { (unsigned long long int) i } );
    }

    // iterate over the other components
    for ( int i = 1; i < legs_per_component.size() - 1; i++ ) {
        
        // create temporary vector
        std::vector<std::vector<unsigned long long int>> temp;        
        for ( int j = 0; j < result.size(); j++ ){
            for ( int k = legs_per_component[ i ]; k <= legs_per_component[ i ] * ( root - 1 ); k++ ){
                
                // to every element in result, add every allowed flux on the i-th component
                std::vector<unsigned long long int> e_tmp = { result[ j ] };
                e_tmp.push_back( (unsigned long long int) k );
                temp.push_back( e_tmp );
                
            }
        }
        
        // overwrite result with this temporary list
        result = temp;
        
    }
    
    // in the final step, only allow fluxes, such that they are divisible by r
    std::vector<std::vector<unsigned long long int>> temp;        
    for ( int j = 0; j < result.size(); j++ ){
        for ( int k = legs_per_component[ legs_per_component.size()-1 ]; k <= legs_per_component[ legs_per_component.size()-1 ] * ( root - 1 ); k++ ){
            
            // to every element in result, add every allowed flux on the last component, such that the total flux is divisible by r
            std::vector<unsigned long long int> e_tmp = { result[ j ] };
            e_tmp.push_back( (unsigned long long int) k );
            int total = std::accumulate( e_tmp.begin(), e_tmp.end(), 0 );
            if ( total % root == 0 ){
                temp.push_back( e_tmp );
            }
            
        }
    }
    
    return temp;
    
}
