##########################################################################################
##
##  CohomologyFromMyTheorem.gi         SheafCohomologyOnToricVarieties package
##
##  Copyright 2016                     Martin Bies,       ITP Heidelberg
##
#! @Chapter Sheaf cohomology via my cohomology theorem
##
#########################################################################################



#############################################################
##
## Section Specialised GradedHom methods
##
#############################################################

InstallMethod( InternalHomDegreeZeroOnObjects,
               " for a toric variety, a f.p. graded left S-module, a f.p. graded left S-module",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsGradedLeftOrRightModulePresentationForCAP, IsBool ],
  function( variety, a, b, display_messages )
      local range, source, map, Q, matrix1, matrix2, matrix3, new_mat, vec_space_morphism;

      # Let a = ( R_A --- alpha ---> A ) and b = (R_B --- beta ---> B ). Then we have to compute the kernel embedding of the
      # following map:
      #
      # A^v \otimes R_B -----------alpha^v \otimes id_{R_B} --------------> R_A^v \otimes R_B
      #       |                                                                      |
      #       |                                                                      |
      # id_{A^v} \otimes beta                                            id_{R_A^v} \otimes beta
      #       |                                                                      |
      #       v                                                                      v
      # A^v \otimes B -------------- alpha^v \otimes id_B -------------------> R_A^v \otimes B
      #

      # compute the map or graded module preseentations
      if display_messages then
        Print( Concatenation( "We will now compute the map of graded module presentations, ",
                              "whose kernel is the InternalHOM that we are interested in... \n" ) );
      fi;
      range := CAPPresentationCategoryObject( TensorProductOnMorphisms(
                                                      IdentityMorphism( DualOnObjects( Source( UnderlyingMorphism( a ) ) ) ),
                                                      UnderlyingMorphism( b ) )
                                                      );
      source := CAPPresentationCategoryObject( TensorProductOnMorphisms(
                                                      IdentityMorphism( DualOnObjects( Range( UnderlyingMorphism( a ) ) ) ),
                                                      UnderlyingMorphism( b ) )
                                                      );
      map := TensorProductOnMorphisms( DualOnMorphisms( UnderlyingMorphism( a ) ),
                                       IdentityMorphism( Range( UnderlyingMorphism( b ) ) )
                                      );


      # inform that we have the graded module presentation morphism and will now try to truncate it
      if display_messages then
        Print( "Computed the map of graded module presentations. Will now truncate it... \n" );
      fi;

      # -> parallisation if possible! (speed up of up to factor 3 for this step)
      Q := HomalgFieldOfRationalsInMAGMA();

      matrix1 := UnderlyingMatrix( UnderlyingVectorSpaceMorphism( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                                                          variety,
                                                                          UnderlyingMorphism( source ),
                                                                          TheZeroElement( DegreeGroup( CoxRing( variety ) ) ),
                                                                          Q,
                                                                          display_messages
                                                                          ) ) );
      if display_messages then
        Print( "\n \n" );
      fi;

      # if the source is isomorphic to the zero_vector_space, then also H0 will be zero
      if NrColumns( matrix1 ) = 0 then
        if display_messages then
          Print( "Syzygies computed, now computing the dimension of the cokernel object... \n" );
        fi;
        return ZeroMorphism( ZeroObject( CapCategory( VectorSpaceObject( 0, Q ) ) ), VectorSpaceObject( 0, Q ) );
      elif NrColumns( matrix1 ) - ColumnRankOfMatrix( matrix1 ) = 0 then
        if display_messages then
        Print( "Syzygies computed, now computing the dimension of the cokernel object... \n" );
        fi;
        return ZeroMorphism( ZeroObject( CapCategory( VectorSpaceObject( 0, Q ) ) ), VectorSpaceObject( 0, Q ) );
      fi;

      # otherwise also compute the other matrices
      matrix2 := UnderlyingMatrix( UnderlyingVectorSpaceMorphism( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                                                          variety,
                                                                          map,
                                                                          TheZeroElement( DegreeGroup( CoxRing( variety ) ) ),
                                                                          Q,
                                                                          display_messages
                                                                          ) ) );
      if display_messages then
        Print( "\n \n" );
      fi;

      matrix3 := UnderlyingMatrix( UnderlyingVectorSpaceMorphism( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                                                          variety,
                                                                          UnderlyingMorphism( range ),
                                                                          TheZeroElement( DegreeGroup( CoxRing( variety ) ) ),
                                                                          Q,
                                                                          display_messages
                                                                          ) ) );

      if display_messages then
        Print( "\n \n" );
      fi;

      # inform that the matrices have been computed and we now compute the syzygies
      if display_messages then
        Print( "All matrices computed. Will now compute syzygies... \n" );
      fi;
      new_mat := SyzygiesOfRows( SyzygiesOfRows( matrix2, matrix3 ), matrix1 );

      # inform that syzygies have been computed and that we now compute the dimension of the cokernel object
      if display_messages then
      Print( "Syzygies computed, now computing the vector space morphism... \n" );
      fi;
      vec_space_morphism := VectorSpaceMorphism( VectorSpaceObject( NrRows( new_mat ), Q ),
                                                 new_mat,
                                                 VectorSpaceObject( NrColumns( new_mat ), Q )
                                                );

      # and return the result
      return vec_space_morphism;

end );


