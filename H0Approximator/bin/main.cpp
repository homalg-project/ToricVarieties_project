//                      Martin Bies
//                      University of Pennsylvania
//
//                      Muyang Liu
//                      University of Pennsylvania
//
//  Copyright 2021
//
// A program to compute all effective descendants of a curve class in dP3 upon splitting-off rigid divisors

#include <algorithm>
#include<iostream>
#include <sstream>
#include <vector>
#include <string>
#include <set>

bool isEffective (std::vector<int> &curve)
{
    
    // install result
    bool result = true;
    
    // compute inequalities
    int ineq0 = curve[ 0 ];
    int ineq1 = curve[ 0 ] + curve[ 3 ];
    int ineq2 = curve[ 0 ] + curve[ 2 ];
    int ineq3 = curve[ 0 ] + curve[ 1 ];
    int ineq4 = 2 * curve[ 0 ] + curve[ 1 ] + curve[ 2 ] + curve[ 3 ];
    
    if ( ( ineq0 < 0 ) || ( ineq1 < 0 ) || ( ineq2 < 0 ) || ( ineq3 < 0 ) || ( ineq4 < 0 ) ){
        result = false;
    }
    
    // return result
    return result;
    
}

bool isPowerE1( std::vector<int> &curve )
{
    
    if ( curve[ 0 ] != 0 ){
        return false;
    }
    if ( curve[ 1 ] == 0 ){
        return false;
    }
    if ( curve[ 2 ] != 0 ){
        return false;
    }
    if ( curve[ 3 ] != 0 ){
        return false;
    }
    
    return true;
    
}

bool isPowerE2( std::vector<int> &curve )
{
    
    if ( curve[ 0 ] != 0 ){
        return false;
    }
    if ( curve[ 1 ] != 0 ){
        return false;
    }
    if ( curve[ 2 ] == 0 ){
        return false;
    }
    if ( curve[ 3 ] != 0 ){
        return false;
    }
    
    return true;
    
}

bool isPowerE3( std::vector<int> &curve )
{
    
    if ( curve[ 0 ] != 0 ){
        return false;
    }
    if ( curve[ 1 ] != 0 ){
        return false;
    }
    if ( curve[ 2 ] != 0 ){
        return false;
    }
    if ( curve[ 3 ] == 0 ){
        return false;
    }
    
    return true;
    
}

bool isPowerE4( std::vector<int> &curve )
{
    
    int a = curve[ 0 ];
    if ( a < 1 ){
        return false;
    }
    if ( curve[ 1 ] != -a ){
        return false;
    }
    if ( curve[ 2 ] != -a ){
        return false;
    }
    if ( curve[ 3 ] != 0 ){
        return false;
    }
    
    return true;
    
}

bool isPowerE5( std::vector<int> &curve )
{
    
    int a = curve[ 0 ];
    if ( a < 1 ){
        return false;
    }
    if ( curve[ 1 ] != -a ){
        return false;
    }
    if ( curve[ 2 ] != 0 ){
        return false;
    }
    if ( curve[ 3 ] != -a ){
        return false;
    }
    
    return true;
    
}

bool isPowerE6( std::vector<int> &curve )
{
    
    int a = curve[ 0 ];
    if ( a < 1 ){
        return false;
    }
    if ( curve[ 1 ] != 0 ){
        return false;
    }
    if ( curve[ 2 ] != -a ){
        return false;
    }
    if ( curve[ 3 ] != -a ){
        return false;
    }
    
    return true;
    
}

bool isRigidPower( std::vector<int> &curve )
{
    if ( isPowerE1( curve ) ){
        return true;
    }
    if ( isPowerE2( curve ) ){
        return true;
    }
    if ( isPowerE3( curve ) ){
        return true;
    }
    if ( isPowerE4( curve ) ){
        return true;
    }
    if ( isPowerE5( curve ) ){
        return true;
    }
    if ( isPowerE6( curve ) ){
        return true;
    }
    return false;
}

bool isZero( std::vector<int> &curve )
{
    if ( curve[ 0 ] != 0 ){
        return false;
    }
    if ( curve[ 1 ] != 0 ){
        return false;
    }
    if ( curve[ 2 ] != 0 ){
        return false;
    }
    if ( curve[ 3 ] != 0 ){
        return false;
    }
    return true;
}

int intersection (std::vector<int> &a, std::vector<int> &b)
{
    
    return a[ 0 ] * b[ 0 ] - a[ 1 ] * b[ 1 ] - a[ 2 ] * b[ 2 ] - a[ 3 ] * b[ 3 ];
    
}

int genus (std::vector<int> &a)
{
    
    // compute the genus
    std::vector<int> factor{ -3 + a[ 0 ], 1 + a[ 1 ], 1 + a[ 2 ], 1 + a[ 3 ] };
    int inter = intersection( factor, a );
    float g = (inter/2) + 1;
    
    // return the result
    return (int) g;
    
}

