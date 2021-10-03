// print vector
void print (std::vector<int>& v, int level){
    for(int i=0;i<=level;i++)
        std::cout << v[i] << " ";
    std::cout << std::endl;
}

// compute number of partitions
unsigned long long int part( const int & n, std::vector<int>& v, int level, const int & r, const int & max){
    int first; /* first is before last */
    unsigned long long int count = 0;
    
    // check degenerate case
    if(n<1){
        return 0;
    }
    
    // set v at position level
    v[level]=n;
    
    // we are only looking for partitions of length r
    if( level+1 == r ) {
        
        // check if all numbers are in the given range
        bool test = true;
        for ( int i = 0; i <= level; i ++ ){
            if ( ( v[ i ] < 0 ) || ( v[ i ] > max ) ){
                test = false;
                break;
            }
        }
        
        // return correspondingly
        if ( test ){
            return 1;
        }
        else{
            return 0;
        }
        
        // if output necessary/desired
        // print( v, level );
        
    }
    
    // set level appropriately
    if ( level == 0 ){
        first = 1;
    }
    else{
      first = v[ level-1 ];  
    }
    
    // perform recursion
    for(int i=first;i<=n/2;i++){
        v[level]=i; /* replace last */
        count = count + part( n-i, v, level+1, r, max );
    }
    
    // return final result
    return count;
    
}


// compute number of partitions
unsigned long long int part(const int & n, const int & r, const int & max){
    std::vector<int> v( n );
    int level = 0;
    return part( n, v, level, r, max );
}


// compute number of partitions
unsigned long long int comb_factor( const int & a, const int & b, const int & n_half, const int & r ){
    // flux a on H1-component, flux b on H2-component, number of edges among a,b is n_half and we are looking for r-th roots
    
    unsigned long long int count = 0;
    
    // iterate over flux among comonents 1 and 2
    int min = std::max( n_half, a - n_half * ( r- 1 ) );
    int max = std::min( n_half * ( r - 1 ), a - n_half );
    for ( int f12 = min; f12 <= max; f12++ ){
        
        // compute flux f23
        int f23 = b - n_half * r + f12;
        
        // only need to continue if f23 is in [ n_half, n_half * (r-1) ]
        if ( ( f23 >= n_half ) && ( f23 <= n_half * ( r - 1 ) ) ){
          
            // compute partitions as combinatorial factors
            unsigned long long int N1 = part( f12, n_half, r-1 );
            unsigned long long int N2 = part( a - f12, n_half, r-1 );
            unsigned long long int N3 = part( f23, n_half, r-1 );
            
            // increase counter
            count = count + N1 * N2 * N3;
            
        }
        
    }
    
    // return result
    return count;
    
}
