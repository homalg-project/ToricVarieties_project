#############################################################################
##
##  CohomologyViaGSForCAP.gi         ToricVarieties package
##
##  Copyright 2015- 2016, Sebastian Gutsche, TU Kaiserslautern
##                        Martin Bies,       ITP Heidelberg
##
##  Sheaf cohomology via the theorem of Greg. Smith for CAP
##
#############################################################################



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
      map := CAPPresentationCategoryMorphism( source,
                                              map,
                                              range,
                                              CapCategory( source )!.constructor_checks_wished
                                             );
      map := ByASmallerPresentation( map );

      # inform that we have the graded module presentation morphism and will now try to truncate it
      if display_messages then
        Print( "Computed the map of graded module presentations. Will now truncate it... \n" );
      fi;

      # -> parallisation if possible! (speed up of up to factor 3 for this step)
      Q := HomalgFieldOfRationalsInMAGMA();

      matrix1 := UnderlyingMatrix( UnderlyingVectorSpaceMorphism( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                                                          variety,
                                                                          UnderlyingMorphism( Source( map ) ),
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
                                                                          UnderlyingMorphism( map ),
                                                                          TheZeroElement( DegreeGroup( CoxRing( variety ) ) ),
                                                                          Q,
                                                                          display_messages
                                                                          ) ) );
      Print( "\n \n" );

      matrix3 := UnderlyingMatrix( UnderlyingVectorSpaceMorphism( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                                                          variety,
                                                                          UnderlyingMorphism( Range( map ) ),
                                                                          TheZeroElement( DegreeGroup( CoxRing( variety ) ) ),
                                                                          Q,
                                                                          display_messages
                                                                          ) ) );
      Print( "\n \n" );

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

InstallMethod( InternalHomDegreeZeroOnObjectsWrittenToFiles,
               " for a toric variety, a f.p. graded left S-module, a f.p. graded left S-module",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsGradedLeftOrRightModulePresentationForCAP ],
  function( variety, a, b )
      local range, source, map, matrix1, matrix2, matrix3, new_mat, vec_space_morphism;

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
      Print( Concatenation( "We will now compute the map of graded module presentations, ",
                            "whose kernel is the InternalHOM that we are interested in... \n" ) );
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
      map := ByASmallerPresentation( map );

      # inform that we have the graded module presentation morphism and will now try to truncate it
      Print( "Computed the map of graded module presentations. Will now truncate it... \n" );


      # -> parallisation if possible! (speed up of up to factor 3 for this step)
      # use e.g. MPI-gap!
      matrix1 := WriteDegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphismToFileForMAGMA( variety,
                                                                          UnderlyingMorphism( Source( map ) ),
                                                                          TheZeroElement( DegreeGroup( CoxRing( variety ) ) ),
                                                                          "matrix1"
                                                                         );
      Print( "\n \n" );
      matrix2 := WriteDegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphismToFileForMAGMA( variety,
                                                                          UnderlyingMorphism( map ),
                                                                          TheZeroElement( DegreeGroup( CoxRing( variety ) ) ),
                                                                          "matrix2"
                                                                         );
      Print( "\n \n" );
      matrix3 := WriteDegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphismToFileForMAGMA( variety,
                                                                          UnderlyingMorphism( Range( map ) ),
                                                                          TheZeroElement( DegreeGroup( CoxRing( variety ) ) ),
                                                                          "matrix3"
                                                                         );
      Print( "\n \n" );

      # inform that the matrices have been computed and we now compute the syzygies
      Print( "All matrices computed and written to files... \n" );

      # return that computation was successful
      return true;

end );

