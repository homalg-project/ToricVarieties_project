##########################################################################################
##
##  DegreeXLayerVectorSpace.gi         TruncationsOfFPGradedModules package
##
##  Copyright 2020                     Martin Bies,    University of Oxford
##
#! @Chapter DegreeXLayerVectorSpaces and morphisms
##
#########################################################################################


##############################################################################################
##
## Section GAP category of DegreeXLayerVectorSpaces and DegreeXLayerVectorSpaceMorphisms
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
#! @Section Constructors for DegreeXLayerVectorSpaces and DegreeXLayerVectorSpaceMorphisms
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
                             UnderlyingVectorSpacePresentation, FreydCategoryObject( UnderlyingVectorSpaceMorphism( morphism ) )
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
                             FreydCategoryMorphism( UnderlyingVectorSpacePresentation( source ),
                                                    morphism,
                                                    UnderlyingVectorSpacePresentation( range ) )
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

