##########################################################################################
##
##  TruncationsOfFPGradedModules.gi    TruncationsOfFPGradedModules package
##
##  Copyright 2020                     Martin Bies,    University of Oxford
##
##  Truncations of f.p. graded modules
##
#########################################################################################


##############################################################################################
##
## Section Truncations of fp graded modules
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
## Section Truncations of fp graded modules in parallel
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
## Section Truncations of fp graded module morphisms
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
## Section Truncations of fp graded module morphisms in parallel
##
##############################################################################################

InstallMethod( TruncateFPGradedModuleMorphismInParallel,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsList, IsList, IsBool, IsFieldForHomalg ],
  function( variety, graded_module_morphism, degree, NrJobs, display_messages, rationals )
    local source, map, range, gensOfSource, gensOfRange, input, job1, job2, job3, run1, run2, run3, entries,
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
        Print( "Compute matrix for range...\n" );
        Print( Concatenation( "Size: ", String( Length( gensOfSource ) ) ,"x", String( gensOfRange[ 1 ] ), "\n" ) );
    fi;

    # initialise run3
    run3 := false;

    # truncate the mapping matrix
    if Length( gensOfSource ) = 0 then
        matrix3 := HomalgZeroMatrix( 0, gensOfRange[ 1 ], rationals );
        if display_messages then
          Print( "Result trivially obtained..." );
        fi;
    elif gensOfRange[ 1 ] = 0 then
        matrix3 := HomalgZeroMatrix( Length( gensOfSource ), 0, rationals );
        if display_messages then
          Print( "Result trivially obtained..." );
        fi;
    else

        # start a background job with this input data to obtain entries
        # this job calls a number of other jobs by itself
        if display_messages then
          Print( Concatenation( "Starting ", String( NrJobs[ 3 ] ), " background jobs..." ) );
        fi;

        # compute the input
        input := ComputeInput( variety, range, gensOfSource );

        # and start the background job
        # remove rationals here - i.e. write method that merely returns the entries!
        job3 := BackgroundJobByFork( TruncationParallel,
                                     [ input, gensOfRange, Length( gensOfSource ), NrJobs[ 3 ], false ],
                                     rec( TerminateImmediately := true ) );

        # remember that this job is running
        run3 := true;

    fi;
    if display_messages then
        Print( "\n\n" );
    fi;

    # ( 3 ) process map
    gensOfSource := GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListList( variety, Source( map ), degree );
    gensOfRange := GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListsOfRecords( variety, Range( map ), degree );

    # signal start of the matrix computation
    if display_messages then
        Print( "Compute matrix for map...\n" );
        Print( Concatenation( "Size: ", String( Length( gensOfSource ) ) ,"x", String( gensOfRange[ 1 ] ), "\n" ) );
    fi;

    # initalise run2
    run2 := false;

    # truncate the mapping matrix
    if Length( gensOfSource ) = 0 then
        matrix2 := HomalgZeroMatrix( 0, gensOfRange[ 1 ], rationals );
        if display_messages then
          Print( "Result trivially obtained..." );
        fi;
    elif gensOfRange[ 1 ] = 0 then
        matrix2 := HomalgZeroMatrix( Length( gensOfSource ), 0, rationals );
        if display_messages then
          Print( "Result trivially obtained..." );
        fi;
    else

        # start a background job with this input data to obtain entries
        # this job calls a number of other jobs by itself
        if display_messages then
          Print( Concatenation( "Starting ", String( NrJobs[ 2 ] ), " background jobs..." ) );
        fi;

        # compute the input
        input := ComputeInput( variety, map, gensOfSource );

        # and start the background job
        # remove rationals here - i.e. write method that merely returns the entries!
        job2 := BackgroundJobByFork( TruncationParallel,
                                     [ input, gensOfRange, Length( gensOfSource ), NrJobs[ 2 ], false ],
                                     rec( TerminateImmediately := true ) );

        # remember that this job is running
        run2 := true;

    fi;
    if display_messages then
        Print( "\n\n" );
    fi;

    # ( 4 ) process source
    gensOfSource := GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListList( variety, Source( source ), degree );
    gensOfRange := GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListsOfRecords( variety, Range( source ), degree );

    # signal start of the matrix computation
    if display_messages then
        Print( "Compute matrix for source...\n" );
        Print( Concatenation( "Size: ", String( Length( gensOfSource ) ) ,"x", String( gensOfRange[ 1 ] ), "\n" ) );
    fi;

    # initialise run1
    run1 := false;

    # truncate the mapping matrix
    if Length( gensOfSource ) = 0 then
        matrix1 := HomalgZeroMatrix( 0, gensOfRange[ 1 ], rationals );
        if display_messages then
          Print( "Result trivially obtained..." );
        fi;
    elif gensOfRange[ 1 ] = 0 then
        matrix1 := HomalgZeroMatrix( Length( gensOfSource ), 0, rationals );
        if display_messages then
          Print( "Result trivially obtained..." );
        fi;
    else

        # start a background job with this input data to obtain entries
        # this job calls a number of other jobs by itself
        if display_messages then
          Print( Concatenation( "Starting ", String( NrJobs[ 1 ] ), " background jobs..." ) );
        fi;

        # compute the input
        input := ComputeInput( variety, source, gensOfSource );

        # and start the background job
        # remove rationals here - i.e. write method that merely returns the entries!
        job1 := BackgroundJobByFork( TruncationParallel,
                                     [ input, gensOfRange, Length( gensOfSource ), NrJobs[ 1 ], false ],
                                     rec( TerminateImmediately := true ) );

        # remember that this job is running
        run1 := true;

    fi;
    if display_messages then
        Print( "\n\n" );
    fi;

    # ( 5 ) retrieve result of job 1
    if display_messages and run1 then
        Print( "Extract result of truncation of source: \n" );
    fi;

    # only perform actions with job1 if it is running
    if run1 then

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
            matrix1 := CreateHomalgMatrixFromSparseString( String( entries[ 1 ] ), entries[ 2 ], entries[ 3 ], rationals );

            if display_messages then
                Print( "(*) result of job1 read \n" );
            fi;

            # and kill this job
            Kill( job1 );

            if display_messages then
                Print( "(*) job1 killed \n\n" );
            fi;

        fi;

    fi;

    # ( 6 ) retrieve result of job 2
    if display_messages and run2 then
        Print( "Extract result of truncation of map: \n" );
    fi;

    # only perform actions with job2 if it is running
    if run2 then

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
            matrix2 := CreateHomalgMatrixFromSparseString( String( entries[ 1 ] ), entries[ 2 ], entries[ 3 ], rationals );

            if display_messages then
                Print( "(*) result of job2 read \n" );
            fi;

            # and kill this job
            Kill( job2 );

            if display_messages then
                Print( "(*) job2 killed \n\n" );
            fi;

        fi;

    fi;

    # ( 7 ) retrieve result of job 3
    if display_messages and run3 then
        Print( "Extract result of truncation of range: \n" );
    fi;

    # only perform actions with job1 if it is running
    if run3 then

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
            matrix3 := CreateHomalgMatrixFromSparseString( String( entries[ 1 ] ), entries[ 2 ], entries[ 3 ], rationals );

            if display_messages then
                Print( "(*) result of job3 read \n" );
            fi;

            # and kill this job
            Kill( job3 );

            if display_messages then
                Print( "(*) job3 killed \n\n" );
            fi;

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

