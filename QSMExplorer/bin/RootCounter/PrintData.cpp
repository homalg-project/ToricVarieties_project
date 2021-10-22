void print_data( std::vector<int> input ){
    
    // Extract data
    int numberVertices = input[ 0 ];
    int numberEdges = input[ 3 * numberVertices + 1 ];
    int root = input[ 4 * numberVertices + 2 * numberEdges + 3 ];    
    std::vector<int> degrees_H1, degrees_H2, legs_per_component, external_legs;
    for ( int i = 0; i < numberVertices; i++ ){
        degrees_H1.push_back( input[ i + 1 ] );
        degrees_H2.push_back( input[ i + 1 + numberVertices ] );
        legs_per_component.push_back( input[ 3 * input[ 0 ] + 1 + 1 + 2 * numberEdges + i ] );
        for ( int j = 0; j < input[ 3 * input[ 0 ] + 1 + 1 + 2 * numberEdges + i ]; j++ ){
            external_legs.push_back( i );
        }
    }
    
    // Display data
    std:: cout << "\n";
    std:: cout << "Received the following data:\n";
    std:: cout << "----------------------------------------\n";
    std::cout << "Degrees H1: ";
    for ( int j = 0; j < degrees_H1.size(); j++ ){
        std::cout << degrees_H1[ j ] << ", ";
    }
    std::cout << "\n";
    std::cout << "Degrees H2: ";
    for ( int j = 0; j < degrees_H2.size(); j++ ){
        std::cout << degrees_H2[ j ] << ", ";
    }
    std::cout << "\n";
    std::cout << "Root: " << root << "\n";
    std::cout << "External legs: (";
    for ( int i = 0; i < external_legs.size() - 1; i++ ){
        std::cout << external_legs[ i ] << ", ";
    }
    std::cout << external_legs[ external_legs.size() - 1 ] << ")\n";
    std::cout << "Legs per component: (";
    for ( int i = 0; i < legs_per_component.size() - 1; i++ ){
        std::cout << legs_per_component[ i ] << ", ";
    }
    std::cout << legs_per_component[ legs_per_component.size() - 1 ] << ")\n\n";
    
}
