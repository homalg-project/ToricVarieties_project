// A program to compute the number of minimal limit roots on full blowups of nodal curves

#include "WDiagram.h"


//###########################################
//############# (1) Constructors ############
//###########################################

// "Empty" constructor
WeightedDiagram::WeightedDiagram()
{
    std::vector<int> vertices = {0,1};
    std::vector<int> degrees = {0,0};
    std::vector<int> genera = {0,0};
    std::vector<std::vector<int>> edges = {{1,2}};
    int g = 0;
    int r = 1;
    WeightedDiagram( vertices, degrees, genera, edges, g, r );
}

// Parametrized Constructor
WeightedDiagram::WeightedDiagram(std::vector<int> &vi, std::vector<int> &di, std::vector<int> &gi, std::vector<std::vector<int>> &ei, int &g, int &r )
{
    
    // set variables
    vertices = vi;
    degrees = di;
    genera = gi;
    edges = ei;
    genus = g;
    root = r;
    
    // we can only work if the genera are either 0 or 1
    for ( int i = 0; i < genera.size(); i++ ){
        if ( genera[ i ] < 0 || genera[ i ] > 1 ){
            throw std::invalid_argument( "We only support g = 0,1 for each vertex." );
        }
    }
    
    // if at least one degree is specified we can make more tests
    if ( degrees.size() > 0 ){
        
        degree = std::accumulate(degrees.begin(), degrees.end(), 0);
        
        // check that the degree is divisible by root
        if ( degree % root != 0 ){
            throw std::invalid_argument("The total degree must be divisible by root. Received degree = " + std::to_string(degree) + " and root = " + std::to_string(root) );
        }
        
        // compute h0_min
        h0_min = (int) degree/root - genus + 1;
        
    }
    
    // Determine edge number for each vertex
    if ( edges.size() > 0 ){
        std::vector<int> counter(vertices.size());
        for (int i = 0; i < edges.size(); i++){
            counter[ edges[ i ][ 0 ] ]++;
            counter[ edges[ i ][ 1 ] ]++;
        }
        edge_numbers = counter;
    }
    else{
        edge_numbers = {};
    }
    
}



//###########################################
//############### (2) Print #################
//###########################################

// helper to print vector (of vectors) of integers
void print_vector(std::vector<int> const &vs, std::string const &message)
{
    std::cout << message;
    for ( int i = 0; i < vs.size()-1; i++ ){
        std::cout << vs[ i ] << ",";
    }
    std::cout << vs[ vs.size() - 1 ] << "\n";
}

// helper to print vector (of vectors) of integers
void print_vector_without_break(std::vector<int> const &vs, std::string const &msg1, std::string const &msg2 )
{
    std::cout << msg1;
    for ( int i = 0; i < vs.size()-1; i++ ){
        std::cout << vs[ i ] << ",";
    }
    std::cout << vs[ vs.size() - 1 ] << msg2;
}

void print_vector_of_vector(std::vector<std::vector<int>> const &vs, std::string const &message)
{
    std::cout << message;
    for ( int i = 0; i < vs.size(); i++ ){
            print_vector_without_break( vs[ i ], "(", ") " );
    }
    std::cout << "\n";
}

void WeightedDiagram::print_vertices()
{
    print_vector( vertices, "Vertices: " );
}
void WeightedDiagram::print_edge_numbers()
{
    print_vector( edge_numbers, "Edge numbers: " );
}
void WeightedDiagram::print_degrees()
{
    print_vector( degrees, "Degrees: " );
}
void WeightedDiagram::print_genera()
{
    print_vector( genera, "Genera: " );
}
void WeightedDiagram::print_edges()
{
    print_vector_of_vector( edges, "Edges: " );
}
void WeightedDiagram::print_degree()
{
    std::cout << "Degree: " << degree << "\n";
}
void WeightedDiagram::print_root()
{
    std::cout << "Root: " << root << "\n";
}
void WeightedDiagram::print_genus()
{
    std::cout << "Genus: " << genus << "\n";
}
void WeightedDiagram::print_h0_min()
{
    std::cout << "h0_min: " << h0_min << "\n";
}
void WeightedDiagram::print_complete_information()
{
    
    std::cout << "\n";
    std::cout << "Received diagram:\n";
    std::cout << "-----------------\n";
    print_vertices();
    print_edge_numbers();
    print_degrees();
    print_genera();
    print_edges();
    print_degree();
    print_root();
    print_genus();
    print_h0_min();
    std::cout << "\n";
    
}