InstallMethod( SaveMorphismOfProjectiveModulesOnToricVarietyToFile,
               " for a filename, a morphism of projective graded S-modules",
               [ IsString, IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism, IsList, IsList ],
function( filename, variety, morphism, gens_source, gens_range )
  local path, file, output, rays, max_cones, names, 
       ring, vars, s, degree_group, weights, generator_degrees, relation_degrees, 
       matrix_entries, i, j, k, help_list, left, mapping_matrix, images, image, non_zero_rows;

  # set up the stream
  path := PackageInfo( "SheafCohomologyOnToricVarieties" )[ 1 ]!.InstallationPath;
  file := Filename( Directory( path ), Concatenation( filename, ".gi" ) );
  
  # check if the file exists and if so, delete it if possible
  if IsExistingFile( file ) then

    # if it does, try to remove it
    if RemoveFile( file ) = fail then
      Error( "the file already exists and cannot be deleted before the write process" );
      return;
    fi;

  fi;
  
  # now set up the stream and append to the above file
  output := OutputTextFile( file, true );;

  # check if the stream works
  if output = fail then
    Error( "failed to set up file-stream" );
    return;
  fi;

  # (0) ensure that SheafCohomology is loaded
  AppendTo( output, "LoadPackage( \"SheafCohomologyOnToricVarieties\" ); \n" );
  
  # (1) save gens_range
  AppendTo( output, "record_list := []; \n" );
  for i in [ 1 .. Length( gens_range[ 2 ] ) ] do
    AppendTo( output, "help_rec := rec(); \n" );
    names := RecNames( gens_range[ 2 ][ i ] );
    for j in [ 1 .. Length( names ) ] do
      s := Concatenation( " help_rec.( \"", names[ j ], "\" ) := ", String( gens_range[ 2 ][ i ].( names[ j ] ) ), "; \n" );
      AppendTo( output, s );
    od;
    AppendTo( output, "Append( record_list, [ help_rec ] ); \n" );
  od;
  AppendTo( output, "gens_range := [ ", String( gens_range[ 1 ] ), ", record_list ]; \n" );

  # (2) compute and save images of gens_source
  # (2) compute and save images of gens_source

  # identify the mapping matrix
  left := IsCAPCategoryOfProjectiveGradedLeftModulesMorphism( morphism );
  mapping_matrix := UnderlyingHomalgMatrix( morphism );
  if left then
    mapping_matrix := Involution( mapping_matrix );
  fi;

  # save images
  AppendTo( output, "images := [ \n" );
  images := [];
  for i in [ 1 .. Length( gens_source ) ] do
    image := mapping_matrix * gens_source[ i ];
    non_zero_rows := NonZeroRows( image );
    image := EntriesOfHomalgMatrix( image );
    AppendTo( output, Concatenation( "[ ", String( non_zero_rows ), ", [ \n" ) );
    for j in [ 1 .. Length( image-1 ) ] do
      AppendTo( output, Concatenation( "\"", String( image[ j ] ), "\", \n" ) );
    od;
    if i < Length( gens_source ) then
      AppendTo( output, Concatenation( "\"", String( image[ Length( image ) ] ), "\" ] ], \n" ) );
    else
      AppendTo( output, Concatenation( "\"", String( image[ Length( image ) ] ), "\" ] ] \n" ) );
    fi;
  od;
  AppendTo( output, "]; \n" );

  # (3) save the name of the indeterminates
  s := Concatenation( " name_of_indeterminates := ", 
                   String( String( IndeterminatesOfPolynomialRing( HomalgRing( mapping_matrix ) )[ 1 ] )[ 1 ] ), "; \n" );
  AppendTo( output, s );

  # (4) close the stream and return success
  CloseStream(output);
  return true;

end );


