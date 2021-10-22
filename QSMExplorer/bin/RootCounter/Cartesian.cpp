// Construct all outfluxes
std::vector<std::vector<unsigned long long int>> constructAllOutfluxes( const std::vector<std::vector<int>>& lists, int root ) {
    std::vector<std::vector<unsigned long long int>> result;
    
    // initiate the process by using all entries of lists[ 0 ]
    for ( int i = lists[ 0 ][ 0 ]; i <= lists[ 0 ][ 1 ]; i++ ){
        result.push_back( { (unsigned long long int) i } );
    }
    
    // iterate
    for ( int i = 1; i < lists.size() - 1; i++ ) {
        
        // create temporary vector
        std::vector<std::vector<unsigned long long int>> temp;        
        for ( int j = 0; j < result.size(); j++ ){
            for ( int k = lists[ i ][ 0 ]; k <= lists[ i ][ 1 ]; k++ ){
                
                // to every element in result, add every element from lists[ i ]
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
        for ( int k = lists[ lists.size() - 1 ][ 0 ]; k <= lists[ lists.size() - 1 ][ 1 ]; k++ ){
            
            // to every element in result, add every element from lists[ lists.size()-1 ]
            std::vector<unsigned long long int> e_tmp = { result[ j ] };
            e_tmp.push_back( (unsigned long long int) k );
            
            // check if divisible by r
            int total = std::accumulate( e_tmp.begin(), e_tmp.end(), 0 );
            if ( total % root == 0 ){
                temp.push_back( e_tmp );
            }
            
        }
    }
    
    return temp;
    
}
