##########################################################################################
##
##  TruncationsOfFPGradedModules.gi        SheafCohomologyOnToricVarieties package
##
##  Copyright 2019                         Martin Bies,       ULB Brussels
##
#! @Chapter Truncations of f.p. graded modules
##
#########################################################################################


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
    if not IsValidInputForCohomologyComputations( variety ) then

      Error( "The variety has to be smooth, complete (or simplicial, projective if you allow for lazy checks)" );
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
    if not IsValidInputForCohomologyComputations( variety ) then

      Error( "The variety has to be smooth, complete (or simplicial, projective if you allow for lazy checks)" );
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
    if not IsValidInputForCohomologyComputations( variety ) then

      Error( "The variety has to be smooth, complete (or simplicial, projective if you allow for lazy checks)" );
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
