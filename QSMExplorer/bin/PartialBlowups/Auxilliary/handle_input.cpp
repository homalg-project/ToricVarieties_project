// (1) Parse input
// (1) Parse input
// (1) Parse input

void parse_input(std::string input_string,
                            int & number_vertices,
                            std::vector<int> & vertices,
                            std::vector<int> & degrees,
                            std::vector<int> & genera,
                            std::vector<std::vector<int>> & edges,
                            int & genus,
                            int & root,
                            int & number_threads,
                            int & h0Min,
                            int & h0Max,
                            bool & display_details)
{
    
    // (1) Parse input string into integers
    std::stringstream iss(input_string);
    std::vector<int> input;
    int number;
    while (iss >> number){
        input.push_back(number);
    }
    
    // (2) Read-off vertices, degrees and genera
    number_vertices = input[0];
    for (int i = 1; i <= number_vertices; i++){
        vertices.push_back(i - 1);
        degrees.push_back(input[i]);
        genera.push_back(input[i + number_vertices]);
    }
    
    // (3) Read-off the edges
    int numberEdges = input[2 * number_vertices + 1];
    for (int i = 0; i < numberEdges; i ++){
        std::vector<int> helper (2);
        int index = 2 + 2 * number_vertices + 2 * i;
        helper[0] = input[index];
        helper[1] = input[index + 1];
        edges.push_back(helper);
    }
    
    // (4) Read-off the external edges and weights
    int numberExternalEdges = input[2 * number_vertices + 1 + 1 + 2 * numberEdges];
    std::vector<int> external_legs, external_weights;
    for (int i = 0; i < numberExternalEdges; i ++){
        int index = 2 * number_vertices + 1 + 1 + 2 * numberEdges + 1 + 2 * i;
        external_legs.push_back(input[index]);
        external_weights.push_back(input[index + 1]);
    }
    
    // (5) Read-off integer data
    genus = input[2 * number_vertices + 2 + 2 * numberEdges + 2 * numberExternalEdges + 1];
    root = input[2 * number_vertices + 2 + 2 * numberEdges + 2 * numberExternalEdges + 2];
    number_threads = input[2 * number_vertices + 2 + 2 * numberEdges + 2 * numberExternalEdges + 3];
    h0Min = input[2 * number_vertices + 2 + 2 * numberEdges + 2 * numberExternalEdges + 4];
    h0Max = input[2 * number_vertices + 2 + 2 * numberEdges + 2 * numberExternalEdges + 5];
    
    // (6) Read-off if we are to display details
    int details = input[2 * number_vertices + 2 + 2 * numberEdges + 2 * numberExternalEdges + 6];
    if (details >= 0){display_details = true;}
    else{display_details = false;}
        
    // (7) Subtract external_weights from degrees
    for (int i = 0; i < external_legs.size(); i++){
        degrees[external_legs[i]] -= external_weights[i];
    }
    
}




// (2) Consistency check on input
// (2) Consistency check on input
// (2) Consistency check on input

void consistency_check(const int & genus,
                                      const std::vector<int> & genera,
                                      const std::vector<int> & degrees,
                                      const int & root,
                                      const int & h0Min,
                                      const int & h0Max,
                                      const int & number_threads)
{
    if (genus < 0){throw std::invalid_argument("Genus must not be negative!");}
    if (root <= 1){throw std::invalid_argument("Root must be at least 2!");}
    if (h0Min > h0Max){throw std::invalid_argument("h0Min must not be larger than h0Max!");}
    if (h0Min < 0){throw std::invalid_argument("h0Min must not be negative!");}
    if (h0Max < 0){throw std::invalid_argument("h0Max must not be negative!");}    
    if (number_threads < 1){throw std::invalid_argument("Number of threads must not be smaller than 1!");}
    if (number_threads > 100){throw std::invalid_argument("Received number of threads larger than 100. This is probably not good!");}
    if (std::accumulate(degrees.begin(),degrees.end(),0) % root != 0){throw std::invalid_argument("Total degree is not divisible by root!");}
}
