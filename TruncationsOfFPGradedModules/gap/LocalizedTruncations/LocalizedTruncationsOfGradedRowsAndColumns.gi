################################################################################################
##
##  LocalizedDegree0OfGradedRowsAndColumns.gi       TruncationsOfFPGradedModules
##
##  Copyright 2020               Martin Bies,       University of Oxford
##
##  Localized truncations of graded rows or columns
##
################################################################################################


#######################################################################################
##
##  Technical tools
##
#######################################################################################

InstallMethod( Degree_basis,
               "for a graded ring and two lists",
               [ IsHomalgGradedRing, IsList, IsList ],
  function( graded_ring, localized_variables, degree )
    local degree_matrix, degree_matrix_list, kernel_of_degree_matrix, kernel_of_degree_matrix_transposed,
         translation_vector, inequalities_list, rows, inequalities_polytope, generating_set, monomial_transformation;
    
    # Check for valid input
    if Length( degree ) <> Rank( DegreeGroup( graded_ring ) ) then
        Error( "The provided degree does not belong to the degree group of the given graded ring" );
    fi;
    
    # Check if we have to compute the degree-0 layer. If so, trigger special method below...
    #if degree = UnderlyingListOfRingElements( TheZeroElement( DegreeGroup( graded_ring ) ) ) then
        #Error( "Test - check this test, remove the original function and place also the mapping functions more adequatly describing what they are doing!" )
    #    return Localized_degree_zero_monomials( graded_ring, localized_variables );
    #fi;
    
    # Support localization only for rings with indeterminates
    if Length( IndeterminatesOfPolynomialRing( graded_ring ) ) = 0 then
        Error( "localized degree-0 is not supported for rings with no indeterminates" );
    fi;
    
    # extract the degree_matrix
    degree_matrix := UnionOfRows( List( WeightsOfIndeterminates( graded_ring ), i -> MatrixOfMap( UnderlyingMorphism( i ) ) ) );
    degree_matrix_list := EntriesOfHomalgMatrixAsListList( degree_matrix );
    
    # and compute its kernel
    kernel_of_degree_matrix := MatrixOfMap( KernelEmb( HomalgMap( degree_matrix, "free", DegreeGroup( graded_ring ) ) ) );
    kernel_of_degree_matrix_transposed := Involution( kernel_of_degree_matrix );
    
    # find the translation vector
    translation_vector := SolutionIntMat( degree_matrix_list, degree );
    
    # formulate inequalities and compute generators as lattice point generators
    inequalities_list := EntriesOfHomalgMatrixAsListList( kernel_of_degree_matrix_transposed );
    rows := [ 1 .. Length( inequalities_list ) ];
    rows := Filtered( rows, i -> not i in localized_variables );
    inequalities_list := List( rows, i -> Concatenation( [ translation_vector[ i ] ], inequalities_list[ i ] ) );
    inequalities_polytope := PolyhedronByInequalities( inequalities_list );
    generating_set := LatticePointsGenerators( inequalities_polytope );
    generating_set := ShallowCopy( generating_set[ 1 ] );
    
    # identify the monomial transformation
    monomial_transformation := EntriesOfHomalgMatrixAsListList( kernel_of_degree_matrix );
    
    # and employ it to turn the lattice point into rationoms
    return List( [ 1 .. Length( generating_set ) ], i -> generating_set[ i ] * monomial_transformation + translation_vector );
    
end );