# declare globale variables associated to this package - they are used for communication with other gap instances
# as the following methods is planned to be run in parallel
InstallMethod( InternalHomDegreeZeroOnObjectsWrittenToFiles,
               " for a toric variety, a f.p. graded left S-module, a f.p. graded left S-module",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsGradedLeftOrRightModulePresentationForCAP ],
  function( variety, a, b )
      local range, source, map, rationals, zero, gens_source_1, gens_range_1, gens_source_2, gens_range_2, 
           gens_source_3, gens_range_3, matrix1, compute_job1, matrix2, compute_job2, 
           matrix3, compute_job3, job1, job2, job3, res, path, file, helper1, del, helper2, helper3, new_mat, 
           vec_space_morphism; 

      # Let a = ( R_A --- alpha ---> A ) and b = (R_B --- beta ---> B ). Then we have to compute the kernel embedding of the
      # following map:
      #
      # A^v \otimes R_B -----------alpha^v \otimes id_{R_B} --------------> R_A^v \otimes R_B
      #       |                                                                      |
      #       |                                                                      |
      # id_{A^v} \otimes beta                                            id_{R_A^v} \otimes beta
      #       |                                                                      |
      #       v                                                                      v
      # A^v \otimes B -------------- alpha^v \otimes id_B -------------------> R_A^v \otimes B
      #
 
      # step0: to avoid banners, load packages here 
      # step0: to avoid banners, load packages here 
      LoadPackage( "GaussForHomalg" );


      # step1: initialise a few things
      # step1: initialise a few things
      rationals := HomalgFieldOfRationalsInMAGMA();
      zero := UnderlyingListOfRingElements( TheZeroElement( DegreeGroup( CoxRing( variety ) ) ) );


      # step2: compute the map of graded module presentations
      # step2: compute the map of graded module presentations
      Print( "compute map of graded module presentations whose kernel is InternalHOM... \n" );
      range := CAPPresentationCategoryObject( TensorProductOnMorphisms(
                                                  IdentityMorphism( DualOnObjects( Source( UnderlyingMorphism( a ) ) ) ),
                                                  UnderlyingMorphism( b ) )
                                                  );
      source := CAPPresentationCategoryObject( TensorProductOnMorphisms(
                                                  IdentityMorphism( DualOnObjects( Range( UnderlyingMorphism( a ) ) ) ),
                                                  UnderlyingMorphism( b ) )
                                                  );
      map := TensorProductOnMorphisms( DualOnMorphisms( UnderlyingMorphism( a ) ),
                                       IdentityMorphism( Range( UnderlyingMorphism( b ) ) )
                                      );
      map := CAPPresentationCategoryMorphism( source,
                                              map,
                                              range,
                                              CapCategory( source )!.constructor_checks_wished
                                             );
      Print( "\n" );


      # step3: compute the truncations of all projective modules in the above morphism of module presentations
      #        formatted exactly the way we need them for later computations
      # step3: compute the truncations of all projective modules in the above morphism of module presentations
      #        formatted exactly the way we need them for later computations
      Print( "truncate the projective modules in this morphism... \n" );
      gens_source_1 := DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListOfColumnMatrices( 
                                                       variety, Source( UnderlyingMorphism( source ) ), zero );
      gens_range_1 := DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListsOfRecords(
                                                       variety, Range( UnderlyingMorphism( source ) ), zero );
      Print( "done for source morphism... \n" );
      gens_source_2 := DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListOfColumnMatrices( 
                                                       variety, Range( UnderlyingMorphism( source ) ), zero );
      gens_range_2 := DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListsOfRecords(
                                                       variety, Range( UnderlyingMorphism( range ) ), zero );
      Print( "done for map morphism... \n" );
      gens_source_3 := DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListOfColumnMatrices( 
                                                       variety, Source( UnderlyingMorphism( range ) ), zero );
      gens_range_3 := gens_range_2;
      Print( "done for range morphism... \n \n" );


      # step4: analyse the source morphism
      # step4: analyse the source morphism

      # if its source is the zero vector space...
      Print( "analyse the source morphism... \n" );
      if Length( gens_source_1 ) = 0 then

        matrix1 := HomalgZeroMatrix( gens_range_1[ 1 ], 0, rationals );
        Print( "matrix 1 computed... \n" );
        Print( Concatenation( "NrRows: ", String( NrRows( matrix1 ) ), "\n" ) );
        Print( Concatenation( "NrColumns: ", String( NrColumns( matrix1 ) ), "\n \n" ) );

      # if its range is the zero vector space...
      elif gens_range_1[ 1 ] = 0 then

        matrix1 := HomalgZeroMatrix( 0, Length( gens_source_1 ), rationals );
        Print( "matrix 1 computed... \n" );
        Print( Concatenation( "NrRows: ", String( NrRows( matrix1 ) ), "\n" ) );
        Print( Concatenation( "NrColumns: ", String( NrColumns( matrix1 ) ), "\n \n" ) );

      else

        SaveMorphismOfProjectiveModulesOnToricVarietyToFile( "source", variety, UnderlyingMorphism( source ),
                                                                                         gens_source_1, gens_range_1 );
        compute_job1 := true;
        Print( "-> starting background job for this truncation... \n \n" );
        job1 := BackgroundJobByFork( WriteDegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphismToFileForGAPMinimal,
                                    [ "source", "helper1", false ], rec( TerminateImmediately := true ) );

      fi;


      # step5: truncate the map morphism
      # step5: truncate the map morphism

      # if its source is the zero vector space...
      Print( "analyse the map morphism... \n" );
      if Length( gens_source_2 ) = 0 then

        matrix2 := HomalgZeroMatrix( gens_range_2[ 1 ], 0, rationals );
        Print( "matrix 2 computed... \n" );
        Print( Concatenation( "NrRows: ", String( NrRows( matrix2 ) ), "\n" ) );
        Print( Concatenation( "NrColumns: ", String( NrColumns( matrix2 ) ), "\n \n" ) );

      # if its range is the zero vector space...      
      elif gens_range_2[ 1 ] = 0 then

        matrix2 := HomalgZeroMatrix( 0, Length( gens_source_2 ), rationals );
        Print( "matrix 2 computed... \n" );
        Print( Concatenation( "NrRows: ", String( NrRows( matrix2 ) ), "\n" ) );
        Print( Concatenation( "NrColumns: ", String( NrColumns( matrix2 ) ), "\n \n" ) );

      else

        SaveMorphismOfProjectiveModulesOnToricVarietyToFile( "map", variety, UnderlyingMorphism( map ),
                                                                                         gens_source_2, gens_range_2 );
        compute_job2 := true;
        Print( "-> starting background job for this truncation... \n \n" );
        job2 := BackgroundJobByFork( WriteDegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphismToFileForGAPMinimal,
                                    [ "map", "helper2", false ], rec( TerminateImmediately := true ) );

      fi;


      # step6: truncate the range morphism
      # step6: truncate the range morphism

      # if its source is the zero vector space...
      Print( "analyse the range morphism... \n" );
      if Length( gens_source_3 ) = 0 then

        matrix2 := HomalgZeroMatrix( gens_range_3[ 1 ], 0, rationals );
        Print( "matrix 3 computed... \n" );
        Print( Concatenation( "NrRows: ", String( NrRows( matrix3 ) ), "\n" ) );
        Print( Concatenation( "NrColumns: ", String( NrColumns( matrix3 ) ), "\n \n" ) );

      # if its range is the zero vector space...      
      elif gens_range_3[ 1 ] = 0 then

        matrix3 := HomalgZeroMatrix( 0, Length( gens_source_3 ), rationals );
        Print( "matrix 3 computed... \n" );
        Print( Concatenation( "NrRows: ", String( NrRows( matrix3 ) ), "\n" ) );
        Print( Concatenation( "NrColumns: ", String( NrColumns( matrix3 ) ), "\n \n" ) );

      else

        SaveMorphismOfProjectiveModulesOnToricVarietyToFile( "range", variety, UnderlyingMorphism( range ),
                                                                                         gens_source_3, gens_range_3 );
        compute_job3 := true;
        WriteDegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphismToFileForGAPMinimal( "range", "helper3", true );

      fi;


      # step7: collect result of job1 and kill this job
      # step7: collect result of job1 and kill this job
      if compute_job1 then
        Print( "extract result of job 1: \n" );
        res := Pickup( job1 );
        if not res then
          Error( "job 1 completed with message 'fail' " );
        else
          path := PackageInfo( "SheafCohomologyOnToricVarieties" )[ 1 ]!.InstallationPath;
          file := Filename( Directory( path ), "helper1.gi" );
          if not IsExistingFile( file ) then
            Error( Concatenation( "the file", String( file ), "does not exist" ) );
          fi;
          Read( file );
          helper1 := ValueGlobal( "helper1" );
          matrix1 := Involution( rationals * helper1 );
          del := RemoveFile( file );
          if not del then
            Error( Concatenation( "could not delete the file", String( file ) ) );
          fi;
          file := Filename( Directory( path ), "source.gi" );
          del := RemoveFile( file );
          if not del then
            Error( Concatenation( "could not delete the file", String( file ) ) );
          fi;
          Kill( job1 );
          Print( "(*) matrix 1 computed \n" );
          Print( "(*) cleaned working directory \n \n" );
        fi;
      fi;


      # step8: collect result of job2
      # step8: collect result of job2
      if compute_job2 then
        res := Pickup( job2 );
        Print( "extract result of job 2: \n" );
        if not res then
          Error( "job 2 completed with message 'fail' " );
        else
          path := PackageInfo( "SheafCohomologyOnToricVarieties" )[ 1 ]!.InstallationPath;
          file := Filename( Directory( path ), "helper2.gi" );
          if not IsExistingFile( file ) then
            Error( Concatenation( "the file", String( file ), "does not exist" ) );
          fi;
          Read( file );
          helper2 := ValueGlobal( "helper2" );
          matrix2 := Involution( rationals * helper2 );
          del := RemoveFile( file );
          if not del then
            Error( Concatenation( "could not delete the file", String( file ) ) );
          fi;
          file := Filename( Directory( path ), "map.gi" );
          del := RemoveFile( file );
          if not del then
            Error( Concatenation( "could not delete the file", String( file ) ) );
          fi;
          #Kill( job2 );
          Print( "(*) matrix 2 computed \n" );
          Print( "(*) cleaned working directory \n \n" );
        fi;
      fi;


      # step9: collect result of 'job3'
      # step9: collect result of 'job3'
      if compute_job3 then
        Print( "recall result of job 3: \n" );
        path := PackageInfo( "SheafCohomologyOnToricVarieties" )[ 1 ]!.InstallationPath;
        file := Filename( Directory( path ), "helper3.gi" );
        if not IsExistingFile( file ) then
          Error( Concatenation( "the file", String( file ), "does not exist" ) );
        fi;
        Read( file );
        helper3 := ValueGlobal( "helper3" );
        matrix3 := Involution( rationals * helper3 );
        del := RemoveFile( file );
        if not del then
          Error( Concatenation( "could not delete the file", String( file ) ) );
        fi;
        file := Filename( Directory( path ), "range.gi" );
        del := RemoveFile( file );
        if not del then
          Error( Concatenation( "could not delete the file", String( file ) ) );
        fi;
        Print( "(*) matrix 3 computed \n" );
        Print( "(*) cleaned working directory \n \n" );
      fi;


      # step 10: compute syzygies and vec_space_morphism
      # step 10: compute syzygies and vec_space_morphism
      Print( "compute syzygies and vector space morphism \n" );
      new_mat := SyzygiesOfRows( SyzygiesOfRows( matrix2, matrix3 ), matrix1 );
      vec_space_morphism := VectorSpaceMorphism( VectorSpaceObject( NrRows( new_mat ), rationals ),
                                                 new_mat,
                                                 VectorSpaceObject( NrColumns( new_mat ), rationals )
                                                );

      # and return the result
      return vec_space_morphism;

