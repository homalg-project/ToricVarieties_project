##########################################################################################
##
##  CohomologyWithSpasm.gi             SheafCohomologyOnToricVarieties package
##
##  Copyright 2020                     Martin Bies,       University of Oxford
##
#! @Chapter Sheaf cohomology computations (https://arxiv.org/abs/1802.08860) with Spasm
##
#########################################################################################


#############################################################
##
#! @Section Cohomology from Spasm, Linbox and Singular
##
#############################################################


# compute H^0 by applying my theorem and using Spasm as external CAS for the truncation
InstallMethod( H0ParallelBySpasm,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject ],
  function( variety, module_presentation )
    
    return H0ParallelBySpasmAndLinbox( variety, module_presentation, 42013, true, false );
    
end );

# compute H^0 by applying my theorem and using Spasm as external CAS for the truncation
InstallMethod( H0ParallelBySpasm,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsInt ],
  function( variety, module_presentation, p )
    
    return H0ParallelBySpasmAndLinbox( variety, module_presentation, p, true, false );
    
end );

# compute H^0 by applying my theorem and using Spasm as external CAS for the truncation and perform check with linbox
InstallMethod( H0ParallelBySpasmAndLinboxCheck,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject ],
  function( variety, module_presentation )
    
    return H0ParallelBySpasmAndLinbox( variety, module_presentation, 42013, true, true );
    
end );

# compute H^0 by applying my theorem and using Spasm as external CAS for the truncation  and perform check with linbox
InstallMethod( H0ParallelBySpasmAndLinboxCheck,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsInt ],
  function( variety, module_presentation, p )
    
    return H0ParallelBySpasmAndLinbox( variety, module_presentation, p, true, true );
    
end );


# compute H^0 by applying my theorem and using Spasm as external CAS for the truncation
InstallMethod( H0ParallelBySpasmAndLinbox,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsInt, IsBool, IsBool ],
  function( variety, module_presentation, p, display_messages, linbox_check )
    local prime, ideal_infos, B_power, coker_dim;
    
    # check if the input is valid
    if not IsValidInputForCohomologyComputations( variety ) then
    
      Error( "The variety has to be smooth, complete (or simplicial, projective if you allow for lazy checks)" );
      return;
    
    fi;
    
    if not p > 0 then
        Error( "Specified prime must be positive" );
        return;
    fi;
    
    if not IsPrimeInt( p ) then
        prime := NextPrimeInt( p );
    else
        prime := p;
    fi;
    
    # Step 0: compute the vanishing sets
    if not HasVanishingSets( variety ) then
        if display_messages then
            Print( "(*) Compute vanishing sets... " );
        fi;
        VanishingSets( variety );;
        if display_messages then
            Print( "finished \n" );
        fi;
    else
        if display_messages then
            Print( "(*) Vanishing sets known... \n" );
        fi;
    fi;
    
    # step 1: compute Betti number of the module
    if HasBettiTableForCAP( module_presentation ) then
        if display_messages then
            Print( "(*) Betti numbers of module known... \n" );
        fi;
    else
        if display_messages then
            Print( "(*) Compute Betti numbers of module..." );
        fi;
        BettiTableForCAP( module_presentation );;
        if display_messages then
            Print( "finished \n" );
        fi;
    fi;
    
    # step 2: compute ideal B such that H0 = GradedHom( B, M )
    if display_messages then
        Print( "(*) Determine ideal... " );
    fi;
    if IsFpGradedLeftModulesObject( module_presentation ) then
        ideal_infos := FindLeftIdeal( variety, module_presentation, 0 );
    else
        ideal_infos := FindRightIdeal( variety, module_presentation, 0 );
    fi;
    B_power := ideal_infos[ 3 ];
    if display_messages then
        Print( Concatenation( "finished (found e = ", String( ideal_infos[ 1 ] ) , " for degree ", String( ideal_infos[ 2 ] ), ") \n" ) );
        Print( "(*) Compute GradedHom... \n\n" );
    fi;
    
    # step 3: compute presentation of the truncated GradedHom by use of Spasm
    coker_dim := TOOLS_FOR_HOMALG_GET_REAL_TIME_OF_FUNCTION_CALL(
                                            TruncateIntHomToZeroInParallelBySpasm,
                                            variety,
                                            B_power,
                                            module_presentation,
                                            prime,
                                            display_messages,
                                            linbox_check
                                  );
    
    # step 4: inform about result
    if display_messages then
        Print( "------------------------------------------------------------------------------\n" );
        Print( Concatenation( "Found dimension of truncated GradedHom after ", String( coker_dim[ 1 ] ), " seconds. Summary: \n" ) );
        Print( Concatenation( "(*) used ideal power: ", String( ideal_infos[ 1 ] ), "\n" ) );
        Print( Concatenation( "(*) h^0 = ", String( coker_dim[ 2 ] ), "\n \n" ) );
    fi;
    
    # return the result
    return [ coker_dim[ 1 ], ideal_infos[ 1 ], coker_dim[ 2 ] ];
    
