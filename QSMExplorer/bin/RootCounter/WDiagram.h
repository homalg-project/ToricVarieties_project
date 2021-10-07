// A program to compute the number of minimal limit roots on full blowups of nodal curves

#include<iostream>
#include <vector>
#include <numeric>
#include <stdexcept>
#include <boost/multiprecision/cpp_int.hpp>

#ifndef WDIAGRAM_H
#define WDIAGRAM_H

// Define a class for weighted diagrams
// Define a class for weighted diagrams

class WeightedDiagramWithExternalLegs
{
    
    // variables that have to be set upon construction
    std::vector<int> vertices;
    std::vector<int> degrees;
    std::vector<int> genera;
    std::vector<std::vector<int>> edges;
    std::vector<int> external_legs;
    std::vector<int> external_weights;
    int genus;
    int root;
    
    // variables that are computed upon construction
    int degree;
    int h0_min;
    std::vector<int> edge_numbers;
    std::vector<int> external_leg_reductions;
    
    // the public section of this class
    public:
    
    // Constructors
    WeightedDiagramWithExternalLegs();
    WeightedDiagramWithExternalLegs(std::vector<int> &vi, std::vector<int> &di, std::vector<int> &gi, std::vector<std::vector<int>> &ei, std::vector<int> &el, std::vector<int> &ew, int &g, int &r );
    
    // print functions
    void print_vertices();
    void print_edge_numbers();
    void print_degrees();
    void print_genera();
    void print_edges();
    void print_external_legs();
    void print_external_weights();
    void print_external_leg_reductions();
    void print_degree();
    void print_root();
    void print_genus();
    void print_h0_min();
    void print_complete_information();
    
    // getter functions
    std::vector<int> get_vertices();
    std::vector<int> get_edge_numbers();
    std::vector<int> get_degrees();
    std::vector<int> get_genera();
    std::vector<std::vector<int>> get_edges();
    std::vector<int> get_external_legs();
    std::vector<int> get_external_weights();
    std::vector<int> get_external_leg_reductions();
    
    int get_degree();
    int get_root();
    int get_genus();
    int get_h0_min();
    boost::multiprecision::int128_t get_mult(std::vector<int> weights);
    
    // set and test weight configurations
    bool test_weights(std::vector<int> weights, int h0Min, int h0Max );
    bool test_weights(std::vector<int> weights);
    int h0_from_weights( std::vector<int> weights );
    
};

#endif
