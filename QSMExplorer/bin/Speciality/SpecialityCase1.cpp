// A program to decide if (C,L) - C a nodal, tree-like curve and L a line bundle on C - is special, i.e. if h0( C, L ) jumps as we deform C to a smooth curve.
// This algorithm was first formulated and proven by Prof. Dr. Ron Donagi (Universtiy of Pennsylvania).

// CASE 1: Total degree is greater than -2
// CASE 1: Total degree is greater than -2
bool checkSpecialityGreaterMinusTwo( const std::vector<int>& degrees, const std::vector<std::vector<int>>& edges, bool& details )
{

    // CHECK 0: Inform the user
    // CHECK 0: Inform the user
        
    if ( details ){
        std::cout << "\n\n";
        std::cout << "##################################################################\n";
        std::cout << "##################################################################\n";
        std::cout << "Performing check for curve and bundle of degree >= -1 \n" ;
        std::cout << "##################################################################\n";
        std::cout << "##################################################################\n\n";
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
        }
        else{
            std:: cout << "( )";
        }
        std::cout << "\n\n";
    }
    
    // CHECK 1: Is one di < -1? If yes, then (C,L) is special.
    // CHECK 1: Is one di < -1? If yes, then (C,L) is special.
    
    if ( details ){
        std::cout << "------------------------------------------------------------------\n";
        std::cout << "(Check 1) Any degrees smaller than -1?\n";
        std::cout << "------------------------------------------------------------------\n\n";
    }
    
    for ( int i = 0; i < degrees.size(); i ++ ){
        if ( degrees[ i ] < -1 ){
            if ( details ){
                std::cout << "YES! (C,L) is special!\n\n";
            }
            return true;
        }
    }
    if ( details ){
        std::cout << "No\n\n";
    }
    
    // CHECK 2: Is Iminus empty? If yes, then (C,L) is not special.
    // CHECK 2: Is Iminus empty? If yes, then (C,L) is not special.
    
    if ( details ){
        std::cout << "------------------------------------------------------------------\n";
        std::cout << "(Check 2) Is Iminus trivial?\n";
        std::cout << "------------------------------------------------------------------\n\n";
    }
    
    // Form Iminus
    std::vector<int> Iminus;
    for ( int i = 0; i < degrees.size(); i++ ){
        if ( degrees[ i ] < 0 ){
            Iminus.push_back( i );
        }
    }
    
    // Check if I_+ is empty
    if ( Iminus.size() > 0 ){
        if (details ){
            std::cout << "I- is not empty.\n";
        }
    }
    else{
        if (details ){
            std::cout << "I- IS EMPTY! (C,L) is not special!\n\n";
        }
        return false;
    }

    // Print Iminus
    if ( Iminus.size() > 0 ){
        if ( details ){
            std::cout << "Iminus = (";
            for ( int i = 0; i < Iminus.size() - 1; i ++ ){
                std::cout << Iminus[ i ] << ", ";
            }
            std::cout << Iminus[ Iminus.size() - 1 ] << ")\n\n";
        }
    }
    
    // CHECK 3: Do any two Ci with negative degree intersect? If yes, then (C,L) is special.
    // CHECK 3: Do any two Ci with negative degree intersect? If yes, then (C,L) is special.
    
    if ( details ){
        std::cout << "------------------------------------------------------------------\n";
        std::cout << "(Check 3) Do curves with negative degree intersect?\n";
        std::cout << "------------------------------------------------------------------\n\n";
    }
    
    // Form intersection matrix
    if ( details ){
        std::cout << "Intersection matrix:\n";
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
    // Check if any two Ci with negative degrees do intersect
    for ( int i = 0; i < Iminus.size(); i ++ ){
        for ( int j = i+1; j < Iminus.size(); j ++ ){
            if ( intersections[ Iminus[ i ] ][ Iminus[ j ] ] > 0 ){
                if ( details ){
                    std::cout << "\n";
                    std::cout << "FOUND INTERSECTION AMONG " << Iminus[ i ] << " AND " << Iminus[ j ] << "! (C,L) is special!\n\n";
                }
                return true;
            }
        }
    }
    if ( details ){
        std::cout << "\n";
        std::cout << "No intersections found.\n\n";
    }
    
    // CHECK 4: Is (C+,L+) special?
    // CHECK 4: Is (C+,L+) special?
    
    if ( details ){
        std::cout << "------------------------------------------------------------------\n";
        std::cout << "(Check 4) Is (C+,L+) special?\n";
        std::cout << "------------------------------------------------------------------\n\n";
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
    return checkSpecialityGreaterMinusTwo( new_degrees, new_edges, details );

}
