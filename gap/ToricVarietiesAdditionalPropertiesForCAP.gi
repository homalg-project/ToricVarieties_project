################################################################################################
##
##  ToricVarietiesAdditionalPropertiesForCAP.gi        SheafCohomologyOnToricVarieties package
##
##  Copyright 2019                                     Martin Bies,       ULB Brussels
##
#! @Chapter Additional methods/properties for toric varieties
##
################################################################################################


###################################################
##
## Section Input check for cohomology computations
##
###################################################

#  Global variable that defines testing of input
SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_INTERNAL_LAZY := true;

InstallMethod( IsValidInputForCohomologyComputations,
               " for a toric variety",
               [ IsToricVariety ],

  function( variety )
    local result;

    # initialise value
    result := true;
    
    # check that the variety matches our general requirements
    if SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_INTERNAL_LAZY then

      if not ( ( IsSmooth( variety ) and IsComplete( variety ) ) or 
               ( IsSimplicial( FanOfVariety( variety ) ) and IsProjective( variety ) ) ) then

        result := false;

      fi;

    else

      if not ( IsSmooth( variety ) and IsComplete( variety ) ) then
      
        result := false;

      fi;

    fi;

    # and return result
    return result;

end );


####################################################################
##
## Section Stanley-Reisner and irrelevant ideal via FpGradedModules
##
####################################################################

InstallMethod( IrrelevantLeftIdealForCAP,
               " for toric varieties",
               [ IsFanRep ],
  function( variety )
    local cox_ring, maximal_cones, indeterminates, irrelevant_ideal, i, j, matrix, range, alpha;
    
    # extract the necessary information
    cox_ring := CoxRing( variety );
    maximal_cones := RaysInMaximalCones( FanOfVariety( variety ) );
    indeterminates := Indeterminates( cox_ring );
    
    # initialise the list of generators of the irrelvant ideal
    irrelevant_ideal := [ 1 .. Length( maximal_cones ) ];
    
    # and now compute these generators
    for i in [ 1 .. Length( maximal_cones ) ] do
        
        irrelevant_ideal[ i ] := 1;
        
        for j in [ 1 .. Length( maximal_cones[ i ] ) ] do
            
            irrelevant_ideal[ i ] := irrelevant_ideal[ i ] * indeterminates[ j ]^( 1 - maximal_cones[ i ][ j ] );
            
        od;
        
    od;
    
    return LeftIdealForCAP( irrelevant_ideal, cox_ring );

end );

InstallMethod( IrrelevantRightIdealForCAP,
               " for toric varieties",
               [ IsFanRep ],
  function( variety )
    local cox_ring, maximal_cones, indeterminates, irrelevant_ideal, i, j, matrix, range, alpha;
    
    # extract the necessary information
    cox_ring := CoxRing( variety );
    maximal_cones := RaysInMaximalCones( FanOfVariety( variety ) );
    indeterminates := Indeterminates( cox_ring );
    
    # initialise the list of generators of the irrelvant ideal
    irrelevant_ideal := [ 1 .. Length( maximal_cones ) ];
    
    # and now compute these generators
    for i in [ 1 .. Length( maximal_cones ) ] do

        irrelevant_ideal[ i ] := 1;

        for j in [ 1 .. Length( maximal_cones[ i ] ) ] do

            irrelevant_ideal[ i ] := irrelevant_ideal[ i ] * indeterminates[ j ]^( 1 - maximal_cones[ i ][ j ] );

        od;
        
    od;
    
    return RightIdealForCAP( irrelevant_ideal, cox_ring );

end );

InstallMethod( SRLeftIdealForCAP,
               " for toric varieties",
               [ IsToricVariety ],
  function( variety )
    local cox_ring, primitive_collections, SR_generators, I, k, buffer, SR_ideal, matrix, range, alpha;

    # identify the Cox ring
    cox_ring := CoxRing( variety );

    # compute primitive collections of the fan
    primitive_collections := PrimitiveCollections( FanOfVariety( variety ) );

    # form monomial from the primivite collections
    SR_generators := [];
    for I in primitive_collections do
        buffer := Indeterminates( CoxRing( variety ) )[ I[ 1 ] ];
        for k in [ 2 .. Length( I ) ] do
           buffer := buffer * Indeterminates( CoxRing( variety ) )[ I[ k ] ];
        od;
        Add( SR_generators, buffer );
    od;

    return LeftIdealForCAP( SR_generators, cox_ring );

end );

InstallMethod( SRRightIdealForCAP,
               " for toric varieties",
               [ IsToricVariety ],
  function( variety )
    local cox_ring, primitive_collections, SR_generators, I, k, buffer, SR_ideal, matrix, range, alpha;

    # identify the Cox ring
    cox_ring := CoxRing( variety );

    # compute primitive collections of the fan
    primitive_collections := PrimitiveCollections( FanOfVariety( variety ) );

    # form monomial from the primivite collections
    SR_generators := [];
    for I in primitive_collections do
        buffer := Indeterminates( CoxRing( variety ) )[ I[ 1 ] ];
        for k in [ 2 .. Length( I ) ] do
           buffer := buffer * Indeterminates( CoxRing( variety ) )[ I[ k ] ];
        od;
        Add( SR_generators, buffer );
    od;

    return RightIdealForCAP( SR_generators, cox_ring );

end );

