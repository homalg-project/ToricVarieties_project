################################################################################################
##
##  MonomsOfDegree.gi        TruncationsOfFPGradedModules package
##
##  Copyright 2020           Martin Bies,       University of Oxford
##
##  Monoms of Coxring of given degree
##
################################################################################################


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

    if not IsComplete( variety ) then

      Error( "This method is currently only supported for COMPLETE toric varieties" );
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

    if not IsComplete( variety ) then

      Error( "This method is currently only supported for COMPLETE toric varieties" );
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

    if not IsComplete( variety ) then

      Error( "This method is currently only supported for COMPLETE toric varieties" );
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
