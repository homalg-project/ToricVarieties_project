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
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsList, IsBool, IsFieldForHomalg ] );
  function( variety, graded_module_morphism, degree, display_messages, rationals )
    local source, map, range;

    # truncate source, map and range
    source := FreydCategoryObject(
                TruncateGradedRowOrColumnMorphism(
                     variety, RelationMorphism( Source( graded_module_morphism ) ), degree, display_message, rationals ) );
    map := TruncateGradedRowOrColumnMorphism( 
                     variety, MorphismDatum( graded_module_morphism ), degree, display_message, rationals );
    range := FreydCategoryObject(
                TruncateGradedRowOrColumnMorphism(
                     variety, RelationMorphism( Range( graded_module_morphism ) ), degree, display_message, rationals ) );

    # and return the result
    return FreydCategoryMorphism( source, map, range );

end );

InstallMethod( TruncateFPGradedModuleMorphism,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsHomalgModuleElement, IsBool, IsFieldForHomalg ] );
  function( variety, graded_module_morphism, degree, display_messages, rationals )

      return TruncateFPGradedModuleMorphism( variety,
                                             graded_module_morphism,
                                             UnderlyingListOfRingElements( degree ),
                                             display_messages,
                                             rationals );

end );

InstallMethod( TruncateFPGradedModuleMorphism,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsList, IsBool ] );
  function( variety, graded_module_morphism, degree, display_messages )

      return TruncateFPGradedModuleMorphism( variety,
                                             graded_module_morphism,
                                             degree,
                                             display_messages,
                                             CoefficientsRing( CoxRing( variety ) ) );

end );

InstallMethod( TruncateFPGradedModuleMorphism,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsHomalgModuleElement, IsBool ] );
  function( variety, graded_module_morphism, degree, display_messages )

      return TruncateFPGradedModuleMorphism( variety,
                                             graded_module_morphism,
                                             UnderlylingListOfRingElements( degree ),
                                             display_messages,
                                             CoefficientsRing( CoxRing( variety ) ) );

end );

