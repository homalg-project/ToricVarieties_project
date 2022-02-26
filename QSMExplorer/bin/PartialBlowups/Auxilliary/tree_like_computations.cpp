// (0) Number connected components
// (0) Number connected components
// (0) Number connected components

int merge(std::vector<int> & parent, int x)
{
    if (parent[x] == x){
        return x;
    }
    return merge(parent, parent[x]);
}

int number_connected_components(const std::vector<std::vector<int>>& input_edges)
{
    
    // (1) Find all vertices (avoiding duplicated) and sort them in ascending order
    std::vector<int> vertices;
    vertices.reserve(2*input_edges.size());
    for (int i = 0; i < input_edges.size(); i++){
        if (!(std::count(vertices.begin(), vertices.end(), input_edges[i][0]))) {
            vertices.push_back(input_edges[i][0]);
        }
        if (!(std::count(vertices.begin(), vertices.end(), input_edges[i][1]))) {
            vertices.push_back(input_edges[i][1]);
        }
    }
    
    // (2) Construct vertex_correspondence: input vertex names (e.g. "0, 2, 5, 6, ...") -> "0, 1, 2, 3, ..."
    std::map<int, int> vertex_correspondence;
    for (int i = 0; i < vertices.size(); i++){
        vertex_correspondence.insert(std::pair<int, int>(vertices[i], i));
    }
    
    // (3) Form list of edges with internal/new vertex indices (-> can be easily processed below)
    std::vector<std::vector<int>> edges;
    edges.reserve(input_edges.size());
    for (int i = 0; i < input_edges.size(); i++){
        edges.push_back({vertex_correspondence[input_edges[i][0]], vertex_correspondence[input_edges[i][1]]});
    }
    
    // (4) Count number of connected components
    int c = 0;
    std::vector<int> parent(vertices.size());
    std::iota(std::begin(parent), std::end(parent), 0);
    for (int i = 0; i < edges.size(); i++){
        parent[merge(parent, edges[i][0])] = merge(parent, edges[i][1]);
    }
    for (int i = 0; i < vertices.size(); i++) {
        c += (parent[i] == i);
    }
    
    // return betti number
    return c;
    
}


// (1) Compute betti number
// (1) Compute betti number
// (1) Compute betti number

int betti_number(const std::vector<std::vector<int>>& input_edges)
{
    
    // (1) Find all vertices (avoiding duplicated) and sort them in ascending order
    std::vector<int> vertices;
    vertices.reserve(2*input_edges.size());
    for (int i = 0; i < input_edges.size(); i++){
        if (!(std::count(vertices.begin(), vertices.end(), input_edges[i][0]))) {
            vertices.push_back(input_edges[i][0]);
        }
        if (!(std::count(vertices.begin(), vertices.end(), input_edges[i][1]))) {
            vertices.push_back(input_edges[i][1]);
        }
    }
    
    // (2) Number of connected components
    int ncc = number_connected_components(input_edges);
    
    // (3) return the betti number
    return input_edges.size() + ncc - vertices.size();
    
}


// (2) Compute h0 on a CONNECTED tree-like rational curve (no check for connected conducted)
// (2) Compute h0 on a CONNECTED tree-like rational curve (no check for connected conducted)
// (2) Compute h0 on a CONNECTED tree-like rational curve (no check for connected conducted)

int h0_on_rational_tree(const std::vector<int>& vertices,
                                     const std::vector<int>& degrees,
                                     const std::vector<std::vector<int>>& nodal_edges,
                                     const bool& details)
{
    
    // inform about entered graph
    if (details){
        std::cout << "\n";
        std::cout << "############################################\n";
        std::cout << "Simplify tree-like graph:\n";
        std::cout << "--------------------------------\n\n";
        print_vector("Degrees: ", degrees);
        print_vector_of_vector("Edges:\n", nodal_edges);
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
        
        // (6) inform about simplified graph
        if (details){
            print_vector("Degrees: ", simple_degrees);
            print_vector_of_vector("Edges:\n", simple_edges);
        }
        
    }
    
    // compute h0
    int h0 = 0;
    bool positive_component = false;
    for (int i = 0; i < simple_degrees.size(); i++){
        if (simple_degrees[i] >= 0){
            h0 += simple_degrees[i];
            positive_component = true;
        }
    }
    if (positive_component){
        
        // compute number of connected components
        std::vector<std::vector<int>> edges_of_Iplus;
        for (int i = 0; i < simple_edges.size(); i++){
            if ((simple_degrees[simple_edges[i][0]] >= 0) && (simple_degrees[simple_edges[i][1]] >= 0)){
                edges_of_Iplus.push_back(simple_edges[i]);
            }
        }
        int ncc = number_connected_components(edges_of_Iplus);
        
        // add also all vertices which are disconnected
        int number_disconnected_vertices = 0;
        for (int i = 0; i < simple_degrees.size(); i++){
            bool test = true;
            for (int j = 0; j < simple_edges.size(); j++){
                if ((simple_edges[j][0] == i) || (simple_edges[j][1] == i)){
                    test = false;
                }
            }
            if (test){
                number_disconnected_vertices++;
            }
        }
        
        // increase h0
        h0 = h0 + ncc + number_disconnected_vertices;
        
    }
    
    // inform about result
    if (details){
      std::cout << "--------------------------------\n";
      std::cout << "Graph fully simplified\n";
      std::cout << "Result: H0 = " << h0 << "\n";
      std::cout << "############################################\n\n";
    }
    
    // return result
    return h0;
    
}


