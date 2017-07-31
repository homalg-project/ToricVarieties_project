##########################################################################################
##
##  DegreeXLayer.gi                    SheafCohomologyOnToricVarieties package
##
##  Copyright 2016                     Martin Bies,       ITP Heidelberg
##
#! @Chapter Truncations of Sfpgrmod to single degrees
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
    
    #A, rays, n, input, i, buffer, p, l, ListOfExponents, Deg1Elements, grading, C, exponent;

    if not IsSmooth( variety ) then

      Error( "Variety must be smooth for this method to work" );
      return;

    elif not IsComplete( variety ) then

      Error( "Variety must be complete for this method to work" );
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

    if not IsSmooth( variety ) then

      Error( "Variety must be smooth for this method to work" );
      return;

    elif not IsComplete( variety ) then

      Error( "Variety must be complete for this method to work" );
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

    if not IsSmooth( variety ) then

      Error( "Variety must be smooth for this method to work" );
      return;

    elif not IsComplete( variety ) then

      Error( "Variety must be complete for this method to work" );
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



######################################################################################################
##
## Section Truncations of PROJECTIVE graded modules (as defined in the CAP Proj-Category) to 
##         a single degree
##
######################################################################################################

# compute degree X layer of projective graded S-module
InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModule,
               " a toric variety, a projective graded module, a list specifying a degree ",
               [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsList, IsHomalgRing ],
  function( variety, projective_module, degree, rationals )
    local left, degree_list, degrees, extended_degree_list, i, generators, vectorSpace;

    # check if we have to deal with a left or right module morphism
    left := IsCAPCategoryOfProjectiveGradedLeftModulesObject( projective_module );

    # check that the input is valid to work with
    if not IsSmooth( variety ) then

      Error( "Variety must be smooth for this method to work" );
      return;

    elif not IsComplete( variety ) then

      return Error( "Variety must be complete for this method to work" );

    elif left and not IsIdenticalObj( CapCategory( projective_module ), 
                                      CAPCategoryOfProjectiveGradedLeftModules( CoxRing( variety ) ) ) then

      Error( Concatenation( "The module is not defined in the category of projective graded left-modules",
                                   " over the Coxring of the variety" ) );
      return;

    elif ( not left ) and not IsIdenticalObj( CapCategory( projective_module ), 
                                              CAPCategoryOfProjectiveGradedRightModules( CoxRing( variety ) ) ) then

      Error( Concatenation( "The module is not defined in the category of projective graded left-modules",
                            " over the Coxring of the variety" ) );
      return;

    elif not IsFieldForHomalg( CoefficientsRing( CoxRing( variety ) ) ) then

      Error( Concatenation( "DegreeXLayer operations are currently only supported if the coefficient ring",
                            " of the Cox ring is a field" ) );
      return;

    elif not Rank( ClassGroup( variety ) ) = Length( degree ) then

      Error( "The given list does not specify an element of the class group of the variety in question" );
      return;

    fi;

    # compute the degree layers of S that need to be computed
    degree_list := DegreeList( projective_module );

    # 'unzip' the degree_list
    extended_degree_list := [];
    for i in [ 1 .. Length( degree_list ) ] do
      extended_degree_list := Concatenation( extended_degree_list,
                                        ListWithIdenticalEntries( degree_list[ i ][ 2 ],
                                                                  degree - UnderlyingListOfRingElements( degree_list[ i ][ 1 ] )
                                                                 ) );
    od;

    # now extract the generators
    generators := [];
    for i in [ 1 .. Rank( projective_module ) ] do

      generators := Concatenation(
                          generators,
                          DegreeXLayerVectorsAsColumnMatrices( variety, extended_degree_list[ i ], i, Rank( projective_module ) )
                          );

    od;

    # and the underlying vector space
    vectorSpace := VectorSpaceObject( Length( generators ), rationals );

    # then return the DegreeXLayerVectorSpace
    return DegreeXLayerVectorSpace( generators, CoxRing( variety ), vectorSpace, Rank( projective_module ) );

end );

InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModule,
               " a toric variety, a projective graded module, a homalg_module_element specifying a degree ",
               [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsHomalgModuleElement, IsHomalgRing ],
  function( variety, projective_module, degree, rationals )

    return DegreeXLayerOfProjectiveGradedLeftOrRightModule(
                                               variety, projective_module, UnderlyingListOfRingElements( degree ), rationals );

end );

InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModule,
               " a toric variety, a projective graded module, a homalg_module_element specifying a degree ",
               [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsList ],
  function( variety, projective_module, degree )

    return DegreeXLayerOfProjectiveGradedLeftOrRightModule( 
                                               variety, projective_module, degree, CoefficientsRing( CoxRing( variety ) ) );

end );

InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModule,
               " a toric variety, a projective graded module, a homalg_module_element specifying a degree ",
               [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsHomalgModuleElement ],
  function( variety, projective_module, degree )

    return DegreeXLayerOfProjectiveGradedLeftOrRightModule( 
                       variety, projective_module, UnderlyingListOfRingElements( degree ), CoefficientsRing( CoxRing( variety ) ) );

end );

# compute degree X layer of projective graded S-module
InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListOfColumnMatrices,
               " a toric variety, a projective graded module, a list specifying a degree ",
               [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsList ],
  function( variety, projective_module, degree )
    local left, degree_list, degrees, extended_degree_list, i, generators;

    # check if we have to deal with a left or right module morphism
    left := IsCAPCategoryOfProjectiveGradedLeftModulesObject( projective_module );

    # check that the input is valid to work with
    if not IsSmooth( variety ) then

      Error( "Variety must be smooth for this method to work" );
      return;

    elif not IsComplete( variety ) then

      return Error( "Variety must be complete for this method to work" );

    elif left and not IsIdenticalObj( CapCategory( projective_module ), 
                                      CAPCategoryOfProjectiveGradedLeftModules( CoxRing( variety ) ) ) then

      Error( Concatenation( "The module is not defined in the category of projective graded left-modules",
                                   " over the Coxring of the variety" ) );
      return;

    elif ( not left ) and not IsIdenticalObj( CapCategory( projective_module ), 
                                              CAPCategoryOfProjectiveGradedRightModules( CoxRing( variety ) ) ) then

      Error( Concatenation( "The module is not defined in the category of projective graded left-modules",
                            " over the Coxring of the variety" ) );
      return;

    elif not IsFieldForHomalg( CoefficientsRing( CoxRing( variety ) ) ) then

      Error( Concatenation( "DegreeXLayer operations are currently only supported if the coefficient ring",
                            " of the Cox ring is a field" ) );
      return;

    elif not Rank( ClassGroup( variety ) ) = Length( degree ) then

      Error( "The given list does not specify an element of the class group of the variety in question" );
      return;

    fi;

    # compute the degree layers of S that need to be computed
    degree_list := DegreeList( projective_module );

    # 'unzip' the degree_list
    extended_degree_list := [];
    for i in [ 1 .. Length( degree_list ) ] do
      extended_degree_list := Concatenation( extended_degree_list,
                                        ListWithIdenticalEntries( degree_list[ i ][ 2 ],
                                                                  degree - UnderlyingListOfRingElements( degree_list[ i ][ 1 ] )
                                                                 ) );
    od;

    # now extract the generators
    generators := [];
    for i in [ 1 .. Rank( projective_module ) ] do

      generators := Concatenation( 
                          generators, 
                          DegreeXLayerVectorsAsColumnMatrices( variety, extended_degree_list[ i ], i, Rank( projective_module ) )
                          );

    od;

    # then return the DegreeXLayerVectorSpace
    return generators;

end );

InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListOfColumnMatrices,
               " a toric variety, a projective graded module, a homalg_module_element specifying a degree ",
               [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsHomalgModuleElement ],
  function( variety, projective_module, degree )

    return DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListOfColumnMatrices( 
                                               variety, projective_module, UnderlyingListOfRingElements( degree ) );

end );

# compute degree X layer of projective graded S-module
InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListsOfRecords,
               " a toric variety, a projective graded module, a list specifying a degree ",
               [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsList ],
  function( variety, projective_module, degree )
    local left, degree_list, extended_degree_list, i, j, record_entries_list, record_list, offset, buffer;

    # check if we have to deal with a left or right module morphism
    left := IsCAPCategoryOfProjectiveGradedLeftModulesObject( projective_module );

    # check that the input is valid to work with
    if not IsSmooth( variety ) then

      Error( "Variety must be smooth for this method to work" );
      return;

    elif not IsComplete( variety ) then

      return Error( "Variety must be complete for this method to work" );

    elif left and not IsIdenticalObj( CapCategory( projective_module ), 
                                      CAPCategoryOfProjectiveGradedLeftModules( CoxRing( variety ) ) ) then

      Error( Concatenation( "The module is not defined in the category of projective graded left-modules",
                                   " over the Coxring of the variety" ) );
      return;

    elif ( not left ) and not IsIdenticalObj( CapCategory( projective_module ), 
                                              CAPCategoryOfProjectiveGradedRightModules( CoxRing( variety ) ) ) then

      Error( Concatenation( "The module is not defined in the category of projective graded left-modules",
                            " over the Coxring of the variety" ) );
      return;

    elif not IsFieldForHomalg( CoefficientsRing( CoxRing( variety ) ) ) then

      Error( Concatenation( "DegreeXLayer operations are currently only supported if the coefficient ring",
                            " of the Cox ring is a field" ) );
      return;

    elif not Rank( ClassGroup( variety ) ) = Length( degree ) then

      Error( "The given list does not specify an element of the class group of the variety in question" );
      return;

    fi;

    # compute the degree layers of S that need to be computed
    degree_list := DegreeList( projective_module );

    # 'unzip' the degree_list
    extended_degree_list := [];
    for i in [ 1 .. Length( degree_list ) ] do
      extended_degree_list := Concatenation( extended_degree_list,
                                      ListWithIdenticalEntries( degree_list[ i ][ 2 ],
                                                                degree - UnderlyingListOfRingElements( degree_list[ i ][ 1 ] )
                                                               ) );
    od;

    # now extract the generators
    record_entries_list := List( [ 1 .. Length( extended_degree_list ) ],
                  i -> List( MonomsOfCoxRingOfDegreeByNormaliz( variety, extended_degree_list[ i ] ), j -> String( j ) ) );


    # and create the list of records
    offset := 0;
    record_list := [];
    for i in [ 1 .. Length( record_entries_list ) ] do
      buffer := rec();
      for j in [ 1 .. Length( record_entries_list[ i ] ) ] do
        buffer.( record_entries_list[ i ][ j ] ) := j + offset;
      od;
      Add( record_list, buffer );
      offset := offset + Length( record_entries_list[ i ] );
    od;

    # return the result
    return [ offset, record_list ];