InstallMethod( TruncateFPGradedModuleMorphism,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsList ] );
  function( variety, graded_module_morphism, degree, display_messages )

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
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsList, IsList, IsBool, IsFieldForHomalg ] );
  function( variety, graded_module_morphism, degree, NrJobs, display_messages, rationals )
    local source, map, range, gensOfSourceOfSource, gensOfRangeOfSource, matrix1;

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

    # (2) truncate source and range of the morphism "source"
    if display_messages then
        Print( "truncate the source... \n" );
    fi;
    gensOfSourceOfSource := GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListList( variety, Source( source ), degree );
    gensOfRangeOfSource := GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListsOfRecords( variety, Range( source ), degree );

    if display_messages then
        Print( "analyse the source morphism... \n" );
    fi;

    # (3) check for degenerate cases before we immediately set off to make a non-trivial computation
    if Length( gensOfSourceOfSource ) = 0 then #its source is the zero vector space

        matrix1 := HomalgZeroMatrix( 0, gensOfRangeOfSource[ 1 ], rationals );
        if display_messages then
          Print( "matrix 1 computed... \n" );
          Print( Concatenation( "NrRows: ", String( NrRows( matrix1 ) ), "\n" ) );
          Print( Concatenation( "NrColumns: ", String( NrColumns( matrix1 ) ), "\n \n" ) );
        fi;

    elif gensOfRangeOfSource[ 1 ] = 0 then #its range is the zero vector space

        matrix1 := HomalgZeroMatrix( Length( gensOfSourceOfSource ), 0, rationals );
        if display_messages then
          Print( "matrix 1 computed... \n" );
          Print( Concatenation( "NrRows: ", String( NrRows( matrix1 ) ), "\n" ) );
          Print( Concatenation( "NrColumns: ", String( NrColumns( matrix1 ) ), "\n \n" ) );
        fi;

    else

        # (3.1) compute input
        if display_messages then
          Print( "-> compute images... \n" );
        fi;
        input := ComputeInput( variety, source, gensOfRangeOfSource );

        # (3.2) start background jobs

        compute_job1 := true;
        if display_messages then
          Print( "-> starting background job for this truncation... \n \n" );
        fi;

        # start background job
        job1 := BackgroundJobByFork( ComputeDegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphismMinimally, 
                              [ [ input[ 1 ], gens_range_1, input[ 2 ] ], false ], rec( TerminateImmediately := true ) );

      fi;


      # step5: truncate the map morphism
      # step5: truncate the map morphism
      if display_messages then
        Print( "truncate the projective modules in the map... \n" );
      fi;
      gens_source_2 := DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListList( 
                                                       variety, Source( map ), zero );
      gens_range_2 := DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListsOfRecords(
                                                       variety, Range( map ), zero );

      if display_messages then
        Print( "analyse the map morphism... \n" );
      fi;

      # if its source is the zero vector space...
      if Length( gens_source_2 ) = 0 then

        matrix2 := HomalgZeroMatrix( 0, gens_range_2[ 1 ], rationals );
        if display_messages then
          Print( "matrix 2 computed... \n" );
          Print( Concatenation( "NrRows: ", String( NrRows( matrix2 ) ), "\n" ) );
          Print( Concatenation( "NrColumns: ", String( NrColumns( matrix2 ) ), "\n \n" ) );
        fi;

      # if its range is the zero vector space...
      elif gens_range_2[ 1 ] = 0 then

        matrix2 := HomalgZeroMatrix( Length( gens_source_2 ), 0, rationals );
        if display_messages then
          Print( "matrix 2 computed... \n" );
          Print( Concatenation( "NrRows: ", String( NrRows( matrix2 ) ), "\n" ) );
          Print( Concatenation( "NrColumns: ", String( NrColumns( matrix2 ) ), "\n \n" ) );
        fi;

      else

        # compute input
        if display_messages then
          Print( "-> compute images... \n" );
        fi;
        input := ComputeInput( variety, map, gens_source_2 );
        compute_job2 := true;
        if display_messages then
          Print( "-> starting background job for this truncation... \n \n" );
        fi;

        # start background job
        job2 := BackgroundJobByFork( ComputeDegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphismMinimally,
                              [ [ input[ 1 ], gens_range_2, input[ 2 ] ], false ], rec( TerminateImmediately := true ) );

      fi;


      # step6: truncate the range morphism
      # step6: truncate the range morphism
      if display_messages then
        Print( "truncate the projective modules in the range... \n" );
      fi;
      gens_source_3 := DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListList( 
                                                       variety, Source( range ), zero );
      gens_range_3 := gens_range_2;

      if display_messages then
        Print( "analyse the range morphism... \n" );
      fi;

      # if its source is the zero vector space...
      if Length( gens_source_3 ) = 0 then

        matrix3 := HomalgZeroMatrix( 0, gens_range_3[ 1 ], rationals );
        if display_messages then
          Print( "matrix 3 computed... \n" );
          Print( Concatenation( "NrRows: ", String( NrRows( matrix3 ) ), "\n" ) );
          Print( Concatenation( "NrColumns: ", String( NrColumns( matrix3 ) ), "\n \n" ) );
        fi;

      # if its range is the zero vector space...
      elif gens_range_3[ 1 ] = 0 then

        matrix3 := HomalgZeroMatrix( Length( gens_source_3 ), 0, rationals );
        if display_messages then
          Print( "matrix 3 computed... \n" );
          Print( Concatenation( "NrRows: ", String( NrRows( matrix3 ) ), "\n" ) );
          Print( Concatenation( "NrColumns: ", String( NrColumns( matrix3 ) ), "\n \n" ) );
        fi;

      else

        # compute input
        if display_messages then
          Print( "-> compute images... \n" );
        fi;
        input := ComputeInput( variety, range, gens_source_3 );
        compute_job3 := true;
        if display_messages then
          Print( "-> starting 3 background jobs for this truncation...\n" );
        fi;

        # determine cutoff
        if IsInt( Length( gens_source_3 ) /3 ) then
          cutoff := Length( gens_source_3 ) / 3;
        else
          cutoff := Int( Length( gens_source_3 ) / 3 ) + 1;
        fi;

        # start background job1
        job31 := BackgroundJobByFork( ComputeDegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphismMinimally,
                    [ [ input[ 1 ], gens_range_3, input[ 2 ] ], false, 1, cutoff ], rec( TerminateImmediately := true ) );
        if display_messages then
          Print( "-> job31 running... \n" );
        fi;

        # start background job2
        job32 := BackgroundJobByFork( ComputeDegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphismMinimally,
                                              [ [ input[ 1 ], gens_range_3, input[ 2 ] ], false, cutoff + 1, 2 * cutoff ],
                                                                                    rec( TerminateImmediately := true ) );
        if display_messages then
          Print( "-> job32 running... \n" );
        fi;

        # start background job3
        job33 := BackgroundJobByFork( ComputeDegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphismMinimally,
                             [ [ input[ 1 ], gens_range_3, input[ 2 ] ], false, 2 * cutoff + 1, Length( gens_source_3 ) ],
                                                                                    rec( TerminateImmediately := true ) );
        if display_messages then
          Print( "-> job33 running... \n \n" );
        fi;

      fi;


      # step7: collect result of job1 and kill this job
      # step7: collect result of job1 and kill this job
      if compute_job1 then
        if display_messages then
          Print( "extract result of job 1: \n" );
        fi;
        res := Pickup( job1 );
        if res = fail then
          Error( "job 1 completed with message 'fail' " );
        else
          if display_messages then
            Print( "(*) process completed... \n" );
            Print( "(*) result read... \n" );
          fi;
          matrix1 := CreateHomalgMatrixFromSparseString( String( res ), 
                                                         Length( gens_source_1 ), gens_range_1[ 1 ], rationals );
          if display_messages then
            Print( "(*) matrix values set... \n" );
          fi;
          Kill( job1 );
          if display_messages then
            Print( "(*) process killed \n \n" );
            Print( "matrix 1 computed \n" );
            Print( Concatenation( "(*) NrRows: ", String( NrRows( matrix1 ) ), "\n" ) );
            Print( Concatenation( "(*) NrColumns: ", String( NrColumns( matrix1 ) ), "\n \n" ) );
          fi;
        fi;
      fi;


      # step8: collect result of job2
      # step8: collect result of job2
      if compute_job2 then
        res := Pickup( job2 );
        if display_messages then
          Print( "extract result of job 2: \n" );
        fi;
        if res = fail then
          Error( "job 2 completed with message 'fail' " );
        else
          if display_messages then
            Print( "(*) process completed \n" );
            Print( "(*) result read \n" );
          fi;
          matrix2 := CreateHomalgMatrixFromSparseString( String( res ), 
                                                         Length( gens_source_2 ), gens_range_2[ 1 ], rationals );
          if display_messages then
            Print( "(*) matrix values set \n" );
          fi;
          Kill( job2 );
          if display_messages then
            Print( "(*) process killed \n \n" );
            Print( "matrix 2 computed \n" );
            Print( Concatenation( "(*) NrRows: ", String( NrRows( matrix2 ) ), "\n" ) );
            Print( Concatenation( "(*) NrColumns: ", String( NrColumns( matrix2 ) ), "\n \n" ) );
          fi;
        fi;
      fi;


      # step9: collect result of job31 and job32 and kill them
      # step9: collect result of job31 and job32 and kill them
      if compute_job3 then

        # extract result of job31 first
        if display_messages then
          Print( "extract result of job31: \n" );
        fi;
        res := Pickup( job31 );
        if res = fail then
          Error( "job31 completed with message 'fail' " );
        else
          if display_messages then
            Print( "(*) process completed \n" );
          fi;
          helper := res;
          if display_messages then
            Print( "(*) result read \n" );
          fi;
          Kill( job31 );
          if display_messages then
            Print( "(*) process killed \n \n" );
          fi;
        fi;


        # extract result of job32 next
        if display_messages then
          Print( "extract result of job32: \n" );
        fi;
        res := Pickup( job32 );
        if res = fail then
          Error( "job32 completed with message 'fail' " );
        else
          if display_messages then
            Print( "(*) process completed \n" );
          fi;
          Append( helper, res );
          if display_messages then
            Print( "(*) result read \n" );
          fi;
          Kill( job32 );
          if display_messages then
            Print( "(*) process killed \n \n" );
          fi;
        fi;

        # extract result of job33 next
        if display_messages then
          Print( "extract result of job33: \n" );
        fi;
        res := Pickup( job33 );
        if res = fail then
          Error( "job33 completed with message 'fail' " );
        else
          if display_messages then
            Print( "(*) process completed \n" );
          fi;
          Append( helper, res );
          if display_messages then
            Print( "(*) result read \n" );
          fi;
          matrix3 := CreateHomalgMatrixFromSparseString( String( helper ), 
                                                         Length( gens_source_3 ), gens_range_3[ 1 ], rationals );
          if display_messages then
            Print( "(*) matrix values set \n" );
          fi;
          Kill( job33 );
          if display_messages then
            Print( "(*) process killed \n \n" );
            Print( "matrix3 computed \n" );
            Print( Concatenation( "(*) NrRows: ", String( NrRows( matrix3 ) ), "\n" ) );
            Print( Concatenation( "(*) NrColumns: ", String( NrColumns( matrix3 ) ), "\n \n" ) );
          fi;
        fi;

      fi;

      # step 10: compute syzygies and vec_space_morphism
      # step 10: compute syzygies and vec_space_morphism
      if display_messages then
        Print( "compute syzygies and vector space morphism \n" );
      fi;

      new_mat := SyzygiesOfRows( SyzygiesOfRows( matrix2, matrix3 ), matrix1 );
      vec_space_morphism := VectorSpaceMorphism( VectorSpaceObject( NrRows( new_mat ), rationals ),
                                                 new_mat,
                                                 VectorSpaceObject( NrColumns( new_mat ), rationals )
                                                );

      # and return the result
      return vec_space_morphism;



    # (2) truncate
    source_truncated :=
                  TruncateGradedRowOrColumnMorphismInParallel( variety, source, degree, NrJobs[ 1 ], display_messages, rationals );
    map_truncated := TruncateGradedRowOrColumnMorphismInParallel( variety, map, degree, NrJobs[ 2 ], display_messages, rationals );
    range_truncated :=
                   TruncateGradedRowOrColumnMorphismInParallel( variety, range, degree, NrJobs[ 3 ], display_messages, rationals );

    # (3) return the result
    return FreydCategoryMorphism( source_truncated, map_truncated, range_truncated );

end );