InstallMethod( InternalHomDegreeZeroOnMorphisms,
               " for a toric variety, a f.p. graded left S-module, a f.p. graded left S-module",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsBool ],
  function( variety, mor1, mor2, display_messages )
      local range, source, map, Q, matrix1, matrix2, matrix3, source_vec_space_pres, range_vec_space_pres, map_vec_space_pres,
           ker1, ker2, bridge;

      # Let mor1: A -> A' and mor2: B -> B' and let A = (R_A - \rho_A G_A ) and alike for the others. Then we need to compute the 
      # morphism Hom( A', B ) -> Hom( A, B' ). 


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

      # compute the map or graded module preseentations
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
      map := ByASmallerPresentation( map );

      # inform that we have the graded module presentation morphism and will now try to truncate it
      if display_messages then
        Print( Concatenation( "Computed the map of graded module presentations whose kernel is GradedHom( Range( mor1 ), Source( mor2 ) ).",
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

      # compute the map or graded module preseentations
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
      map := ByASmallerPresentation( map );

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


# compute H^0 by applying the theorem from Greg Smith
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
## Section Parameter checker for the theorem of G.S.
##
#############################################################

# this methods checks if the conditions in the theorem by Greg Smith are satisfied
BindGlobal( "TORIC_VARIETIES_INTERNAL_GS_PARAMETER_CHECK_FOR_CAP",
  function( variety, e, module, u, Index )
    local B_generators, B, aB01, d, i, j, C, a_module;
    #local B, BPower, aB, aB01, d, i, j, C, deg, div, result;

    # check if Index is meaningful
    if Index < 0 then

      Error( "Index must be non-negative." );
      return false;

    elif Index > Dimension( variety ) then

      Error( "Index must not be greater than the dimension of the variety." );
      return false;

    fi;

    # we compute the e-th Frobenius power of the degree u layer (considered as S-module)
    B_generators := DegreeXLayer( variety, u );
    B_generators := List( [ 1 .. Length( B_generators ) ], k -> B_generators[ k ]^e );
    B := GradedLeftSubmoduleForCAP( TransposedMat( [ B_generators ] ), CoxRing( variety ) );

    # compute the respective degree that is needed to compare
    aB01 := UnderlyingListOfRingElements( DegreeList( Range( UnderlyingMorphism( PresentationForCAP( B ) ) ) )[ 1 ][ 1 ] );

    # compute the Betti table of the module - since this is an attribute, we compute it only once
    a_module := BettiTableForCAP( module );

    # determine the range in which we need to perform checks
    d := Minimum( Dimension( variety ) - Index, Length( a_module ) -1 );

    # compute the improved vanishing set
    #C := ImprovedVanishingSetForGS( variety );
    C := GSCone( variety );

    # now check the GS-criterion
    for i in [ 0 .. d ] do
      for j in [ 1 .. Length( a_module[ i+1 ] ) ] do

        # check if aB01 - a_module[ i+1 ][ j ] is contained in the improved vanishing set
        #if not PointContainedInVanishingSet( C, aB01 - UnderlyingListOfRingElements( a_module[ i+1 ][ j ] ) ) then
        if not PointContainedInCone( C, aB01 - UnderlyingListOfRingElements( a_module[ i+1 ][ j ] ) ) then
          return false;
        fi;

      od;
    od;

    # if nothing unusual was found, the criterion is satisfied and we return 'true'
    return true;

end );



#############################################################
##
## Section Computation of H0 by my theorem
##
#############################################################

# compute H^0 by applying the theorem from Greg Smith
InstallMethod( H0,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool, IsBool, IsBool ],
  function( variety, module, saturation_wished, fast_algorithm_wished, display_messages )
    local deg, ideal_generators, B, mSat, e, B_power, zero, GH, vec_space_morphism;

    # check that the input is valid to work with
    if not IsSmooth( variety ) then

      Error( "Variety must be smooth" );
      return;

    elif not IsProjective( variety ) then

      Error( "Variety must be projective (which implies completness)" );
      return;

    fi;

    # compute smallest ample divisor via Nef cone
    deg := ClassOfSmallestAmpleDivisor( variety );

    # and the corresponding ideal in the Coxring that is generated by this degree layer
    ideal_generators := DegreeXLayer( variety, deg );
    B := GradedLeftSubmoduleForCAP( TransposedMat( [ ideal_generators ] ), CoxRing( variety ) );

    # saturate the module
    mSat := module;
    if saturation_wished then
      mSat := Saturate( module, B );
    fi;

    # and check if mSat is a submodule (if so, replace it by a presentation)
    if IsGradedLeftOrRightSubmoduleForCAP( mSat ) then
      mSat := PresentationForCAP( mSat );
    fi;

    # determine integer e that we need to perform the computation of the cohomology
    e := 0;
    while not TORIC_VARIETIES_INTERNAL_GS_PARAMETER_CHECK_FOR_CAP( variety, e, mSat, deg, 0 ) do
      e := e + 1;
    od;

    # inform the user that we have found a suitable e
    if display_messages then
      Print( Concatenation( "Found integer: ", String( e ) , "\n" ) );
    fi;

    # we have a specialised algorithm for H0 of vector bundles
    zero := List( [ 1 .. Rank( ClassGroup( variety ) ) ], x -> 0 );
    if IsZeroForObjects( Source( UnderlyingMorphism( mSat ) ) ) then
      return [ e, UnderlyingVectorSpaceObject(
                             DegreeXLayerOfProjectiveGradedLeftOrRightModule(
                               variety,
                               Range( UnderlyingMorphism( mSat ) ),
                               zero
                               )
                                        ) ];
    fi;

    # compute the appropriate Frobenius power of the ideal B
    ideal_generators := List( [ 1 .. Length( ideal_generators ) ], k -> ideal_generators[ k ]^e );
    B_power := GradedLeftSubmoduleForCAP( TransposedMat( [ ideal_generators ] ), CoxRing( variety ) );

    # compute H0 as a vector space presentation
    if fast_algorithm_wished then
      vec_space_morphism := TOOLS_FOR_HOMALG_GET_REAL_TIME_OF_FUNCTION_CALL(
                                  InternalHomDegreeZeroOnObjects,
                                            variety,
                                            PresentationForCAP( B_power ),
                                            mSat,
                                            display_messages
                                  );
    else
      vec_space_morphism := TOOLS_FOR_HOMALG_GET_REAL_TIME_OF_FUNCTION_CALL(
                                  UnderlyingVectorSpaceMorphism,
                                       DegreeXLayer( variety,
                                                     ByASmallerPresentation( InternalHomOnObjects( PresentationForCAP( B_power ), mSat ) ),
                                                     zero,
                                                     display_messages
                                                     )
                                  );

    fi;

    # signal end of computation
    if display_messages then
      Print( "\n" );
      Print( Concatenation( "Computation finished after ", String( vec_space_morphism[ 1 ] ), " seconds and found: \n" ) );
      Print( Concatenation( "(*) used ideal power: ", String( e ), "\n" ) );
      Print( Concatenation( "(*) h^0 = ", String( Dimension( CokernelObject( vec_space_morphism[ 2 ] ) ) ), "\n \n" ) );
    fi;

    # return the cokernel object of this presentation
    return [ e, CokernelObject( vec_space_morphism[ 2 ] ) ];

end );

InstallMethod( H0,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool, IsBool ],
  function( variety, module, saturation_wished, fast_algorithm_wished )

    return H0( variety, module, saturation_wished, fast_algorithm_wished, false );

end );