end );

InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListsOfRecords,
               " a toric variety, a projective graded module, a homalg_module_element specifying a degree ",
               [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsHomalgModuleElement ],
  function( variety, projective_module, degree )

    return DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListsOfRecords(
                                               variety, projective_module, UnderlyingListOfRingElements( degree ) );

end );

# compute degree X layer of projective graded S-module
InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsUnionOfColumnMatrices,
               " a toric variety, a projective graded module, a list specifying a degree ",
               [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsList ],
  function( variety, projective_module, degree )
    local left, degree_list, degrees, extended_degree_list, i, generators, matrix, pos;

    # check if we have to deal with a left or right module morphism
    left := IsCAPCategoryOfProjectiveGradedLeftModulesObject( projective_module );

    # check that the input is valid to work with
    if not IsSmooth( variety ) then

      Error( "Variety must be smooth for this method to work" );
      return;

    elif not IsComplete( variety ) then

      Error( "Variety must be complete for this method to work" );
      return;

    elif left and not IsIdenticalObj( CapCategory( projective_module ), 
                                      CAPCategoryOfProjectiveGradedLeftModules( CoxRing( variety ) ) ) then

      Error( Concatenation( "The module is not defined in the category of projective graded left-modules",
                                   " over the Coxring of the variety" ) );
      return;

    elif ( not left ) and not IsIdenticalObj( CapCategory( projective_module ), 
                                              CAPCategoryOfProjectiveGradedRightModules( CoxRing( variety ) ) ) then

      Error( Concatenation( "The module is not defined in the category of projective graded left-modules",
                            " over the Coxring of the variety" ) );
      return;

    elif not IsFieldForHomalg( CoefficientsRing( CoxRing( variety ) ) ) then

      Error( Concatenation( "DegreeXLayer operations are currently only supported if the coefficient ring",
                            " of the Cox ring is a field" ) );
      return;

    elif not Rank( ClassGroup( variety ) ) = Length( degree ) then

      Error( "The given list does not specify an element of the class group of the variety in question" );
      return;

    fi;

    # compute the degree layers of S that need to be computed
    degree_list := DegreeList( projective_module );

    # 'unzip' the degree_list
    extended_degree_list := [];
    for i in [ 1 .. Length( degree_list ) ] do
      extended_degree_list := Concatenation( extended_degree_list,
                                        ListWithIdenticalEntries( degree_list[ i ][ 2 ],
                                                                  degree - UnderlyingListOfRingElements( degree_list[ i ][ 1 ] )
                                                                 ) );
    od;

    # now extract the generators
    generators := [];
    for i in [ 1 .. Rank( projective_module ) ] do

      generators := Concatenation(
                          generators,
                          DegreeXLayerVectorsAsColumnMatrices( variety, extended_degree_list[ i ], i, Rank( projective_module ) )
                          );

    od;

    # construct the matrix
    matrix := HomalgInitialMatrix( Rank( projective_module ), Length( generators ), CoxRing( variety ) );
    for i in [ 1 .. Length( generators ) ] do
      pos := NonZeroRows( generators[ i ] );
      SetMatElm( matrix, pos[ 1 ], i, EntriesOfHomalgMatrix( CertainRows( generators[ i ], pos ) )[ 1 ] );
    od;

    # then return the DegreeXLayerVectorSpace
    return matrix;

end );

InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsUnionOfColumnMatrices,
               " a toric variety, a projective graded module, a homalg_module_element specifying a degree ",
               [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsHomalgModuleElement ],
  function( variety, projective_module, degree )

    return DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsUnionOfColumnMatrices( 
                                               variety, projective_module, UnderlyingListOfRingElements( degree ) );

end );

# compute degree X layer of projective graded S-module
InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListList,
               " a toric variety, a projective graded module, a list specifying a degree ",
               [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsList ],
  function( variety, projective_module, degree )
    local left, degree_list, extended_degree_list, i, generators, mons;

    # check if we have to deal with a left or right module morphism
    left := IsCAPCategoryOfProjectiveGradedLeftModulesObject( projective_module );

    # check that the input is valid to work with
    if not IsSmooth( variety ) then

      Error( "Variety must be smooth for this method to work" );
      return;

    elif not IsComplete( variety ) then

      Error( "Variety must be complete for this method to work" );
      return;

    elif left and not IsIdenticalObj( CapCategory( projective_module ), 
                                      CAPCategoryOfProjectiveGradedLeftModules( CoxRing( variety ) ) ) then

      Error( Concatenation( "The module is not defined in the category of projective graded left-modules",
                                   " over the Coxring of the variety" ) );
      return;

    elif ( not left ) and not IsIdenticalObj( CapCategory( projective_module ), 
                                              CAPCategoryOfProjectiveGradedRightModules( CoxRing( variety ) ) ) then

      Error( Concatenation( "The module is not defined in the category of projective graded left-modules",
                            " over the Coxring of the variety" ) );
      return;

    elif not IsFieldForHomalg( CoefficientsRing( CoxRing( variety ) ) ) then

      Error( Concatenation( "DegreeXLayer operations are currently only supported if the coefficient ring",
                            " of the Cox ring is a field" ) );
      return;

    elif not Rank( ClassGroup( variety ) ) = Length( degree ) then

      Error( "The given list does not specify an element of the class group of the variety in question" );
      return;

    fi;

    # compute the degree layers of S that need to be computed
    degree_list := DegreeList( projective_module );

    # 'unzip' the degree_list
    extended_degree_list := [];
    for i in [ 1 .. Length( degree_list ) ] do
      extended_degree_list := Concatenation( extended_degree_list,
                                        ListWithIdenticalEntries( degree_list[ i ][ 2 ],
                                                                  degree - UnderlyingListOfRingElements( degree_list[ i ][ 1 ] )
                                                                 ) );
    od;

    # now extract the generators
    generators := [];
    for i in [ 1 .. Rank( projective_module ) ] do

      mons := MonomsOfCoxRingOfDegreeByNormaliz( variety, extended_degree_list[ i ] );
      mons := List( [ 1 .. Length( mons ) ], k -> [ i, mons[ k ] ] );
      Append( generators, mons );

    od;

    # return the result
    return generators;

end );

InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListList,
               " a toric variety, a projective graded module, a homalg_module_element specifying a degree ",
               [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsHomalgModuleElement ],
  function( variety, projective_module, degree )

    return DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListList( 
                                               variety, projective_module, UnderlyingListOfRingElements( degree ) );

end );