# f.p. graded left S-modules category
InstallMethod( FpGradedLeftModules,
               " for toric varieties",
               [ IsToricVariety ],
  function( variety )

    return FpGradedLeftModules( CoxRing( variety ) );

end );

# f.p. graded right S-modules category
InstallMethod( FpGradedRightModules,
               " for toric varieties",
               [ IsToricVariety ],
  function( variety )

    return FpGradedRightModules( CoxRing( variety ) );

end );


##########################################################
##
## Section Monoms of given degree in the Cox ring
##
##########################################################

# This method uses the NormalizInterface to compute the exponents of the degree 'degree' monoms in the Coxring of a smooth and compact toric variety 'variety'
InstallMethod( Exponents,
               "for a toric variety and a list describing a degree",
               [ IsToricVariety, IsList ],
  function( variety, degree )
    local divisor, cox_ring, ring, points, rays, n, ListOfExponents, i, exponent;

    if not IsValidInputForCohomologyComputations( variety ) then

      Error( "The variety has to be smooth, complete (or simplicial, projective if you allow for lazy checks)" );
      return;

    elif not Length( degree ) = Rank( ClassGroup( variety ) ) then

        Error( "Length of degree does not match the rank of the class group" );
        return;

    fi;

    # construct divisor of given class
    divisor := DivisorOfGivenClass( variety, degree );
    cox_ring := CoxRing( variety );
    ring := ListOfVariablesOfCoxRing( variety );

    # compute the lattice points in question
    if not IsBounded( PolytopeOfDivisor( divisor ) ) then
        Error( "list is infinite, cannot compute basis because it is not finite\n" );
    fi;

    if IsEmpty( PolytopeOfDivisor( divisor ) ) then
      return [];
    fi;

    points := LatticePoints( PolytopeOfDivisor( divisor ) );
    rays := RayGenerators( FanOfVariety( variety ) );
    divisor := UnderlyingListOfRingElements( UnderlyingGroupElement( divisor ) );
    n := Length( rays );

    # and extract the exponents from these lattice points
    ListOfExponents := [ ];
    for i in points do

        exponent := List( [ 1 .. n ], j -> Sum( List( [ 1 .. Length( i ) ], m -> rays[ j ][ m ] * i[ m ] ) ) + divisor[ j ] );
        Add( ListOfExponents, exponent );

    od;

    # and return the list of exponents
    return ListOfExponents;

end );


# this method computes the Laurent monomials of the lattice points and thereby identifies the monoms of given degree in the Coxring
InstallMethod( MonomsOfCoxRingOfDegreeByNormaliz,
               "for a smooth and compact toric variety and a list describing a degree in its class group",
               [ IsToricVariety, IsList ],
  function( variety, degree )
    local cox_ring, variables, exponents, i,j, mons, mon;

    if not IsValidInputForCohomologyComputations( variety ) then

      Error( "The variety has to be smooth, complete (or simplicial, projective if you allow for lazy checks)" );
      return;

    elif not Length( degree ) = Rank( ClassGroup( variety ) ) then

        Error( "Length of degree does not match the rank of the class group" );
        return;

    fi;

    # collect the necessary information
    cox_ring := CoxRing( variety );
    variables := ListOfVariablesOfCoxRing( variety );
    exponents := Exponents( variety, degree );

    # initialise the list of monoms
    mons := [ ];

    # turn the lattice points into monoms of the cox_ring
    for i in exponents do

      mon := List( [ 1 .. Length( variables ) ], j -> JoinStringsWithSeparator( [ variables[ j ], String( i [ j ] ) ], "^" ) );
      mon := JoinStringsWithSeparator( mon, "*" );
      Add( mons, HomalgRingElement( mon, cox_ring ) );

    od;

    # now return the result
    return mons;

end );

# represent the degree X layer of a line bundle as lists of length 'length' and the corresponding monoms at position 'index'
InstallMethod( MonomsOfCoxRingOfDegreeByNormalizAsColumnMatrices,
               " for toric varieties",
               [ IsToricVariety, IsList, IsPosInt, IsPosInt ],
  function( variety, degree, index, length )
    local gens, res, i;

    if not IsValidInputForCohomologyComputations( variety ) then

      Error( "The variety has to be smooth, complete (or simplicial, projective if you allow for lazy checks)" );
      return;

    elif not Length( degree ) = Rank( ClassGroup( variety ) ) then

        Error( "Length of degree does not match the rank of the class group" );
        return;

    elif index > length then

        Error( "Index must be smaller than length" );
        return;

    fi;

    # compute Q-Basisof its global sections
    gens := MonomsOfCoxRingOfDegreeByNormaliz( variety, degree );

    # now represent these as matrices of length 'length' which contain nothing but at position 'index'
    # there we place the monoms that form a Q-basis of the corresponding degree X layer
    res := List( [ 1 .. Length( gens ) ] );
    for i in [ 1 .. Length( gens ) ] do
      res[ i ] := HomalgInitialMatrix( length, 1, CoxRing( variety ) );
      SetMatElm( res[ i ], index, 1, gens[ i ] );
    od;

    return res;

end );