end );

InstallMethod( InternalHomDegreeZeroOnMorphisms,
               " for a toric variety, a f.p. graded left S-module, a f.p. graded left S-module",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsBool ],
  function( variety, mor1, mor2, display_messages )
      local range, source, map, Q, matrix1, matrix2, matrix3, source_vec_space_pres, range_vec_space_pres, map_vec_space_pres,
           ker1, ker2, bridge;

      # Let mor1: A -> A' and mor2: B -> B' and let A = (R_A - \rho_A -> G_A ) and alike for the others. 
      # Then we compute the degree zero layer of the morphism Hom( A', B ) -> Hom( A, B' ). 


      # STEP1: Hom( A', B ):
      # STEP1: Hom( A', B ):

      # We have the following map
      #
      # G_{A'}^v \otimes R_B -----------rho_{A'}^v \otimes id_{R_B} --------------> R_{A'}^v \otimes R_B
      #       |                                                                      |
      #       |                                                                      |
      # id_{G_{A'}^v} \otimes rho_B                                            id_{R_{A'}^v} \otimes rho_B
      #       |                                                                      |
      #       v                                                                      v
      # G_{A'}^v \otimes G_B ---------- rho_{A'}^v \otimes id_{G_B} ------------> R_{A'}^v \otimes G_B
      #

      # compute the map of graded module presentations
      if display_messages then
        Print( "Step1: \n" );
        Print( "------ \n" );
        Print( Concatenation( "We will now compute the map of graded module presentations, ",
                              "whose kernel is GradedHom( Range( mor1 ), Source( mor2 ) )... \n" ) );
      fi;
      range := CAPPresentationCategoryObject( TensorProductOnMorphisms(
                                                      IdentityMorphism( DualOnObjects( Source( UnderlyingMorphism( Range( mor1 ) ) ) ) ),
                                                      UnderlyingMorphism( Source( mor2 ) ) )
                                                      );
      source := CAPPresentationCategoryObject( TensorProductOnMorphisms(
                                                      IdentityMorphism( DualOnObjects( Range( UnderlyingMorphism( Range( mor1 ) ) ) ) ),
                                                      UnderlyingMorphism( Source( mor2 ) ) )
                                                      );
      map := TensorProductOnMorphisms( DualOnMorphisms( UnderlyingMorphism( Range( mor1 ) ) ),
                                       IdentityMorphism( Range( UnderlyingMorphism( Source( mor2 ) ) ) )
                                      );
      map := CAPPresentationCategoryMorphism( source,
                                              map,
                                              range,
                                              CapCategory( source )!.constructor_checks_wished
                                             );

      # inform that we have the graded module presentation morphism and will now try to truncate it
      if display_messages then
        Print( Concatenation( "Computed the map of graded module presentations whose kernel is ",
                              "GradedHom( Range( mor1 ), Source( mor2 ) ).",
                              "Will now truncate it... \n \n" ) );
      fi;

      # Set up rationals in MAGMA, so that we can compute the kernels and so on of matrices with MAGMA
      Q := HomalgFieldOfRationalsInMAGMA();

      source_vec_space_pres := CAPPresentationCategoryObject(
                                    UnderlyingVectorSpaceMorphism( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                                                          variety,
                                                                          UnderlyingMorphism( Source( map ) ),
                                                                          TheZeroElement( DegreeGroup( CoxRing( variety ) ) ),
                                                                          Q,
                                                                          display_messages
                                                                          ) ) );
      if display_messages then
        Print( "\n \n" );
      fi;
      map_vec_space_pres := UnderlyingVectorSpaceMorphism( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                                                          variety,
                                                                          UnderlyingMorphism( map ),
                                                                          TheZeroElement( DegreeGroup( CoxRing( variety ) ) ),
                                                                          Q,
                                                                          display_messages
                                                                          ) );
      if display_messages then
        Print( "\n \n" );
      fi;
      range_vec_space_pres := CAPPresentationCategoryObject( 
                                   UnderlyingVectorSpaceMorphism( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                                                          variety,
                                                                          UnderlyingMorphism( Range( map ) ),
                                                                          TheZeroElement( DegreeGroup( CoxRing( variety ) ) ),
                                                                          Q,
                                                                          display_messages
                                                                          ) ) );
      if display_messages then
        Print( "\n \n" );
      fi;
      ker1 := KernelEmbedding( CAPPresentationCategoryMorphism( source_vec_space_pres,
                                                                map_vec_space_pres,
                                                                range_vec_space_pres,
                                                                CapCategory( source )!.constructor_checks_wished
                                                               ) );


      # STEP2: Hom( A, B' ):
      # STEP2: Hom( A, B' ):

      # We have the following map
      #
      # G_{A}^v \otimes R_{B'} -------rho_{A}^v \otimes id_{R_{B'}} ----------> R_{A}^v \otimes R_{B'}
      #       |                                                                      |
      #       |                                                                      |
      # id_{G_{A}^v} \otimes rho_{B'}                                       id_{R_{A}^v} \otimes rho_{B'}
      #       |                                                                      |
      #       v                                                                      v
      # G_{A}^v \otimes G_{B'} ---------- rho_{A}^v \otimes id_{G_{B'}} ---------> R_{A}^v \otimes G_{B'}
      #

      # compute the map of graded module presentations
      if display_messages then
        Print( "\n \n" );
        Print( "Step2: \n" );
        Print( "------ \n" );
        Print( Concatenation( "We will now compute the map of graded module presentations, ",
                              "whose kernel is GradedHom( Source( mor1 ), Range( mor2 ) )... \n" ) );
      fi;
      range := CAPPresentationCategoryObject( TensorProductOnMorphisms(
                                                      IdentityMorphism( DualOnObjects( Source( UnderlyingMorphism( Source( mor1 ) ) ) ) ),
                                                      UnderlyingMorphism( Range( mor2 ) ) )
                                                      );
      source := CAPPresentationCategoryObject( TensorProductOnMorphisms(
                                                      IdentityMorphism( DualOnObjects( Range( UnderlyingMorphism( Source( mor1 ) ) ) ) ),
                                                      UnderlyingMorphism( Range( mor2 ) ) )
                                                      );
      map := TensorProductOnMorphisms( DualOnMorphisms( UnderlyingMorphism( Source( mor1 ) ) ),
                                       IdentityMorphism( Range( UnderlyingMorphism( Range( mor2 ) ) ) )
                                      );
      map := CAPPresentationCategoryMorphism( source,
                                              map,
                                              range,
                                              CapCategory( source )!.constructor_checks_wished
                                             );

      # inform that we have the graded module presentation morphism and will now try to truncate it
      if display_messages then
        Print( Concatenation( "Computed the map of graded module presentations whose kernel is GradedHom( Source( mor1 ), Range( mor2 ) ).",
                              "Will now truncate it... \n \n" ) );
      fi;

      source_vec_space_pres := CAPPresentationCategoryObject(
                                    UnderlyingVectorSpaceMorphism( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                                                          variety,
                                                                          UnderlyingMorphism( Source( map ) ),
                                                                          TheZeroElement( DegreeGroup( CoxRing( variety ) ) ),
                                                                          Q,
                                                                          display_messages
                                                                          ) ) );
      if display_messages then
        Print( "\n \n" );
      fi;
      map_vec_space_pres := UnderlyingVectorSpaceMorphism( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                                                          variety,
                                                                          UnderlyingMorphism( map ),
                                                                          TheZeroElement( DegreeGroup( CoxRing( variety ) ) ),
                                                                          Q,
                                                                          display_messages
                                                                          ) );
      if display_messages then
        Print( "\n \n" );
      fi;
      range_vec_space_pres := CAPPresentationCategoryObject( 
                                    UnderlyingVectorSpaceMorphism( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                                                          variety,
                                                                          UnderlyingMorphism( Range( map ) ),
                                                                          TheZeroElement( DegreeGroup( CoxRing( variety ) ) ),
                                                                          Q,
                                                                          display_messages
                                                                          ) ) );
      if display_messages then
        Print( "\n \n" );
      fi;
      ker2 := KernelEmbedding( CAPPresentationCategoryMorphism( source_vec_space_pres,
                                                                map_vec_space_pres,
                                                                range_vec_space_pres,
                                                                CapCategory( source )!.constructor_checks_wished
                                                               ) );


      # STEP3: The bridge map
      # STEP3: The bridge map

      # compute the map or graded module preseentations
      if display_messages then
        Print( "\n \n" );
        Print( "Step3: \n" );
        Print( "------ \n" );
        Print( "We will now compute the bridge map... \n" );
      fi;
      map := TensorProductOnMorphisms( DualOnMorphisms( UnderlyingMorphism( mor1 ) ),
                                       UnderlyingMorphism( mor2 )
                                      );
      if display_messages then
        Print( "and truncate it... \n \n" );
      fi;
      map_vec_space_pres := UnderlyingVectorSpaceMorphism( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                                                          variety,
                                                                          map,
                                                                          TheZeroElement( DegreeGroup( CoxRing( variety ) ) ),
                                                                          Q,
                                                                          display_messages
                                                                          ) );

      bridge := CAPPresentationCategoryMorphism( Range( ker1 ),
                                                 map_vec_space_pres,
                                                 Range( ker2 ),
                                                 CapCategory( source )!.constructor_checks_wished
                                                );


      # STEP3: The bridge map
      # STEP3: The bridge map

      # compute the lift
      if display_messages then
        Print( "\n \n \n" );
        Print( "Step4: \n" );
        Print( "------ \n" );
        Print( "We will compute the necessary lift and return it... \n \n \n \n" );
      fi;

      return Lift( PreCompose( ker1, bridge ), ker2 );

