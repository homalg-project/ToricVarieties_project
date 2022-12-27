// Compute/estimate via lower bound h0 on nodal curve
// Compute/estimate via lower bound h0 on nodal curve
// Compute/estimate via lower bound h0 on nodal curve

void h0_on_nodal_curve(const std::vector<int>& degrees,
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
        
        /*
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
            
        }*/
        
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
