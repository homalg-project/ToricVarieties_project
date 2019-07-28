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
#! @Section Truncations of fp graded modules
##
##############################################################################################

InstallMethod( TruncateFPGradedModule,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsList ],
  function( variety, graded_module, degree )

      return FreydCategoryObject(
                TruncateGradedRowOrColumnMorphism( variety, RelationMorphism( graded_module ), degree ) );

end );

InstallMethod( TruncateFPGradedModule,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsHomalgModuleElement ],
  function( variety, graded_module, degree )

      return FreydCategoryObject(
                TruncateGradedRowOrColumnMorphism( variety, RelationMorphism( graded_module ), degree ) );

end );

InstallMethod( TruncateFPGradedModule,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsList, IsBool ],
  function( variety, graded_module, degree, display_messages )

      return FreydCategoryObject(
                TruncateGradedRowOrColumnMorphism( variety, RelationMorphism( graded_module ), degree, display_messages ) );

end );

InstallMethod( TruncateFPGradedModule,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsHomalgModuleElement, IsBool ],
  function( variety, graded_module, degree, display_messages )

      return FreydCategoryObject(
                TruncateGradedRowOrColumnMorphism( variety, RelationMorphism( graded_module ), degree, display_messages ) );

end );

InstallMethod( TruncateFPGradedModule,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsList, IsBool, IsFieldForHomalg ],
  function( variety, graded_module, degree, display_messages, rationals )

      return FreydCategoryObject(
                TruncateGradedRowOrColumnMorphism(
                                          variety, RelationMorphism( graded_module ), degree, display_messages, rationals ) );

end );

InstallMethod( TruncateFPGradedModule,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsHomalgModuleElement, IsBool, IsFieldForHomalg ],
  function( variety, graded_module, degree, display_messages, rationals )

      return FreydCategoryObject(
                TruncateGradedRowOrColumnMorphism(
                                          variety, RelationMorphism( graded_module ), degree, display_messages, rationals ) );

end );



##############################################################################################
##
#! @Section Truncations of fp graded modules in parallel
##
##############################################################################################

InstallMethod( TruncateFPGradedModuleInParallel,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsList, IsPosInt ],
  function( variety, graded_module, degree, NrJobs )

      return FreydCategoryObject(
                TruncateGradedRowOrColumnMorphismInParallel( variety, RelationMorphism( graded_module ), degree, NrJobs ) );

end );

InstallMethod( TruncateFPGradedModuleInParallel,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsHomalgModuleElement, IsPosInt ],
  function( variety, graded_module, degree, NrJobs )

      return FreydCategoryObject(
                TruncateGradedRowOrColumnMorphismInParallel( variety, RelationMorphism( graded_module ), degree, NrJobs ) );

end );

InstallMethod( TruncateFPGradedModuleInParallel,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsList, IsPosInt, IsBool ],
  function( variety, graded_module, degree, NrJobs, display_messages )

      return FreydCategoryObject(
                TruncateGradedRowOrColumnMorphismInParallel(
                                              variety, RelationMorphism( graded_module ), degree, NrJobs, display_messages ) );

end );

InstallMethod( TruncateFPGradedModuleInParallel,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsHomalgModuleElement, IsPosInt, IsBool ],
  function( variety, graded_module, degree, NrJobs, display_messages )

      return FreydCategoryObject(
                TruncateGradedRowOrColumnMorphismInParallel(
                                             variety, RelationMorphism( graded_module ), degree, NrJobs, display_messages ) );

end );

InstallMethod( TruncateFPGradedModuleInParallel,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsList, IsPosInt, IsBool, IsFieldForHomalg ],
  function( variety, graded_module, degree, NrJobs, display_messages, rationals )

      return FreydCategoryObject(
                TruncateGradedRowOrColumnMorphismInParallel(
                                   variety, RelationMorphism( graded_module ), degree, NrJobs, display_messages, rationals ) );

end );

InstallMethod( TruncateFPGradedModuleInParallel,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsHomalgModuleElement, IsPosInt, IsBool, IsFieldForHomalg ],
  function( variety, graded_module, degree, NrJobs, display_messages, rationals )

      return FreydCategoryObject(
                TruncateGradedRowOrColumnMorphismInParallel(
                                  variety, RelationMorphism( graded_module ), degree, NrJobs, display_messages, rationals ) );

end );



##############################################################################################
##
#! @Section Truncations of fp graded module morphisms
##
##############################################################################################


InstallMethod( TruncateFPGradedModuleMorphism,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsList, IsBool, IsFieldForHomalg ],
  function( variety, graded_module_morphism, degree, display_messages, rationals )
    local source, map, range;

    # truncate source, map and range
    source := FreydCategoryObject(
                TruncateGradedRowOrColumnMorphism(
                     variety, RelationMorphism( Source( graded_module_morphism ) ), degree, display_messages, rationals ) );
    map := TruncateGradedRowOrColumnMorphism(
                     variety, MorphismDatum( graded_module_morphism ), degree, display_messages, rationals );
    range := FreydCategoryObject(
                TruncateGradedRowOrColumnMorphism(
                     variety, RelationMorphism( Range( graded_module_morphism ) ), degree, display_messages, rationals ) );

    # and return the result
    return FreydCategoryMorphism( source, map, range );