// (3) Find the connected components of a graph
// (3) Find the connected components of a graph
// (3) Find the connected components of a graph

void find_connected_components(const std::vector<std::vector<int>> & input_edges,
                                                    const std::vector<int> & degrees,
                                                    const bool & details,
                                                    std::vector<std::vector<int>> & connected_components,
                                                    std::vector<std::vector<std::vector<int>>> & edges_of_connected_components,
                                                    std::map<int, int> & degree_correspondence)
{
    
    // (0) Inform about entered graph
    if (details){
        std::cout << "\n";
        std::cout << "############################################\n";
        std::cout << "Find connected components of input graph:\n";
        std::cout << "--------------------------------\n\n";
        print_vector_of_vector("Edges:\n", input_edges);
    }
    
    // (1) Find all vertices (avoiding duplicated) and sort them in ascending order
    std::vector<int> vertices;
    vertices.reserve(2*input_edges.size());
    for (int i = 0; i < input_edges.size(); i++){
        if (!(std::count(vertices.begin(), vertices.end(), input_edges[i][0]))) {
            vertices.push_back(input_edges[i][0]);
        }
        if (!(std::count(vertices.begin(), vertices.end(), input_edges[i][1]))) {
            vertices.push_back(input_edges[i][1]);
        }
    }
    
    // (2) Construct two maps:
    // vertex_correspondence: our vertex names (e.g. "0, 2, 5, 6, ...") -> "0, 1, 2, 3, ..."
    // degree_correspondence: new vertex indices "0, 1, 2, 3, ..." -> degree on this vertex
    std::map<int, int> vertex_correspondence;
    for (int i = 0; i < vertices.size(); i++){
        vertex_correspondence.insert(std::pair<int, int>(vertices[i], i));
        degree_correspondence.insert(std::pair<int, int>(i, degrees[vertices[i]]));
    }
    
    // (3) Form list of edges with internal/new vertex indices (-> can be easily processed below)
    std::vector<std::vector<int>> edges;
    edges.reserve(input_edges.size());
    for (int i = 0; i < input_edges.size(); i++){
        edges.push_back({vertex_correspondence[input_edges[i][0]], vertex_correspondence[input_edges[i][1]]});
    }
    
    // (4) Compute the connected components
    std::vector<int> parent(vertices.size());
    std::iota(std::begin(parent), std::end(parent), 0);
    for (int i = 0; i < edges.size(); i++){
        parent[merge(parent, edges[i][0])] = merge(parent, edges[i][1]);
    }
    for (int i = 0; i < vertices.size(); i++) {
        parent[i] = merge(parent, parent[i]);
    }
    std::map<int, std::vector<int>> m;
    for (int i = 0; i < vertices.size(); i++) {
        m[parent[i]].push_back(i);
    }
    for (auto it = m.begin(); it != m.end(); it++){
        connected_components.push_back(it->second);
    }
    
    // (5) Construct edge list of the connected components
    edges_of_connected_components.resize(connected_components.size());
    for (int i = 0; i < edges.size(); i++){
        for (int j = 0; j < connected_components.size(); j++){
            if (std::count(connected_components[j].begin(), connected_components[j].end(), edges[i][0])){
                edges_of_connected_components[j].push_back(edges[i]);
                break;
            }
        }
    }
    
    // (6) Inform what we found
    if (details){
        std::cout << "--------------------------------\n";
        std::cout << "Found " << connected_components.size() << " connected components:\n\n";
        for (int i = 0; i < connected_components.size(); i++){
            print_vector("Vertices: ", connected_components[i]);
            print_vector_of_vector("Edges:\n", edges_of_connected_components[i]);
        }
        std::cout << "############################################\n\n";
    }
}


// (4) Compute/estimate via lower bound h0 on nodal curve with P1s as components
// (4) Compute/estimate via lower bound h0 on nodal curve with P1s as components
// (4) Compute/estimate via lower bound h0 on nodal curve with P1s as components