# compute degree X layer of projective graded S-module morphism
InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism,
               " a toric variety, a projective graded module morphism, a list specifying a degree ",
               [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism, IsList, IsHomalgRing, IsBool ],
  function( variety, projective_module_morphism, degree, rationals, display_messages )
    local left, gens_source, gens_range, dim_range, matrix, mapping_matrix, counter, i, comparer, j, non_zero_rows,
         poly, poly_split, poly_split2, k, pos, coeff, l, name_of_indeterminates, vector_space_morphism, split_pos;

    # check if we have to deal with a left or right module morphism
    left := IsCAPCategoryOfProjectiveGradedLeftModulesMorphism( projective_module_morphism );

    # check that the input is valid to work with
    if not IsSmooth( variety ) then

      Error( "Variety must be smooth for this method to work" );
      return;

    elif not IsComplete( variety ) then

      Error( "Variety must be complete for this method to work" );
      return;

    elif left and not IsIdenticalObj( CapCategory( projective_module_morphism ), 
                                      CAPCategoryOfProjectiveGradedLeftModules( CoxRing( variety ) ) ) then

      Error( Concatenation( "The module is not defined in the category of projective graded left-modules",
                            " over the Coxring of the variety" ) );
      return;

    elif ( not left ) and not IsIdenticalObj( CapCategory( projective_module_morphism ), 
                                              CAPCategoryOfProjectiveGradedRightModules( CoxRing( variety ) ) ) then

      Error( Concatenation( "The module is not defined in the category of projective graded left-modules",
                            " over the Coxring of the variety" ) );
      return;

    elif not IsFieldForHomalg( CoefficientsRing( CoxRing( variety ) ) ) then

      Error( Concatenation( "DegreeXLayer operations are currently only supported if the coefficient ring",
                            " of the Cox ring is a field" ) );
      return;

    elif not Rank( ClassGroup( variety ) ) = Length( degree ) then

      Error( "The given list does not specify an element of the class group of the variety in question" );
      return;

    fi;

    # extract source and range generators
    gens_source := DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListOfColumnMatrices(
                                                                           variety,
                                                                           Source( projective_module_morphism ), 
                                                                           degree
                                                                         );
    gens_range := DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListsOfRecords(
                                                                          variety,
                                                                          Range( projective_module_morphism ),
                                                                          degree
                                                                         );

    # compute the dimension of the range
    dim_range := gens_range[ 1 ];
    gens_range := gens_range[ 2 ];

    # check for degenerate cases
    if Length( gens_source ) = 0 then

      if display_messages then
        Print( "Starting the matrix computation now... \n \n" );
      fi;

      matrix := HomalgZeroMatrix( dim_range,
                                  0,
                                  rationals
                                 );

      if display_messages then
        Print( Concatenation( "NrRows: ", String( NrRows( matrix ) ), "\n" ) );
        Print( Concatenation( "NrColumns: ", String( NrColumns( matrix ) ), "\n" ) );
        Print( "matrix created... \n" );
      fi;

    elif dim_range = 0 then

      if display_messages then
        Print( "Starting the matrix computation now... \n \n" );
      fi;

      matrix := HomalgZeroMatrix( 0,
                                  Length( gens_source ),
                                  rationals
                                 );

      if display_messages then
        Print( Concatenation( "NrRows: ", String( NrRows( matrix ) ), "\n" ) );
        Print( Concatenation( "NrColumns: ", String( NrColumns( matrix ) ), "\n" ) );
        Print( "matrix created... \n" );
      fi;

    else;

      # both vector spaces are of non-zero dimension
      # -> so here is the non-trivial case

      # This is the most crucial piece of the code in DegreeXLayer, and thus a few explaining words are appropriate:

      # Note:
      # gens_source and gens_range are lists. Each entry is a generator of the source/ range vector spaces.
      # These generators themselves are lists, whose length matches the rank of source/range vector space respectively.
      # The entries are elements of the underlying graded homalg_ring.
      #
      # Consequently, turning such a generator into a matrix means that we can for left presentations multiply the mapping
      # matrix from the left with such a generator. For right presentations, we can multiply a generator_matrix from the right
      # onto the mapping matrix.
      #
      # We turn the generators of the source into such matrices. We then compute products of the following type:
      # AsMatrix( source_generator[ i ] ) * mapping_matrix         (for left modules)
      # mapping_matrix * AsMatrix( source_generator[ i ] )         (for right modules)
      #
      # The results of these multiplications are elements of the vector space spanned by gens_range. So we should try to
      # express the result in terms of these generators. Therefore we form a matrix M from the listlist gens_range such that:
      #
      # for left modules, each generator in gens_range is a row of that matrix
      # for right modules, each generator in gens_range is a column of that matrix
      #
      # Expressing the elements in terms of the generators of the range is then the task to find a matrix B such that
      #
      # for left modules:   AsMatrix( source_generator[ i ] ) * mapping_matrix = B * M
      #                     RightDivide( AsMatrix( source_generator[ i ] ) * mapping_matrix, M ) = B
      # for right modules:  mapping_matrix * AsMatrix( source_generator[ i ] ) = M * B
      #                     LeftDivide( M, mapping_matrix * AsMatrix( source_generator[ i ] ) ) = B
      #
      # for each i, B will be a row (for left modules)/ a column (for right modules)
      # the union of these rows/columns then gives a morphism of left/right vector spaces
      #
      # MatrixCategory( ) in LinearAlgebraForCAP solemnly supports left vector spaces. Therefore we need to turn morphisms
      # of right vector_spaces into morphisms of left_vector spaces at the end of the computation.

      # extract the underlying matrix of the morphism
      mapping_matrix := UnderlyingHomalgMatrix( projective_module_morphism );

      # if a left module was provided we have to transpose the mapping matrix
      if left then

        # remember that the mapping_matrix should be used as transposed matrix for left modules
        mapping_matrix := Involution( mapping_matrix );

      fi;

      # figure out what names are used for the variables in the Cox ring
      # we will later look for appearences of this char in a string (that is way faster than e.g. left divide and so on)
      # this works only if the underlying ring is a polynomial ring and the variable names are of the form 'x1 x2 ...' or 'w_1, w_2' but for
      # example 'hans1 hans2 hans3...' will lead to problems
      name_of_indeterminates := String( IndeterminatesOfPolynomialRing( HomalgRing( mapping_matrix ) )[ 1 ] )[ 1 ];

      # initialise the matrix as a sparse matrix
      matrix := HomalgInitialMatrix( dim_range,
                                     Length( gens_source ),
                                     rationals
                                    );

      # print status of the computation
      if display_messages then
        Print( "Starting the matrix computation now... \n \n" );
        Print( Concatenation( "NrRows: ", String( NrRows( matrix ) ), "\n" ) );
        Print( Concatenation( "NrColumns: ", String( NrColumns( matrix ) ), "\n" ) );
        Print( Concatenation( "Have to go until i = ", String( Length( gens_source ) ), "\n" ) );
      fi;

      counter := 1;

      for i in [ 1 .. Length( gens_source ) ] do

        # information about the status
        if not ( Int( i / Length( gens_source ) * 100 ) < counter ) then

          # express current status as multiply of 10%, so we compute this number first
          counter := Int( i / Length( gens_source ) * 10 ) * 10;

          # then inform the user
          if display_messages then
            Print( Concatenation( String( counter ), "% done...\n" ) );
          fi;

          # and finally increase counter
          counter := counter + 10;

        fi;

        # compute image of the i-th source generator
        comparer := mapping_matrix * gens_source[ i ];

        # extract the non_zero rows of this image-column
        non_zero_rows := NonZeroRows( comparer );
        comparer := EntriesOfHomalgMatrix( comparer );

        # now work over each and every nontrivial entry of comparer
        for j in [ 1 .. Length( non_zero_rows ) ] do

          # consider the non_zero_rows[j]-th image as a string
          poly := String( comparer[ non_zero_rows[ j ] ] );

          # find positions of plus and minus
          split_pos := [ 1 ];
          Append( split_pos, Positions( poly, '-' ) );
          Append( split_pos, Positions( poly, '+' ) );
          split_pos := DuplicateFreeList( split_pos );
          Sort( split_pos );

          # initialise the split string
          poly_split := List( [ 1 .. Length( split_pos ) ] );

          # and extract the substrings
          for k in [ 1 .. Length( poly_split ) ] do
             if k <> Length( poly_split ) then
               poly_split[ k ] := List( [ 1 .. split_pos[ k+1 ] - split_pos[ k ] ], l -> poly[ split_pos[ k ] - 1 + l ] );
             else
               poly_split[ k ] := List( [ 1 .. Length( poly ) - split_pos[ k ] + 1 ], l -> poly[ split_pos[ k ] - 1 + l ] );
             fi;
          od;

          # -> we have now split the string at each occurance of '+' and '-'
          # note that SplitString would throw away the signs, but we need to keep track of them (mixed entries in a matrix give 
          # different cokernel than say only positive ones)
          # -> therefore we cannot use SplitString
          # -> the above code is really necessary!

          # now initialise poly_split2
          poly_split2 := List( [ 1 .. Length( poly_split ) ] );

          # now extract the coefficients of the individual monoms
          for k in [ 1 .. Length( poly_split ) ] do
            if poly_split[ k ][ 1 ] = name_of_indeterminates then

              poly_split2[ k ] := [ One( rationals ), poly_split[ k ] ];

            elif poly_split[ k ][ 1 ] <> name_of_indeterminates then

              # find first occurance of 'x' (or more generally the variables names used)
              # -> whatever is in front of it will be our coefficient
              pos := Position( poly_split[ k ], name_of_indeterminates );

              if pos <> fail then
                # at least one 'x' does appear in this string
                coeff := List( [ 1 .. pos-1 ], l -> poly_split[ k ][ l ] );

                # massage the coefficient
                if coeff[ Length( coeff ) ] = '*' then
                  Remove( coeff );
                fi;

                # check for degenerate case
                if coeff = "-" then
                  coeff := "-1";
                elif coeff = "+" then
                  coeff := "+1";
                fi;

                # remove the coefficient part from poly_split
                for l in [ 1 .. pos-1 ] do
                  Remove( poly_split[ k ], 1 );
                od;

                # finally save the coefficient and the monom
                poly_split2[ k ] := [ EvalString( coeff ) / rationals, poly_split[ k ] ];

              else
                # no 'x' (or more generally, variable name) appears, so the entire string is the coefficient and the monom is just 1
                poly_split2[ k ] := [ Int( poly_split[ k ] ) / rationals, "1" ];

              fi;

            fi;

          od;

          # next figure out which range monoms did appear from gens_range[ non_zero_rows ]
          for k in [ 1 .. Length( poly_split2 ) ] do

            pos := gens_range[ non_zero_rows[ j ] ].( poly_split2[ k ][ 2 ] );
            SetMatElm( matrix, pos, i, poly_split2[ k ][ 1 ] );

          od;

        od;

      od;

      # and return the result
      if display_messages then
        Print( "matrix created... \n" );
      fi;

    fi;

    # and create the vector space morphism
    # note that CAP only supports left vector spaces, but the above matrix is the mapping matrix of right vector spaces
    # -> so we need 'Involution'
    vector_space_morphism := VectorSpaceMorphism( VectorSpaceObject( NrColumns( matrix ), rationals ),
                                                  Involution( matrix ),
                                                  VectorSpaceObject( NrRows( matrix ), rationals )
                                                 );

    # finally return the result
    return DegreeXLayerVectorSpaceMorphism( DegreeXLayerOfProjectiveGradedLeftOrRightModule(
                                                              variety, Source( projective_module_morphism ), degree, rationals ),
                                            vector_space_morphism,
                                            DegreeXLayerOfProjectiveGradedLeftOrRightModule(
                                                               variety, Range( projective_module_morphism ), degree, rationals )
                                           );

end );

# compute degree X layer of projective graded S-module
InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism,
               " a toric variety, a projective graded module morphism, a homalg_module_element specifying a degree ",
               [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism, IsHomalgModuleElement, IsHomalgRing, IsBool ],
  function( variety, projective_module_morphism, degree, rationals, display_messages )

    return DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                   variety, projective_module_morphism, UnderlyingListOfRingElements( degree ), rationals, display_messages );

end );

InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism,
               " a toric variety, a projective graded module morphism, a homalg_module_element specifying a degree ",
               [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism, IsList, IsBool ],
  function( variety, projective_module_morphism, degree, display_messages )

    return DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                       variety, projective_module_morphism, degree, CoefficientsRing( CoxRing( variety ) ), display_messages );

