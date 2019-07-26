##########################################################################################
##
##  DegreeXLayerVectorSpaces.gi        SheafCohomologyOnToricVarieties package
##
##  Copyright 2019                     Martin Bies,       ULB Brussels
##
#! @Chapter DegreeXLayerVectorSpaces and morphisms
##
#########################################################################################



##########################################################
##
#! @Section Truncations of the Cox ring to a single degree
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


# Compute basis of the degree X layer of the Coxring of a toric variety (smooth and compact will be assumed)
# probably not needed
InstallMethod( DegreeXLayer,
               " for toric varieties, a list specifying a degree ",
               [ IsToricVariety, IsList ],
  function( variety, degree )

    # return the result
    return MonomsOfCoxRingOfDegreeByNormaliz( variety, degree );

end );


# represent the degree X layer of a line bundle as lists of length 'length' and the corresponding monoms at position 'index'
InstallMethod( DegreeXLayerVectorsAsColumnMatrices,
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

    # compute Q-Basis of its global sections
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



##############################################################################################
##
## Section GAP category of DegreeXLayerVectorSpaces(Morphisms)
##
##############################################################################################

# install DegreeXLayerVectorSpace
DeclareRepresentation( "IsDegreeXLayerVectorSpaceRep",
                       IsDegreeXLayerVectorSpace and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfDegreeXLayerVectorSpaces",
            NewFamily( "TheFamilyOfDegreeXLayerVectorSpaces" ) );

BindGlobal( "TheTypeOfDegreeXLayerVectorSpace",
            NewType( TheFamilyOfDegreeXLayerVectorSpaces,
                     IsDegreeXLayerVectorSpaceRep ) );

# install DegreeXLayerVectorSpaceMorphism
DeclareRepresentation( "IsDegreeXLayerVectorSpaceMorphismRep",
                       IsDegreeXLayerVectorSpaceMorphism and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfDegreeXLayerVectorSpaceMorphisms",
            NewFamily( "TheFamilyOfDegreeXLayerVectorSpaceMorphisms" ) );

BindGlobal( "TheTypeOfDegreeXLayerVectorSpaceMorphism",
            NewType( TheFamilyOfDegreeXLayerVectorSpaceMorphisms,
                     IsDegreeXLayerVectorSpaceMorphismRep ) );

# install DegreeXLayerVectorSpaceLeftPresentation
DeclareRepresentation( "IsDegreeXLayerVectorSpacePresentationRep",
                       IsDegreeXLayerVectorSpacePresentation and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfDegreeXLayerVectorSpacePresentations",
            NewFamily( "TheFamilyOfDegreeXLayerVectorSpacePresentations" ) );

BindGlobal( "TheTypeOfDegreeXLayerVectorSpacePresentation",
            NewType( TheFamilyOfDegreeXLayerVectorSpacePresentations,
                     IsDegreeXLayerVectorSpacePresentationRep ) );

# install DegreeXLayerVectorSpaceLeftPresentationMorphism
DeclareRepresentation( "IsDegreeXLayerVectorSpacePresentationMorphismRep",
                       IsDegreeXLayerVectorSpacePresentationMorphism and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfDegreeXLayerVectorSpacePresentationMorphisms",
            NewFamily( "TheFamilyOfDegreeXLayerVectorSpacePresentationMorphisms" ) );

BindGlobal( "TheTypeOfDegreeXLayerVectorSpacePresentationMorphism",
            NewType( TheFamilyOfDegreeXLayerVectorSpacePresentationMorphisms,
                     IsDegreeXLayerVectorSpacePresentationMorphismRep ) );



##############################################################################################
##
#! @Section Constructors for DegreeXLayerVectorSpaces(Morphisms)
##
##############################################################################################

# constructor for DegreeXLayerVectorSpaces
InstallMethod( DegreeXLayerVectorSpace,
               " a list of generators, a Cox ring, a vectorspace",
               [ IsList, IsHomalgGradedRing, IsVectorSpaceObject, IsInt ],
  function( generators, Coxring, vectorSpace, n )
    local degreeXLayerVectorSpace;

    # check if the input is valid
    if n < 0 then
      Error( "The embedding dimension is always non-negative" );
      return;
    fi;
    
    # now objectify to form a DegreeXLayerVectorSpace
    degreeXLayerVectorSpace := rec( );
    ObjectifyWithAttributes( degreeXLayerVectorSpace, TheTypeOfDegreeXLayerVectorSpace,
                             UnderlyingHomalgGradedRing, Coxring,
                             Generators, generators,
                             UnderlyingVectorSpaceObject, vectorSpace,
                             EmbeddingDimension, n
                             );
    return degreeXLayerVectorSpace;

end );

# constructor for DegreeXLayerVectorSpaceMorphisms
InstallMethod( DegreeXLayerVectorSpaceMorphism,
               " a DegreeXLayerVectorSpace, a vectorspace morphism, a DegreeXLayerVectorSpace",
               [ IsDegreeXLayerVectorSpace, IsVectorSpaceMorphism, IsDegreeXLayerVectorSpace ],
  function( source, morphism, range )
    local degreeXLayerVectorSpaceMorphism;
    
    # test the input first
    if not IsEqualForObjects( UnderlyingVectorSpaceObject( source ), Source( morphism ) ) then
    
      Error( Concatenation( "The source of morphism must be identical to the underlying vector space",
                            " of the DegreeXLayerVectorspace which serves as soruce" ) );
      return;

    elif not IsEqualForObjects( UnderlyingVectorSpaceObject( range ), Range( morphism ) ) then

      Error( Concatenation( "The range of morphism must be identical to the underlying vector space",
                            " of the DegreeXLayerVectorspace which serves as range" ) );
      return;

    elif not IsIdenticalObj( UnderlyingHomalgGradedRing( source ), UnderlyingHomalgGradedRing( range ) ) then

      Error( "Source and range vector spaces are embedded into different Cox rings" );
      return;

    fi;

    degreeXLayerVectorSpaceMorphism := rec( );
    ObjectifyWithAttributes( degreeXLayerVectorSpaceMorphism, TheTypeOfDegreeXLayerVectorSpaceMorphism,
                             Source, source,
                             UnderlyingVectorSpaceMorphism, morphism,
                             Range, range,
                             UnderlyingHomalgGradedRing, UnderlyingHomalgGradedRing( source )
                             );
    return degreeXLayerVectorSpaceMorphism;
    
end );

# constructor for DegreeXLayerVectorSpacePresentations
InstallMethod( DegreeXLayerVectorSpacePresentation,
               " a DegreeXLayerVectorSpaceMorphism ",
               [ IsDegreeXLayerVectorSpaceMorphism ],
  function( morphism )
    local degreeXLayerVectorSpacePresentation;
        
    degreeXLayerVectorSpacePresentation := rec( );
    ObjectifyWithAttributes( degreeXLayerVectorSpacePresentation, TheTypeOfDegreeXLayerVectorSpacePresentation,
                             UnderlyingDegreeXLayerVectorSpaceMorphism, morphism,
                             UnderlyingVectorSpaceObject, CokernelObject( UnderlyingVectorSpaceMorphism( morphism ) ),
                             UnderlyingVectorSpaceMorphism, UnderlyingVectorSpaceMorphism( morphism ),
                             UnderlyingHomalgGradedRing, UnderlyingHomalgGradedRing( morphism ),
                             UnderlyingVectorSpacePresentation, CAPPresentationCategoryObject( 
                                                                          UnderlyingVectorSpaceMorphism( morphism ) )
                             );
    return degreeXLayerVectorSpacePresentation;

end );

# constructor for DegreeXLayerVectorSpacePresentationMorphisms
InstallMethod( DegreeXLayerVectorSpacePresentationMorphism,
               " a DegreeXLayerVectorSpacePresentation, a vector space morphism, a DegreeXLayerVectorSpacePresentation",
               [ IsDegreeXLayerVectorSpacePresentation, IsVectorSpaceMorphism, IsDegreeXLayerVectorSpacePresentation ],
  function( source, morphism, range )
    local degreeXLayerVectorSpacePresentationMorphism;

    # test the input first
    if not IsEqualForObjects( UnderlyingVectorSpaceObject( Range( UnderlyingDegreeXLayerVectorSpaceMorphism( source ) ) ), 
                              Source( morphism ) ) then

      Error( "The source of morphism must be identical to the range of the source presentation" );
      return;

    elif not IsEqualForObjects( UnderlyingVectorSpaceObject( Range( UnderlyingDegreeXLayerVectorSpaceMorphism( range ) ) ), 
                                Range( morphism ) ) then

      Error( "The range of morphism must be identical to the range of the range presentation" );
      return;

    elif not IsIdenticalObj( UnderlyingHomalgGradedRing( Range( UnderlyingDegreeXLayerVectorSpaceMorphism( source ) ) ), 
                             UnderlyingHomalgGradedRing( Range( UnderlyingDegreeXLayerVectorSpaceMorphism( range ) ) ) 
                             ) then

      Error( "Source and range vector spaces are embedded into different Cox rings" );
      return;

    fi;

    degreeXLayerVectorSpacePresentationMorphism := rec( );
    ObjectifyWithAttributes( degreeXLayerVectorSpacePresentationMorphism, TheTypeOfDegreeXLayerVectorSpacePresentationMorphism,
                             Source, source,
                             UnderlyingVectorSpaceMorphism, morphism,
                             Range, range,
                             UnderlyingHomalgGradedRing, UnderlyingHomalgGradedRing( source ),
                             UnderlyingVectorSpacePresentationMorphism, 
                                  CAPPresentationCategoryMorphism( UnderlyingVectorSpacePresentation( source ),
                                                                   morphism,
                                                                   UnderlyingVectorSpacePresentation( range )
                                                                  )
                             );

    return degreeXLayerVectorSpacePresentationMorphism;

end );



#################################################
##
## Section: String methods for the new categories
##
#################################################

InstallMethod( String,
              [ IsDegreeXLayerVectorSpace ],
  function( degree_X_layer_vector_space )
    
     return Concatenation( "A vector space embedded into (",       
                           RingName( UnderlyingHomalgGradedRing( degree_X_layer_vector_space ) ),
                           ")^",
                           String( EmbeddingDimension( degree_X_layer_vector_space ) )
                          );

end );

InstallMethod( String,
              [ IsDegreeXLayerVectorSpaceMorphism ],
  function( degree_X_layer_vector_space_morphism )
    
     return Concatenation( "A morphism of two vector spaces embedded into (suitable powers of) ", 
                           RingName( UnderlyingHomalgGradedRing( degree_X_layer_vector_space_morphism ) )
                          );

end );

InstallMethod( String,
              [ IsDegreeXLayerVectorSpacePresentation ],
  function( degree_X_layer_vector_space_presentation )
    
     return Concatenation( "A vector space embedded into (a suitable power of) ", 
                           RingName( UnderlyingHomalgGradedRing( degree_X_layer_vector_space_presentation ) ),
                           " given as the cokernel of a vector space morphism"
                          );

end );

InstallMethod( String,
              [ IsDegreeXLayerVectorSpacePresentationMorphism ],
  function( degree_X_layer_vector_space_presentation_morphism )

     return Concatenation( "A vector space presentation morphism of vector spaces embedded into (a suitable power of) ", 
                     RingName( UnderlyingHomalgGradedRing( degree_X_layer_vector_space_presentation_morphism ) ),
                     " and given as cokernels"
                     );

end );

##################################################
##
## Section: Display methods for the new categories
##
##################################################

InstallMethod( Display,
              [ IsDegreeXLayerVectorSpace ],
  function( degree_X_layer_vector_space )
    
     Print( Concatenation( "A vector space over ",
                           RingName( CoefficientsRing( UnderlyingHomalgGradedRing( degree_X_layer_vector_space ) ) ),
                           " of dimension ",
                           String( Dimension( UnderlyingVectorSpaceObject( degree_X_layer_vector_space ) ) ),
                           " embedded into (",
                           RingName( UnderlyingHomalgGradedRing( degree_X_layer_vector_space ) ),
                           ")^",
                           String( EmbeddingDimension( degree_X_layer_vector_space ) ),
                           " via its set of generators: \n"
                          ) );
     Display( Generators( degree_X_layer_vector_space ) );

end );

InstallMethod( Display,
              [ IsDegreeXLayerVectorSpaceMorphism ],
  function( degree_X_layer_vector_space_morphism )
    
     Print( Concatenation( "A morphism of vector spaces embedded into (suitable powers of) ", 
                           Name( UnderlyingHomalgGradedRing( degree_X_layer_vector_space_morphism ) ),
                           ": \n"
                          ) );
     Print( "Source: \n" );
     Print( "-------- \n" );
     Display( Source( degree_X_layer_vector_space_morphism ) );
     Print( "\n" );
     Print( "Vector space morphism:" );
     Print( "----------------------- \n" );
     Display( UnderlyingVectorSpaceMorphism( degree_X_layer_vector_space_morphism ) );
     Print( "\n" );     
     Print( "Range: \n" );
     Print( "-------- \n" );
     Display( Range( degree_X_layer_vector_space_morphism ) );
     
end );

InstallMethod( Display,
              [ IsDegreeXLayerVectorSpacePresentation ],
  function( degree_X_layer_vector_space_presentation )
    
     Print( Concatenation( "A vector space embedded into (a suitable power of) ", 
                           RingName( UnderlyingHomalgGradedRing( degree_X_layer_vector_space_presentation ) ),
                           " which is presented by the following morphism: \n"
                          ) );
     Display( UnderlyingDegreeXLayerVectorSpaceMorphism( degree_X_layer_vector_space_presentation ) );
     Print( "The cokernel of this map is the following vector space: \n" );
     Display( UnderlyingVectorSpaceObject( degree_X_layer_vector_space_presentation ) );

end );

InstallMethod( Display,
              [ IsDegreeXLayerVectorSpacePresentationMorphism ],
  function( degree_X_layer_vector_space_presentation_morphism )
    
     Print( Concatenation( "A vector space presentation morphism of vector spaces embedded into (a suitable power of) ", 
                     RingName( UnderlyingHomalgGradedRing( degree_X_layer_vector_space_presentation_morphism ) ),                           
                     " \n"
                     ) );
     Print( "Source: \n" );
     Print( "-------- \n" );
     Display( Source( degree_X_layer_vector_space_presentation_morphism ) );
     Print( "Mapping: \n" );
     Print( "-------- \n" );
     Display( UnderlyingVectorSpaceMorphism( degree_X_layer_vector_space_presentation_morphism ) );
     Print( "Range: \n" );
     Print( "-------- \n" );
     Display( Range( degree_X_layer_vector_space_presentation_morphism ) );

end );

################################################
##
## Section: View methods for the new categories
##
################################################

InstallMethod( ViewObj,
              [ IsDegreeXLayerVectorSpace ],
               999, # FIXME FIXME FIXME!!!
  function( degree_X_layer_vector_space )

      Print( Concatenation( "<", String( degree_X_layer_vector_space ), ">" ) );

end );

InstallMethod( ViewObj,
              [ IsDegreeXLayerVectorSpaceMorphism ],
               999, # FIXME FIXME FIXME!!!
  function( degree_X_layer_vector_space_morphism )

      Print( Concatenation( "<", String( degree_X_layer_vector_space_morphism ), ">" ) );

end );

InstallMethod( ViewObj,
              [ IsDegreeXLayerVectorSpacePresentation ],
               999, # FIXME FIXME FIXME!!!
  function( degree_X_layer_vector_space_presentation )

      Print( Concatenation( "<", String( degree_X_layer_vector_space_presentation ), ">" ) );

end );

InstallMethod( ViewObj,
              [ IsDegreeXLayerVectorSpacePresentationMorphism ],
               999, # FIXME FIXME FIXME!!!
  function( degree_X_layer_vector_space_presentation_morphism )

      Print( Concatenation( "<", String( degree_X_layer_vector_space_presentation_morphism ), ">" ) );

end );

################################################################################################################
##
#! @Section Convenient methods to display all information about vector space presentations and morphisms thereof
##
################################################################################################################

InstallMethod( FullInformation,
               [ IsDegreeXLayerVectorSpacePresentation ],
  function( degree_X_layer_vector_space_presentation )

    FullInformation( UnderlyingVectorSpacePresentation( degree_X_layer_vector_space_presentation ) );
  
end );

InstallMethod( FullInformation,
               [ IsDegreeXLayerVectorSpacePresentationMorphism ],
  function( degree_X_layer_vector_space_presentation_morphism )
  
    FullInformation( UnderlyingVectorSpacePresentation( degree_X_layer_vector_space_presentation_morphism ) );

end );



#################################################
##
## Section ViewObj methods for the new categories
##
#################################################

InstallMethod( ViewObj,
              [ IsDegreeXLayerVectorSpace ],
  function( degree_X_layer_vector_space )
  
    Print( Concatenation( "<", String( degree_X_layer_vector_space ), ">" ) );
    
end );

InstallMethod( ViewObj,
              [ IsDegreeXLayerVectorSpaceMorphism ],
  function( degree_X_layer_vector_space_morphism )

    Print( Concatenation( "<", String( degree_X_layer_vector_space_morphism ), ">" ) );

end );

InstallMethod( ViewObj,
              [ IsDegreeXLayerVectorSpacePresentation ],
  function( degree_X_layer_vector_space_presentation )

    Print( Concatenation( "<", String( degree_X_layer_vector_space_presentation ), ">" ) );

end );

InstallMethod( ViewObj,
              [ IsDegreeXLayerVectorSpacePresentationMorphism ],
  function( degree_X_layer_vector_space_presentation_morphism )

    Print( Concatenation( "<", String( degree_X_layer_vector_space_presentation_morphism ), ">" ) );

end );

