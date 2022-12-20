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


// (3) Compute h0 on a CONNECTED tree-like rational curve (no check for connected conducted)
// (3) Compute h0 on a CONNECTED tree-like rational curve (no check for connected conducted)
// (3) Compute h0 on a CONNECTED tree-like rational curve (no check for connected conducted)

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
    
    
    // (4) Compute all connected components
    std::vector<std::vector<int>> connected_components;
    connected_components.reserve(2*resolved_edges.size() + 2*nodal_edges.size());
    std::vector<std::vector<std::vector<int>>> edges_of_connected_components;
    std::map<int, int> degree_correspondence;
    find_connected_components(nodal_edges, degrees, details, connected_components, edges_of_connected_components, degree_correspondence);
    
    
    // (5) Iterate over the connected components
    for (int i = 0; i < connected_components.size(); i++){
        
        // tree-like case
        if (edges_of_connected_components[i].size()+1-connected_components[i].size() == 0){
            std::vector<int> helper_degrees;
            helper_degrees.reserve(degrees.size());
            for (int j = 0; j < connected_components[i].size(); j++){
                helper_degrees.push_back(degree_correspondence[connected_components[i][j]]);
            }
            h0 += h0_on_rational_tree(connected_components[i], helper_degrees, edges_of_connected_components[i], details);
        }
        
        // handle a couple of simple cases with b1 = 1
        else if (edges_of_connected_components[i].size()+1-connected_components[i].size() == 1 
            && connected_components[i].size() >= 2 && connected_components[i].size() <= 3){
        
            // count local sections
            int local_sections = 0;
            for (int j = 0; j < connected_components[i].size(); j++){
                if (degree_correspondence[connected_components[i][j]] >= 0){
                    local_sections += degree_correspondence[connected_components[i][j]] + 1;
                }
            }
            
            // estimate conditions
            int conditions = 0;
            for (int j = 0; j < edges_of_connected_components[i].size(); j++){
                int d1 = degree_correspondence[edges_of_connected_components[i][j][0]];
                int d2 = degree_correspondence[edges_of_connected_components[i][j][1]];
                if ((d1 >= 0) || (d2 >= 0)){
                    conditions++;
                }
            }
            
            // increase h0
            if (local_sections >= conditions){
                h0 += local_sections - conditions;
            }
            
            // check if we merely deal with a lower bound
            
            if (connected_components[i].size() == 2){
                
                // simple circuit of two components
                // -> easy to deal with
                if (degree_correspondence[connected_components[i][0]] == 0
                    && degree_correspondence[connected_components[i][1]] == 0){
                        lower_bound = true;
                }
                
            }
            
            if (connected_components[i].size() == 3){
                
                // Slightly more involved case, as 3 components can form b1 in different ways
                // -> Need to tell those configurations apart.
                
                // find out if there is an amputated component
                std::vector<int> copy_of_components(connected_components[i]);
                std::vector<int> amputated_components;
                std::vector<int> connected_to;
                for (int j = 0; j < connected_components[i].size(); j++){
                    int count_for_component_j = 0;
                    for (int k = 0; k < edges_of_connected_components[i].size(); k++){
                        if (edges_of_connected_components[i][k][0] == connected_components[i][j]){
                            count_for_component_j++;
                        }
                        if (edges_of_connected_components[i][k][1] == connected_components[i][j]){
                            count_for_component_j++;
                        }
                        if (count_for_component_j > 1){
                            break;
                        }
                    }

                    if (count_for_component_j == 1){
                        amputated_components.push_back(connected_components[i][j]);
                        //copy_of_components.erase(copy_of_components.begin()+j);
                        for (int k = 0; k < edges_of_connected_components[i].size(); k++){
                            int connector;
                            if (edges_of_connected_components[i][k][0] == connected_components[i][j]){
                                connector = edges_of_connected_components[i][k][1];
                                connected_to.push_back(connector);
                            }
                            if (edges_of_connected_components[i][k][1] == connected_components[i][j]){
                                connector = edges_of_connected_components[i][k][0];
                                connected_to.push_back(connector);
                            }
                            int pos = std::distance(copy_of_components.begin(),std::find(copy_of_components.begin(), copy_of_components.end(), connector));
                            //copy_of_components.erase(copy_of_components.begin()+pos);
                        }
                    }
                }
                
                // Case 1: Circuit of 3 components
                int d1,d2,d3;
                if (amputated_components.size() == 0){
                    
                    d1 = degree_correspondence[connected_components[i][0]];
                    d2 = degree_correspondence[connected_components[i][1]];
                    d3 = degree_correspondence[connected_components[i][2]];
                    
                    if (d1 == 0 && d2 == 0 && d3 == 0){
                        lower_bound = true;
                    }
                }
                // Case 2: Circuit of 2 components and one amputated component
                else if (amputated_components.size() == 1){
                    
                    // find out to what components the amputated component is not connected to
                    // TODO This is now special for 3 compoennts, i.e. at most one amputated component, one connected and
                    // TODO one component which the amputated component is not connected to
                    std::vector<int> not_connected_to;
                    for (int j = 0; j < connected_components[i].size(); j++){
                        if ((connected_components[i][j] != amputated_components[0])
                            && (connected_components[i][j] != connected_to[0])){
                            not_connected_to.push_back(connected_components[i][j]);
                            break;
                        }
                    }
                    //std::vector<int> not_connected_to(copy_of_components);
                    
                    // Consistency check
                    if (amputated_components.size() != 1 || connected_to.size() != 1 || not_connected_to.size() != 1){
                        //throw std::invalid_argument("\nPartition of circuit into amputated, connected and not connected went wrong.\n");
                        std::cout << "\nProblem:\n";
                        print_vector("Amputated:", amputated_components);
                        print_vector("Connected:", connected_to);
                        print_vector("Not connected:", not_connected_to);
                        std::cout << "\n\n";
                    }
                    
                    d1 = degree_correspondence[not_connected_to[0]];
                    d2 = degree_correspondence[connected_to[0]];
                    d3 = degree_correspondence[amputated_components[0]];
                    
                    if (d1 == 0 && d2 == 1 && d3 < 0){
                        lower_bound = true;
                    }
                }
            }
            
        }
        
        // beyond what we can currently handle
        else{
            if (details){
                std::cout << "\n";
                std::cout << "############################################\n";
                std::cout << "Study circuit which is possibly jumping:\n";
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