end );

InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism,
               " a toric variety, a projective graded module morphism, a homalg_module_element specifying a degree ",
               [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism, IsHomalgModuleElement, IsBool ],
  function( variety, projective_module_morphism, degree, display_messages )

    return DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
               variety, projective_module_morphism, UnderlyingListOfRingElements( degree ), CoefficientsRing( CoxRing( variety ) ),
               display_messages 
           );

end );

InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism,
               " a toric variety, a projective graded module morphism, a homalg_module_element specifying a degree ",
               [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism, IsList ],
  function( variety, projective_module_morphism, degree )

    return DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                       variety, projective_module_morphism, degree, CoefficientsRing( CoxRing( variety ) ), false );

end );

InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism,
               " a toric variety, a projective graded module morphism, a homalg_module_element specifying a degree ",
               [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism, IsHomalgModuleElement ],
  function( variety, projective_module_morphism, degree )

    return DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
               variety, projective_module_morphism, UnderlyingListOfRingElements( degree ), CoefficientsRing( CoxRing( variety ) ), false );

end );

# a minimal version to compute degree X layer of projective graded S-module morphism
InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphismMinimal,
               " a toric variety, a projective graded module morphism, a list specifying a degree ",
               [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism, IsList, IsList, IsHomalgRing, IsBool ],
  function( variety, projective_module_morphism, gens_source, gens_range_original, rationals, display_messages )
    local left, dim_range, gens_range, matrix, mapping_matrix, name_of_indeterminates, counter, i, 
         comparer, j, non_zero_rows, poly, poly_split, poly_split2, k, pos, coeff, l, split_pos;

    # check if we have to deal with a left or right module morphism
    left := IsCAPCategoryOfProjectiveGradedLeftModulesMorphism( projective_module_morphism );

    # compute the dimension of the range
    dim_range := gens_range_original[ 1 ];
    gens_range := gens_range_original[ 2 ];

    # extract the underlying matrix of the morphism
    mapping_matrix := UnderlyingHomalgMatrix( projective_module_morphism );

    # if a left module was provided we have to transpose the mapping matrix
    if left then

      # remember that the mapping_matrix should be used as transposed matrix for left modules
      mapping_matrix := Involution( mapping_matrix );

    fi;

    # figure out what names are used for the variables in the Cox ring
    # we will later look for appearences of this char in a string (that is way faster than e.g. left divide and so on)
    # this works only if the underlying ring is a polynomial ring and the variable names are of the form 'x1 x2 ...' or 'w_1, w_2' but for
    # example 'hans1 hans2 hans3...' will lead to problems
    name_of_indeterminates := String( IndeterminatesOfPolynomialRing( HomalgRing( mapping_matrix ) )[ 1 ] )[ 1 ];

    # initialise the matrix as a sparse matrix
    matrix := HomalgInitialMatrix( Length( gens_source ), dim_range, rationals );

    # print status of the computation
    if display_messages then
      Print( "Starting the matrix computation now... \n \n" );
      Print( Concatenation( "NrRows: ", String( NrRows( matrix ) ), "\n" ) );
      Print( Concatenation( "NrColumns: ", String( NrColumns( matrix ) ), "\n" ) );
      Print( Concatenation( "Have to go until i = ", String( NrColumns( matrix ) ), "\n" ) );
    fi;

    counter := 1;

    for i in [ 1 .. Length( gens_source ) ] do

      # information about the status
      if not ( Int( i / Length( gens_source ) * 100 ) < counter ) then

        # express current status as multiply of 10%, so we compute this number first
        counter := Int( i / Length( gens_source ) * 10 ) * 10;

        # then inform the user
        if display_messages then
          Print( Concatenation( String( counter ), "% done...\n" ) );
        fi;

        # and finally increase counter
        counter := counter + 10;

      fi;

      # compute image of the i-th source generator
      comparer := mapping_matrix * gens_source[ i ];

      # extract the non_zero rows of this image-column
      non_zero_rows := NonZeroRows( comparer );
      comparer := EntriesOfHomalgMatrix( comparer );

      # now work over each and every nontrivial entry of comparer
      for j in [ 1 .. Length( non_zero_rows ) ] do

        # consider the non_zero_rows[j]-th image as a string
        poly := String( comparer[ non_zero_rows[ j ] ] );

        # find positions of plus and minus
        split_pos := [ 1 ];
        Append( split_pos, Positions( poly, '-' ) );
        Append( split_pos, Positions( poly, '+' ) );
        split_pos := DuplicateFreeList( split_pos );
        Sort( split_pos );

        # initialise the split string
        poly_split := List( [ 1 .. Length( split_pos ) ] );

        # and extract the substrings
        for k in [ 1 .. Length( poly_split ) ] do
           if k <> Length( poly_split ) then
             poly_split[ k ] := List( [ 1 .. split_pos[ k+1 ] - split_pos[ k ] ], l -> poly[ split_pos[ k ] - 1 + l ] );
           else
             poly_split[ k ] := List( [ 1 .. Length( poly ) - split_pos[ k ] + 1 ], l -> poly[ split_pos[ k ] - 1 + l ] );
           fi;
        od;

        # now initialise poly_split2
        poly_split2 := List( [ 1 .. Length( poly_split ) ] );

        # now extract the coefficients of the individual monoms
        for k in [ 1 .. Length( poly_split ) ] do
          if poly_split[ k ][ 1 ] = name_of_indeterminates then

            poly_split2[ k ] := [ One( rationals ), poly_split[ k ] ];

          elif poly_split[ k ][ 1 ] <> name_of_indeterminates then

            # find first occurance of 'x' (or more generally the variables names used)
            # -> whatever is in front of it will be our coefficient
            pos := Position( poly_split[ k ], name_of_indeterminates );

            if pos <> fail then
              # at least one 'x' does appear in this string
              coeff := List( [ 1 .. pos-1 ], l -> poly_split[ k ][ l ] );

              # massage the coefficient
              if coeff[ Length( coeff ) ] = '*' then
                Remove( coeff );
              fi;

              # check for degenerate case
              if coeff = "-" then
                coeff := "-1";
              elif coeff = "+" then
                coeff := "+1";
              fi;

              # remove the coefficient part from poly_split
              for l in [ 1 .. pos-1 ] do
                Remove( poly_split[ k ], 1 );
              od;

              # finally save the coefficient and the monom
              poly_split2[ k ] := [ EvalString( coeff ) / rationals, poly_split[ k ] ];

            else
              # no 'x' (or more generally, variable name) appears, so the entire string is the coefficient
              # and the monom is just 1
              poly_split2[ k ] := [ Int( poly_split[ k ] ) / rationals, "1" ];

            fi;

          fi;

        od;

        # next figure out which range monoms did appear from gens_range[ non_zero_rows ]
        for k in [ 1 .. Length( poly_split2 ) ] do

          pos := gens_range[ non_zero_rows[ j ] ].( poly_split2[ k ][ 2 ] );
          SetMatElm( matrix, i, pos, poly_split2[ k ][ 1 ] );

        od;

      od;

    od;

    # and return the result
    if display_messages then
      Print( "matrix created... \n \n" );
    fi;

    # finally return the result
    return matrix;

end );


######################################################################################################
##
## Section Truncation a PROJECTIVE graded module morphism and write the corresponding matrix to a file
##         formated for use in gap
##
######################################################################################################

# compute degree X layer of projective graded S-module morphism and write the corresponding matrix to a file
InstallMethod( ComputeDegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphismMinimally,
               " a list of information and a string",
               [ IsList, IsBool ],
  function( infos, display_messages )

  return ComputeDegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphismMinimally( 
  infos, display_messages, 1, Length( infos[ 1 ] ) );

end );