//############################################
//############### (3) Getter #################
//############################################

std::vector<int> WeightedDiagram::get_vertices()
{
    return vertices;
}
std::vector<int> WeightedDiagram::get_edge_numbers()
{
    return edge_numbers;
}
std::vector<int> WeightedDiagram::get_degrees()
{
    return degrees;
}
std::vector<int> WeightedDiagram::get_genera()
{
    return genera;
}
std::vector<std::vector<int>> WeightedDiagram::get_edges()
{
    return edges;
}
int WeightedDiagram::get_degree()
{
    return degree;
}
int WeightedDiagram::get_root()
{
    return root;
}
int WeightedDiagram::get_genus()
{
    return genus;
}
int WeightedDiagram::get_h0_min()
{
    return h0_min;
}
int WeightedDiagram::get_mult( std::vector<int> weights )
{
    
    // find the number of weights
    int w_total = weights.size();
    if ( w_total < edges.size() ){
        std::cout << "Length of provided weight vector does not match number of edges\n";
        return -1;
    }
    
    // initialize multiplier variable
    int m;
    
    // check if one component is g = 1 - if not, then the multiplicity will be 1
    bool test = true;
    for ( int i = 0; i < vertices.size(); i++ ){
        if ( genera[ i ] == 1 ){
            test = false;
            break;
        }
    }
    
    // return multiplicity simplified
    if ( test == true ){
        m = 1;
    }
    else {
        
        // set the weigths, check how many weights are assigned per vertex and compute the incident for each vertex
        int number_of_assigned_weights[ vertices.size() ]{ 0 };
        int incidents_of_vertices[ vertices.size() ]{ 0 };
        for ( int i = 0; i < w_total; i++ ){
            
            if ( weights[ i ] > 0 ){
                
                number_of_assigned_weights[ edges[ i ][ 0 ] ]++;
                incidents_of_vertices[ edges[ i ][ 0 ] ] = incidents_of_vertices[ edges[ i ][ 0 ] ] + weights[ i ];
                
                number_of_assigned_weights[ edges[ i ][ 1 ] ]++;
                incidents_of_vertices[ edges[ i ][ 1 ] ] = incidents_of_vertices[ edges[ i ][ 1 ] ] + root - weights[ i ];
                
            }
            
        }
        
        // iterate over all vertices
        for ( int i = 0; i < vertices.size(); i++ ){
            
            // check if mod condition is satisfied
            if ( number_of_assigned_weights[ i ] == edge_numbers[ i ] ){
                
                int deg = (int) ( degrees[ i ] - incidents_of_vertices[ i ] ) / root;
                if ( genera[ i ] == 1 ){
                    if ( deg == 0 ){
                        m = root * root - 1;
                    }
                    else{
                        m = root * root;
                    }
                }
                
            }
        }
    
    }
    
    // return multiplicity
    return m;
    
}


//############################################################
//############### (4) Test weight assignment #################
//############################################################