bool counting_applies( std::vector<std::vector<int>> &components, std::vector<int> &local_sections )
{
    
    // check neighbouring condition
    for (int i = 0; i < components.size(); i++){
        if ( local_sections[ i ] != 0 ){
            for (int j = 0; j < components.size(); j++){
                if ( ( i != j ) and ( local_sections[ j ] != 0 ) ){
                    if ( intersection( components[ i ], components[ j ] ) != 0 ){
                        return false;
                    }
                }
            }
        }
    }
    
    // all tests passed
    return true;
    
}

int approxH0( std::vector<std::vector<int>> &components, std::vector<int> &bundle, int &h0_min, int &verbose ){
    
    // compute topological data
    std::vector<int> genera;
    std::vector<int> boundaries;
    std::vector<int> degrees;
    std::vector<int> local_sections;
    for (int i = 0; i < components.size(); i++){
        
        // compute genus
        int g = genus( components[ i ] );
        genera.push_back( g );
        
        // compute boundaries
        int b = 0;
        for (int j = 0; j < components.size(); j++){
            if ( i != j ){
                b = b + intersection( components[ i ], components[ j ] );
            }
        }
        boundaries.push_back( b );
        
        // compute degrees
        degrees.push_back( intersection( components[ i ], bundle ) );
        
        // estimate local_sections
        int chi = degrees[ i ] - g + 1;
        if ( chi < 0 ){
            local_sections.push_back( 0 );
        } else {
           local_sections.push_back( chi );
        }
        
    }
    
    int estimate = -1;
    if ( counting_applies( components, local_sections ) ){
        estimate = 0;
        for ( int i = 0; i < components.size(); i++){
            if ( local_sections[ i ] >= boundaries[ i ] ){
                estimate = estimate + local_sections[ i ] - boundaries[ i ];
            }
        }
    } else if ( components.size() == 2 ) {
        if (local_sections[0] + local_sections[1] >= boundaries[0]) {
           estimate =  local_sections[0] + local_sections[1] - boundaries[0];
        } 	 
      }
     
    // check if our estimate is valid
    if ( estimate < h0_min ){ 
        estimate = -1;
    }
    
    // display results only for setups for which we could produce a good estimate of h0
    if ( ( estimate >= h0_min ) && ( verbose > 0 ) ){
        for ( int i = 0; i < components.size(); i++ ){
            std::cout << "Component " << i <<": (" << components[ i ][ 0 ] << ", " << components[ i ][ 1 ] << ", " << components[ i ][ 2 ] << ", " << components[ i ][ 3 ] << ")\n";
        }
        std::cout<<"degrees: ";
        for (int i = 0; i < components.size(); i++){
            std::cout<<"("<< degrees[ i ] <<")";
        }
        std::cout<<"\n";
        std::cout<<"genera: ";
        for (int i = 0; i < components.size(); i++){
            std::cout<<"("<< genera[ i ] <<")";
        }
        std::cout<<"\n";
        std::cout<<"sections: ";
        for (int i = 0; i < components.size(); i++){
            std::cout<<"("<< local_sections[ i ] <<")";
        }
        std::cout<<"\n";
        std::cout<<"boundaries: ";
        for (int i = 0; i < components.size(); i++){
            std::cout<<"("<< boundaries[ i ] <<")";
        }
        std::cout << "\n";
        std::cout<<"estimate h0 = " << estimate;
        std::cout << "\n\n";
    }
    
    // return the result
    return estimate;
    
}