# compute degree X layer of projective graded S-module morphism and write the corresponding matrix to a file
InstallMethod( ComputeDegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphismMinimally,
               " a list of information and a string",
               [ IsList, IsBool, IsInt, IsInt ],
  function( infos, display_messages, starting_pos, ending_pos )
    local images, gens_range, name_of_indeterminates, dim_range, path, file, stream, counter, i,
         comparer, non_zero_rows, j, poly, poly_split, poly_split2, k, pos, coeff, l, split_pos, positions;

    # extract the data
    images := infos[ 1 ];
    gens_range := infos[ 2 ];
    name_of_indeterminates := infos[ 3 ];

    # compute the dimension of the range
    dim_range := gens_range[ 1 ];
    gens_range := gens_range[ 2 ];

    # initialise positions
    positions := [];

    # print status of the computation
    if display_messages then
      Print( "starting the matrix computation... \n \n" );
      Print( Concatenation( "NrRows: ", String( Length( images ) ), "\n" ) );
      Print( Concatenation( "NrColumns: ", String( dim_range ), "\n" ) );
      Print( Concatenation( "Have to go until i = ", String( Length( images ) ), "\n" ) );
    fi;

    # set the counter
    counter := 1;

    # check that the ranges are meaningful
    if starting_pos < 0 then
      Error( "the starting position must be non-negative" );
    elif starting_pos > ending_pos then
      Error( "the starting position must not be bigger than the ending position" );
    elif ending_pos > Length( images ) then
      Error( "the ending position must not be bigger than the number of images to translate" );
    fi;

    # now perform the computation
    for i in [ starting_pos .. ending_pos ] do

      # information about the status
      if not ( Int( i / Length( images ) * 100 ) < counter ) then

        # express current status as multiply of 10%, so we compute this number first
        counter := Int( i / Length( images ) * 10 ) * 10;

        # then inform the user
        if display_messages then
          Print( Concatenation( String( counter ), "% done...\n" ) );
        fi;

        # and finally increase counter
        counter := counter + 10;

      fi;

      # read image of the i-th source generator and the non_zero rows of this image_column
      comparer := images[ i ][ 2 ];
      non_zero_rows := images[ i ][ 1 ];

      # now work over each and every nontrivial entry of comparer
      for j in [ 1 .. Length( non_zero_rows ) ] do

        # consider the non_zero_rows[j]-th image as a string
        poly := String( comparer[ non_zero_rows[ j ] ] );

        # find positions of plus and minus
        split_pos := [ 1 ];
        Append( split_pos, Positions( poly, '-' ) );
        Append( split_pos, Positions( poly, '+' ) );
        split_pos := DuplicateFreeList( split_pos );
        Sort( split_pos );

        # initialise the split string
        poly_split := List( [ 1 .. Length( split_pos ) ] );

        # and extract the substrings
        for k in [ 1 .. Length( poly_split ) ] do
          if k <> Length( poly_split ) then
            poly_split[ k ] := List( [ 1 .. split_pos[ k+1 ] - split_pos[ k ] ], l -> poly[ split_pos[ k ] - 1 + l ] );
          else
            poly_split[ k ] := List( [ 1 .. Length( poly ) - split_pos[ k ] + 1 ], l -> poly[ split_pos[ k ] - 1 + l ] );
          fi;
        od;

        # now initialise poly_split2
        poly_split2 := List( [ 1 .. Length( poly_split ) ] );

        # now extract the coefficients of the individual monoms
        for k in [ 1 .. Length( poly_split ) ] do
          if poly_split[ k ][ 1 ] = name_of_indeterminates then

            poly_split2[ k ] := [ "1", poly_split[ k ] ];

          elif poly_split[ k ][ 1 ] <> name_of_indeterminates then

            # find first occurance of 'x' (or more generally the variables names used) 
            # -> whatever is in front of it will be our coefficient
            pos := Position( poly_split[ k ], name_of_indeterminates );

            if pos <> fail then
              # at least one 'x' does appear in this string
              coeff := List( [ 1 .. pos-1 ], l -> poly_split[ k ][ l ] );

              # massage the coefficient
              if coeff[ Length( coeff ) ] = '*' then
                Remove( coeff );
              fi;

              # check for degenerate case
              if coeff = "-" then
                coeff := "-1";
              elif coeff = "+" then
                coeff := "+1";
              fi;

              # remove the coefficient part from poly_split
              for l in [ 1 .. pos-1 ] do
                Remove( poly_split[ k ], 1 );
              od;

              # finally save the coefficient and the monom
              poly_split2[ k ] := [ coeff, poly_split[ k ] ];

            else
              # no 'x' (or more generally, variable name) appears, so the entire string is the coefficient 
              # and the monom is just 1
              poly_split2[ k ] := [ String( poly_split[ k ] ), "1" ];

            fi;

          fi;

        od;

        # next figure out which range monoms did appear from gens_range[ non_zero_rows ]
        for k in [ 1 .. Length( poly_split2 ) ] do

          # identify the position
          pos := gens_range[ non_zero_rows[ j ] ].( poly_split2[ k ][ 2 ] );

          # remove '+' from poly_split2
          RemoveCharacters( poly_split2[ k ][ 1 ], "+" );

          # and append the evaluation to integer
          Append( positions, [ [ i, pos, Int( poly_split2[ k ][ 1 ] ) ] ] );

        od;

      od;

    od;

    # signal end of computation
    if display_messages then
      Print( "matrix entries have been identified... \n \n" );
    fi;

    # return the result
    return positions;

end );



######################################################################################################
##
## Section Truncations functor of PROJECTIVE graded modules (as defined in the CAP Proj-Category) to 
##         a single degree
##
######################################################################################################

# this function computes the DegreeXLayer functor to single degrees for both left and right presentations
InstallGlobalFunction( DegreeXLayerOfProjectiveGradedModulesFunctor,
  function( variety, degree, left )
    local source_category, range_category, functor;

    # check if the input is valid to work with
    if not IsSmooth( variety ) then

      Error( "The variety must be smooth for this method to work" );
      return;

    elif not IsComplete( variety ) then

      Error( "The variety must be complete for this method to work" );
      return;

    elif not IsFieldForHomalg( CoefficientsRing( CoxRing( variety ) ) ) then

      Error( Concatenation( "DegreeXLayer operations are currently only supported if the coefficient ring",
                            " of the Cox ring is a field" ) );
      return;

    elif not Rank( ClassGroup( variety ) ) = Length( degree ) then

      Error( "The given list does not specify an element of the class group of the variety in question" );
      return;

    fi;

    # determine the category under consideration
    if left = true then    
      source_category := CAPCategoryOfProjectiveGradedLeftModules( CoxRing( variety ) );
    else
      source_category := CAPCategoryOfProjectiveGradedRightModules( CoxRing( variety ) );
    fi;

    # determine the target category
    range_category := MatrixCategory( CoefficientsRing( CoxRing( variety ) ) );

    # then initialise the functor
    functor := CapFunctor(
                      Concatenation( "DegreeXLayer functor for ", Name( source_category ), 
                                     " to the degree ", String( degree ) ), 
                      source_category,
                      range_category
                      );

    # now define the functor operation on the objects
    AddObjectFunction( functor,
      function( object )

          return UnderlyingVectorSpaceObject( DegreeXLayerOfProjectiveGradedLeftOrRightModule( variety, object, degree ) );

      end );

    # and its operation on morphisms
    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )

          return UnderlyingVectorSpaceMorphism( 
                                    DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism( variety, morphism, degree ) );

      end );

    # and finally return the functor
    return functor;

end );

# functor to compute the truncation to single degrees of projective left-modules
InstallMethod( DegreeXLayerOfProjectiveGradedLeftModulesFunctor,
               [ IsToricVariety, IsList ],
      function( variety, degree )

        return DegreeXLayerOfProjectiveGradedModulesFunctor( variety, degree, true );

end );

# functor to compute the truncation to single degrees of projective left-modules
InstallMethod( DegreeXLayerOfProjectiveGradedLeftModulesFunctor,
               [ IsToricVariety, IsHomalgModuleElement ],
      function( variety, degree )

        return DegreeXLayerOfProjectiveGradedModulesFunctor( variety, UnderlyingListOfRingElements( degree ), true );

end );

# functor to compute the truncation to single degrees of projective right-modules
InstallMethod( DegreeXLayerOfProjectiveGradedRightModulesFunctor,
               [ IsToricVariety, IsList ],
      function( variety, degree )

        return DegreeXLayerOfProjectiveGradedModulesFunctor( variety, degree, false );

end );

# functor to compute the truncation to single degrees of projective right-modules
InstallMethod( DegreeXLayerOfProjectiveGradedRightModulesFunctor,
               [ IsToricVariety, IsHomalgModuleElement ],
      function( variety, degree )

        return DegreeXLayerOfProjectiveGradedModulesFunctor( variety, UnderlyingListOfRingElements( degree ), false );

end );



##############################################################################################
##
#! @Section Truncations of graded module presentations (as defined in CAP) to a single degree
##
##############################################################################################

# compute degree X layer of graded module presentation
InstallMethod( DegreeXLayerOfGradedLeftOrRightModulePresentation,
               " a toric variety, a graded module presentation, a list specifying a degree ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsList, IsBool ],
  function( variety, graded_module_presentation, degree, display_messages )
    local proj_category, left, degree_list, degrees, extended_degree_list, i, j, generators, homalg_graded_ring, vectorSpace;

    # check first that the overall input is valid to work with
    if not IsSmooth( variety ) then

      Error( "Variety must be smooth for this method to work" );
      return;

    elif not IsComplete( variety ) then

      Error( "Variety must be complete for this method to work" );
      return;

    elif not IsFieldForHomalg( CoefficientsRing( CoxRing( variety ) ) ) then

      Error( Concatenation( "DegreeXLayer operations are currently only supported if the coefficient ring",
                                   " of the Cox ring is a field" ) );
      return;

    elif not Rank( ClassGroup( variety ) ) = Length( degree ) then

      Error( "The given list does not specify an element of the class group of the variety in question" );
      return;

    fi;

    # then make more detailed check to decide if we are really dealing with a graded_module_presentation
    proj_category := CapCategory( UnderlyingMorphism( graded_module_presentation ) );
    if not IsIdenticalObj( UnderlyingHomalgGradedRing( ZeroObject( proj_category ) ), CoxRing( variety ) ) then

      Error( "The module is not defined over the Cox ring of the variety" );
      return;

    fi;

    # then return the DegreeXLayerVectorSpacePresentation
    return DegreeXLayerVectorSpacePresentation(
                            DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                                               variety,
                                                               UnderlyingMorphism( graded_module_presentation ), 
                                                               degree,
                                                               display_messages
                                                               )
                            );

end );

InstallMethod( DegreeXLayerOfGradedLeftOrRightModulePresentation,
               " a toric variety, a graded module presentation, a list specifying a degree ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsList ],
  function( variety, graded_module_presentation, degree )

    return DegreeXLayerOfGradedLeftOrRightModulePresentation( variety, graded_module_presentation, degree, false );

end );

InstallMethod( DegreeXLayerOfGradedLeftOrRightModulePresentation,
               " a toric variety, a graded module presentation, a list specifying a degree ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsHomalgModuleElement, IsBool ],
  function( variety, graded_module_presentation, degree, display_messages )
 
    return DegreeXLayerOfGradedLeftOrRightModulePresentation( 
                                      variety, graded_module_presentation, UnderlyingListOfRingElements( degree ), display_messages );

end );

InstallMethod( DegreeXLayerOfGradedLeftOrRightModulePresentation,
               " a toric variety, a graded module presentation, a list specifying a degree ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsHomalgModuleElement ],
  function( variety, graded_module_presentation, degree )
 
    return DegreeXLayerOfGradedLeftOrRightModulePresentation( 
                                      variety, graded_module_presentation, UnderlyingListOfRingElements( degree ), false );

end );