end );

InstallMethod( TruncateFPGradedModuleMorphism,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsHomalgModuleElement, IsBool, IsFieldForHomalg ],
  function( variety, graded_module_morphism, degree, display_messages, rationals )

      return TruncateFPGradedModuleMorphism( variety,
                                             graded_module_morphism,
                                             UnderlyingListOfRingElements( degree ),
                                             display_messages,
                                             rationals );

end );

InstallMethod( TruncateFPGradedModuleMorphism,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsList, IsBool ],
  function( variety, graded_module_morphism, degree, display_messages )

      return TruncateFPGradedModuleMorphism( variety,
                                             graded_module_morphism,
                                             degree,
                                             display_messages,
                                             CoefficientsRing( CoxRing( variety ) ) );

end );

InstallMethod( TruncateFPGradedModuleMorphism,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsHomalgModuleElement, IsBool ],
  function( variety, graded_module_morphism, degree, display_messages )

      return TruncateFPGradedModuleMorphism( variety,
                                             graded_module_morphism,
                                             UnderlyingListOfRingElements( degree ),
                                             display_messages,
                                             CoefficientsRing( CoxRing( variety ) ) );

end );

InstallMethod( TruncateFPGradedModuleMorphism,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsList ],
  function( variety, graded_module_morphism, degree )

      return TruncateFPGradedModuleMorphism( variety,
                                             graded_module_morphism,
                                             degree,
                                             false,
                                             CoefficientsRing( CoxRing( variety ) ) );

end );

InstallMethod( TruncateFPGradedModuleMorphism,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsHomalgModuleElement ],
  function( variety, graded_module_morphism, degree )

    return TruncateFPGradedModuleMorphism( variety,
                                           graded_module_morphism,
                                           UnderlyingListOfRingElements( degree ),
                                           false,
                                           CoefficientsRing( CoxRing( variety ) ) );

end );


##############################################################################################
##
#! @Section Truncations of fp graded module morphisms in parallel
##
##############################################################################################