end );



#############################################################
##
## Section Specialised GradedExt methods
##
#############################################################


# compute GradedExt degree zero layer
InstallMethod( GradedExtDegreeZeroOnObjects,
               " for a toric variety, a f.p. graded left S-module, a f.p. graded left S-module",
               [ IsInt, IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsGradedLeftOrRightModulePresentationForCAP, IsBool ],
  function( i, variety, module1, module2, display_messages )
    local left, mu, graded_hom_mapping;

    # check input
    left := IsGradedLeftModulePresentationForCAP( module1 );
    if i < 0 then
      Error( "the integer i must be non-negative" );
      return;
    elif IsGradedLeftModulePresentationForCAP( module2 ) <> left then
      Error( "the two modules must either both be left or both be right modules" );
      return;
    fi;

    # if we are given submodules, then turn them into presentations
    if IsGradedLeftOrRightSubmoduleForCAP( module1 ) then
      module1 := PresentationForCAP( module1 );
    fi;
    if IsGradedLeftOrRightSubmoduleForCAP( module2 ) then
      module2 := PresentationForCAP( module2 );
    fi;

    # now compute the extension module

    # step1:
    if display_messages then
      Print( "Step 0: \n" );
      Print( "------- \n");
      Print( "We will now extract the 'i-th' morphism \mu in the resolution of module1... \n" );
    fi;

    if i = 0 then
      mu := ZeroMorphism( module1, ZeroObject( CapCategory( module1 ) ) );
    else
      mu := UnderlyingZFunctorCell( MinimalFreeResolutionForCAP( module1 ) )!.differential_func( -i );
      mu := ApplyFunctor( EmbeddingOfProjCategory( CapCategory( mu ) ), mu );
      mu := KernelEmbedding( CokernelProjection( mu ) );
    fi;

    # step2:
    if display_messages then
      Print( "Next will now compute GradedHom( Range( mu ), module2 )_0 -> GradedHom( Source( mu ), module2 )_0... \n \n \n \n" );
    fi;
    graded_hom_mapping := InternalHomDegreeZeroOnMorphisms( variety, mu, IdentityMorphism( module2 ), display_messages );

    # (3) then return the cokernel object of this morphism (this is a vector space presentation)
    if display_messages then
      Print( "Step 5: \n" );
      Print( "------- \n");
      Print( "Finally, we now compute the cokernel of this morphism... \n \n" );
    fi;

    return UnderlyingMorphism( CokernelObject( graded_hom_mapping ) );

end );



