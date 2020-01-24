##########################################################################################
##
##  CohomologyWithSpasm.gi             SheafCohomologyOnToricVarieties package
##
##  Copyright 2020                     Martin Bies,       University of Oxford
##
#! @Chapter Sheaf cohomology computations (https://arxiv.org/abs/1802.08860) with Spasm
##
#########################################################################################

# This fixes the number of parallel jobs being used during the truncation
SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_FIELD_JOBS_FOR_SPASM := [ 2, 2, 3 ];

# compute H^0 by applying my theorem and using Spasm as external CAS for the truncation
InstallMethod( H0ParallelBySpasm,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsFpGradedLeftModulesObject ],
  function( variety, module_presentation )
    local ideal_infos, B_power, coker_dim;
    
    # check if the input is valid
    if not IsValidInputForCohomologyComputations( variety ) then
    
      Error( "The variety has to be smooth, complete (or simplicial, projective if you allow for lazy checks)" );
      return;
    
    fi;
    
    # Step 0: compute the vanishing sets
    if not HasVanishingSets( variety ) then
        Print( "(*) Compute vanishing sets... " );
        VanishingSets( variety );;
        Print( "finished \n" );
    else
        Print( "(*) Vanishing sets known... \n" );
    fi;
    
    # step 1: compute Betti number of the module
    if HasBettiTableForCAP( module_presentation ) then
        Print( "(*) Betti numbers of module known... \n" );
    else
        Print( "(*) Compute Betti numbers of module..." );
        BettiTableForCAP( module_presentation );;
        Print( "finished \n" );
    fi;
    
    # step 2: compute ideal B such that H0 = GradedHom( B, M )
    Print( "(*) Determine ideal... " );
    ideal_infos := FindIdeal( variety, module_presentation, 0 );
    B_power := ideal_infos[ 3 ];
    Print( Concatenation( "finished (found e = ", String( ideal_infos[ 1 ] ) , " for degree ", String( ideal_infos[ 2 ] ), ") \n" ) );
    Print( "(*) Compute GradedHom... \n\n" );
    
    # step 3: compute presentation of the truncated GradedHom by use of Spasm
    coker_dim := TOOLS_FOR_HOMALG_GET_REAL_TIME_OF_FUNCTION_CALL(
                                            TruncateIntHomToZeroInParallelBySpasm,
                                            variety,
                                            B_power,
                                            module_presentation
                                  );
    
    # step 4: inform about result
    Print( "------------------------------------------------------------------------------\n" );
    Print( Concatenation( "Found dimension of truncated GradedHom after ", String( coker_dim[ 1 ] ), " seconds. Summary: \n" ) );
    Print( Concatenation( "(*) used ideal power: ", String( ideal_infos[ 1 ] ), "\n" ) );
    Print( Concatenation( "(*) h^0 = ", String( coker_dim[ 2 ] ), "\n \n" ) );
    
    # return the result
    return [ coker_dim[ 1 ], ideal_infos[ 1 ], coker_dim[ 2 ] ];
    
end );


