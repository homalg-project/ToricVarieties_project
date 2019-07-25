##########################################################################################
##
##  ToolsForFPGradedModules.gi        SheafCohomologyOnToricVarieties package
##
##  Copyright 2019                     Martin Bies,       ULB Brussels
##
#! @Chapter Tools for FPGradedModules
##
#########################################################################################


####################################################################################
##
#! @Section Minimal free resolutions
##
####################################################################################

# compute a minimal free resolution of a graded module presentation
InstallMethod( MinimalFreeResolutionForCAP,
               "for a CAPPresentationCategoryObject",
               [ IsFpGradedLeftOrRightModulesObject ],
  function( presentation_object )
    local proj_category, left, morphisms, new_mapping_matrix, buffer_mapping, kernel_matrix, i, pos;

    # gather necessary information
    proj_category := CapCategory( RelationMorphism( presentation_object ) );
    left := IsGradedRowMorphism( RelationMorphism( presentation_object ) );

    # initialise morphisms
    morphisms := [];

    # use a presentation that does not contain units -> minimal (!) resolution
    if left then
      new_mapping_matrix := ReducedBasisOfRowModule( UnderlyingHomalgMatrix( 
                                                                          RelationMorphism( presentation_object ) ) );
      buffer_mapping := DeduceMapFromMatrixAndRangeForGradedRows( new_mapping_matrix, 
                                                                    Range( RelationMorphism( presentation_object ) ) );
    else
      new_mapping_matrix := ReducedBasisOfColumnModule( UnderlyingHomalgMatrix(
                                                                           RelationMorphism( presentation_object ) ) );
      buffer_mapping := DeduceMapFromMatrixAndRangeForGradedCols( new_mapping_matrix,
                                                                    Range( RelationMorphism( presentation_object ) ) );
    fi;

    # and use this mapping as the first morphisms is the minimal free resolution
    Add( morphisms, buffer_mapping );

    # now compute "reduced" kernels
    if left then
      kernel_matrix := ReducedSyzygiesOfRows( UnderlyingHomalgMatrix( morphisms[ 1 ] ) );
      buffer_mapping := DeduceMapFromMatrixAndRangeForGradedRows( kernel_matrix, Source( morphisms[ 1 ] ) );      
    else
      kernel_matrix := ReducedSyzygiesOfColumns( UnderlyingHomalgMatrix( morphisms[ 1 ] ) );
      buffer_mapping := DeduceMapFromMatrixAndRangeForGradedCols( kernel_matrix, Source( morphisms[ 1 ] ) );
    fi;

    # as long as the kernel is non-zero
    while not IsZeroForMorphisms( buffer_mapping ) do

      # add the corresponding kernel embedding
      Add( morphisms, buffer_mapping );

      # and compute the next kernel_embedding
      if left then
        kernel_matrix := ReducedSyzygiesOfRows( UnderlyingHomalgMatrix( buffer_mapping ) );
        buffer_mapping := DeduceMapFromMatrixAndRangeForGradedRows( kernel_matrix, Source( buffer_mapping ) );
      else
        kernel_matrix := ReducedSyzygiesOfColumns( UnderlyingHomalgMatrix( buffer_mapping ) );
        buffer_mapping := DeduceMapFromMatrixAndRangeForGradedCols( kernel_matrix, Source( buffer_mapping ) );
      fi;

    od;

    # and return the corresponding complex
    return ComplexFromMorphismList( morphisms );

end );



####################################################################################
##
#! @Section Full information about complex
##
####################################################################################

# compute a minimal free resolution of a graded module presentation
InstallMethod( FullInformation,
               "for a complex",
               [ IsCapComplex ],
  function( cocomplex )
    local differential_function, pos;

    # extract the differentials
    differential_function := UnderlyingZFunctorCell( cocomplex )!.differential_func;

    # start to print information
    pos := -1;
    
    while not IsZeroForObjects( Source( differential_function( pos ) ) ) do
    
      # print information
      Print( String( DegreeList( Range( differential_function( pos ) ) ) ) );
      Print( "\n" );
      Print( " ^ \n" );
      Print( " | \n" );
      Display( UnderlyingHomalgMatrix( differential_function( pos ) ) );
      Print( " | \n" );
      
      # increment
      pos := pos - 1;
    
    od;
    
    Print( String( DegreeList( Range( differential_function( pos ) ) ) ) );
    Print( "\n \n" );

end );



####################################################################################
##
#! @Section Betti tables
##
####################################################################################

# compute a minimal free resolution of a graded module presentation
InstallMethod( BettiTableForCAP,
               "for a CAPPresentationCategoryObject",
               [ IsFpGradedLeftOrRightModulesObject ],
  function( presentation_object )
    local proj_category, left, betti_table, new_mapping_matrix, buffer_mapping, kernel_matrix, i, pos;

    # gather necessary information
    proj_category := CapCategory( RelationMorphism( presentation_object ) );
    left := IsGradedRowMorphism( RelationMorphism( presentation_object ) );

    # initialise morphisms
    betti_table := [];

    # use a presentation that does not contain units -> minimal (!) resolution
    if left then
      new_mapping_matrix := ReducedBasisOfRowModule( UnderlyingHomalgMatrix( RelationMorphism( presentation_object ) ) );
      buffer_mapping := DeduceMapFromMatrixAndRangeForGradedRows( new_mapping_matrix, Range( RelationMorphism( presentation_object ) ) );
    else
      new_mapping_matrix := ReducedBasisOfColumnModule( UnderlyingHomalgMatrix( RelationMorphism( presentation_object ) ) );
      buffer_mapping := DeduceMapFromMatrixAndRangeForGradedCols( new_mapping_matrix, Range( RelationMorphism( presentation_object ) ) );
    fi;

    # and use this mapping as the first morphisms is the minimal free resolution
    Add( betti_table, UnzipDegreeList( Range( buffer_mapping ) ) );

    # check if we are already done
    if IsZeroForObjects( Source( buffer_mapping ) ) then
      return betti_table;
    fi;

    # otherwise add the source and compute the next mapping
    Add( betti_table, UnzipDegreeList( Source( buffer_mapping ) ) );

    # now compute "reduced" kernels
    if left then
      kernel_matrix := ReducedSyzygiesOfRows( UnderlyingHomalgMatrix( buffer_mapping ) );
      buffer_mapping := DeduceMapFromMatrixAndRangeForGradedRows( kernel_matrix, Source( buffer_mapping ) );
    else
      kernel_matrix := ReducedSyzygiesOfColumns( UnderlyingHomalgMatrix( buffer_mapping ) );
      buffer_mapping := DeduceMapFromMatrixAndRangeForGradedCols( kernel_matrix, Source( buffer_mapping ) );
    fi;

    # as long as the kernel is non-zero
    while not IsZeroForObjects( Source( buffer_mapping ) ) do

      # add the corresponding kernel embedding
      Add( betti_table, UnzipDegreeList( Source( buffer_mapping ) ) );

      # and compute the next kernel_embedding
      if left then
        kernel_matrix := ReducedSyzygiesOfRows( UnderlyingHomalgMatrix( buffer_mapping ) );
        buffer_mapping := DeduceMapFromMatrixAndRangeForGradedRows( kernel_matrix, Source( buffer_mapping ) );
      else
        kernel_matrix := ReducedSyzygiesOfColumns( UnderlyingHomalgMatrix( buffer_mapping ) );
        buffer_mapping := DeduceMapFromMatrixAndRangeForGradedCols( kernel_matrix, Source( buffer_mapping ) );
      fi;

    od;

    # and return the Betti table
    return betti_table;

end );