void h0_from_partial_blowups(const std::vector<int>& degrees,
                                            const std::vector<std::vector<int>>& resolved_edges,                
                                            const std::vector<std::vector<int>>& nodal_edges,
                                            const std::vector<int> & genera,
                                            const bool & details,
                                            int & h0,
                                            bool & lower_bound)
{
    
    // (0) Initial assumption: We can compute the exact number of global sections
    lower_bound = false;
    
    
    // (1) Find compoents with nodes and add h0's from components without nodes
    std::vector<int> components_with_nodes;
    components_with_nodes.reserve(2*resolved_edges.size() + 2*nodal_edges.size());
    h0 = 0;
    for (int i = 0; i < degrees.size(); i++){
        bool test = false; // component i has no nodes attached to it
        for (int j = 0; j < nodal_edges.size(); j++){
            if ((nodal_edges[j][0] == i) || (nodal_edges[j][1] == i)){
                
                // Check for degenerate case: Is a g = 1 attached to node? If so, provide only lower bound.
                if (genera[i] == 1){
                    lower_bound = true;
                    h0 = 0;
                    for (int k = 0; k < degrees.size(); k++){
                        if ((degrees[k] >= 0)&&(genera[k] == 0)){
                            h0 += degrees[k]+1;
                        }
                        if ((degrees[k] >= 0)&&(genera[k] == 1)){
                            h0 += degrees[k];
                        }
                    }
                    if (h0 >= nodal_edges.size()){
                        h0 -= nodal_edges.size();
                    }
                    else{
                        h0 = 0;
                    }
                    if (details){
                        std::cout << "Lower bound since elliptic curve found attached to node: h0 >= " << h0 << "\n";
                    }
                    return;
                }

                // Remember this component and off to the next
                components_with_nodes.push_back(i);
                test = true;
                break;
                
            }
        }
        if (!test && (degrees[i] >= 0) && (genera[i] == 0)){
            h0 += degrees[i]+1;
        }
        if (!test && (degrees[i] >= 0) && (genera[i] == 1)){
            // We only compute a lower bound. So we assume that d = 0 on elliptic curve implies h0 = 0.
            h0 += degrees[i];
        }
    }
    
    
    // (2) Inform what we find from non-nodal curves
    if (details){
        std::cout << "\n";
        std::cout << "############################################\n";
        print_vector("degrees: ", degrees);
        std::cout << "H0 = " << h0 << " from NON-nodal components:\n";
        std::cout << "############################################\n\n";
    }
    
    
    // (3) Degenerate case: no nodes
    if (components_with_nodes.size() == 0){
        if (details){std::cout << "h0 = " << h0 << "\n";}
        return;
    }
    
    
    // (4) Compute all connected componentss
    std::vector<std::vector<int>> connected_components;
    connected_components.reserve(2*resolved_edges.size() + 2*nodal_edges.size());
    std::vector<std::vector<std::vector<int>>> edges_of_connected_components;
    std::map<int, int> degree_correspondence;
    find_connected_components(nodal_edges, degrees, details, connected_components, edges_of_connected_components, degree_correspondence);
    
    
    // (5) Iterate over the connected components
    for (int i = 0; i < connected_components.size(); i++){
        // if NOT tree-like
        if (edges_of_connected_components[i].size()+1-connected_components[i].size() > 0){
            if (details){
                std::cout << "\n";
                std::cout << "############################################\n";
                std::cout << "Study NON-tree like graph:\n";
                std::cout << "--------------------------------\n\n";
            }
            lower_bound = true;
            int number_nodes = edges_of_connected_components[i].size();
            int local_sections = 0;
            if (details){
              std::cout << "Degrees: ";
            }
            for (int j = 0; j < connected_components[i].size(); j++){
                if (details){
                  std::cout << degree_correspondence[connected_components[i][j]] << ", ";
                }
                if (degree_correspondence[connected_components[i][j]] >= 0){
                    local_sections += degree_correspondence[connected_components[i][j]] + 1;
                }
            }
            if (details){
                std::cout << "\nb1 = " << edges_of_connected_components[i].size()+1-connected_components[i].size() << "\n";
                print_vector_of_vector("\nEdges:\n", edges_of_connected_components[i]);
                std::cout << "Number nodes: " << number_nodes << "\n";
                std::cout << "Local sections: " << local_sections << "\n";
            }
            if (local_sections > number_nodes){
                if (local_sections >= number_nodes){
                    h0 += local_sections - number_nodes;
                }
                if (details){
                    std::cout << "=> H0 >= " << local_sections - number_nodes << "\n";
                    std::cout << "############################################\n\n";
                }
            }
            else{
                if (details){
                    std::cout << "=> H0 >= 0\n";
                    std::cout << "############################################\n\n";
                }
            }
        }
        // if tree-like
        else{
            std::vector<int> helper_degrees;
            helper_degrees.reserve(degrees.size());
            for (int j = 0; j < connected_components[i].size(); j++){
                helper_degrees.push_back(degree_correspondence[connected_components[i][j]]);
            }
            h0 += h0_on_rational_tree(connected_components[i], helper_degrees, edges_of_connected_components[i], details);
        }
    }
    
    
    // (6) Print result
    if (details){
        std::cout << "\n";
        std::cout << "############################################\n";
        std::cout << "Final result:\n";
        std::cout << "--------------------------------\n";
        if (lower_bound){std::cout << "H0 >= " << h0 << "\n";}
        else{std::cout << "H0 = " << h0 << "\n";}
        std::cout << "############################################\n";
        std::cout << "############################################\n\n";
    }
    
    // (6) Return the result
    return;
    
}