# Compute matrix with the degree relations
InstallMethod( Degree_part_relations,
               [ IsList, IsList, IsHomalgRing ],
  function( degree_zero_generating_set, degree_basis_elements, new_base_ring )
    local relation_point_matrix, poly, ineqs_poly, offsets_i, ineqs_poly_i, p_i, offsets_j, ineqs_poly_j, p_j, intersection_poly,
          intersection_lattice_points_generators, i, j, monomial_solution, transposed_degree_zero_generating_set, positive_orthant_inequalities, positive_orthant_inequalities_rhs, current_vector,
          current_intersected_point, ring_indets, matrix;
    
    # initialize relation_point_matrix
    relation_point_matrix := [ ];
    
    # check for degenerate cases
    if degree_zero_generating_set = [ ] then
        return HomalgZeroMatrix( 0, 0, new_base_ring );
    fi;
    
    # set up a number of quantities needed for the computation
    transposed_degree_zero_generating_set := TransposedMat( degree_zero_generating_set );
    positive_orthant_inequalities := IdentityMat( Length( degree_zero_generating_set[ 1 ] ) );
    positive_orthant_inequalities_rhs := ListWithIdenticalEntries( Length( degree_zero_generating_set[ 1 ] ), 0 );
    ring_indets := Indeterminates( new_base_ring );
    
    for i in [ 1 .. Length( degree_basis_elements ) ] do
        for j in [ i + 1 .. Length( degree_basis_elements ) ] do
            
            if degree_zero_generating_set = [ ] then
                continue;
            fi;
            
            # compute first the polytope fro the degree_zero_generating_set
            poly := Polytope( degree_zero_generating_set );
            ineqs_poly := DefiningInequalities( poly );
            
            # The integral points in poly correspond to the monomials in S_0
            # Relations among the generators g_i = degree_basis_elements[ i ] are of the form g_i m_i - g_j m_j where m_i, m_j
            # are monomials of degree 0 in S_0.
            
            # g_i m_i is in the polytope poly + g_i and g_j m_j in the polytope poly + g_j.
            # If these two have common points, then there is a relation among g_i and g_j.
            
            # compute polytope shifted by degree_basis_elements[ i ]
            offsets_i := List( [ 1 .. Length( ineqs_poly ) ], k -> ineqs_poly[ k ][ 1 ] -
                                                ineqs_poly[ k ]{[ 2 .. Length( ineqs_poly[ k ] ) ]} * degree_basis_elements[ i ] );
            ineqs_poly_i := List( [ 1 .. Length( ineqs_poly ) ],
                                    k -> Concatenation( [ offsets_i[ k ] ], ineqs_poly[ k ]{[ 2 .. Length( ineqs_poly[ k ] ) ]} ) );
            p_i := PolytopeByInequalities( ineqs_poly_i );
            
            # compute polytope shifted by degree_basis_elements[ j ]
            offsets_j := List( [ 1 .. Length( ineqs_poly ) ], k -> ineqs_poly[ k ][ 1 ] -
                                                ineqs_poly[ k ]{[ 2 .. Length( ineqs_poly[ k ] ) ]} * degree_basis_elements[ j ] );
            ineqs_poly_j := List( [ 1 .. Length( ineqs_poly ) ],
                                    k -> Concatenation( [ offsets_j[ k ] ], ineqs_poly[ k ]{[ 2 .. Length( ineqs_poly[ k ] ) ]} ) );
            p_j := PolytopeByInequalities( ineqs_poly_j );
            
            # compute intersection polytope
            intersection_poly := IntersectionOfPolytopes( p_i, p_j );
            intersection_lattice_points_generators := LatticePointsGenerators( intersection_poly )[ 1 ];
            
            if intersection_lattice_points_generators = [ ] then
                continue;
            fi;
            
            # Elements in intersection_lattice_points_generators are the exponents of the elements in S_0 which generate relations.
            # We cannot handle negative powers of variables in gap. By Gutsches thesis however, there is a clever way to remove them.
            # Given an intersection points, we find the linear combination of monomials in S_0 which give us this monomial.
            # So this looks like sum_i a_i m_i with a_i >= 0. We remember [ a_1, a_2, ..., a_n ].
            # The magic is now, that we can replace the intersection point by x_1^a_1 * x_2^a_2 * ...
            
            # Finally, since the relations are of the form g_i m_i - g_j m_j, we have to remember this relative (-1) of every
            # such binary relation.
            for current_intersected_point in intersection_lattice_points_generators do
                
                # initialise the list with [ a_i ]
                current_vector := ListWithIdenticalEntries( Length( degree_basis_elements ), 0 );
                
                # express the intersection point as (element in S_0 ) * i-th generator
                monomial_solution := SolveEqualitiesAndInequalitiesOverIntergers(
                                        transposed_degree_zero_generating_set, current_intersected_point - degree_basis_elements[ i ],
                                        positive_orthant_inequalities, positive_orthant_inequalities_rhs );
                
                # and set this as i-th entry
                #current_vector[ i ] := Concatenation( monomial_solution[ 1 ][ 1 ], [ +1 ] );
                current_vector[ i ] := Product( [ 1 .. Length( ring_indets ) ],
                                       k -> ring_indets[ k ]^monomial_solution[ 1 ][ 1 ][ k ] );
                
                # express intersection point as (element in S_0 ) * j-th generator
                monomial_solution := SolveEqualitiesAndInequalitiesOverIntergers(
                                        transposed_degree_zero_generating_set, current_intersected_point - degree_basis_elements[ j ], 
                                        positive_orthant_inequalities, positive_orthant_inequalities_rhs );
                
                # and the this as j-th entry
                #current_vector[ j ] := Concatenation( monomial_solution[ 1 ][ 1 ], [ -1 ] );
                current_vector[ j ] := (-1) * Product( [ 1 .. Length( ring_indets ) ],
                                              k -> ring_indets[ k ]^monomial_solution[ 1 ][ 1 ][ k ] );
                
                # finally save this relation to the relation matrix
                Add( relation_point_matrix, current_vector );
                
            od;
        od;
    od;
    
    # check for degenerate cases
    if relation_point_matrix = [] then
        matrix := HomalgZeroMatrix( 0, Length( degree_basis_elements ), new_base_ring );
    else
        matrix := Involution( HomalgMatrix( relation_point_matrix, new_base_ring ) );
    fi;
    
    # return the resulting matrix
    return matrix;
    
end );


