// Compute/estimate via lower bound h0 on nodal curve
// Compute/estimate via lower bound h0 on nodal curve
// Compute/estimate via lower bound h0 on nodal curve

void h0_on_nodal_curve(const std::vector<int>& degrees,
                        const std::vector<std::vector<int>>& nodal_edges,
                        const std::vector<int> & genera,
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
    
    
    // (3) Degenerate case: no nodes
    if (components_with_nodes.size() == 0){
        return;
    }
    
    
    // (4) Compute all connected components
    std::vector<std::vector<std::vector<int>>> edges_of_cc;
    std::vector<std::vector<int>> degs_of_cc, gens_of_cc;
    find_connected_components2(nodal_edges, degrees, genera, edges_of_cc, degs_of_cc, gens_of_cc);
    
    
    // (5) Iterate over the connected components
    for (int i = 0; i < edges_of_cc.size(); i++){
        
        // tree-like case
        if (betti_number(edges_of_cc[i]) == 0){
            h0 += h0_on_rational_tree(degs_of_cc[i], edges_of_cc[i]);
        }
        
        // beyond what we can currently handle
        else{
            lower_bound = true;
            int number_nodes = edges_of_cc[i].size();
            int local_sections = 0;
            for (int j = 0; j < degs_of_cc[i].size(); j++){
                if (degs_of_cc[i][j] >= 0){
                    local_sections += degs_of_cc[i][j] - gens_of_cc[i][j] + 1;
                }
            }
            if (local_sections >= number_nodes){
                h0 += local_sections - number_nodes;
            }
        }
    }
    
    return;
    
}