// set weights and test if this assignment is ok
bool WeightedDiagram::test_weights( std::vector<int> weights, int h0_target )
{
    
    // find the number of weights
    int w_total = weights.size();
    if ( w_total < edges.size() ){
        std::cout << "Length of provided weight vector does not match number of edges\n";
        return -1;
    }
    
    // h0_target must be non-negative
    if ( h0_target < 0 ){
        std::cout << "h0_target must be a non-negative integer\n";
        return -1;
    }
    
    // set the weigths, check how many weights are assigned per vertex and compute the incident for each vertex
    int number_of_assigned_weights[ vertices.size() ]{ 0 };
    int incidents_of_vertices[ vertices.size() ]{ 0 };
    int non_initialized = 0;
    for ( int i = 0; i < w_total; i++ ){
        
        // count the number of not initialized weights
        if ( weights[ i ] == 0 ){
            non_initialized ++;
        }
        
        // compute incidents for good weights
        if ( weights[ i ] > 0 ){
            
            number_of_assigned_weights[ edges[ i ][ 0 ] ]++;
            incidents_of_vertices[ edges[ i ][ 0 ] ] = incidents_of_vertices[ edges[ i ][ 0 ] ] + weights[ i ];
            
            number_of_assigned_weights[ edges[ i ][ 1 ] ]++;
            incidents_of_vertices[ edges[ i ][ 1 ] ] = incidents_of_vertices[ edges[ i ][ 1 ] ] + root - weights[ i ];
            
        }
        
    }
    
    // iterate over all vertices
    int h0_total = 0;
    for ( int i = 0; i < vertices.size(); i++ ){
        
        // check if mod condition is satisfied
        if ( number_of_assigned_weights[ i ] == edge_numbers[ i ] ){
            if ( ( degrees[ i ] - incidents_of_vertices[ i ] ) % root != 0 ){
                return false;
            }
            else{
                
                // determine h0
                int deg = (int) ( degrees[ i ] - incidents_of_vertices[ i ] ) / root;
                int h0 = 0;
                if ( deg >= 0 ){
                    h0 = deg;
                    if ( genera[ i ] == 0 ){
                        h0 = h0 + 1;
                    }
                }
                
                // increase h0_total
                h0_total = h0_total + h0;
                
                // check if this is ok
                if ( h0_total > h0_target ){
                //if ( h0_total > 100 ){
                    //std::cout << "Fail \n";
                    return false;
                }
            }
        }
    }
    //std::cout << h0_total << "\n";
    // consistency check -- this should NEVER happen
    if ( ( ( h0_total > h0_target ) || ( h0_total < h0_min ) ) && ( non_initialized == 0 ) ){
        std::cout << "\n";
        std::cout << "THIS SHOULD NOT HAPPEN! PLEASE REPORT ISSUE IMMEDIATELY ON GITHUB. THANK YOU!\n";
        std::cout << h0_total << " vs. min " << h0_min << " and max " << h0_target << "\n";
        std::cout << "number of weights provided: " << weights.size() << "\n";
        std::cout << "number of edges" << edges.size() << "\n";
        for ( int i = 0; i < weights.size()-1; i++ ){
            std::cout << weights[ i ] << ",";
            }
        std::cout << weights[ weights.size() - 1 ] << "\n\n";
    }

    // all successful
    return true;
    
}

// set weights and test if this assignment is ok
bool WeightedDiagram::test_weights( std::vector<int> weights )
{
    
    return test_weights( weights, h0_min );
    
}

//############################################################
//################### (5) Compute h0 from given weights ###################
//############################################################

// set weights and test if this assignment is ok
int WeightedDiagram::h0_from_weights( std::vector<int> weights )
{
    
    // find the number of weights
    int w_total = weights.size();
    if ( w_total < edges.size() ){
        std::cout << "Length of provided weight vector does not match number of edges\n";
        return -1;
    }
    
    // set the weigths, check how many weights are assigned per vertex and compute the incident for each vertex
    int number_of_assigned_weights[ vertices.size() ]{ 0 };
    int incidents_of_vertices[ vertices.size() ]{ 0 };
    int non_initialized = 0;
    for ( int i = 0; i < w_total; i++ ){
        
        // count the number of not initialized weights
        if ( weights[ i ] == 0 ){
            non_initialized ++;
        }
        
        // compute incidents for good weights
        if ( weights[ i ] > 0 ){
            
            number_of_assigned_weights[ edges[ i ][ 0 ] ]++;
            incidents_of_vertices[ edges[ i ][ 0 ] ] = incidents_of_vertices[ edges[ i ][ 0 ] ] + weights[ i ];
            
            number_of_assigned_weights[ edges[ i ][ 1 ] ]++;
            incidents_of_vertices[ edges[ i ][ 1 ] ] = incidents_of_vertices[ edges[ i ][ 1 ] ] + root - weights[ i ];
            
        }
        
    }

    // if some weights are not initialized, we cannot perform this operation
    if ( non_initialized > 0 ){
        throw std::invalid_argument("Some weights are not initialized! Cannot compute h0." );
        return -1;
    }
    
    // iterate over all vertices
    int h0_total = 0;
    for ( int i = 0; i < vertices.size(); i++ ){
        
        // check if mod condition is satisfied
        if ( ( degrees[ i ] - incidents_of_vertices[ i ] ) % root != 0 ){
                throw std::invalid_argument("Likely, the provided weights do not define a root bundle. Check weights!" );
                return -1;
        }
        
        // determine h0
        int deg = (int) ( degrees[ i ] - incidents_of_vertices[ i ] ) / root;
        int h0 = 0;
        if ( deg >= 0 ){
                h0 = deg;
                if ( genera[ i ] == 0 ){
                    h0 = h0 + 1;
                }
        }
        
        // increase h0_total
        h0_total = h0_total + h0;
        
    }
    
    // return h0_total
    return h0_total;

}