InstallMethod( DegreeXLayer,
               " a toric variety, a graded module presentation, a list specifying a degree ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsList, IsBool ],
  function( variety, graded_module_presentation, degree, display_messages )

    return CAPPresentationCategoryObject(
                 UnderlyingVectorSpaceMorphism(
                        DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                                               variety, 
                                                               UnderlyingMorphism( graded_module_presentation ), 
                                                               degree,
                                                               display_messages
                                                               )
                        ) 
                 );

end );

InstallMethod( DegreeXLayer,
               " a toric variety, a graded module presentation, a list specifying a degree ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsList ],
  function( variety, graded_module_presentation, degree )

    return DegreeXLayer( variety, graded_module_presentation, degree, false );

end );

InstallMethod( DegreeXLayer,
               " a toric variety, a graded module presentation, a list specifying a degree ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsHomalgModuleElement, IsBool ],
  function( variety, graded_module_presentation, degree, display_messages )

    return DegreeXLayer( variety, graded_module_presentation, UnderlyingListOfRingElements( degree ), display_messages );

end );

InstallMethod( DegreeXLayer,
               " a toric variety, a graded module presentation, a list specifying a degree ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsHomalgModuleElement ],
  function( variety, graded_module_presentation, degree )

    return DegreeXLayer( variety, graded_module_presentation, degree, false );

end );

InstallMethod( DegreeXLayer,
               " a toric variety, a graded module presentation, a list specifying a degree ",
               [ IsToricVariety, IsGradedLeftOrRightSubmoduleForCAP, IsList, IsBool ],
  function( variety, graded_submodule, degree, display_messages )

    return DegreeXLayer( variety, UnderlyingMorphism( PresentationForCAP( graded_submodule ) ), degree, display_messages );

end );

InstallMethod( DegreeXLayer,
               " a toric variety, a graded module presentation, a list specifying a degree ",
               [ IsToricVariety, IsGradedLeftOrRightSubmoduleForCAP, IsList ],
  function( variety, graded_submodule, degree )

    return DegreeXLayer( variety, graded_submodule, degree, false );

end );

InstallMethod( DegreeXLayer,
               " a toric variety, a graded module presentation, a list specifying a degree ",
               [ IsToricVariety, IsGradedLeftOrRightSubmoduleForCAP, IsHomalgModuleElement, IsBool ],
  function( variety, graded_submodule, degree, display_messages )

    return DegreeXLayer( variety, graded_submodule, UnderlyingListOfRingElements( degree ), display_messages );

end );

InstallMethod( DegreeXLayer,
               " a toric variety, a graded module presentation, a list specifying a degree ",
               [ IsToricVariety, IsGradedLeftOrRightSubmoduleForCAP, IsHomalgModuleElement ],
  function( variety, graded_submodule, degree )

    return DegreeXLayer( variety, graded_submodule, UnderlyingListOfRingElements( degree ), false );

end );



# compute degree X layer of graded module presentation morphism
InstallMethod( DegreeXLayerOfGradedLeftOrRightModulePresentationMorphism,
               " a toric variety, a graded module presentation, a list specifying a degree ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsList, IsBool ],
  function( variety, graded_module_presentation_morphism, degree, display_messages )
    local proj_category, left, degree_list, degrees, extended_degree_list, i, j, generators, homalg_graded_ring, vectorSpace;

    # check first that the overall input is valid to work with
    if not IsSmooth( variety ) then

      Error( "Variety must be smooth for this method to work" );
      return;

    elif not IsComplete( variety ) then

      Error( "Variety must be complete for this method to work" );
      return;

    elif not IsFieldForHomalg( CoefficientsRing( CoxRing( variety ) ) ) then

      Error( Concatenation( "DegreeXLayer operations are currently only supported if the coefficient ring",
                            " of the Cox ring is a field" ) );
      return;

    elif not Rank( ClassGroup( variety ) ) = Length( degree ) then

      Error( "The given list does not specify an element of the class group of the variety in question" );
      return;

    fi;

    # then make more detailed check to decide if we are really dealing with a graded_module_presentation
    proj_category := CapCategory( UnderlyingMorphism( graded_module_presentation_morphism ) );
    if not IsIdenticalObj( UnderlyingHomalgGradedRing( ZeroObject( proj_category ) ), CoxRing( variety ) ) then

      Error( "The module is not defined over the Cox ring of the variety" );
      return;

    fi;

    # FIXME:
    # the order of the generators of degreeXLayerVectorSpaces is time dependent, that is running the same command can lead to
    # isomorphic vector spaces - their generators being permutated against each other
    # this would corrupt the output produced from the following line, for the DegreeXLayer of 
    # Range( UnderlyingMorphism( Source( graded_module_presentation_morphism ) ) ) could be chosen differently for the source
    # and the mapping of the produced vector space morphism
    # -> needs to be adjusted

    # then return the DegreeXLayerVectorSpace
    return DegreeXLayerVectorSpacePresentationMorphism( 
                DegreeXLayerOfGradedLeftOrRightModulePresentation( variety,
                                                                   Source( graded_module_presentation_morphism ),
                                                                   degree,
                                                                   display_messages ),
                UnderlyingVectorSpaceMorphism(
                               DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                                               variety,
                                                               UnderlyingMorphism( graded_module_presentation_morphism ), 
                                                               degree,
                                                               display_messages
                                                               )
                                                        ),
                DegreeXLayerOfGradedLeftOrRightModulePresentation( variety,
                                                                   Range( graded_module_presentation_morphism ),
                                                                   degree,
                                                                   display_messages )
                );

end );

InstallMethod( DegreeXLayerOfGradedLeftOrRightModulePresentationMorphism,
               " a toric variety, a graded module presentation, a homalg_module_element specifying a degree ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsList ],
  function( variety, graded_module_presentation_morphism, degree )

    return DegreeXLayerOfGradedLeftOrRightModulePresentationMorphism( 
                          variety, graded_module_presentation_morphism, degree, false );

end );

InstallMethod( DegreeXLayerOfGradedLeftOrRightModulePresentationMorphism,
               " a toric variety, a graded module presentation, a homalg_module_element specifying a degree ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsHomalgModuleElement, IsBool ],
  function( variety, graded_module_presentation_morphism, degree, display_messages )

    return DegreeXLayerOfGradedLeftOrRightModulePresentationMorphism( 
                          variety, graded_module_presentation_morphism, UnderlyingListOfRingElements( degree ), display_messages );

end );

InstallMethod( DegreeXLayerOfGradedLeftOrRightModulePresentationMorphism,
               " a toric variety, a graded module presentation, a homalg_module_element specifying a degree ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsHomalgModuleElement ],
  function( variety, graded_module_presentation_morphism, degree )

    return DegreeXLayerOfGradedLeftOrRightModulePresentationMorphism( 
                          variety, graded_module_presentation_morphism, UnderlyingListOfRingElements( degree ), false );

end );


# compute degree X layer of graded module presentation morphism
InstallMethod( DegreeXLayerOfGradedLeftOrRightModulePresentationMorphismWithGivenSourceAndRange,
               " a toric variety, a graded module presentation, a list specifying a degree ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsList,
                 IsCAPPresentationCategoryObject, IsCAPPresentationCategoryObject, IsBool ],
  function( variety, graded_module_presentation_morphism, degree, new_source, new_range, display_messages )
    local proj_category, left, degree_list, degrees, extended_degree_list, i, j, generators, homalg_graded_ring, vectorSpace;

    # check first that the overall input is valid to work with
    if not IsSmooth( variety ) then

      Error( "Variety must be smooth for this method to work" );
      return;

    elif not IsComplete( variety ) then

      Error( "Variety must be complete for this method to work" );
      return;

    elif not IsFieldForHomalg( CoefficientsRing( CoxRing( variety ) ) ) then

      Error( Concatenation( "DegreeXLayer operations are currently only supported if the coefficient ring",
                            " of the Cox ring is a field" ) );
      return;

    elif not Rank( ClassGroup( variety ) ) = Length( degree ) then

      Error( "The given list does not specify an element of the class group of the variety in question" );
      return;

    fi;

    # then make more detailed check to decide if we are really dealing with a graded_module_presentation
    proj_category := CapCategory( UnderlyingMorphism( graded_module_presentation_morphism ) );
    if not IsIdenticalObj( UnderlyingHomalgGradedRing( ZeroObject( proj_category ) ), CoxRing( variety ) ) then

      Error( "The module is not defined over the Cox ring of the variety" );
      return;

    fi;

    # FIXME:
    # the order of the generators of degreeXLayerVectorSpaces is time dependent, that is running the same command can lead to
    # isomorphic vector spaces - their generators being permutated against each other
    # this would corrupt the output produced from the following line, for the DegreeXLayer of 
    # Range( UnderlyingMorphism( Source( graded_module_presentation_morphism ) ) ) could be chosen differently for the source
    # and the mapping of the produced vector space morphism
    # -> needs to be adjusted

    # then return the DegreeXLayerVectorSpace
    return CAPPresentationCategoryMorphism( 
                new_source,
                UnderlyingVectorSpaceMorphism(
                               DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                                               variety,
                                                               UnderlyingMorphism( graded_module_presentation_morphism ), 
                                                               degree,
                                                               display_messages
                                                               )
                                                        ),
                new_range
                );

end );

InstallMethod( DegreeXLayerOfGradedLeftOrRightModulePresentationMorphismWithGivenSourceAndRange,
               " a toric variety, a graded module presentation, a list specifying a degree ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsList,
                 IsCAPPresentationCategoryObject, IsCAPPresentationCategoryObject ],
  function( variety, graded_module_presentation_morphism, degree, new_source, new_range )

    return DegreeXLayerOfGradedLeftOrRightModulePresentationMorphismWithGivenSourceAndRange( 
                     variety, 
                     graded_module_presentation_morphism,
                     degree, 
                     new_source, 
                     new_range, 
                     false 
                     );

end );