#######################################################################################
##
## Section Localized degree-0-layer of graded rows and columns
##
#######################################################################################

InstallMethod( LocalizedDegreeZero,
               [ IsGradedRow, IsList, IsHomalgGradedRing, IsList, IsCapCategory ],
  function( module, localized_variables, graded_ring, new_ring_data, rows )
    
    local ring_generators, new_ring, ring_degrees, kernel_of_ring_degrees, degree_list, module_generators, modules, 
         empty_gens, current_part, current_generators, current_relation_matrix, range, source, new_module, new_object;

    # read off information about the ring
    ring_generators := new_ring_data[ 1 ];
    new_ring := new_ring_data[ 2 ];
    
    # extract ring_degrees and their kernel
    ring_degrees := UnionOfRows( List( WeightsOfIndeterminates( graded_ring ), i -> MatrixOfMap( UnderlyingMorphism( i ) ) ) );
    kernel_of_ring_degrees := MatrixOfMap( KernelEmb( HomalgMap( ring_degrees, "free", DegreeGroup( graded_ring ) ) ) );
    
    # extract the degrees of the given module
    degree_list := List( UnzipDegreeList( module ), i -> UnderlyingListOfRingElements( i ) );
    
    # next perform the localized truncation
    module_generators := [ ];
    modules := [ ];
    empty_gens := [ ];
    for current_part in [ 1 .. Length( degree_list ) ] do
        
        # truncate the current generators
        current_generators := Degree_basis( graded_ring, localized_variables, degree_list[ current_part ] );
        
        # check if the result is trivial
        if current_generators = [ ] then
            Add( empty_gens, current_part );
        else
            # if not, first remember the generators
            Add( module_generators, current_generators );
            
            # then compute the relation matrix
            current_relation_matrix := Degree_part_relations( ring_generators, current_generators, new_ring );
            
            # and turn it into an fp graded left module module
            range := CategoryOfRowsObject( NumberColumns( current_relation_matrix ), rows );
            source := CategoryOfRowsObject( NumberRows( current_relation_matrix ), rows );
            Add( modules, FreydCategoryObject( CategoryOfRowsMorphism( source, current_relation_matrix, range ) ) );
            
        fi;
        
    od;
    
    # compute object to be returned
    if Length( modules ) = 0 then
        new_module := AsFreydCategoryObject( ZeroObject( rows ) );
    else
        new_module := DirectSum( modules );
    fi;
    new_module!.degree_part_generator_monomials := module_generators;
    new_module!.deleted_free_parts := empty_gens;

    # and return it
    return new_module;
    
end );


InstallMethod( LocalizedDegreeZero,
               [ IsGradedRow, IsList ],
  function( module, localized_variables )
    local graded_ring, new_ring_data, rows;
    
    # compute the localized ring
    graded_ring := UnderlyingHomalgGradedRing( module );
    new_ring_data := Localized_degree_zero_ring_and_generators( graded_ring, localized_variables );
    
    # initialize the category of rows of the new ring
    rows := CategoryOfRows( new_ring_data[ 2 ] );
    
    # and compute the truncation
    return LocalizedDegreeZero( module, localized_variables, graded_ring, new_ring_data, rows );
    
end );


InstallMethod( LocalizedDegreeZero,
               [ IsGradedColumn, IsList, IsHomalgGradedRing, IsList, IsCapCategory ],
  function( module, localized_variables, graded_ring, new_ring_data, rows )
    local new_module, localize;
    
    new_module := TurnIntoGradedRow( module );
    localize := LocalizedDegreeZero( new_module, localized_variables, graded_ring, new_ring_data, rows );
    return TurnIntoColumnPresentation( localize );
    
end );


