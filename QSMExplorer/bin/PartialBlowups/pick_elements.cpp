#include <cassert>
#include <algorithm>
#include <iostream>
#include <numeric>
#include <vector>
#include <set>

// calculate numbers of ways in which we can pick number_of_elements_to_pick from
// number_of_elements
std::vector<std::vector<int>> get_combinations_of_indices_to_pick(std::size_t number_of_elements_to_pick, std::size_t number_of_elements)
{
    
    // initialize container for result
    std::vector<std::vector<int>> combinations;
    
    // compute the combinations
    if (number_of_elements == number_of_elements_to_pick){
        std::vector<int> v(number_of_elements);
        std::iota(std::begin(v), std::end(v), 0);
        combinations = {v};
    }
    else{
        assert(number_of_elements > number_of_elements_to_pick);
        std::vector<bool> pick_element_n(number_of_elements_to_pick, true);
        pick_element_n.insert(pick_element_n.end(), number_of_elements - number_of_elements_to_pick, 0);        
        do{
            std::vector<int> combination;
            for(int i = 0; i < number_of_elements; ++i){
                if (pick_element_n[i]) combination.push_back(i);
            }
            combinations.push_back(combination);
        } while (std::prev_permutation(pick_element_n.begin(), pick_element_n.end()));
    }
    
    // return result
    return combinations;
    
}