#############################################################
##
## Section Parameter check
##
#############################################################

# this methods checks if the conditions in my theorem as satisfied
BindGlobal( "SHEAF_COHOMOLOGY_INTERNAL_PARAMETER_CHECK",
  function( variety, ideal, module, Index )
    local betti_ideal, betti_module, L_ideal, L_module, u, j, k, l, diff, tester;

    # check if Index is meaningful
    if ( Index < 0 ) or ( Index > Dimension( variety ) )  then

      Error( "Index must be non-negative and must not exceed the dimension of the variety." );
      return;

    fi;

    # compute resolutions of both modules
    betti_ideal := BettiTableForCAP( ideal );
    betti_module := BettiTableForCAP( module );

    # extract the 'lengths' of the two ideals
    L_ideal := Length( betti_ideal ) - 1; # resolution indexed from F0 to F( L_ideal )
    L_module := Length( betti_module ) - 1; # same...

    # check condition 1
    # check condition 1
    if not (Minimum( L_ideal, Index - 1 ) < 0) then

      for u in [ 0 .. Minimum( L_ideal, Index - 1 ) ] do
        for j in [ 1 .. Length( betti_ideal[ u+1 ] ) ] do
          for k in [ 0 .. Minimum( Dimension( variety ) - Index + u, L_module ) ] do
            for l in [ 1 .. Length( betti_module[ k+1 ] ) ] do
              diff := UnderlyingListOfRingElements( betti_ideal[ u+1 ][ j ] ) -
                      UnderlyingListOfRingElements( betti_module[ k+1 ][ l ] );
              tester := PointContainedInVanishingSet( VanishingSets( variety ).( k+Index-u ), diff );
              if tester = false then
                return false;
              fi;
            od;
          od;
        od;
      od;

    fi;

    # check condition 2
    # check condition 2
    if not (Minimum( L_ideal, Index - 2 ) < 0) then

      for u in [ 0 .. Minimum( L_ideal, Index - 2 ) ] do
        for j in [ 1 .. Length( betti_ideal[ u+1 ] ) ] do
          for k in [ 0 .. Minimum( Dimension( variety ) - Index + u + 1, L_module ) ] do
            for l in [ 1 .. Length( betti_module[ k+1 ] ) ] do
              diff := UnderlyingListOfRingElements( betti_ideal[ u+1 ][ j ] ) -
                      UnderlyingListOfRingElements( betti_module[ k+1 ][ l ] );
              tester := PointContainedInVanishingSet( VanishingSets( variety ).( k+Index-u-1 ), diff );
              if tester = false then
                return false;
              fi;
            od;
          od;
        od;
      od;

    fi;

    # check condition 3
    # check condition 3
    if ( 0 < Index ) and not ( Index > L_ideal + 1 ) then

      for j in [ 1 .. Length( betti_ideal[ Index ] ) ] do
        for u in [ 1 .. Minimum( L_module, Dimension( variety ) ) ] do
          for l in [ 1 .. Length( betti_module[ u+1 ] ) ] do
            diff := UnderlyingListOfRingElements( betti_ideal[ Index ][ j ] ) -
                    UnderlyingListOfRingElements( betti_module[ u+1 ][ l ] );
            tester := PointContainedInVanishingSet( VanishingSets( variety ).( u ), diff );
            if tester = false then
              return false;
            fi;
          od;
        od;
      od;

    fi;

    # check condition 4
    # check condition 4
    if not ( Index + 1 > L_ideal + 1 ) then

      for j in [ 1 .. Length( betti_ideal[ Index + 1 ] ) ] do
        for u in [ 1 .. Minimum( L_module, Dimension( variety ) ) ] do
          for l in [ 1 .. Length( betti_module[ u+1 ] ) ] do
            diff := UnderlyingListOfRingElements( betti_ideal[ Index+1 ][ j ] ) -
                    UnderlyingListOfRingElements( betti_module[ u+1 ][ l ] );
            tester := PointContainedInVanishingSet( VanishingSets( variety ).( u ), diff );
            if tester = false then
              return false;
            fi;
          od;
        od;
      od;

    fi;

    # check condition 5
    # check condition 5
    if not ( Index > L_ideal ) then

      for j in [ 1 .. Length( betti_ideal[ Index + 1 ] ) ] do
        for u in [ 2 .. Minimum( L_module, Dimension( variety ) + 1 ) ] do
          for l in [ 1 .. Length( betti_module[ u+1 ] ) ] do
            diff := UnderlyingListOfRingElements( betti_ideal[ Index+1 ][ j ] ) -
                    UnderlyingListOfRingElements( betti_module[ u+1 ][ l ] );
            tester := PointContainedInVanishingSet( VanishingSets( variety ).( u-1 ), diff );
            if tester = false then
              return false;
            fi;
          od;
        od;
      od;

    fi;

    # check condition 6
    # check condition 6
    if not ( Index + 2 > L_ideal + 1 ) then
      for j in [ 1 .. Length( betti_ideal[ Index + 2 ] ) ] do
        for u in [ 2 .. Minimum( L_module, Dimension( variety ) + 1 ) ] do
          for l in [ 1 .. Length( betti_module[ u+1 ] ) ] do
            diff := UnderlyingListOfRingElements( betti_ideal[ Index+2 ][ j ] ) -
                    UnderlyingListOfRingElements( betti_module[ u+1 ][ l ] );
            tester := PointContainedInVanishingSet( VanishingSets( variety ).( u-1 ), diff );
            if tester = false then
              return false;
            fi;
          od;
        od;
      od;

    fi;

    # all tests passed, so return true
    return true;

end );