InstallMethod( LocalizedDegreeZero,
               [ IsGradedColumn, IsList ],
  function( module, localized_variables )
    local graded_ring, new_ring_data, rows;
    
    # compute the localized ring
    graded_ring := UnderlyingHomalgGradedRing( module );
    new_ring_data := Localized_degree_zero_ring_and_generators( graded_ring, localized_variables );
    
    # initialize the category of rows of the new ring
    rows := CategoryOfRows( new_ring_data[ 2 ] );
    
    # and compute the truncation
    return LocalizedDegreeZero( module, localized_variables, graded_ring, new_ring_data, rows );
    
end );


InstallMethod( LocalizedDegreeZero,
               [ IsGradedRowOrColumnMorphism, IsList, IsHomalgGradedRing, IsList, IsCapCategory ],
  function( module_morphism, localized_variables, graded_ring, new_ring_data, rows )
    local column, morphism, ring_generators, new_ring, source_module, range_module, homalg_matrix_as_list_list, i, 
         new_matrix, new_mor_datum, new_mor;
    
    # is the input a morphism of graded columns?
    if IsGradedColumnMorphism( module_morphism ) then
        column := true;
        morphism := TurnIntoGradedRowMorphism( module_morphism );
    else
        column := false;
        morphism := module_morphism;
    fi;
    
    # compute the localized ring
    ring_generators := new_ring_data[ 1 ];
    new_ring := new_ring_data[ 2 ];
    
    # compute localized truncation of source and range
    source_module := LocalizedDegreeZero( Source( morphism ), localized_variables, graded_ring, new_ring_data, rows );
    range_module := LocalizedDegreeZero( Range( morphism ), localized_variables, graded_ring, new_ring_data, rows );
    
    # check for degenerate case
    if RankOfObject( Range( RelationMorphism( range_module ) ) ) = 0 then
        if column then
            return AsFreydCategoryObject( ZeroObject( CategoryOfColumns( new_ring ) ) );
        else
            return AsFreydCategoryObject( ZeroObject( CategoryOfRows( new_ring ) ) );
        fi;
    fi;
    
    # extract underlying homalg matrix
    homalg_matrix_as_list_list := EntriesOfHomalgMatrixAsListList( UnderlyingHomalgMatrix( morphism ) );
    
    # remove parts that have been removed in the truncation process
    for i in Reversed( source_module!.deleted_free_parts ) do
        Remove( homalg_matrix_as_list_list, i );
    od;
    homalg_matrix_as_list_list := TransposedMatMutable( homalg_matrix_as_list_list );
    for i in Reversed( range_module!.deleted_free_parts ) do
        Remove( homalg_matrix_as_list_list, i );
    od;
    homalg_matrix_as_list_list := TransposedMatMutable( homalg_matrix_as_list_list );
    
    # and finally compute the mapping matrix of the localized truncated morphism
    if Length( homalg_matrix_as_list_list ) = 0 then
        new_matrix := HomalgZeroMatrix( RankOfObject( Range( RelationMorphism( source_module ) ) ),
                                        RankOfObject( Range( RelationMorphism( range_module ) ) ),
                                        new_ring );
    else
        new_matrix := New_matrix_mapping_by_generator_lists(
                        source_module!.degree_part_generator_monomials,
                        range_module!.degree_part_generator_monomials,
                        homalg_matrix_as_list_list,
                        ring_generators,
                        new_ring );
    fi;
    
    # construct the truncated morphism
    new_mor_datum := CategoryOfRowsMorphism( Range( RelationMorphism( source_module ) ),
                                             new_matrix,
                                             Range( RelationMorphism( range_module ) ) );
    new_mor := FreydCategoryMorphism( source_module, new_mor_datum, range_module );
    
    # if we have to truncate a morphism of fp graded right modules, then turn new_mor into a presentation morphism of columns
    if column then
        new_mor := TurnIntoColumnPresentationMorphism( new_mor );
    fi;
    
    # remember generator monomials and deleted free parts
    new_mor!.degree_part_generator_monomials := range_module!.degree_part_generator_monomials;
    new_mor!.deleted_free_parts := range_module!.deleted_free_parts;
    
    # and return the new morphism
    return new_mor;
    
end );


InstallMethod( LocalizedDegreeZero,
               [ IsGradedRowOrColumnMorphism, IsList ],
  function( module_morphism, localized_variables )
    local graded_ring, new_ring_data, rows;
    
    # compute the localized ring
    graded_ring := UnderlyingHomalgGradedRing( module_morphism );
    new_ring_data := Localized_degree_zero_ring_and_generators( graded_ring, localized_variables );
    
    # initialize the category of rows of the new ring
    rows := CategoryOfRows( new_ring_data[ 2 ] );
    
    # and compute the truncation
    return LocalizedDegreeZero( module_morphism, localized_variables, graded_ring, new_ring_data, rows );
    
end );
