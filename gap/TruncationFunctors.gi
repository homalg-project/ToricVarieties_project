##########################################################################################
##
##  TruncationsFunctors.gi             SheafCohomologyOnToricVarieties package
##
##  Copyright 2019                     Martin Bies,       ULB Brussels
##
#! @Chapter Truncation functors for f.p. graded modules
##
#########################################################################################


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