InstallMethod( DegreeXLayerOfGradedLeftOrRightModulePresentationMorphismWithGivenSourceAndRange,
               " a toric variety, a graded module presentation, a homalg_module_element specifying a degree ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsHomalgModuleElement,
                 IsCAPPresentationCategoryObject, IsCAPPresentationCategoryObject, IsBool ],
  function( variety, graded_module_presentation_morphism, degree, new_source, new_range, display_messages )

    return DegreeXLayerOfGradedLeftOrRightModulePresentationMorphismWithGivenSourceAndRange( 
           variety, graded_module_presentation_morphism, UnderlyingListOfRingElements( degree ), new_source, new_range, display_messages );

end );

InstallMethod( DegreeXLayerOfGradedLeftOrRightModulePresentationMorphismWithGivenSourceAndRange,
               " a toric variety, a graded module presentation, a homalg_module_element specifying a degree ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsHomalgModuleElement,
                 IsCAPPresentationCategoryObject, IsCAPPresentationCategoryObject ],
  function( variety, graded_module_presentation_morphism, degree, new_source, new_range )

    return DegreeXLayerOfGradedLeftOrRightModulePresentationMorphismWithGivenSourceAndRange( 
           variety, graded_module_presentation_morphism, UnderlyingListOfRingElements( degree ), new_source, new_range, false );

end );


InstallMethod( DegreeXLayer,
               " a toric variety, a graded module presentation, a list specifying a degree ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsList, IsBool ],
  function( variety, graded_module_presentation_morphism, degree, display_messages )
    local new_source, new_range, new_mapping;
    
    new_source := DegreeXLayer( variety, Source( graded_module_presentation_morphism ), degree, display_messages );
    new_range := DegreeXLayer( variety, Range( graded_module_presentation_morphism ), degree, display_messages );
    new_mapping := UnderlyingVectorSpaceMorphism(
                        DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                                               variety, 
                                                               UnderlyingMorphism( graded_module_presentation_morphism ), 
                                                               degree,
                                                               display_messages
                                                               ) );
    return CAPPresentationCategoryMorphism( new_source, new_mapping, new_range );

end );

InstallMethod( DegreeXLayer,
               " a toric variety, a graded module presentation, a list specifying a degree ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsList ],
  function( variety, graded_module_presentation_morphism, degree )

      return DegreeXLayer( variety, graded_module_presentation_morphism, degree, false );

end );

InstallMethod( DegreeXLayer,
               " a toric variety, a graded module presentation, a list specifying a degree ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsHomalgModuleElement, IsBool ],
  function( variety, graded_module_presentation_morphism, degree, display_messages )
    local new_source, new_range, new_mapping;

    new_source := DegreeXLayer( variety, Source( graded_module_presentation_morphism ), degree, display_messages );
    new_range := DegreeXLayer( variety, Range( graded_module_presentation_morphism ), degree, display_messages );
    new_mapping := UnderlyingVectorSpaceMorphism(
                        DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                                               variety, 
                                                               UnderlyingMorphism( graded_module_presentation_morphism ), 
                                                               UnderlyingListOfRingElements( degree ),
                                                               display_messages
                                                               ) );
    return CAPPresentationCategoryMorphism( new_source, new_mapping, new_range );

end );

InstallMethod( DegreeXLayer,
               " a toric variety, a graded module presentation, a list specifying a degree ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsHomalgModuleElement ],
  function( variety, graded_module_presentation_morphism, degree )

      return DegreeXLayer( variety, graded_module_presentation_morphism, degree, false );

end );



######################################################################################################
##
## Section Truncations functor of graded module presentations (as defined in the CAP Proj-Category) to
##         a single degree
##
######################################################################################################

# this function computes the truncation functor to single degrees for both left and right graded module presentations
InstallGlobalFunction( DegreeXLayerOfGradedModulePresentationFunctor,
  function( variety, degree, left, display_messages )
    local source_category, range_category, functor;

    # check if the input is valid to work with
    if not IsSmooth( variety ) then

      Error( "Variety must be smooth for this method to work" );
      return;

    elif not IsComplete( variety ) then

      Error( "Variety must be complete for this method to work" );
      return;

    elif not IsFieldForHomalg( CoefficientsRing( CoxRing( variety ) ) ) then

      Error( Concatenation( "DegreeXLayer operations are currently only supported if the coefficient ring",
                            " of the Cox ring is a field" ) );
      return;

    elif not Rank( ClassGroup( variety ) ) = Length( degree ) then

      Error( "The given list does not specify an element of the class group of the variety in question" );
      return;

    fi;
    
    # determine the category under consideration
    if left = true then    
      source_category := SfpgrmodLeft( CoxRing( variety ) );
    else
      source_category := SfpgrmodLeft( CoxRing( variety ) );
    fi;
    
    # determine the target category
    range_category := PresentationCategory( MatrixCategory( CoefficientsRing( CoxRing( variety ) ) ) );

    # then initialise the functor
    functor := CapFunctor(
                      Concatenation( "DegreeXLayer functor for ", Name( source_category ), 
                                     " to the degree ", String( degree ) ), 
                      source_category,
                      range_category
                      );

    # now define the functor operation on the objects
    AddObjectFunction( functor,
      function( object )

        return UnderlyingVectorSpacePresentation( 
                                DegreeXLayerOfGradedLeftOrRightModulePresentation( variety, object, degree, display_messages ) );

      end );

    # and its operation on morphisms
    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )

        return DegreeXLayerOfGradedLeftOrRightModulePresentationMorphismWithGivenSourceAndRange( 
                                                            variety, morphism, degree, new_source, new_range, display_messages );

      end );

    # and finally return the functor
    return functor;

end );

# functor to compute the truncation to single degrees of projective left-modules
InstallMethod( DegreeXLayerOfGradedLeftModulePresentationFunctor,
               [ IsToricVariety, IsList, IsBool ],
      function( variety, degree, display_messages )

        return DegreeXLayerOfGradedModulePresentationFunctor( variety, degree, true, display_messages );

end );

InstallMethod( DegreeXLayerOfGradedLeftModulePresentationFunctor,
               [ IsToricVariety, IsList ],
      function( variety, degree )

        return DegreeXLayerOfGradedModulePresentationFunctor( variety, degree, true, false );

end );

InstallMethod( DegreeXLayerOfGradedLeftModulePresentationFunctor,
               [ IsToricVariety, IsHomalgModuleElement, IsBool ],
      function( variety, degree, display_messages )

        return DegreeXLayerOfGradedModulePresentationFunctor( variety, UnderlyingListOfRingElements( degree ), true, display_messages );

end );

InstallMethod( DegreeXLayerOfGradedLeftModulePresentationFunctor,
               [ IsToricVariety, IsHomalgModuleElement ],
      function( variety, degree )

        return DegreeXLayerOfGradedModulePresentationFunctor( variety, UnderlyingListOfRingElements( degree ), true, false );

end );

# functor to compute the truncation to single degrees of projective right-modules
InstallMethod( DegreeXLayerOfGradedRightModulePresentationFunctor,
               [ IsToricVariety, IsList, IsBool ],
      function( variety, degree, display_messages )

        return DegreeXLayerOfGradedModulePresentationFunctor( variety, degree, false, display_messages );

end );

InstallMethod( DegreeXLayerOfGradedRightModulePresentationFunctor,
               [ IsToricVariety, IsList ],
      function( variety, degree )

        return DegreeXLayerOfGradedModulePresentationFunctor( variety, degree, false, false );

end );

InstallMethod( DegreeXLayerOfGradedRightModulePresentationFunctor,
               [ IsToricVariety, IsHomalgModuleElement, IsBool ],
      function( variety, degree, display_messages )

        return DegreeXLayerOfGradedModulePresentationFunctor( variety, UnderlyingListOfRingElements( degree ), false, display_messages );

end );

InstallMethod( DegreeXLayerOfGradedRightModulePresentationFunctor,
               [ IsToricVariety, IsHomalgModuleElement ],
      function( variety, degree )

        return DegreeXLayerOfGradedModulePresentationFunctor( variety, UnderlyingListOfRingElements( degree ), false, false );

end );











##################################################################################################
##
#! @Section Truncations of graded module presentations as defined in the package GradedModules
##
##################################################################################################


# compute degree X layer of projective graded S-module
InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListOfColumnMatrices,
               " a toric variety, a projective graded module, a list specifying a degree ",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsList ],
  function( variety, projective_module, degree )
    local degree_list, degrees, extended_degree_list, i, generators;

    # check that the input is valid to work with
    if not IsSmooth( variety ) then

      Error( "Variety must be smooth for this method to work" );
      return;

    elif not IsComplete( variety ) then

      return Error( "Variety must be complete for this method to work" );

    elif not Rank( ClassGroup( variety ) ) = Length( degree ) then

      Error( "The given list does not specify an element of the class group of the variety in question" );
      return;

    elif not IsFree( projective_module ) then

      Error( "The module is not free" );
      return;

    elif IsZero( projective_module ) then

      return [];

    fi;

    # compute the degree layers of S that need to be computed
    degree_list := DegreesOfGenerators( projective_module );

    # 'unzip' the degree_list
    extended_degree_list := [ degree - UnderlyingListOfRingElements( degree_list[ 1 ] ) ];
    for i in [ 2 .. Length( degree_list ) ] do
      Add( extended_degree_list, degree - UnderlyingListOfRingElements( degree_list[ i ] ) );
    od;

    # now extract the generators
    generators := [];
    for i in [ 1 .. Rank( projective_module ) ] do

      generators := Concatenation(
                          generators,
                          DegreeXLayerVectorsAsColumnMatrices( variety, extended_degree_list[ i ], i, Rank( projective_module ) )
                          );

    od;

    # then return the DegreeXLayerVectorSpace
    return generators;

end );

InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListOfColumnMatrices,
               " a toric variety, a projective graded module, a homalg_module_element specifying a degree ",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsHomalgModuleElement ],
  function( variety, projective_module, degree )

    return DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListOfColumnMatrices( 
                                               variety, projective_module, UnderlyingListOfRingElements( degree ) );