InstallMethod( TruncateFPGradedModuleMorphismInParallel,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsList, IsList, IsBool, IsFieldForHomalg ],
  function( variety, graded_module_morphism, degree, NrJobs, display_messages, rationals )
    local source, map, range, gensOfSource, gensOfRange, input, job1, job2, job3, entries,
         matrix1, matrix2, matrix3, vec_space_source, vec_space_map, vec_space_range;

    # first check that the user specified meaningful NrJobs
    if not Length( NrJobs ) = 3 then
      Error( "NrJobs must be a list of 3 positive integers" );
      return;
    fi;

    if not ForAll( NrJobs, IsPosInt ) then
      Error( "NrJobs must be a list of 3 positive integers" );
      return;
    fi;

    # ( 1 ) exact the morphisms to be truncated
    source := RelationMorphism( Source( graded_module_morphism ) );
    map := MorphismDatum( graded_module_morphism );
    range := RelationMorphism( Range( graded_module_morphism ) );

    # ( 2 ) process range
    gensOfSource := GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListList( variety, Source( range ), degree );
    gensOfRange := GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListsOfRecords( variety, Range( range ), degree );

    # signal start of the matrix computation
    if display_messages then
        Print( "Compute matrix for source...\n" );
    fi;

    # truncate the mapping matrix
    if Length( gensOfSource ) = 0 then
        matrix3 := HomalgZeroMatrix( gensOfRange[ 1 ], 0, rationals );
    elif gensOfRange[ 1 ] = 0 then
        matrix3 := HomalgZeroMatrix( 0, Length( gensOfSource ), rationals );
    else

        # start a background job with this input data to obtain entries
        # this job calls a number of other jobs by itself
        if display_messages then
          Print( "Starting a background job...\n" );
        fi;

        # compute the input
        input := ComputeInput( variety, range, gensOfSource );

        # and start the background job
        # remove rationals here - i.e. write method that merely returns the entries!
        job3 := BackgroundJobByFork( TruncationParallel,
                                     [ input, gensOfRange, Length( gensOfSource ), NrJobs[ 3 ], false ],
                                     rec( TerminateImmediately := true ) );
    fi;

    # ( 3 ) process map
    gensOfSource := GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListList( variety, Source( map ), degree );
    gensOfRange := GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListsOfRecords( variety, Range( map ), degree );

    # signal start of the matrix computation
    if display_messages then
        Print( "Compute matrix for source...\n" );
    fi;

    # truncate the mapping matrix
    if Length( gensOfSource ) = 0 then
        matrix2 := HomalgZeroMatrix( gensOfRange[ 1 ], 0, rationals );
    elif gensOfRange[ 1 ] = 0 then
        matrix2 := HomalgZeroMatrix( 0, Length( gensOfSource ), rationals );
    else

        # start a background job with this input data to obtain entries
        # this job calls a number of other jobs by itself
        if display_messages then
          Print( "Starting a background job...\n" );
        fi;

        # compute the input
        input := ComputeInput( variety, map, gensOfSource );

        # and start the background job
        # remove rationals here - i.e. write method that merely returns the entries!
        job2 := BackgroundJobByFork( TruncationParallel,
                                     [ input, gensOfRange, Length( gensOfSource ), NrJobs[ 2 ], false ],
                                     rec( TerminateImmediately := true ) );
    fi;

    # ( 4 ) process source
    gensOfSource := GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListList( variety, Source( source ), degree );
    gensOfRange := GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListsOfRecords( variety, Range( source ), degree );

    # signal start of the matrix computation
    if display_messages then
        Print( "Compute matrix for source...\n" );
    fi;

    # truncate the mapping matrix
    if Length( gensOfSource ) = 0 then
        matrix1 := HomalgZeroMatrix( gensOfRange[ 1 ], 0, rationals );
    elif gensOfRange[ 1 ] = 0 then
        matrix1 := HomalgZeroMatrix( 0, Length( gensOfSource ), rationals );
    else

        # start a background job with this input data to obtain entries
        # this job calls a number of other jobs by itself
        if display_messages then
          Print( "Starting a background job...\n" );
        fi;

        # compute the input
        input := ComputeInput( variety, source, gensOfSource );

        # and start the background job
        # remove rationals here - i.e. write method that merely returns the entries!
        job1 := BackgroundJobByFork( TruncationParallel,
                                     [ input, gensOfRange, Length( gensOfSource ), NrJobs[ 1 ], false ],
                                     rec( TerminateImmediately := true ) );
    fi;

    # ( 5 ) retrieve result of job 1
    if display_messages then
        Print( "Extract result of truncation of source: \n" );
    fi;

    # extract result
    entries := Pickup( job1 );

    # check if the job completed successfully
    if entries = fail then
      Error( "Job1 completed with message 'fail'" );
    else

      if display_messages then
        Print( "(*) job1 completed successfully \n" );
      fi;

      # create the corresponding matrix
      matrix1 := CreateHomalgMatrixFromSparseString( entries[ 1 ], entries[ 2 ], entries[ 3 ], rationals );

      if display_messages then
        Print( "(*) result of job1 read \n" );
      fi;

      # and kill this job
      Kill( job1 );

      if display_messages then
        Print( "(*) job1 killed \n\n" );
      fi;

    fi;

    # ( 6 ) retrieve result of job 2
    if display_messages then
        Print( "Extract result of truncation of map: \n" );
    fi;

    # extract result
    entries := Pickup( job2 );

    # check if the job completed successfully
    if entries = fail then
      Error( "Job2 completed with message 'fail'" );
    else

      if display_messages then
        Print( "(*) job2 completed successfully \n" );
      fi;

      # create the corresponding matrix
      matrix2 := CreateHomalgMatrixFromSparseString( entries[ 1 ], entries[ 2 ], entries[ 3 ], rationals );

      if display_messages then
        Print( "(*) result of job2 read \n" );
      fi;

      # and kill this job
      Kill( job2 );

      if display_messages then
        Print( "(*) job2 killed \n\n" );
      fi;

    fi;

    # ( 7 ) retrieve result of job 3
    if display_messages then
        Print( "Extract result of truncation of range: \n" );
    fi;

    # extract result
    entries := Pickup( job3 );

    # check if the job completed successfully
    if entries = fail then
      Error( "Job3 completed with message 'fail'" );
    else

      if display_messages then
        Print( "(*) job3 completed successfully \n" );
      fi;

      # create the corresponding matrix
      matrix3 := CreateHomalgMatrixFromSparseString( entries[ 1 ], entries[ 2 ], entries[ 3 ], rationals );

      if display_messages then
        Print( "(*) result of job3 read \n" );
      fi;

      # and kill this job
      Kill( job1 );

      if display_messages then
        Print( "(*) job3 killed \n\n" );
      fi;

    fi;

    # ( 8 ) construct the morphism of vector space presentations
    vec_space_source := VectorSpaceMorphism( VectorSpaceObject( NrRows( matrix1 ), rationals ),
                                             matrix1,
                                             VectorSpaceObject( NrColumns( matrix1 ), rationals ) );
    vec_space_source := FreydCategoryObject( vec_space_source );
    vec_space_map := VectorSpaceMorphism( VectorSpaceObject( NrRows( matrix2 ), rationals ),
                                          matrix2,
                                          VectorSpaceObject( NrColumns( matrix2 ), rationals ) );
    vec_space_range := VectorSpaceMorphism( VectorSpaceObject( NrRows( matrix3 ), rationals ),
                                            matrix3,
                                            VectorSpaceObject( NrColumns( matrix3 ), rationals ) );
    vec_space_range := FreydCategoryObject( vec_space_range );

    # ( 9 ) return the result
    return FreydCategoryMorphism( vec_space_source, vec_space_map, vec_space_range );

end );
