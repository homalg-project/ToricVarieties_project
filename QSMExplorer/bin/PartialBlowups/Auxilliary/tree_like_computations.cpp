// (1) Helper functions to print vectors and vectors of vectors
// (1) Helper functions to print vectors and vectors of vectors
// (1) Helper functions to print vectors and vectors of vectors

void print_vector(const std::string &message, const std::vector<int> &values)
{
    std::cout << message;
    for (auto i: values)
        std::cout << i << ", ";
    std::cout << "\n";
}

void print_vector_of_vector(const std::string &message, const std::vector<std::vector<int>> &values)
{
    std::cout << message;
    for (int i = 0; i < values.size(); i++){
        print_vector("", values[i]);
    }
    std::cout << "\n";
}







// (2) Compute h0 on a CONNECTED tree-like rational curve (no check for connected conducted)
// (2) Compute h0 on a CONNECTED tree-like rational curve (no check for connected conducted)
// (2) Compute h0 on a CONNECTED tree-like rational curve (no check for connected conducted)

int h0_on_rational_tree(const std::vector<int>& degrees,
                                     const std::vector<std::vector<int>>& nodal_edges,
                                     const bool& details)
{
    
    // save entered degrees and edges
    std::vector<int> simple_degrees(degrees.begin(), degrees.end());
    std::vector<std::vector<int>> simple_edges(nodal_edges.begin(), nodal_edges.end());
    
    // inform about entered graph
    if (details){
        std::cout << "\n";
        std::cout << "############################################\n";
        std::cout << "Simplify tree-like graph:\n";
        std::cout << "--------------------------------\n\n";
        print_vector("Degrees: ", simple_degrees);
        print_vector_of_vector("Edges:\n", simple_edges);
    }
    
    // simplify the graph as much as possible
    while(true){
        
        // (1) Iminus or Iplus trivial?
        std::vector<int> Iminus, Iplus;
        for (int i = 0; i < simple_degrees.size(); i++){
            if (simple_degrees[i] < 0){
                Iminus.push_back(i);
            }
        }
        if ((Iminus.size() == 0) || (Iminus.size() == simple_degrees.size())){break;}
        
        // (2) no edges left?
        if (simple_edges.size() == 0){break;}
        
        // (3) No intersections among Iminus and Iplus?
        bool non_trivial_intersection = false;
        std::vector<std::vector<int>> intersections;
        for (int i = 0; i < simple_degrees.size(); i++){
            std::vector<int> helper(simple_degrees.size(), 0);
            for (int j = 0; j < simple_edges.size(); j++){
                if (simple_edges[j][0] == i){
                    helper[simple_edges[j][1]]++;
                    if ((simple_degrees[i] < 0) && (simple_degrees[simple_edges[j][1]] >= 0)){
                        non_trivial_intersection = true;
                    }
                    if ((simple_degrees[i] >= 0) && (simple_degrees[simple_edges[j][1]] < 0)){
                        non_trivial_intersection = true;
                    }
                }
                if (simple_edges[j][1] == i){
                    helper[simple_edges[j][0]]++;
                    if ((simple_degrees[i] < 0) && (simple_degrees[simple_edges[j][0]] >= 0)){
                        non_trivial_intersection = true;
                    }
                    if ((simple_degrees[i] >= 0) && (simple_degrees[simple_edges[j][0]] < 0)){
                        non_trivial_intersection = true;
                    }
                }
            }
            intersections.push_back(helper);
        }
        if (!non_trivial_intersection){break;}
        
        // (3) compute new degrees (C+,L+)
        std::vector<int> dictionary(simple_degrees.size(), -1);
        std::vector<int> new_degrees;
        int index = 0;
        for (int i = 0; i < simple_degrees.size(); i ++){
            if (simple_degrees[i] >= 0){
                dictionary[i] = index;
                index++;
                int new_deg = simple_degrees[i];
                for(int j = 0; j < Iminus.size(); j ++){
                    new_deg -= intersections[i][Iminus[j]];
                }
                new_degrees.push_back(new_deg);
            }
        }
        
        // (4) compute new edges
        std::vector<std::vector<int>> new_edges;
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
    
    // split the degrees into negative and non-negative part
    std::vector<int> neg, pos;
    std::partition_copy(simple_degrees.begin(), simple_degrees.end(), back_inserter(neg), back_inserter(pos), [](int value){return value < 0;});
    
    // compute total positive degree
    int h0 = std::accumulate(pos.begin(), pos.end(), 0);
    if (pos.size() > 0){
        h0++;
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

int merge(int* parent, int x)
{
    if (parent[x] == x)
        return x;
    return merge(parent, parent[x]);
}

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
    for (int i = 0; i < input_edges.size(); i++){
        if (!(std::count(vertices.begin(), vertices.end(), input_edges[i][0]))) {
            vertices.push_back(input_edges[i][0]);
        }
        if (!(std::count(vertices.begin(), vertices.end(), input_edges[i][1]))) {
            vertices.push_back(input_edges[i][1]);
        }
    }
    //sort(vertices.begin(), vertices.end());
    
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
    for (int i = 0; i < input_edges.size(); i++){
        std::vector<int> new_edge = {vertex_correspondence[input_edges[i][0]], vertex_correspondence[input_edges[i][1]]};
        edges.push_back(new_edge);
    }
    
    // (4) Compute the connected components
    int parent[vertices.size()];
    for (int i = 0; i < vertices.size(); i++) {
        parent[i] = i;
    }
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
    std::vector<std::vector<int>> copy_of_edges(edges.begin(), edges.end());
    edges_of_connected_components.resize(connected_components.size());
    while (copy_of_edges.size() > 0){
        // pick first edge and erase it from copy of edges
        std::vector<int> edge = copy_of_edges[0];
        copy_of_edges.erase(copy_of_edges.begin());
        
        // check to which connected component this edge belongs
        for (int i = 0; i < connected_components.size(); i++){
            if (std::count(connected_components[i].begin(), connected_components[i].end(), edge[0])){
                edges_of_connected_components[i].push_back(edge);
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





// (4) Compute betti number
// (4) Compute betti number
// (4) Compute betti number

int betti_number(std::vector<std::vector<int>>& input_edges)
{
    
    // (1) Find all vertices (avoiding duplicated) and sort them in ascending order
    std::vector<int> vertices;
    for (int i = 0; i < input_edges.size(); i++){
        if (!(std::count(vertices.begin(), vertices.end(), input_edges[i][0]))) {
            vertices.push_back(input_edges[i][0]);
        }
        if (!(std::count(vertices.begin(), vertices.end(), input_edges[i][1]))) {
            vertices.push_back(input_edges[i][1]);
        }
    }
    //sort(vertices.begin(), vertices.end());
    
    // (2) Construct two maps:
    // vertex_correspondence: our vertex names (e.g. "0, 2, 5, 6, ...") -> "0, 1, 2, 3, ..."
    // degree_correspondence: new vertex indices "0, 1, 2, 3, ..." -> degree on this vertex
    std::map<int, int> vertex_correspondence;
    for (int i = 0; i < vertices.size(); i++){
        vertex_correspondence.insert(std::pair<int, int>(vertices[i], i));
    }
    
    // (3) Form list of edges with internal/new vertex indices (-> can be easily processed below)
    std::vector<std::vector<int>> edges;
    for (int i = 0; i < input_edges.size(); i++){
        std::vector<int> new_edge = {vertex_correspondence[input_edges[i][0]], vertex_correspondence[input_edges[i][1]]};
        edges.push_back(new_edge);
    }
    
    // (4) Count number of connected components
    int c = 0;
    int parent[vertices.size()];
    for (int i = 0; i < vertices.size(); i++) {
        parent[i] = i;
    }
    for (auto x : edges) {
        parent[merge(parent, x[0])] = merge(parent, x[1]);
    }
    for (int i = 0; i < vertices.size(); i++) {
        c += (parent[i] == i);
    }
    for (int i = 0; i < vertices.size(); i++) {
        parent[i] = merge(parent, parent[i]);
    }
    std::map<int, std::list<int>> m;
    for (int i = 0; i < vertices.size(); i++) {
        m[parent[i]].push_back(i);
    }
    
    // compute betti number
    return edges.size() + c - vertices.size();
    
}



// (5) Compute/estimate via lower bound h0 on nodal curve with P1s as components
// (5) Compute/estimate via lower bound h0 on nodal curve with P1s as components
// (5) Compute/estimate via lower bound h0 on nodal curve with P1s as components

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

                // Remember this component
                components_with_nodes.push_back(i);
                test = true;
                
                // Off to the next component
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
    std::vector<std::vector<std::vector<int>>> edges_of_connected_components(connected_components.size());
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
            for (int j = 0; j < connected_components[i].size(); j++){
                helper_degrees.push_back(degree_correspondence[connected_components[i][j]]);
            }
            h0 += h0_on_rational_tree(helper_degrees, edges_of_connected_components[i], details);
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