end );

# compute degree X layer of projective graded S-module
InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsUnionOfColumnMatrices,
               " a toric variety, a projective graded module, a list specifying a degree ",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsList ],
  function( variety, projective_module, degree )
    local degree_list, degrees, extended_degree_list, i, generators, matrix, pos;

    # check that the input is valid to work with
    if not IsSmooth( variety ) then

      Error( "Variety must be smooth for this method to work" );
      return;

    elif not IsComplete( variety ) then

      return Error( "Variety must be complete for this method to work" );

    elif not Rank( ClassGroup( variety ) ) = Length( degree ) then

      Error( "The given list does not specify an element of the class group of the variety in question" );
      return;

    elif not IsFree( projective_module ) then

      Error( "The module is not free" );
      return;

    elif IsZero( projective_module ) then

      return HomalgInitialMatrix( 0, 0, CoxRing( variety ) );

    fi;

    # compute the degree layers of S that need to be computed
    degree_list := DegreesOfGenerators( projective_module );

    # 'unzip' the degree_list
    extended_degree_list := [ degree - UnderlyingListOfRingElements( degree_list[ 1 ] ) ];
    for i in [ 2 .. Length( degree_list ) ] do
      Add( extended_degree_list, degree - UnderlyingListOfRingElements( degree_list[ i ] ) );
    od;

    # now extract the generators
    generators := [];
    for i in [ 1 .. Rank( projective_module ) ] do

      generators := Concatenation( 
                          generators, 
                          DegreeXLayerVectorsAsColumnMatrices( variety, extended_degree_list[ i ], i, Rank( projective_module ) )
                          );

    od;

    # construct the matrix
    matrix := HomalgInitialMatrix( Rank( projective_module ), Length( generators ), CoxRing( variety ) );
    for i in [ 1 .. Length( generators ) ] do
      pos := NonZeroRows( generators[ i ] );
      SetMatElm( matrix, pos[ 1 ], i, EntriesOfHomalgMatrix( CertainRows( generators[ i ], pos ) )[ 1 ] );
    od;

    # then return the DegreeXLayerVectorSpace
    return matrix;

end );

InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsUnionOfColumnMatrices,
               " a toric variety, a projective graded module, a homalg_module_element specifying a degree ",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsHomalgModuleElement ],
  function( variety, projective_module, degree )

    return DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsUnionOfColumnMatrices( 
                                               variety, projective_module, UnderlyingListOfRingElements( degree ) );

end );

# compute degree X layer of projective graded S-module morphism
InstallMethod( DegreeXLayerOfFPGradedModuleForGradedModules,
               " a toric variety, a f.p. graded S-module for GradedModules, a list specifying a degree ",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsList ],
  function( variety, graded_module, degree )
    local left, h, gens_source, gens_range, i, j, buffer, non_zero_rows, cols, mapping_matrix, matrix, vector_space_morphism;

    # check if we have to deal with a left or right module
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( graded_module );

    # check that the input is valid to work with
    if not IsSmooth( variety ) then

      Error( "Variety must be smooth for this method to work" );
      return;

    elif not IsComplete( variety ) then

      Error( "Variety must be complete for this method to work" );
      return;

    elif not Rank( ClassGroup( variety ) ) = Length( degree ) then

      Error( "The given list does not specify an element of the class group of the variety in question" );
      return;

    fi;

    # the module is not zero nor free, so extract the presentation morphism h
    if HasSuperObject( graded_module ) then

      h := ByASmallerPresentation( PresentationMorphism( Source( EmbeddingInSuperObject( graded_module ) ) ) );

    else

      h := ByASmallerPresentation( PresentationMorphism( graded_module ) );

    fi;

    # perform the computation for source and range
    gens_source := DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListOfColumnMatrices(
                                                                           variety,
                                                                           Source( h ),
                                                                           degree
                                                                         );
    gens_range := DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsUnionOfColumnMatrices(
                                                                          variety,
                                                                          Range( h ),
                                                                          degree
                                                                         );

    # check for degenerate cases
    if Length( gens_source ) = 0 then

      # can only form the zero morphism
      vector_space_morphism := ZeroMorphism( VectorSpaceObject( Length( gens_source ), CoefficientsRing( CoxRing( variety ) ) ),
                                             VectorSpaceObject( NrColumns( gens_range ), CoefficientsRing( CoxRing( variety ) ) )
                                            );

    elif NrColumns( gens_range ) = 0 then

      # can only form the zero morphism
      vector_space_morphism := ZeroMorphism( VectorSpaceObject( Length( gens_source ), CoefficientsRing( CoxRing( variety ) ) ),
                                             VectorSpaceObject( NrColumns( gens_range ), CoefficientsRing( CoxRing( variety ) ) )
                                            );

    else;

      # <both vector spaces are of non-zero dimension>

      # This is the most crucial piece of the code in DegreeXLayer, and thus a few explaining words are appropriate:

      # Note:
      # gens_source and gens_range are lists. Each entry is a generator of the source/ range vector spaces.
      # These generators themselves are lists, whose length matches the rank of source/range vector space respectively.
      # The entries are elements of the underlying graded homalg_ring.
      #
      # Consequently, turning such a generator into a matrix means that we can for left presentations multiply the mapping
      # matrix from the left with such a generator. For right presentations, we can multiply a generator_matrix from the right
      # onto the mapping matrix.
      #
      # We turn the generators of the source into such matrices. We then compute products of the following type:
      # AsMatrix( source_generator[ i ] ) * mapping_matrix         (for left modules)
      # mapping_matrix * AsMatrix( source_generator[ i ] )         (for right modules)
      #
      # The results of these multiplications are elements of the vector space spanned by gens_range. So we should try to
      # express the result in terms of these generators. Therefore we form a matrix M from the listlist gens_range such that:
      #
      # for left modules, each generator in gens_range is a row of that matrix
      # for right modules, each generator in gens_range is a column of that matrix
      #
      # Expressing the elements in terms of the generators of the range is then the task to find a matrix B such that
      #
      # for left modules:   AsMatrix( source_generator[ i ] ) * mapping_matrix = B * M
      #                     RightDivide( AsMatrix( source_generator[ i ] ) * mapping_matrix, M ) = B
      # for right modules:  mapping_matrix * AsMatrix( source_generator[ i ] ) = M * B
      #                     LeftDivide( M, mapping_matrix * AsMatrix( source_generator[ i ] ) ) = B
      #
      # for each i, B will be a row (for left modules)/ a column (for right modules)
      # the union of these rows/columns then gives a morphism of left/right vector spaces
      #
      # MatrixCategory( ) in LinearAlgebraForCAP solemnly supports left vector spaces. Therefore we need to turn morphisms
      # of right vector_spaces into morphisms of left_vector spaces at the end of the computation.

      # extract the underlying matrix of the morphism
      mapping_matrix := MatrixOfMap( h );

      # the following code could in principle be optimised a bit further!
      # also a proper check for the right module functionality should be performed sometime!

      # differ cases
      if left then

        # express the image of gens_source[ i ] in terms of gens_range
        cols := List( [ 1..Length( gens_source ) ], x ->  
                                           LeftDivide( gens_range, Involution( mapping_matrix ) * gens_source[ x ] ) );

        # extract the non-zero entries
        matrix := HomalgInitialMatrix( NrColumns( gens_range ),
                                       Length( gens_source ),
                                       CoefficientsRing( CoxRing( variety ) )
                                    );
        #non_zero_entries := [];
        for i in [ 1 .. Length( cols ) ] do
          buffer := NonZeroRows( cols[ i ] );
          non_zero_rows := EntriesOfHomalgMatrix( CertainRows( cols[ i ], buffer ) );
          for j in [ 1 .. Length( buffer ) ] do
            SetMatElm( matrix, buffer[ j ], i, non_zero_rows[ j ] / CoefficientsRing( CoxRing( variety ) ) );
          od;
        od;

      else

        # express the image of gens_source[ i ] in terms of gens_range
        cols := List( [ 1..Length( gens_source ) ], x -> 
                                           LeftDivide( gens_range, mapping_matrix * gens_source[ x ] ) ); 

        # extract the non-zero entries
        matrix := HomalgInitialMatrix( NrColumns( gens_range ),
                                       Length( gens_source ),
                                       CoefficientsRing( CoxRing( variety ) )
                                    );
        #non_zero_entries := [];
        for i in [ 1 .. Length( cols ) ] do
          buffer := NonZeroRows( cols[ i ] );
          non_zero_rows := EntriesOfHomalgMatrix( CertainRows( cols[ i ], buffer ) );
          for j in [ 1 .. Length( buffer ) ] do
            SetMatElm( matrix, buffer[ j ], i, non_zero_rows[ j ] / CoefficientsRing( CoxRing( variety ) ) );
          od;
        od;

      fi;

      # and create the vector space morphism
      # note that CAP only supports left vector spaces, but the above matrix the is the mapping matrix of right vector spaces
      # -> so we need 'Involution'
      vector_space_morphism := VectorSpaceMorphism( 
                                             VectorSpaceObject( Length( gens_source ), CoefficientsRing( CoxRing( variety ) ) ),
                                             Involution( matrix ),
                                             VectorSpaceObject( NrColumns( gens_range ), CoefficientsRing( CoxRing( variety ) ) )
                                             );

    fi;

    # finally return the result
    return CokernelObject( vector_space_morphism );

end );

# compute degree X layer of projective graded S-module
InstallMethod( DegreeXLayerOfFPGradedModuleForGradedModules,
               " a toric variety, a projective graded module morphism, a homalg_module_element specifying a degree ",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsHomalgModuleElement ],
  function( variety, projective_module_morphism, degree )

    return DegreeXLayerOfFPGradedModuleForGradedModules( 
                                       variety, projective_module_morphism, UnderlyingListOfRingElements( degree ) );

end );
