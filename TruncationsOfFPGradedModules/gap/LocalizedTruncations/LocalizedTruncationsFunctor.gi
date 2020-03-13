################################################################################################
##
##  LocalizedTruncationsFunctor.gd     TruncationsOfFPGradedModules
##
##  Copyright 2020                     Martin Bies,       University of Oxford
##
##  Functor for localized truncations to degree 0
##
################################################################################################

InstallMethod( LocalizedTruncationFunctorForGradedRowsAndColumns,
               [ IsHomalgGradedRing, IsList, IsBool ],
  function( graded_ring, localized_variables, graded_row )
    local new_ring, source_category, range_category, functor;
    
    # compute localized ring
    new_ring := Localized_degree_zero_ring( graded_ring, localized_variables );
    
    # determine source and range category
    if graded_row = true then
      source_category := CategoryOfGradedRows( graded_ring );
      range_category := FreydCategory( CategoryOfRows( new_ring ) );
    else
      source_category := CategoryOfGradedColumns( graded_ring );
      range_category := FreydCategory( CategoryOfColumns( new_ring ) );
    fi;
    
    # then initialise the functor
    functor := CapFunctor(
                      Concatenation( "Localized trunction functor for ", Name( source_category ), " to the degree 0" ),
                      source_category,
                      range_category
                      );
    
    # now define the functor operation on the objects
    AddObjectFunction( functor,
      function( object )

          return LocalizedDegreeZero( object, localized_variables );

      end );
    
    # its operation on morphisms
    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )

          return LocalizedDegreeZero( morphism, localized_variables );

      end );
    
    # and return this functor
    return functor;
    
end );

InstallMethod( LocalizedTruncationFunctorForGradedRows,
               [ IsHomalgGradedRing, IsList ],
  function( graded_ring, localized_variables )

    return LocalizedTruncationFunctorForGradedRowsAndColumns( graded_ring, localized_variables, true );

end );

InstallMethod( LocalizedTruncationFunctorForGradedColumns,
               [ IsHomalgGradedRing, IsList ],
  function( graded_ring, localized_variables )

    return LocalizedTruncationFunctorForGradedRowsAndColumns( graded_ring, localized_variables, false );

end );


InstallMethod( LocalizedTruncationFunctorForFPGradedModules,
               [ IsHomalgGradedRing, IsList, IsBool ],
  function( graded_ring, localized_variables, graded_row )
    local new_ring, source_category, range_category, functor;
    
    # compute localized ring
    new_ring := Localized_degree_zero_ring( graded_ring, localized_variables );
    
    # determine source and range category
    if graded_row = true then
      source_category := FpGradedLeftModules( graded_ring );
      range_category := FreydCategory( CategoryOfRows( new_ring ) );
    else
      source_category := FpGradedRightModules( graded_ring );
      range_category := FreydCategory( CategoryOfColumns( new_ring ) );
    fi;
    
    # then initialise the functor
    functor := CapFunctor(
                      Concatenation( "Localized trunction functor for ", Name( source_category ), " to the degree 0" ),
                      source_category,
                      range_category
                      );
    
    # now define the functor operation on the objects
    AddObjectFunction( functor,
      function( object )

          return LocalizedDegreeZero( object, localized_variables );

      end );
    
    # its operation on morphisms
    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )

          return LocalizedDegreeZero( morphism, localized_variables );

      end );
    
    # and return this functor
    return functor;
    
end );

InstallMethod( LocalizedTruncationFunctorForFPGradedLeftModules,
               [ IsHomalgGradedRing, IsList ],
  function( graded_ring, localized_variables )

    return LocalizedTruncationFunctorForFPGradedModules( graded_ring, localized_variables, true );

end );

InstallMethod( LocalizedTruncationFunctorForFPGradedRightModules,
               [ IsHomalgGradedRing, IsList ],
  function( graded_ring, localized_variables )

    return LocalizedTruncationFunctorForFPGradedModules( graded_ring, localized_variables, false );

end );
