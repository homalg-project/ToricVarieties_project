// (1) Parse input
// (1) Parse input
// (1) Parse input

void parse_input(const std::string & input_string,
                            std::vector<int> & degrees,
                            std::vector<int> & genera,
                            std::vector<std::vector<int>> & edges,
                            int & genus,
                            int & root,
                            int & number_threads,
                            int & h0Min,
                            int & h0Max,
                            int & numNodesMin,
                            int & numNodesMax,
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
    int number_vertices = input[0];
    for (int i = 1; i <= number_vertices; i++){
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
    
    // (4) Read-off integer data
    genus = input[2 * number_vertices + 2 + 2 * numberEdges];
    root = input[2 * number_vertices + 2 + 2 * numberEdges + 1];
    number_threads = input[2 * number_vertices + 2 + 2 * numberEdges + 2];
    h0Min = input[2 * number_vertices + 2 + 2 * numberEdges + 3];
    h0Max = input[2 * number_vertices + 2 + 2 * numberEdges + 4];
    numNodesMin = input[2 * number_vertices + 2 + 2 * numberEdges + 5];
    numNodesMax = input[2 * number_vertices + 2 + 2 * numberEdges + 6];
    
    // (5) Read-off if we are to display details
    int details = input[2 * number_vertices + 2 + 2 * numberEdges + 7];
    if (details >= 0){display_details = true;}
    else{display_details = false;}
    
}




// (2) Consistency check on input
// (2) Consistency check on input
// (2) Consistency check on input

void consistency_check(const int & genus,
                                      const std::vector<int> & genera,
                                      const std::vector<int> & degrees,
                                      const std::vector<std::vector<int>> & edges,
                                      const int & root,
                                      const int & h0Min,
                                      const int & h0Max,
                                      const int & numNodesMin,
                                      const int & numNodesMax,
                                      const int & number_threads)
{
    for (int i = 0; i < genera.size(); i++){
        if (genera[i] < 0 || genera[i] > 1){
            throw std::invalid_argument("Genera must be either 0 or 1!");
        }
    }
    if (genus < 0){throw std::invalid_argument("Genus must not be negative!");}
    if (root <= 1){throw std::invalid_argument("Root must be at least 2!");}
    if (h0Min > h0Max){throw std::invalid_argument("h0Min must not be larger than h0Max!");}
    if (h0Min < 0){throw std::invalid_argument("h0Min must not be negative!");}
    if (h0Max < 0){throw std::invalid_argument("h0Max must not be negative!");}
    if (numNodesMin < 0){throw std::invalid_argument("numNodesMin must not be negative!");}
    if (numNodesMax > edges.size()){throw std::invalid_argument("numNodesMax must not be larger than the number of edges!");}
    if (numNodesMin > numNodesMax){throw std::invalid_argument("numNodesMin must not be larger than numNodesMax!");}
    if (number_threads < 1){throw std::invalid_argument("Number of threads must not be smaller than 1!");}
    if (number_threads > 100){throw std::invalid_argument("Received number of threads larger than 100. This is probably not good!");}
    if (std::accumulate(degrees.begin(),degrees.end(),0) % root != 0){throw std::invalid_argument("Total degree is not divisible by root!");}
}