# this method finds an ideal to which my theorem applies
BindGlobal( "SHEAF_COHOMOLOGY_INTERNAL_FIND_IDEAL",
  function( variety, module_presentation, index )
    local deg, e_list, i, ideal_generators, e, ideal_generators_power, B_power, best, chosen_degree;

    # determine classes of smallest ample divisors and initialise e_list
    deg := ClassesOfSmallestAmpleDivisors( variety );
    e_list := [];

    # iterate over all these degrees
    for i in [ 1 .. Length( deg ) ] do

      # find the ideal generators for these degrees
      ideal_generators := DuplicateFreeList( DegreeXLayer( variety, deg[ i ] ) );

      # initialise the ideal to the power 0
      e := 0;
      ideal_generators_power := DuplicateFreeList( List( [ 1 .. Length( ideal_generators ) ], k -> ideal_generators[ k ]^e ) );
      B_power := GradedLeftSubmoduleForCAP( TransposedMat( [ ideal_generators_power ] ), CoxRing( variety ) );
      B_power := ByASmallerPresentation( PresentationForCAP( B_power ) );

      # and start the search
      while not SHEAF_COHOMOLOGY_INTERNAL_PARAMETER_CHECK( variety, B_power, module_presentation, index ) do

        e := e + 1;
        ideal_generators_power := DuplicateFreeList( List( [ 1 .. Length( ideal_generators ) ], k -> ideal_generators[ k ]^e ) );
        B_power := GradedLeftSubmoduleForCAP( TransposedMat( [ ideal_generators_power ] ), CoxRing( variety ) );
        B_power := ByASmallerPresentation( PresentationForCAP( B_power ) );
      od;

      # save result
      e_list[ i ] := e;

    od;

    # now compute the 'best' ideal
    best := Position( e_list, Minimum( e_list ) );
    chosen_degree := deg[ best ];
    ideal_generators := DuplicateFreeList( DegreeXLayer( variety, deg[ best ] ) );
    ideal_generators_power := DuplicateFreeList( List( [ 1 .. Length( ideal_generators ) ], 
                                      k -> ideal_generators[ k ]^e_list[ best ] ) );
    B_power := GradedLeftSubmoduleForCAP( TransposedMat( [ ideal_generators_power ] ), CoxRing( variety ) );
    B_power := ByASmallerPresentation( PresentationForCAP( B_power ) );

    # and return the result
    return [ e_list[ best ], chosen_degree, B_power ];

end );


#############################################################
##
## Section Computation of H0
##
#############################################################

# compute H^0 by applying the theorem from Greg Smith
InstallMethod( H0,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool, IsBool, IsBool ],
  function( variety, module, display_messages, very_detailed_output, timings )
    local module_presentation, zero, ideal_infos, B_power, vec_space_morphism;

    # check that the input is valid to work with
    if not ( ( IsSmooth( variety ) and IsComplete( variety ) )
           or ( IsSimplicial( variety ) and IsProjective( variety ) ) ) then

      Error( "variety must either be (smooth, complete) or (simplicial, projective)" );
      return;

    fi;

    # unzip the module
    if IsGradedLeftOrRightSubmoduleForCAP( module ) then
      module_presentation := PresentationForCAP( module );
    else
      module_presentation := module;
    fi;

    # we have a specialised algorithm for H0 of vector bundles
    zero := List( [ 1 .. Rank( ClassGroup( variety ) ) ], x -> 0 );
    if IsZeroForObjects( Source( UnderlyingMorphism( module_presentation ) ) ) then
      if timings then
        return [ 0, 0, UnderlyingVectorSpaceObject(
                       DegreeXLayerOfProjectiveGradedLeftOrRightModule(
                               variety,
                               Range( UnderlyingMorphism( module_presentation ) ),
                               zero
                       ) ) ];
      else
        return [ 0, UnderlyingVectorSpaceObject(
                       DegreeXLayerOfProjectiveGradedLeftOrRightModule(
                               variety,
                               Range( UnderlyingMorphism( module_presentation ) ),
                               zero
                       ) ) ];
      fi;
    fi;

    # otherwise start the overall machinery

    # Step 0: compute the vanishing sets
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
    # step 2: compute ideal B such that H0 = GradedHom( B, M )
    if display_messages then
      Print( "(*) Determine ideal... " );
    fi;

    ideal_infos := SHEAF_COHOMOLOGY_INTERNAL_FIND_IDEAL( variety, module_presentation, 0 );
    B_power := ideal_infos[ 3 ];

    # and inform about the result of this computation
    if display_messages then
      Print( Concatenation( "finished (found e = ", String( ideal_infos[ 1 ] ) , 
                            " for degree ", String( ideal_infos[ 2 ] ), ") \n" ) );
      Print( "(*) Compute GradedHom... \n" );
    fi;

    # step 3: compute GradedHom
    # step 3: compute GradedHom

    vec_space_morphism := TOOLS_FOR_HOMALG_GET_REAL_TIME_OF_FUNCTION_CALL(
                                  InternalHomDegreeZeroOnObjects,
                                            variety,
                                            B_power,
                                            module_presentation,
                                            very_detailed_output
                                  );

    # signal end of computation
    if display_messages then
      Print( "\n" );
      if timings then
        Print( Concatenation( "Computation finished after ", String( vec_space_morphism[ 1 ] ), 
                              " seconds. Summary: \n" ) );
      else
        Print( "Computation finished. Summary: \n" );
      fi;
      Print( Concatenation( "(*) used ideal power: ", String( ideal_infos[ 1 ] ), "\n" ) );
      Print( Concatenation( "(*) h^0 = ", String( Dimension( CokernelObject( vec_space_morphism[ 2 ] ) ) ), 
                            "\n \n" ) );
    fi;

    # return the cokernel object of this presentation
    if timings then
      return [ vec_space_morphism[ 1 ], ideal_infos[ 1 ], CokernelObject( vec_space_morphism[ 2 ] ) ];
    else
      return [ ideal_infos[ 1 ], CokernelObject( vec_space_morphism[ 2 ] ) ];    
    fi;

end );

# convenience method
InstallMethod( H0,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool, IsBool ],
  function( variety, module, display_messages, very_detailed_output )

    # by default never show very detailed output
    return H0( variety, module, display_messages, very_detailed_output, true );

