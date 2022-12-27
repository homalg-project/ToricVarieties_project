// Compute h0 on a CONNECTED tree-like rational curve (no check for connected conducted)
// Compute h0 on a CONNECTED tree-like rational curve (no check for connected conducted)
// Compute h0 on a CONNECTED tree-like rational curve (no check for connected conducted)

int h0_on_rational_tree(const std::vector<int>& degrees,
                        const std::vector<std::vector<int>>& nodal_edges)
{
    
    // Find all vertices (avoiding duplicated) and sort them in ascending order
    std::vector<int> vertices;
    vertices.reserve(2*nodal_edges.size());
    for (int i = 0; i < nodal_edges.size(); i++){
        if (!(std::count(vertices.begin(), vertices.end(), nodal_edges[i][0]))) {
            vertices.push_back(nodal_edges[i][0]);
        }
        if (!(std::count(vertices.begin(), vertices.end(), nodal_edges[i][1]))) {
            vertices.push_back(nodal_edges[i][1]);
        }
    }
    
    // make copy of the degrees
    std::vector<int> simple_degrees(degrees.begin(), degrees.end());
    
    // establish vertex correspondence: input vertex names (e.g. "0, 2, 5, 6, ...") -> "0, 1, 2, 3, ..."
    std::map<int, int> vertex_correspondence;
    for (int i = 0; i < vertices.size(); i++){
        vertex_correspondence.insert(std::pair<int, int>(vertices[i], i));
    }
    
    // adjust list of edges accordingly
    std::vector<std::vector<int>> simple_edges;
    simple_edges.reserve(nodal_edges.size());
    for (int i = 0; i < nodal_edges.size(); i++){
        simple_edges.push_back({vertex_correspondence[nodal_edges[i][0]], vertex_correspondence[nodal_edges[i][1]]});
    }
    
    // simplify the graph as much as possible
    while(true){
        
        // (1) no edges left?
        if (simple_edges.size() == 0){break;}
        
        // (2) compute new degrees (C+,L+)
        std::map<int, int> dictionary;
        std::vector<int> new_degrees;
        new_degrees.reserve(degrees.size());
        for (int i = 0; i < simple_degrees.size(); i ++){
            if (simple_degrees[i] >= 0){
                dictionary.insert(std::pair<int, int>(i, dictionary.size()));
                int new_deg = simple_degrees[i];
                for(int j = 0; j < simple_edges.size(); j++){
                    if ((simple_edges[j][0] == i) && (simple_degrees[simple_edges[j][1]] < 0)){
                        new_deg -= 1;
                    }
                    if ((simple_edges[j][1] == i) && (simple_degrees[simple_edges[j][0]] < 0)){
                        new_deg -= 1;
                    }
                }
                new_degrees.push_back(new_deg);
            }
        }
        
        // (3) degenerate case
        if ((new_degrees == simple_degrees) || (new_degrees.size() == 0)) {break;}
        
        // (4) compute new edges
        std::vector<std::vector<int>> new_edges;
        new_edges.reserve(simple_edges.size());
        for (int i = 0; i < simple_edges.size(); i ++){
            if ((simple_degrees[simple_edges[i][0]] >= 0) and (simple_degrees[simple_edges[i][1]] >= 0)){
                new_edges.push_back({dictionary[simple_edges[i][0]], dictionary[simple_edges[i][1]]});
            }
        }
        
        // (5) update
        simple_degrees = new_degrees;
        simple_edges = new_edges;
                
    }
    
    // initialize h0
    int h0 = 0;
    
    // is there at least one component with non-negative degree?
    bool positive_component = false;
    for (int i = 0; i < simple_degrees.size(); i++){
        if (simple_degrees[i] >= 0){
            positive_component = true;
            break;
        }
    }
    
    // if there is at least one component with non-negative degree, then perform detailed study
    if (positive_component){
        
        // sum of all non-negative degrees
        int sum_non_negative_degrees = 0;
        for (int i = 0; i < simple_degrees.size(); i++){
            if (simple_degrees[i] >= 0){
                sum_non_negative_degrees += simple_degrees[i];
            }
        }
        
        // compute number of connected components of I_plus
        std::vector<std::vector<int>> edges_of_Iplus;
        for (int i = 0; i < simple_edges.size(); i++){
            if ((simple_degrees[simple_edges[i][0]] >= 0) && (simple_degrees[simple_edges[i][1]] >= 0)){
                edges_of_Iplus.push_back(simple_edges[i]);
            }
        }
        int ncc = number_connected_components(edges_of_Iplus);
        
        // find all vertices which are disconnected and have a non-negative degree
        int number_disconnected_vertices = 0;
        for (int i = 0; i < simple_degrees.size(); i++){
            bool test = true;
            for (int j = 0; j < simple_edges.size(); j++){
                if ((simple_edges[j][0] == i) || (simple_edges[j][1] == i)){
                    test = false;
                }
            }
            if ((test==true) && (simple_degrees[i] >= 0)){
                number_disconnected_vertices++;
            }
        }
        
        // increase h0
        h0 = sum_non_negative_degrees + ncc + number_disconnected_vertices;
        
    }
    
    // return result
    return h0;
    
}