InstallMethod( TruncateIntHomToZeroInParallelBySpasm,
               " for a toric variety, an f.p. graded module, an f.p. graded module, a bool ",
               [ IsToricVariety, IsFpGradedLeftModulesObject, IsFpGradedLeftModulesObject ],
  function( variety, a, b )
      local degree, range, source, map, mor, matrices, i, j, entries, enti, max, min, order, prime, emb, ker_pres, ker, coker_dim;
      
      # inform about status
      Print( "Compute FpGradedModuleMorphism whose kernel is the InternalHom...\n" );
      
      # determine morphism whose kernel is the InternalHom in question
      source := InternalHomOnMorphisms( IdentityMorphism( Range( RelationMorphism( a ) ) ), RelationMorphism( b ) );
      source:= FreydCategoryObject( source );
      range := InternalHomOnMorphisms( IdentityMorphism( Source( RelationMorphism( a ) ) ), RelationMorphism( b ) );
      range := FreydCategoryObject( range );
      map := InternalHomOnMorphisms( RelationMorphism( a ), IdentityMorphism( Range( RelationMorphism( b ) ) ) );
      mor := FreydCategoryMorphism( source, map, range );
      
      # inform about status again
      Print( "Truncate it now... \n\n" );
      
      # truncate this morphism and extract the corresponding matrices
      matrices := TruncateFPGradedModuleMorphismToZeroInParallelBySpasm( variety, mor );
      
      # inform about status again
      Print( "------------------------------------------------------------------------------\n" );
      Print( "Obtained matrices defining truncated morphism - compute its kernel now... \n\n" );

      # Estimate a large enough prime number p, s.t. the computation performed by Spasm over
      # the finite field Z_p matches the result over the rational numbers
      
      Print( "(*) Identify largest and smallest entries in the matrices \n" );
      entries := [ , , ];
      for i in [ 1 .. 3 ] do
        enti := List( [ 1 .. Length( Entries( matrices[ i ] ) ) ], j -> Entries( matrices[ i ] )[ j ][ 3 ] );
        if Length( enti ) = 0 then
          enti := [ 0 ];
        fi;
        entries[ i ] := enti;
      od;
      max := [ Maximum( entries[ 1 ] ), Maximum( entries[ 2 ] ), Maximum( entries[ 3 ] ) ];
      max := Maximum( max );
      min := [ Minimum( entries[ 1 ] ), Minimum( entries[ 2 ] ), Minimum( entries[ 3 ] ) ];
      min := Minimum( min );
      
      order := ( max - min ) * ( NumberOfRows( matrices[ 1 ] ) + NumberOfRows( matrices[ 2 ] ) + NumberOfRows( matrices[ 3 ] ) );
      Print( Concatenation( "(*) Estimate prime to be larger than ", String( order ), "\n" ) );
      
      if order < 42013 then
        prime := 42013;
      else
        prime := NextPrimeInt( order );
      fi;
      Print( Concatenation( "(*) Perform syzygies computation modulo p = ", String( prime ), "\n\n" ) );
      
      # compute KernelEmbedding
      emb := SyzygiesGenerators( matrices[ 2 ], matrices[ 3 ], prime );
      ker_pres := SyzygiesGenerators( emb, matrices[ 1 ], prime );
      
      # inform about status again
      Print( "------------------------------------------------------------------------------\n" );
      Print( "Obtained presentation of kernel - compute its dimension now... \n" );
      Print( Concatenation( "(We issue this computation to be performed in the finite field over prime p = ", String( prime ), ") \n\n" ) );
      
      # compute dimension of the cokernel
      ker := SyzygiesOfRowsBySpasm( ker_pres, prime );
      coker_dim := NumberOfColumns( ker_pres ) - NumberOfRows( ker_pres ) + NumberOfRows( ker );
      
      # return this dimension of the cokernel
      return coker_dim;
      
end );


