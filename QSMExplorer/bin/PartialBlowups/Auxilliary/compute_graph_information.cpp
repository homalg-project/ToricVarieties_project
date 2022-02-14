bool contains(const std::vector<int> & vec, const int & elem)
{
    return (std::find(vec.begin(), vec.end(), elem) != vec.end());
}

// method to compute additional information about the graph in question
void additional_graph_information(
                                  const std::vector<std::vector<int>> & edges,
                                  std::vector<int> & edge_numbers,
                                  std::vector<std::vector<std::vector<int>>> & graph_stratification )
{
    
    // compute the edge_numbers
    for (int i = 0; i < edges.size(); i++){
        edge_numbers[edges[i][0]]++;
        edge_numbers[edges[i][1]]++;
    }
    
    // compute the graph_stratification
    bool test = true;
    int index = 0;
    std::vector<std::vector<int>> scan_edges(edges.begin(), edges.end());
    while (test) {
        
        // determine the vertices connected to the index-th vertex
        std::vector<int> connected_vertices;
        for (int i = 0; i < scan_edges.size(); i++){
            if (scan_edges[i][0] == index && contains(connected_vertices, scan_edges[i][1]) == false){
                connected_vertices.push_back(scan_edges[i][1]);
            }
            if (scan_edges[i][1] == index && contains(connected_vertices, scan_edges[i][0]) == false){
                connected_vertices.push_back(scan_edges[i][0]);
            }
        }
        
        // determine the number of connecting edges
        std::vector<int> number_of_connecting_edges(connected_vertices.size(),0);
        for (int i = 0; i < connected_vertices.size(); i++){
            for (int j = 0; j < scan_edges.size(); j++){
                if (scan_edges[j][0] == index && scan_edges[j][1] == connected_vertices[i]){
                    number_of_connecting_edges[i]++;
                }
                if (scan_edges[j][1] == index && scan_edges[j][0] == connected_vertices[i]){
                    number_of_connecting_edges[i]++;
                }
            }
        }
        
        // determine the number of remaining edges for all connected
        std::vector<int> remaining_edges(connected_vertices.size(),0);
        for (int i = 0; i < connected_vertices.size(); i++){
            for (int j = 0; j < scan_edges.size(); j++){
                if (scan_edges[j][0] != index && scan_edges[j][1] == connected_vertices[i]){
                    remaining_edges[i]++;
                }
                if (scan_edges[j][1] != index && scan_edges[j][0] == connected_vertices[i]){
                    remaining_edges[i]++;
                }
            }
        }
        
        // add data to graph_stratification
        graph_stratification.push_back({connected_vertices, number_of_connecting_edges, remaining_edges});
        
        // compute new list of edges
        std::vector<std::vector<int>> new_edges;
        new_edges.reserve(scan_edges.size());
        for (int i = 0; i < scan_edges.size(); i++){
            if (scan_edges[i][0] != index && scan_edges[i][1] != index){
                new_edges.push_back(scan_edges[i]);
            }
        }
        
        // check if we are done: are there no remaining edges?
        if (new_edges.size() == 0){
            // yes -> end while loop
            test = false;
        }
        else{
            // not yet done -> prepare for next iteration
            index++;
            scan_edges = new_edges;
        }
        
    }
    
}
