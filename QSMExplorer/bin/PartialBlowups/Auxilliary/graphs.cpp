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


// (2) Find the connected components of a graph
// (2) Find the connected components of a graph
// (2) Find the connected components of a graph

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






// (3) Find the connected components of a graph
// (3) Find the connected components of a graph
// (3) Find the connected components of a graph

void find_connected_components2(const std::vector<std::vector<int>> & input_edges,
                                const std::vector<int> & degrees,
                                const std::vector<int> & genera,
                                //const bool & details,
                                std::vector<std::vector<std::vector<int>>> & edges_of_cc,
                                std::vector<std::vector<int>> & degrees_of_cc,
                                std::vector<std::vector<int>> & genera_of_cc)
{
        
    // (1) Find all vertices, but avoid duplicates
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
    
    // (2) Construct three maps:
    // vertex_correspondence: our vertex names (e.g. "0, 2, 5, 6, ...") -> "0, 1, 2, 3, ..."
    // degree_correspondence: new vertex indices "0, 1, 2, 3, ..." -> degree on this vertex
    // genera_correspondence: new vertex indices "0, 1, 2, 3, ..." -> genus on this vertex
    std::map<int, int> vertex_correspondence;
    std::map<int, int> degree_correspondence;
    std::map<int, int> genus_correspondence;
    for (int i = 0; i < vertices.size(); i++){
        vertex_correspondence.insert(std::pair<int, int>(vertices[i], i));
        degree_correspondence.insert(std::pair<int, int>(i, degrees[vertices[i]]));
        genus_correspondence.insert(std::pair<int, int>(i, genera[vertices[i]]));
    }
    
    // (3) Form list of edges with new new vertex indices (-> can be easily processed below)
    std::vector<std::vector<int>> edges;
    edges.reserve(input_edges.size());
    for (int i = 0; i < input_edges.size(); i++){
        edges.push_back({vertex_correspondence[input_edges[i][0]], vertex_correspondence[input_edges[i][1]]});
    }
    
    // (4) Compute the connected components
    std::vector<std::vector<int>> vertices_of_cc;
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
        vertices_of_cc.push_back(it->second);
    }
    
    //print_vector_of_vector("Vertices of cc: ", vertices_of_cc);
    //std::cout << "\n\n";
    
    // (5) Construct edge list of the connected components
    //edges_of_cc.resize(vertices_of_cc.size());
    for (int i = 0; i < edges.size(); i++){
        for (int j = 0; j < vertices_of_cc.size(); j++){
            if (std::count(vertices_of_cc[j].begin(), vertices_of_cc[j].end(), edges[i][0])){
                edges_of_cc[j].push_back(edges[i]);
                break;
            }
        }
    }
    
    // (6) Construct list of degrees
    //degrees_of_cc.resize(vertices_of_cc.size());
    //genera_of_cc.resize(vertices_of_cc.size());
    for (int i = 0; i < vertices_of_cc.size(); i++){
        std::vector<int> degrees_of_this_connected_component;
        std::vector<int> genera_of_this_connected_component;
        for (int j = 0; j < vertices_of_cc[i].size(); j++){
            degrees_of_this_connected_component.push_back(degree_correspondence[vertices_of_cc[i][j]]);
            genera_of_this_connected_component.push_back(genus_correspondence[vertices_of_cc[i][j]]);
        }
        //print_vector("Degrees of component: ", degrees_of_this_connected_component);
        degrees_of_cc.push_back(degrees_of_this_connected_component);
        genera_of_cc.push_back(genera_of_this_connected_component);
    }
    
    //print_vector_of_vector("Degrees", degrees_of_cc);
    
}
