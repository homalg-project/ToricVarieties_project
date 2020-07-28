################################################################################################
##
##  LocalizedDegree0Ring.gi            TruncationsOfFPGradedModules
##
##  Copyright 2020                     Martin Bies,       University of Oxford
##
##  Localize a graded ring and then truncate it to degree 0
##
################################################################################################


#######################################################################################
##
## Section Localized degree-0-layer of graded rings
##
#######################################################################################

InstallMethod( Localized_degree_zero_monomials,
               "for a graded ring and a list",
               [ IsHomalgGradedRing, IsList ],
  function( graded_ring, localized_variables )
    local degree_matrix, kernel_of_degree_matrix, kernel_of_degree_matrix_transposed, inequalities_list, inequalities_polytope,
         generating_set, rows, generating_set_hilbert, generating_set_linear, monomial_transformation, current_part, dim_pts,
         mons_hilbert, mon, mons_linear, i;
    
    # Support localization only for rings with indeterminates
    if Length( IndeterminatesOfPolynomialRing( graded_ring ) ) = 0 then
        Error( "localized degree-0 is not supported for rings with no indeterminates" );
    fi;

    # extract the degree_matrix
    degree_matrix := UnionOfRows( List( WeightsOfIndeterminates( graded_ring ), i -> MatrixOfMap( UnderlyingMorphism( i ) ) ) );
    
    # and compute its kernel
    kernel_of_degree_matrix := MatrixOfMap( KernelEmb( HomalgMap( degree_matrix, "free", DegreeGroup( graded_ring ) ) ) );
    kernel_of_degree_matrix_transposed := Involution( kernel_of_degree_matrix );
    
    # identify lattice points which correspond to generating degree-0 monomials in the localized ring
    inequalities_list := EntriesOfHomalgMatrixAsListList( kernel_of_degree_matrix_transposed );
    rows := [ 1 .. Length( inequalities_list ) ];
    rows := Filtered( rows, i -> not i in localized_variables );
    inequalities_list := List( rows, i -> inequalities_list[ i ] );
    inequalities_list := List( inequalities_list, i -> Concatenation( [ 0 ], i ) );
    inequalities_polytope := PolyhedronByInequalities( inequalities_list );
    generating_set := LatticePointsGenerators( inequalities_polytope );
    generating_set_hilbert := ShallowCopy( generating_set[ 2 ] );
    generating_set_linear := ShallowCopy( generating_set[ 3 ] );
    
    # turn these lattice points into monomial representations
    monomial_transformation := EntriesOfHomalgMatrixAsListList( kernel_of_degree_matrix );
    dim_pts := Length( monomial_transformation );
    mons_hilbert := [];
    for i in [ 1 .. Length( generating_set_hilbert ) ] do
        mon := Sum( List( [ 1 .. dim_pts ], j -> generating_set_hilbert[ i ][ j ] * monomial_transformation[ j ] ) );
        Append( mons_hilbert, [ mon ] );
    od;
    mons_linear := [];
    for i in [ 1 .. Length( generating_set_linear ) ] do
        mon := Sum( List( [ 1 .. dim_pts ], j -> generating_set_linear[ i ][ j ] * monomial_transformation[ j ] ) );
        Append( mons_linear, [ mon ] );
    od;
    
    # return the generating set
    return Concatenation( mons_hilbert, mons_linear, - mons_linear );
    
end );


InstallMethod( Localized_degree_zero_ring_and_generators,
               "a graded ring and a list",
               [ IsHomalgGradedRing, IsList ],
  function( graded_ring, localized_variables )
    local ring_generators, monomials, relations, indet_string, ring, indeterminates, i, j, left_side, right_side;
    
    # first identify the generating monomials
    monomials := Localized_degree_zero_monomials( graded_ring, localized_variables );
    
    # and establish the relations among these generators
    if monomials <> [ ] then
        relations := 4ti2Interface_groebner_matrix( monomials );
    else
        relations := [ ];
    fi;
    
    # we represent this localized degree-0 ring as a quotient ring of the following ring
    indet_string := List( [ 1 .. Length( monomials ) ], i -> Concatenation( "t", String( i ) ) );
    indet_string := JoinStringsWithSeparator( indet_string, "," );
    ring := UnderlyingNonGradedRing( CoefficientsRing( graded_ring ) ) * indet_string;
    
    # and the relations which we identify now
    if relations <> [ ] then
        indeterminates := Indeterminates( ring );
        for i in [ 1 .. Length( relations ) ] do
            
            left_side := indeterminates[ 1 ]^0;
            right_side := indeterminates[ 1 ]^0;
            
            for j in [ 1 .. Length( indeterminates ) ] do
                
                if relations[ i ][ j ] > 0 then
                    left_side := left_side*indeterminates[ j ]^relations[ i ][ j ];
                elif relations[ i ][ j ] < 0 then
                    right_side := right_side*indeterminates[ j ]^( - relations[ i ][ j ] );
                fi;
                
            od;
            
            relations[ i ] := left_side - right_side;
            
        od;
        ring := ring/relations;
    fi;
    
    # return the ring and its monomials
    return [ monomials, ring ];
    
end );


InstallMethod( Localized_degree_zero_ring,
               "a graded ring and a list",
               [ IsHomalgGradedRing, IsList ],
  function( graded_ring, localized_variables )
    
    return Localized_degree_zero_ring_and_generators( graded_ring, localized_variables )[ 2 ];
    
end );
