// Combinatorial factors for root bundle counting
boost::multiprecision::int128_t comb_factor( const int & a, const int & b, const int & n_half, const int & r );


// Task: Combinatorial factor for root bundle counting
// Input: Outflux on H1-component V( xi, s1 ) = a
//           Outflux on H2-component V( xi, s2 ) = b
//           Number of edges among V( xi, s1 ) and V( si, s2 ): n_half = n/2
//           ( The total number of edges of V( xi, s1 ) in H1 is n. Same for V( xi, s2 ) inside of H2. )
//           We are looking for r-th roots
boost::multiprecision::int128_t comb_factor( const int & a, const int & b, const int & n_half, const int & r ){

    // Initialize counter as 0
    boost::multiprecision::int128_t count = 0;
    
    // Partition flux a = f12 + f13, where f12 is the outflow towards V( xi, s2 ).
    // Consequence: f12 can only cover a certain range of values, namely...
    int min = std::max( n_half, a - n_half * ( r- 1 ) );
    int max = std::min( n_half * ( r - 1 ), a - n_half );
    
    // Iterate over the different values of f12
    for ( int f12 = min; f12 <= max; f12++ ){
        
        // This uniquely fixes the flux f23 from V( xi, s2 ) to V( xi, s3 ) as
        int f23 = b - n_half * r + f12;
        
        // Of course, f23 must be in the range [ n_half, ..., n_half * (r-1) ]. So only proceed if this is the case:
        if ( ( f23 >= n_half ) && ( f23 <= n_half * ( r - 1 ) ) ){
            
            // Number of roots which realize this outflux scenario is given by N1 * N2 * N3:
            // N1: Number of partitions of flux f12 (from V( xi, s1) to V( xi, s2 )) into n_half weights, each with admissible ranges being between 1 and r-1.
            // N2: Number of partitions of flux f13 = a - f12 (from V( xi, s1 ) to V( xi, s3 )) into n_half weights, each with admissible ranges being between 1 and r-1.
            // N3: Number of partitions of flux f23 (from V( xi, s2 ) to V( xi, s3 )) into n_half weights, each with admissible ranges being between 1 and r-1.
            boost::multiprecision::int128_t N1 = number_partitions( f12, n_half, r );
            boost::multiprecision::int128_t N2 = number_partitions( a - f12, n_half, r );
            boost::multiprecision::int128_t N3 = number_partitions( f23, n_half, r );
            
            // Increase counter accordingly
            count = count + N1 * N2 * N3;
            
        }
        
    }
    
    // Return result
    return count;
    
}