end );





#############################################################
##
#! @Section Computation of truncated internal hom
##
#############################################################

InstallMethod( TruncateIntHomToZeroInParallelBySpasm,
               " for a toric variety, an f.p. graded module, an f.p. graded module, a bool ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsInt, IsBool, IsBool ],
  function( variety, a, b, prime, display_messages, linbox_check )
      local range, source, map, mor, matrices, rows, cols, sparse, emb, rank_Linbox, ker_pres, rk, coker_dim, checks, ranks;
      
      # inform about status
      if display_messages then
        Print( "Compute FpGradedModuleMorphism whose kernel is the InternalHom...\n" );
      fi;
      
      # determine morphism whose kernel is the InternalHom in question
      source := InternalHomOnMorphisms( IdentityMorphism( Range( RelationMorphism( a ) ) ), RelationMorphism( b ) );
      source:= FreydCategoryObject( source );
      range := InternalHomOnMorphisms( IdentityMorphism( Source( RelationMorphism( a ) ) ), RelationMorphism( b ) );
      range := FreydCategoryObject( range );
      map := InternalHomOnMorphisms( RelationMorphism( a ), IdentityMorphism( Range( RelationMorphism( b ) ) ) );
      mor := FreydCategoryMorphism( source, map, range );
      
      # inform about status again
      if display_messages then
        Print( "Truncate it now... \n\n" );
      fi;
      
      # truncate this morphism and extract the corresponding matrices
      matrices := TruncateFPGradedModuleMorphismToZeroInParallelToSparseMatrices( variety, mor, display_messages );
      
      # initialise results of checks;
      checks := [ false, false, false ];
      ranks := [ 0,0,0 ];
      
      # inform about status again
      if display_messages then
        Print( "------------------------------------------------------------------------------\n" );
        Print( Concatenation( "Obtained matrices defining truncated morphism - compute kernel presentation modulo p = ", String( prime ), "\n\n" ) );
      fi;
      
      if display_messages then
        Print( "(*) Analyse first syzygies computation \n" );
      fi;
      rows := NumberOfRows( matrices[ 2 ] ) + NumberOfRows( matrices[ 3 ] );
      cols := NumberOfRows( matrices[ 2 ] );
      if display_messages then
        Print( Concatenation( "(*) Matrix to be considered: ", String( rows ), " x ", String( cols ),  "\n" ) );
      fi;
      if rows * cols <> 0 then
        sparse := ( Length( Entries( matrices[ 2 ] ) ) + Length( Entries( matrices[ 3 ] ) ) ) / ( rows * cols );
        if display_messages then
            Print( Concatenation( "(*) Sparseness: ", String( Float( 100 * sparse ) ), "%\n" ) );
        fi;
      fi;
      if display_messages then
        Print( "(*) Perform syzygies computation...\n\n" );
      fi;
      emb := RowSyzygiesGeneratorsBySpasm( matrices[ 2 ], matrices[ 3 ], prime );
      if linbox_check then
        if display_messages then
            Print( "\n" );
            Print( "(*) Check rank with Linbox..." );
        fi;
        rank_Linbox := RankByLinbox( UnionOfRowsOp( matrices[ 2 ], matrices[ 3 ] ) );
        ranks[ 1 ] := rank_Linbox;
        if ( NumberOfRows( emb ) <> NumberOfRows( matrices[ 2 ] ) + NumberOfRows( matrices[ 3 ] ) - rank_Linbox ) then
            Print( "failed\n" );
        elif display_messages then
            Print( "success\n" );
            checks[ 1 ] := true;
        fi;
      fi;
      
      if display_messages then
        Print( "\n" );
        Print( "(*) Analyse second syzygies computation \n" );
      fi;
      rows := NumberOfRows( matrices[ 1 ] ) + NumberOfRows( emb );
      cols := NumberOfRows( matrices[ 1 ] );
      if display_messages then
        Print( Concatenation( "(*) Matrix to be considered: ", String( rows ), " x ", String( cols ),  "\n" ) );
      fi;
      if rows * cols <> 0 then
        sparse := ( Length( Entries( matrices[ 1 ] ) ) + Length( Entries( emb ) ) ) / ( rows * cols );
        if display_messages then
            Print( Concatenation( "(*) Sparseness: ", String( Float( 100 * sparse ) ),"%\n" ) );
        fi;
      fi;
      if display_messages then
        Print( "(*) Perform syzygies computation...\n\n" );
      fi;
      ker_pres := RowSyzygiesGeneratorsBySpasm( emb, matrices[ 1 ], prime );
      if linbox_check then
        if display_messages then
            Print( "(*) Check rank with Linbox..." );
        fi;
        rank_Linbox := RankByLinbox( UnionOfRowsOp( emb, matrices[ 1 ] ) );
        ranks[ 2 ] := rank_Linbox;
        if ( NumberOfRows( ker_pres ) <> NumberOfRows( emb ) + NumberOfRows( matrices[ 1 ] ) - rank_Linbox ) then
            Print( "failed\n\n" );
        elif display_messages then
            Print( "success\n\n" );
            checks[ 2 ] := true;
        fi;
      fi;
      
      # inform about status again
      if display_messages then
        Print( "------------------------------------------------------------------------------\n" );
        Print( "Obtained presentation of kernel - compute its dimension... \n\n" );
      fi;
      
      if NumberOfRows( ker_pres ) = 0 then
        rk := 0;
        if display_messages then
            Print( "(*) Rank trivially obtained\n\n" );
            checks[ 3 ] := true;
        fi;
      else
        rk := RankGPLUBySpasm( ker_pres, prime );
        if linbox_check then
            if display_messages then
                Print( "(*) Check rank with Linbox..." );
            fi;
            rank_Linbox := RankByLinbox( ker_pres );
            ranks[ 3 ] := rank_Linbox;
            if ( rk <> rank_Linbox ) then
                Print( "failed\n\n" );
            elif display_messages then
                Print( "success\n\n" );
                checks[ 3 ] := true;
            fi;
        fi;
      fi;
      
      # print results of checks
      if display_messages and linbox_check then
        
        Print( "--------------------------------------------------" );
        Print( "Tests with linbox performed\n\n" );
        Print( "Test 1: \n" );
        Print( Concatenation( "Rank by linbox: ", String( ranks[ 1 ] ), "\n" ) );
        Print( Concatenation( "Rank by spasm: ", String( NumberOfRows( matrices[ 2 ] ) + NumberOfRows( matrices[ 3 ] ) - NumberOfRows( emb ) ), "\n" ) );
        if checks[ 1 ] then
            Print( "Test passed \n\n" );
        else
            Print( "Test failed \n\n" );
        fi;
        
        Print( "Test 2: \n" );
        Print( Concatenation( "Rank by linbox: ", String( ranks[ 2 ] ), "\n" ) );
        Print( Concatenation( "Rank by spasm: ", String( NumberOfRows( emb ) + NumberOfRows( matrices[ 1 ] ) - NumberOfRows( ker_pres ) ), "\n" ) );
        if checks[ 2 ] then
            Print( "Test passed \n\n" );
        else
            Print( "Test failed \n\n" );
        fi;
        
        Print( "Test 3: \n" );
        Print( Concatenation( "Rank by linbox: ", String( ranks[ 3 ] ), "\n" ) );
        Print( Concatenation( "Rank by spasm: ", String( rk ), "\n" ) );
        if checks[ 3 ] then
            Print( "Test passed \n\n" );
        else
            Print( "Test failed \n\n" );
        fi;
        
      fi;
      
      # return result
      return NumberOfColumns( ker_pres ) - rk;
      
end );