InstallMethod( H0,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool ],
  function( variety, module, saturation_wished )

    return H0( variety, module, saturation_wished, true, false );

end );

InstallMethod( H0,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ],
  function( variety, module )

    return H0( variety, module, false, true, false );

end );



#############################################################
##
#! @Section My theorem implemented to compute Hi
##
#############################################################

# compute H^i by applying my theorem
InstallMethod( Hi,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsBool, IsBool, IsBool ],
  function( variety, module, index, saturation_wished, fast_algorithm_wished, display_messages )
    local deg, ideal_generators, B, mSat, e, B_power, zero, vec_space_morphism;

    # check that the input is valid to work with
    if not IsSmooth( variety ) then

      Error( "Variety must be smooth" );
      return;

    elif not IsProjective( variety ) then

      Error( "Variety must be projective (which implies completness)" );
      return;

    fi;

    # compute smallest ample divisor via Nef cone
    deg := ClassOfSmallestAmpleDivisor( variety );

    # and the corresponding ideal in the Coxring that is generated by this degree layer
    ideal_generators := DegreeXLayer( variety, deg );
    B := GradedLeftSubmoduleForCAP( TransposedMat( [ ideal_generators ] ), CoxRing( variety ) );

    # saturate the module
    if saturation_wished then
      mSat := Saturate( module, B );
    else
      mSat := module;
    fi;

    # handle the case that mSat is an ideal
    if IsGradedLeftOrRightIdealForCAP( mSat ) then
      mSat := PresentationForCAP( mSat );
    fi;

    # determine integer e that we need to perform the computation of the cohomology
    e := 0;
    while not TORIC_VARIETIES_INTERNAL_GS_PARAMETER_CHECK_FOR_CAP( variety, e, mSat, deg, index ) do
      e := e + 1;
    od;

    # inform the user that we have found a suitable e
    if display_messages then
      Print( Concatenation( "Found integer: ", String( e ) , "\n" ) );
    fi;

    # we have a specialised algorithm for H0 of vector bundles
    zero := List( [ 1 .. Rank( ClassGroup( variety ) ) ], x -> 0 );
    if index = 0 and IsZeroForObjects( Source( UnderlyingMorphism( mSat ) ) ) then
      return [ e, UnderlyingVectorSpaceObject(
                             DegreeXLayerOfProjectiveGradedLeftOrRightModule(
                               variety,
                               Range( UnderlyingMorphism( mSat ) ),
                               zero
                               )
                                        ) ];
    fi;

    # compute the appropriate Frobenius power of the ideal B
    ideal_generators := List( [ 1 .. Length( ideal_generators ) ], k -> ideal_generators[ k ]^e );
    B_power := GradedLeftSubmoduleForCAP( TransposedMat( [ ideal_generators ] ), CoxRing( variety ) );

    # compute the GradedExt_0:
    if fast_algorithm_wished then
      vec_space_morphism := TOOLS_FOR_HOMALG_GET_REAL_TIME_OF_FUNCTION_CALL(
                                  GradedExtDegreeZeroOnObjects,
                                            index,
                                            variety,
                                            PresentationForCAP( B_power ),
                                            mSat,
                                            display_messages
                                  );
    else
      vec_space_morphism := TOOLS_FOR_HOMALG_GET_REAL_TIME_OF_FUNCTION_CALL(
                                  UnderlyingVectorSpaceMorphism,
                                       DegreeXLayer( variety,
                                                     ByASmallerPresentation( GradedExtForCAP( index, PresentationForCAP( B_power ), mSat ) ),
                                                     zero,
                                                     display_messages
                                                     )
                                  );

    fi;

    # signal end of computation
    if display_messages then
      Print( "\n" );
      Print( Concatenation( "Computation finished after ", String( vec_space_morphism[ 1 ] ), " seconds and found: \n" ) );
      Print( Concatenation( "(*) used ideal power: ", String( e ), "\n" ) );
      Print( Concatenation( "(*) h^", String( index ), " = ", String( Dimension( CokernelObject( vec_space_morphism[ 2 ] ) ) ), "\n \n" ) );
    fi;

    # and return the result
    return [ e, CokernelObject( vec_space_morphism[ 2 ] ) ];