void analyse( std::vector<int> &curve, std::vector<int> &bundle, int &level, int &h0_min, std::vector<std::vector<int>> &estimatable_setups, int &verbose )
{
    
    // count number of effective descendants
    int count = 0;
    std::vector<int> h0_estimates;
    
    // we strip-off curve combinations of up to level divisors
    // so create integers lists with 6 entries, each ranging from 0 to level
    for (int i1 = 0; i1 < level+1; i1++) {
    for (int i2 = 0; i2 < level+1; i2++) {
    for (int i3 = 0; i3 < level+1; i3++) {
    for (int i4 = 0; i4 < level+1; i4++) {
    for (int i5 = 0; i5 < level+1; i5++) {
    for (int i6 = 0; i6 < level+1; i6++) {
        
        // form combination of rigid divisors to be stripped off
        std::vector<int> rigid_factors{ i4 + i5 + i6, i1 - i4 - i5, i2 - i4 - i6, i3 - i5 - i6 };
        std::vector<int> diff{ curve[ 0 ] - rigid_factors[ 0 ], curve[ 1 ] - rigid_factors[ 1 ], curve[ 2 ] - rigid_factors[ 2 ], curve[ 3 ] - rigid_factors[ 3 ] };
        if ( ( isEffective( diff ) ) && ( ! isRigidPower( diff ) ) ) {
            
            // write components in condensed way
            std::vector<std::vector<int>> components;
            
            // add diff only if it is non-trivial
            if ( ! isZero( diff ) ){
                components.push_back( diff );
            }
            
            if ( i1 != 0){
                std::vector<int> c1{ 0, i1, 0, 0 };
                components.push_back( c1 );
            }
            if ( i2 != 0){
                std::vector<int> c2{ 0, 0, i2, 0 };
                components.push_back( c2 );
            }
            if ( i3 != 0){
                std::vector<int> c3{ 0, 0, 0, i3 };
                components.push_back( c3 );
            }
            if ( i4 != 0){
                std::vector<int> c4{ i4, -i4, -i4, 0 };
                components.push_back( c4 );
            }
            if ( i5 != 0){
                std::vector<int> c5{ i5, -i5, 0, -i5 };
                components.push_back( c5 );
            }
            if ( i6 != 0){
                std::vector<int> c6{ i6, 0, -i6, -i6 };
                components.push_back( c6 );
            }
            
            // and approx h0
            int estimate = approxH0( components, bundle, h0_min, verbose );
            if ( estimate >= h0_min ){
                
                // add the estimated value to our list of estimates
                h0_estimates.push_back( estimate );
                
                // increase counter
                count ++;
                
                // save setup to our list of interesting setups
                std::vector<int> setup{diff[ 0 ], diff[ 1 ], diff[ 2 ], diff[ 3 ], i1, i2, i3, i4, i5, i6, estimate};
                estimatable_setups.push_back( setup );
                
            }
        }
    
    }}}}}}
    
    std::vector<int> spectrum = h0_estimates;
    std::set<int> s;
    unsigned size = spectrum.size();
    for( unsigned i = 0; i < size; ++i ) s.insert( spectrum[i] );
    spectrum.assign( s.begin(), s.end() );
    
    // count occurances
    std::vector<int> occurances;
    for (int i = 0; i < spectrum.size(); i++){
        occurances.push_back( std::count( h0_estimates.begin(), h0_estimates.end(), spectrum[ i ] ) );
    }
    
    // process the estimates of h0
    if ( verbose > 0 ){
        std::cout << "------------------------------------------\n";
        std::cout << "Obtained " << count << " estimates for h0:\n";
        for (int i = 0; i < spectrum.size(); i++){
            std::cout << spectrum[ i ] << ": " << occurances[ i ] << "\n";
        }
        std::cout << "\n";
    }
    
    // write out the estimatable spectrum in a way useful for gap
    std::cout << "[";
    for ( int i = 0; i < estimatable_setups.size(); i++ ){
        std::cout << "[";
        for ( int j = 0; j < estimatable_setups[ i ].size(); j++ ){
            if ( j < estimatable_setups[ i ].size() - 1 ){
                std::cout << estimatable_setups[ i ][ j ] << ",";
            } else {
                std::cout << estimatable_setups[ i ][ j ];
            }
        }
        if ( i < estimatable_setups.size() - 1 ){
            std::cout << "],";
        } else {
            std::cout << "]";
        }
    }
    std::cout << "]";
    
}

int main(int argc, char* argv[]) {
    
    // check if we have the correct number of arguments
    if (argc != 2) {
        std::cout << "Error - number of arguments must be exactly 1 and not " << argc << "\n";
        return 0;
    }
    
    // parse input
    std::string myString = argv[1];
    std::stringstream iss( myString );
    std::vector<int> input;
    int number;
    while ( iss >> number ){
        input.push_back( number );
    }
    
    // create curve class
    std::vector<int> curve{ input[ 0 ], input[ 1 ], input[ 2 ], input[ 3 ]};
    std::vector<int> bundle{ input[ 4 ], input[ 5 ], input[ 6 ], input[ 7 ]};
    int level = input[ 8 ];
    int verbose = input[ 9 ];
    
    // check if curve class and bundle class are of correct length
    if ( ( curve.size() != 4 ) || ( bundle.size() != 4 ) ){
        std::cout << "Error - curve and bundle class must consist of 4 integers\n";
        return 0;
    }
    
    // check if level is non-negative
    if ( level < 0 ){
        std::cout << "Error - level must not be negative\n";
        return 0;
    }
    
    // inform what line bundle data we obtained
    if ( verbose > 0 ){
        std::cout << "\n";
        std::cout << "Curve class [";
        for(int i=0; i<curve.size()-1; ++i){
            std::cout << curve[i] << ", ";
        }
        std::cout << curve[curve.size()-1] << "]\n";
        std::cout << "Bundle class [";
        for(int i=0; i<bundle.size()-1; ++i){
            std::cout << bundle[i] << ", ";
        }
        std::cout << curve[curve.size()-1] << "]\n";
        
        // check if we obtained an effective curve class
        std::cout << "\n";
        std::cout << "Analyse descendants..\n\n";
    }
    
    // compute minimal value for h0
    int g = genus( curve );
    int d = intersection( curve, bundle );
    int chi = d - g + 1;
    int h0_min = 0;
    if ( chi >= 0 ){
        h0_min = chi;
    }
    
    // prepare list of estimatable setups
    std::vector<std::vector<int>> estimatable_setups;
    analyse( curve, bundle, level, h0_min, estimatable_setups, verbose );
    
    // signal successful end
    return 0;
}