#############################################################
##
#! @Section Truncation to sparse matrices
##
#############################################################

# This fixes the number of parallel jobs being used during the truncation
SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_FIELD_JOBS_FOR_SPASM := [ 2, 2, 3 ];

InstallMethod( TruncateFPGradedModuleMorphismToZeroInParallelToSparseMatrices,
               " a toric variety, an f.p. graded module, and a boolian",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsBool ],
  function( variety, graded_module_morphism, display_messages )
    local rationals, degree, NrJobs, source, map, range, gensOfSource, gensOfRange, input, job1, job2, job3, run1, run2, run3, entries,
         matrix1, matrix2, matrix3;

    # make a selection of CAS for the computation of the images
    rationals := SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_FIELD;
    degree := UnderlyingListOfRingElements( TheZeroElement( DegreeGroup( CoxRing( variety ) ) ) );
    NrJobs := SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_FIELD_JOBS_FOR_SPASM;

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
        matrix3 := SMSSparseMatrix( 0, gensOfRange[ 1 ], [] );
        if display_messages then
            Print( "Result trivially obtained..." );
        fi;
    elif gensOfRange[ 1 ] = 0 then
        matrix3 := SMSSparseMatrix( Length( gensOfSource ), 0, [] );
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
        matrix2 := SMSSparseMatrix( 0, gensOfRange[ 1 ], [] );
        if display_messages then
            Print( "Result trivially obtained..." );
        fi;
    elif gensOfRange[ 1 ] = 0 then
        matrix2 := SMSSparseMatrix( Length( gensOfSource ), 0, [] );
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
        matrix1 := SMSSparseMatrix( 0, gensOfRange[ 1 ], [] );
        if display_messages then
            Print( "Result trivially obtained..." );
        fi;
    elif gensOfRange[ 1 ] = 0 then
        matrix1 := SMSSparseMatrix( Length( gensOfSource ), 0, [] );
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
    if run1 then
        if display_messages then
            Print( "Extract result of truncation of source: \n" );
        fi;
    fi;

    # only perform actions with job1 if it is running
    if run1 then

        # extract result
        entries := Pickup( job1 );

        # check if the job completed successfully
        if entries = fail then
            Error( "Job1 completed with message 'fail'" );
        else

            # inform about status
            if display_messages then
                Print( "(*) job1 completed successfully \n" );
            fi;

            # create the corresponding matrix
            matrix1 := SMSSparseMatrix( entries[ 2 ], entries[ 3 ], entries[ 1 ] );
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
    if run2 then
        if display_messages then
            Print( "Extract result of truncation of map: \n" );
        fi;
    fi;

    # only perform actions with job2 if it is running
    if run2 then

        # extract result
        entries := Pickup( job2 );

        # check if the job completed successfully
        if entries = fail then
            Error( "Job2 completed with message 'fail'" );
        else

            # inform about status
            if display_messages then
                Print( "(*) job2 completed successfully \n" );
            fi;

            # create the corresponding matrix
            matrix2 := SMSSparseMatrix( entries[ 2 ], entries[ 3 ], entries[ 1 ] );
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
    if run3 then
        if display_messages then
            Print( "Extract result of truncation of range: \n" );
        fi;
    fi;

    # only perform actions with job1 if it is running
    if run3 then

        # extract result
        entries := Pickup( job3 );

        # check if the job completed successfully
        if entries = fail then
            Error( "Job3 completed with message 'fail'" );
        else

            # inform about status
            if display_messages then
                Print( "(*) job3 completed successfully \n" );
            fi;

            # create the corresponding matrix
            matrix3 := SMSSparseMatrix( entries[ 2 ], entries[ 3 ], entries[ 1 ] );
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

    # return the matrices matrix1, matrix2, matrix3
    return [ matrix1, matrix2, matrix3 ];

end );
