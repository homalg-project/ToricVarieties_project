##########################################################################################
##
##  TruncationFunctors.gi             SheafCohomologyOnToricVarieties package
##
##  Copyright 2019                     Martin Bies,       ULB Brussels
##
##  Truncation functors for f.p. graded modules
##
#########################################################################################


######################################################################################################
##
## Section Truncation functor for graded rows and columns
##
######################################################################################################

InstallMethod( TruncationFunctorForGradedRowsAndColumns,
               [ IsToricVariety, IsList, IsBool ],
  function( variety, degree, graded_row )
    local source_category, range_category, functor;

    # check if the input is valid to work with
    if not IsValidInputForCohomologyComputations( variety ) then

      Error( "The variety has to be smooth, complete (or simplicial, projective if you allow for lazy checks)" );
      return;

    elif not IsFieldForHomalg( CoefficientsRing( CoxRing( variety ) ) ) then

      Error( Concatenation( "TruncationFunctor is currently only supported if the coefficient ring",
                            " of the Cox ring is a field" ) );
      return;

    elif not Rank( ClassGroup( variety ) ) = Length( degree ) then

      Error( "The given list does not specify an element of the class group of the variety in question" );
      return;

    fi;

    # determine the category under consideration
    if graded_row = true then
      source_category := CategoryOfGradedRows( CoxRing( variety ) );
    else
      source_category := CategoryOfGradedColumns( CoxRing( variety ) );
    fi;

    # determine the target category
    range_category := MatrixCategory( CoefficientsRing( CoxRing( variety ) ) );

    # then initialise the functor
    functor := CapFunctor(
                      Concatenation( "Trunction functor for ", Name( source_category ),
                                     " to the degree ", String( degree ) ),
                      source_category,
                      range_category
                      );

    # now define the functor operation on the objects
    AddObjectFunction( functor,
      function( object )

          return TruncateGradedRowOrColumn( variety, object, degree );

      end );

    # its operation on morphisms
    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )

          return TruncateGradedRowOrColumnMorphism( variety, morphism, degree );

      end );

    # and return this functor
    return functor;

end );

InstallMethod( TruncationFunctorForGradedRows,
               [ IsToricVariety, IsList ],
      function( variety, degree )

        return TruncationFunctorForGradedRowsAndColumns( variety, degree, true );

end );

InstallMethod( TruncationFunctorForGradedRows,
               [ IsToricVariety, IsHomalgModuleElement ],
      function( variety, degree )

        return TruncationFunctorForGradedRowsAndColumns( variety, UnderlyingListOfRingElements( degree ), true );

end );

InstallMethod( TruncationFunctorForGradedColumns,
               [ IsToricVariety, IsList ],
      function( variety, degree )

        return TruncationFunctorForGradedRowsAndColumns( variety, degree, false );

end );

InstallMethod( TruncationFunctorForGradedColumns,
               [ IsToricVariety, IsHomalgModuleElement ],
      function( variety, degree )

        return TruncationFunctorForGradedRowsAndColumns( variety, UnderlyingListOfRingElements( degree ), false );

end );


######################################################################################################
##
## Section Truncations functor of graded module presentations (as defined in the CAP Proj-Category) to
##         a single degree
##
######################################################################################################

# this function computes the truncation functor to single degrees for both left and right graded module presentations
InstallMethod( TruncationFunctorForFPGradedModules,
               [ IsToricVariety, IsList, IsBool ],
  function( variety, degree, left )
    local source_category, range_category, functor;

    # check if the input is valid to work with
    if not IsValidInputForCohomologyComputations( variety ) then

      Error( "The variety has to be smooth, complete (or simplicial, projective if you allow for lazy checks)" );
      return;

    elif not IsFieldForHomalg( CoefficientsRing( CoxRing( variety ) ) ) then

      Error( Concatenation( "TruncationFunctorForFPGradedModules is currently only supported if the coefficient ring",
                            " of the Cox ring is a field" ) );
      return;

    elif not Rank( ClassGroup( variety ) ) = Length( degree ) then

      Error( "The given list does not specify an element of the class group of the variety in question" );
      return;

    fi;

    # determine the category under consideration
    if left = true then
      source_category := FpGradedLeftModules( CoxRing( variety ) );
    else
      source_category := FpGradedRightModules( CoxRing( variety ) );
    fi;

    # determine the target category
    range_category := FreydCategory( MatrixCategory( CoefficientsRing( CoxRing( variety ) ) ) );

    # then initialise the functor
    functor := CapFunctor(
                      Concatenation( "Truncation functor for ", Name( source_category ),
                                     " to the degree ", String( degree ) ),
                      source_category,
                      range_category
                      );

    # now define the functor operation on the objects
    AddObjectFunction( functor,
      function( object )

        return TruncateFPGradedModule( variety, object, degree );

      end );

    # its operation on morphisms
    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )

        return TruncateFPGradedModuleMorphism( variety, morphism, degree );

      end );

    # and return this functor
    return functor;

end );

InstallMethod( TruncationFunctorForFpGradedLeftModules,
               [ IsToricVariety, IsList ],
      function( variety, degree )

        return TruncationFunctorForFPGradedModules( variety, degree, true );

end );

InstallMethod( TruncationFunctorForFpGradedLeftModules,
               [ IsToricVariety, IsHomalgModuleElement ],
      function( variety, degree )

        return TruncationFunctorForFPGradedModules( variety, UnderlyingListOfRingElements( degree ), true );

end );

InstallMethod( TruncationFunctorForFpGradedRightModules,
               [ IsToricVariety, IsList ],
      function( variety, degree )

        return TruncationFunctorForFPGradedModules( variety, degree, false );

end );

InstallMethod( TruncationFunctorForFpGradedRightModules,
               [ IsToricVariety, IsHomalgModuleElement ],
      function( variety, degree )

        return TruncationFunctorForFPGradedModules( variety, UnderlyingListOfRingElements( degree ), false );

end );