end );

InstallMethod( Hi,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsBool, IsBool ],
  function( variety, module, index, saturation_wished, fast_algorithm_wished )

    return Hi( variety, module, index, saturation_wished, fast_algorithm_wished, false );

end );

InstallMethod( Hi,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsBool ],
  function( variety, module, index, saturation_wished )

    return Hi( variety, module, index, saturation_wished, true, false );

end );

InstallMethod( Hi,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt ],
  function( variety, module, index )

    return Hi( variety, module, index, false, true, false );

end );



###################################################################################
##
#! @Section My theorem implemented to compute all cohomology classes
##
###################################################################################

# compute all cohomology classes by my theorem
InstallMethod( AllHi,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool, IsBool, IsBool ],
  function( variety, module, saturation_wished, fast_algorithm_wished, display_messages )
    local deg, ideal_generators, B, mSat, e, e_list, B_power, zero, GE, vec_space_morphism, cohoms, i, total_time;

    # check that the input is valid to work with
    if not IsSmooth( variety ) then

      Error( "Variety must be smooth." );
      return false;

    elif not IsProjective( variety ) then

      Error( "Variety must be projective. Note that this implies completness." );
      return false;

    fi;

    # compute smallest ample divisor via Nef cone
    deg := ClassOfSmallestAmpleDivisor( variety );

    # and the corresponding ideal in the Coxring that is generated by this degree layer
    ideal_generators := DegreeXLayer( variety, deg );
    B := GradedLeftSubmoduleForCAP( TransposedMat( [ ideal_generators ] ), CoxRing( variety ) );

    # saturate the module
    if saturation_wished then
      mSat := Saturate( module, B );
    else
      mSat := module;
    fi;

    # handle the case that mSat is an ideal
    if IsGradedLeftOrRightIdealForCAP( mSat ) then
      mSat := PresentationForCAP( mSat );
    fi;

    # determine integer e that we need to perform the computation of the cohomology
    e_list := List( [ 1 .. Dimension( variety ) + 1 ] );
    for i in [ 1 .. Dimension( variety ) + 1 ] do
      e := 0;
      while not TORIC_VARIETIES_INTERNAL_GS_PARAMETER_CHECK_FOR_CAP( variety, e, mSat, deg, i-1 ) do
        e := e + 1;
      od;
      e_list[ i ] := e;
    od;

    # inform the user that we have found a suitable e
    if display_messages then
      Print( "Computed the ideal powers needed... \n" );
      Print( "We start the cohomology computations... \n \n" );
    fi;

    # we have a specialised algorithm for H0 of vector bundles
    zero := List( [ 1 .. Rank( ClassGroup( variety ) ) ], x -> 0 );

    # initialise cohoms
    cohoms := List( [ 1 .. Dimension( variety ) + 1 ] );

    # and loop over the cohomology groups
    total_time := 0;
    for i in [ 1 .. Dimension( variety ) + 1 ] do

      # inform about the status
      if display_messages then
        Print( "------------------------------------------------------------------------------------------\n" );
        Print( Concatenation( "We compute h^", String( i-1 ), " from power ", String( e_list[ i ] ), "... \n" ) );
        Print( "------------------------------------------------------------------------------------------\n \n" );
      fi;

      # compute the appropriate Frobenius power of the ideal B
      ideal_generators := List( [ 1 .. Length( ideal_generators ) ], k -> ideal_generators[ k ]^e_list[ i ] );
      B_power := GradedLeftSubmoduleForCAP( TransposedMat( [ ideal_generators ] ), CoxRing( variety ) );

      # compute the GradedExt_0:
      if fast_algorithm_wished then
        vec_space_morphism := TOOLS_FOR_HOMALG_GET_REAL_TIME_OF_FUNCTION_CALL(
                                    GradedExtDegreeZeroOnObjects,
                                              i-1,
                                              variety,
                                              PresentationForCAP( B_power ),
                                              mSat,
                                              display_messages
                                    );
      else
        vec_space_morphism := TOOLS_FOR_HOMALG_GET_REAL_TIME_OF_FUNCTION_CALL(
                                    UnderlyingVectorSpaceMorphism,
                                         DegreeXLayer( variety,
                                                   ByASmallerPresentation( GradedExtForCAP( i-1, PresentationForCAP( B_power ), mSat ) ),
                                                   zero,
                                                   display_messages
                                                   )
                                    );

      fi;

      # save the result
      cohoms[ i ] := [ e_list[ i ], CokernelObject( vec_space_morphism[ 2 ] ) ];

      # increase the total time elapsed
      total_time := total_time + vec_space_morphism[ 1 ];

      # inform that this computation is finished
      if display_messages then
        Print( Concatenation( "Finished computation of h^", String( i-1 ), "after ", String( vec_space_morphism[ 1 ] ), "seconds.",
                              " Result: \n" ) );
        Print( Concatenation( "h^", String( i-1 ), " = ", String( Dimension( cohoms[ i ][ 3 ] ) ), "\n \n" ) );
        Print( "---------------------------------- \n \n" );
      fi;

    od;

    # computation completely finished, so print summary
    if display_messages then

      Print( Concatenation( "Finished all computation after ", String( total_time ), "seconds."," Results: \n" ) );
      for i in [ 1 .. Dimension( variety ) + 1 ] do
        Print( Concatenation( "h^", String( i-1 ), " = ", String( Dimension( cohoms[ i ][ 3 ] ) ), " (from power ", 
                               String( e_list[ i ] ), ") \n" ) );

      od;
    fi;

    # and finally return the results
    return cohoms;

