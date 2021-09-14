// A program to decide if (C,L) - C a nodal, tree-like curve and L a line bundle on C - is special, i.e. if h0( C, L ) jumps as we deform C to a smooth curve.
// This algorithm was first formulated and proven by Prof. Dr. Ron Donagi (Universtiy of Pennsylvania).

// CASE 2: Total degree is smaller than -1
// CASE 2: Total degree is smaller than -1
bool checkSpecialitySmallerMinusOne( const std::vector<int>& degrees, const std::vector<std::vector<int>>& edges, bool& details )
{
    
    // CHECK 0: Inform the user
    // CHECK 0: Inform the user
        
    if ( details ){
        std::cout << "\n";
        std::cout << "######################################################\n";
        std::cout << "######################################################\n";
        std::cout << "Performing check for curve and bundle of degree < -1 \n" ;
        std::cout << "######################################################\n";
        std::cout << "######################################################\n\n";
        std::cout << "Degrees: (";
        for ( int i = 0; i < degrees.size()-1; i++ ){
            std::cout << degrees[ i ] << ", ";
        }
        std::cout << degrees[ degrees.size() - 1 ] << ")\n";
        std::cout << "Edges: ";
        if ( edges.size() > 0 ){
            for ( int i = 0; i < edges.size()-1; i++ ){
                std::cout << "(" << edges[ i ][ 0 ] << ", " << edges[ i ][ 1 ] << "), ";
            }
            std::cout << "( " << edges[ edges.size()-1 ][ 0 ] << " , " << edges[ edges.size()-1 ][ 1 ] << " )";
        };
        std::cout << "\n\n";
    }
    
    // CHECK 1: C+ = empty
    // CHECK 1: C+ = empty

    if ( details ){
        std::cout << "-----------------------------------------\n";
        std::cout << "(Check 1) Is I+ empty?\n";
        std::cout << "-----------------------------------------\n\n";
    }

    // Form Iplus
    std::vector<int> Iplus;
    for ( int i = 0; i < degrees.size(); i++ ){
        if ( degrees[ i ] > -1 ){
            Iplus.push_back( i );
        }
    }
    
    // Check if I_+ is empty
    if ( Iplus.size() > 0 ){
        if (details ){
            std::cout << "I+ is not empty.\n";
        }
    }
    else{
        if (details ){
            std::cout << "I+ IS EMPTY! (C,L) is not special!\n";
        }
        return false;
    }

    // Print Iplus
    if ( details ){
        std::cout << "Iplus = (";
        for ( int i = 0; i < Iplus.size() - 1; i ++ ){
            std::cout << Iplus[ i ] << ", ";
        }
        std::cout << Iplus[ Iplus.size() - 1 ] << ")\n";
    }
    
    // CHECK 2: Does C+ have one isolated component?
    // CHECK 2: Does C+ have one isolated component?

    if ( details ){
        std::cout << "\n";
        std::cout << "-----------------------------------------\n";
        std::cout << "(Check 2) Isolated component with di >= 0?\n";
        std::cout << "-----------------------------------------\n\n";
    }
    
    // Form intersection matrix
    if ( details ){
        std::cout << "Work out intersection matrix:\n";
    }
    
    std::vector<std::vector<int>> intersections;
    for ( int i = 0; i < degrees.size(); i++ ){
        
        std::vector<int> helper( degrees.size(), 0 );
        for ( int j = 0; j < edges.size(); j++ ){
            if ( edges[ j ][ 0 ] == i ){
                helper[ edges[ j ][ 1 ] ]++;
            }
            if ( edges[ j ][ 1 ] == i ){
                helper[ edges[ j ][ 0 ] ]++;
            }
        }
                
        // append to the intersection matrix
        intersections.push_back( helper );
                
        // display content of helper
        if ( details ){
            std::cout << "( ";
            for ( int j = 0; j < helper.size()-1; j++ ){
                std::cout << helper[ j ] << ", ";
            }
            std::cout << helper[ helper.size() - 1 ] << " )\n";
        }
        
    }
    
    // make checks
    if ( details ){
        std::cout << "Check for isolated Ci with di >= 0\n";
    }
    for ( int i = 0; i < degrees.size(); i ++ ){
        if ( degrees[ i ] > -1 ){
            
            // check if it is isolated
            bool isolated = true;
            for ( int j = 0; j < degrees.size(); j ++ ){
                if ( intersections[ i ][ j ] != 0 ){
                    isolated = false;
                }
            }
            
            // in case it is isolated, (C,L) is special
            if ( isolated ){
                if ( details ){
                    std::cout << "Found isolated Ci with di >= 0. (C,L) is special.\n";
                }
                return true;
            }
        }
    }
    
    // no isolated Ci found
    if ( details ){
      std::cout << "None found\n";  
    }
    
    // CHECK 3: Form ( C+, L+) and repeat
    // CHECK 3: Form ( C+, L+) and repeat
    
    if ( details ){
        std::cout << "\n";
        std::cout << "-----------------------------------------\n";
        std::cout << "(Check 3) Is (C+,L+) special?\n";
        std::cout << "-----------------------------------------\n\n";
    }
    
    // Form Iminus
    std::vector<int> Iminus;
    for ( int i = 0; i < degrees.size(); i++ ){
        if ( degrees[ i ] < 0 ){
            Iminus.push_back( i );
        }
    }
    
    // Form (C,L) -> (C+,L+) dictionary
    std::vector<int> dictionary( degrees.size(), -1 );
    std::vector<int> new_degrees;
    int index = 0;
    for ( int i = 0; i < degrees.size(); i ++ ){
        
        if ( degrees[ i ] >= 0 ){
            
            // add entry to dictionary on that curve
            dictionary[ i ] = index;
            index++;
            
            // compute its new degree
            int new_deg = degrees[ i ];
            for( int j = 0; j < Iminus.size(); j ++ ){
                new_deg = new_deg - intersections[ i ][ Iminus[ j ] ];
            }
            new_degrees.push_back( new_deg );
        
        }
        
    }
    
    std::vector<std::vector<int>> new_edges;
    for ( int i = 0; i < edges.size(); i ++ ){
        int start = edges[ i ][ 0 ];
        int end = edges[ i ][ 1 ];
        if ( ( degrees[ start ] >= 0 ) and ( degrees[ end ] >= 0 ) ){
            std::vector<int> helper { dictionary[ start ], dictionary[ end ] };
            new_edges.push_back( helper );
        }
    }
    
    // start recursion by checking the condition for (C+,L+)
    return checkSpecialitySmallerMinusOne( new_degrees, new_edges, details );
    
}