InstallMethod( TruncateFPGradedModuleMorphismToZeroInParallelBySpasm,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftModulesMorphism ],
  function( variety, graded_module_morphism )
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
    Print( "Compute matrix for range...\n" );
    Print( Concatenation( "Size: ", String( Length( gensOfSource ) ) ,"x", String( gensOfRange[ 1 ] ), "\n" ) );

    # initialise run3
    run3 := false;

    # truncate the mapping matrix
    if Length( gensOfSource ) = 0 then
        matrix3 := SMSSparseMatrix( 0, gensOfRange[ 1 ], [] );
        Print( "Result trivially obtained..." );
    elif gensOfRange[ 1 ] = 0 then
        matrix3 := SMSSparseMatrix( Length( gensOfSource ), 0, [] );
        Print( "Result trivially obtained..." );
    else

        # start a background job with this input data to obtain entries
        # this job calls a number of other jobs by itself
        Print( Concatenation( "Starting ", String( NrJobs[ 3 ] ), " background jobs..." ) );

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
    Print( "\n\n" );

    # ( 3 ) process map
    gensOfSource := GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListList( variety, Source( map ), degree );
    gensOfRange := GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListsOfRecords( variety, Range( map ), degree );

    # signal start of the matrix computation
    Print( "Compute matrix for map...\n" );
    Print( Concatenation( "Size: ", String( Length( gensOfSource ) ) ,"x", String( gensOfRange[ 1 ] ), "\n" ) );

    # initalise run2
    run2 := false;

    # truncate the mapping matrix
    if Length( gensOfSource ) = 0 then
        matrix2 := SMSSparseMatrix( 0, gensOfRange[ 1 ], [] );
        Print( "Result trivially obtained..." );
    elif gensOfRange[ 1 ] = 0 then
        matrix2 := SMSSparseMatrix( Length( gensOfSource ), 0, [] );
        Print( "Result trivially obtained..." );
    else

        # start a background job with this input data to obtain entries
        # this job calls a number of other jobs by itself
        Print( Concatenation( "Starting ", String( NrJobs[ 2 ] ), " background jobs..." ) );

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
    Print( "\n\n" );

    # ( 4 ) process source
    gensOfSource := GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListList( variety, Source( source ), degree );
    gensOfRange := GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListsOfRecords( variety, Range( source ), degree );

    # signal start of the matrix computation
    Print( "Compute matrix for source...\n" );
    Print( Concatenation( "Size: ", String( Length( gensOfSource ) ) ,"x", String( gensOfRange[ 1 ] ), "\n" ) );

    # initialise run1
    run1 := false;

    # truncate the mapping matrix
    if Length( gensOfSource ) = 0 then
        matrix1 := SMSSparseMatrix( 0, gensOfRange[ 1 ], [] );
        Print( "Result trivially obtained..." );
    elif gensOfRange[ 1 ] = 0 then
        matrix1 := SMSSparseMatrix( Length( gensOfSource ), 0, [] );
        Print( "Result trivially obtained..." );
    else

        # start a background job with this input data to obtain entries
        # this job calls a number of other jobs by itself
        Print( Concatenation( "Starting ", String( NrJobs[ 1 ] ), " background jobs..." ) );

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
    Print( "\n\n" );

    # ( 5 ) retrieve result of job 1
    if run1 then
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

            # inform about status
            Print( "(*) job1 completed successfully \n" );

            # create the corresponding matrix
            matrix1 := SMSSparseMatrix( entries[ 2 ], entries[ 3 ], entries[ 1 ] );
            Print( "(*) result of job1 read \n" );

            # and kill this job
            Kill( job1 );
            Print( "(*) job1 killed \n\n" );

        fi;

    fi;

    # ( 6 ) retrieve result of job 2
    if run2 then
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

            # inform about status
            Print( "(*) job2 completed successfully \n" );

            # create the corresponding matrix
            matrix2 := SMSSparseMatrix( entries[ 2 ], entries[ 3 ], entries[ 1 ] );
            Print( "(*) result of job2 read \n" );

            # and kill this job
            Kill( job2 );
            Print( "(*) job2 killed \n\n" );

        fi;

    fi;

    # ( 7 ) retrieve result of job 3
    if run3 then
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

            # inform about status
            Print( "(*) job3 completed successfully \n" );

            # create the corresponding matrix
            matrix3 := SMSSparseMatrix( entries[ 2 ], entries[ 3 ], entries[ 1 ] );
            Print( "(*) result of job3 read \n" );

            # and kill this job
            Kill( job3 );
            Print( "(*) job3 killed \n\n" );

        fi;

    fi;

    # return the matrices matrix1, matrix2, matrix3
    return [ matrix1, matrix2, matrix3 ];

end );