end );

InstallMethod( AllHi,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool, IsBool ],
  function( variety, module, saturation_wished, fast_algorithm_wished )

    return AllHi( variety, module, saturation_wished, fast_algorithm_wished, false );

end );

InstallMethod( AllHi,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool ],
  function( variety, module, saturation_wished )

    return AllHi( variety, module, saturation_wished, true, false );

end );

InstallMethod( AllHi,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ],
  function( variety, module )

    return AllHi( variety, module, false, true, false );

end );



#######################################################################
##
## Section Write matrices to be used for H0 computation via GS to files
##
#######################################################################

# compute H^0 by applying the theorem from Greg Smith
InstallMethod( H0ByGSWritingMatricesUsedByFastInternalHomToFilesForCAP,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool ],
  function( variety, module, saturation_wished )
    local deg, ideal_generators, B, mSat, e, B_power, vec_space_presentation;

    # check that the input is valid to work with
    if not IsSmooth( variety ) then

      Error( "Variety must be smooth" );
      return;

    elif not IsProjective( variety ) then

      Error( "Variety must be projective (which implies completness)" );
      return;

    fi;

    # compute smallest ample divisor via Nef cone
    deg := ClassOfSmallestAmpleDivisor( variety );

    # and the corresponding ideal in the Coxring that is generated by this degree layer
    ideal_generators := DegreeXLayer( variety, deg );
    B := GradedLeftSubmoduleForCAP( TransposedMat( [ ideal_generators ] ), CoxRing( variety ) );

    # saturate the module
    mSat := module;
    if saturation_wished then
      mSat := Saturate( module, B );
    fi;

    # turn into module presentation if needed
    if IsGradedLeftOrRightSubmoduleForCAP( mSat ) then
      mSat := PresentationForCAP( mSat );
    fi;

    # determine integer e that we need to perform the computation of the cohomology
    e := 0;
    while not TORIC_VARIETIES_INTERNAL_GS_PARAMETER_CHECK_FOR_CAP( variety, e, mSat, deg, 0 ) do
      e := e + 1;
    od;

    # inform the user that we have found a suitable e
    Print( Concatenation( "Found integer: ", String( e ) , "\n" ) );

    # compute the appropriate Frobenius power of the ideal B
    ideal_generators := List( [ 1 .. Length( ideal_generators ) ], k -> ideal_generators[ k ]^e );
    B_power := GradedLeftSubmoduleForCAP( TransposedMat( [ ideal_generators ] ), CoxRing( variety ) );

    # compute the necessary matrices and save them to files
    InternalHomDegreeZeroOnObjectsWrittenToFiles( variety, PresentationForCAP( B_power ), mSat );

    # return true
    return true;

end );

# compute H^0 by applying the theorem from Greg Smith
InstallMethod( H0ByGSWritingMatricesUsedByFastInternalHomToFilesForCAP,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ],
  function( variety, module )

    return H0ByGSWritingMatricesUsedByFastInternalHomToFilesForCAP( variety, module, false );

end );