end );


# convenience method
InstallMethod( H0,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool ],
  function( variety, module, display_messages )

    # by default never show very detailed output
    return H0( variety, module, display_messages, false, true );

end );

# convenience method
InstallMethod( H0,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ],
  function( variety, module )

    # by default show messages but not the very detailed output
    return H0( variety, module, true, false, true );

end );



#############################################################
##
#! @Section Computation of Hi
##
#############################################################


# compute H^i by applying my theorem
InstallMethod( Hi,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsBool, IsBool, IsBool ],
  function( variety, module, index, display_messages, very_detailed_output, timings )
    local module_presentation, ideal_infos, B_power, zero, vec_space_morphism;

    # check that the input is valid to work with
    if not ( ( IsSmooth( variety ) and IsComplete( variety ) )
           or ( IsSimplicial( variety ) and IsProjective( variety ) ) ) then

      Error( "variety must either be (smooth, complete) or (simplicial, projective)" );
      return;

    fi;

    # check if the index makes sense
    if ( index < 0 ) or ( index > Dimension( variety ) ) then

      Error( "the cohomological index must not be negative and must not exceed the dimension of the variety" );
      return;

    fi;

    # if we compute H0 hand it over to that method
    if index = 0 then
      return H0( variety, module, display_messages, very_detailed_output, timings );
    fi;

    # unzip the module
    if IsGradedLeftOrRightSubmoduleForCAP( module ) then
      module_presentation := PresentationForCAP( module );
    else
      module_presentation := module;
    fi;


    # Step 0: compute the vanishing sets
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
    # step 2: compute ideal B such that H0 = GradedHom( B, M )
    if display_messages then
      Print( "(*) Determine ideal... " );
    fi;

    ideal_infos := SHEAF_COHOMOLOGY_INTERNAL_FIND_IDEAL( variety, module_presentation, index );
    B_power := ideal_infos[ 3 ];

    # and inform about the result of this computation
    if display_messages then
      Print( Concatenation( "finished (found e = ", String( ideal_infos[ 1 ] ) , 
                            " for degree ", String( ideal_infos[ 2 ] ), ") \n" ) );
      Print( "(*) Compute GradedHom... \n" );
    fi;


    # step 3: compute GradedExt
    # step 3: compute GradedExt
    vec_space_morphism := TOOLS_FOR_HOMALG_GET_REAL_TIME_OF_FUNCTION_CALL(
                                  GradedExtDegreeZeroOnObjects,
                                            index,
                                            variety,
                                            B_power,
                                            module_presentation,
                                            very_detailed_output
                                  );

    # signal end of computation
    if display_messages then

      Print( "\n" );
      if timings then
        Print( Concatenation( "Computation finished after ", String( vec_space_morphism[ 1 ] ), 
                              " seconds. Summary: \n" ) );
      else
        Print( "Computation finished. Summary: \n" );
      fi;
      Print( Concatenation( "(*) used ideal power: ", String( ideal_infos[ 1 ] ), "\n" ) );
      Print( Concatenation( "(*) h^", String( index ), " = ", 
                            String( Dimension( CokernelObject( vec_space_morphism[ 2 ] ) ) ), 
                            "\n \n" ) 
                           );

    fi;

    # and return the result
    if timings then
      return [ vec_space_morphism[ 1 ], ideal_infos[ 1 ], CokernelObject( vec_space_morphism[ 2 ] ) ];
    else
      return [ ideal_infos[ 1 ], CokernelObject( vec_space_morphism[ 2 ] ) ];
    fi;

end );

InstallMethod( Hi,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsBool, IsBool ],
  function( variety, module, index, display_messages, very_detailed_output )

    # by default never show very detailed output
    return Hi( variety, module, index, display_messages, very_detailed_output, true );

end );

InstallMethod( Hi,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsBool ],
  function( variety, module, index, display_messages )

    # by default never show very detailed output
    return Hi( variety, module, index, display_messages, false, true );

end );

InstallMethod( Hi,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt ],
  function( variety, module, index )

    # by default display messages but suppress the very detailed output
    return Hi( variety, module, index, true, false, true );

end );



###################################################################################
##
#! @Section My theorem implemented to compute all cohomology classes
##
###################################################################################

# compute all cohomology classes by my theorem
InstallMethod( AllHi,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool, IsBool ],
  function( variety, module, display_messages, timings )
    local cohoms, i, total_time;

    # check that the input is valid to work with
    if not ( ( IsSmooth( variety ) and IsComplete( variety ) )
           or ( IsSimplicial( variety ) and IsProjective( variety ) ) ) then

      Error( "variety must either be (smooth, complete) or (simplicial, projective)" );
      return;

    fi;

    # initialise variables
    cohoms := List( [ 1 .. Dimension( variety ) + 1 ] );
    total_time := 0;

    # and iterate over the cohomology classes
    for i in [ 1 .. Dimension( variety ) + 1 ] do

      # inform about the status of the computation
      Print( Concatenation( "Computing h^", String( i-1 ), "\n" ) );
      Print(  "----------------------------------------------\n" );

      # make the computation - only display messages
      cohoms[ i ] := Hi( variety, module, i-1, display_messages, false, timings );
      total_time := total_time + cohoms[ i ][ 1 ];

      # additional empty line for optical separation
      Print( "\n" );

    od;

    if display_messages then

      if timings then

        # computation completely finished, so print summary
        Print( Concatenation( "Finished all computations after ", String( total_time ), " seconds. Summary: \n" ) );
        for i in [ 1 .. Dimension( variety ) + 1 ] do
          Print( Concatenation( "h^", String( i-1 ), " = ", String( Dimension( cohoms[ i ][ 3 ] ) ), "\n" ) );
        od;

      else

        # computation completely finished, so print summary
        Print( "Finished all computations. Summary: \n" );
        for i in [ 1 .. Dimension( variety ) + 1 ] do
          Print( Concatenation( "h^", String( i-1 ), " = ", String( Dimension( cohoms[ i ][ 2 ] ) ), "\n" ) );
        od;

      fi;

    fi;

    # and finally return the results
    return cohoms;

end );

InstallMethod( AllHi,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool ],
  function( variety, module, display_messages )

    return AllHi( variety, module, display_messages, true );

end );

InstallMethod( AllHi,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ],
  function( variety, module )

    return AllHi( variety, module, true, true );

end );