InstallMethod( TruncateFPGradedModuleMorphismInParallel,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsHomalgModuleElement, IsList, IsBool, IsFieldForHomalg ],
  function( variety, graded_module_morphism, degree, NrJobs, display_messages, rationals )

     return TruncateFPGradedModuleMorphismInParallel( 
                  variety, graded_module_morphism, UnderlyingListOfRingElements( degree ), NrJobs, display_messages, rationals );

end );

InstallMethod( TruncateFPGradedModuleMorphismInParallel,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsList, IsList, IsBool ],
  function( variety, graded_module_morphism, degree, NrJobs, display_messages )

     return TruncateFPGradedModuleMorphismInParallel(
                  variety, graded_module_morphism, degree, NrJobs, display_messages, 
                  CoefficientsRing( CoxRing( variety ) ) );

end );

InstallMethod( TruncateFPGradedModuleMorphismInParallel,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsHomalgModuleElement, IsList, IsBool ],
  function( variety, graded_module_morphism, degree, NrJobs, display_messages )

     return TruncateFPGradedModuleMorphismInParallel(
                  variety, graded_module_morphism, UnderlyingListOfRingElements( degree ), NrJobs, display_messages, 
                  CoefficientsRing( CoxRing( variety ) ) );

end );

InstallMethod( TruncateFPGradedModuleMorphismInParallel,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsList, IsList ],
  function( variety, graded_module_morphism, degree, NrJobs )

     return TruncateFPGradedModuleMorphismInParallel(
                  variety, graded_module_morphism, degree, NrJobs, false, CoefficientsRing( CoxRing( variety ) ) );

end );

InstallMethod( TruncateFPGradedModuleMorphismInParallel,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsHomalgModuleElement, IsList ],
  function( variety, graded_module_morphism, degree, NrJobs )

     return TruncateFPGradedModuleMorphismInParallel(
                  variety, graded_module_morphism, UnderlyingListOfRingElements( degree ), NrJobs, false,
                  CoefficientsRing( CoxRing( variety ) ) );

end );
