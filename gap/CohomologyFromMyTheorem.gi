#########################################################################################
##
##  CohomologyFromMyTheorem.gi         SheafCohomologyOnToricVarieties package
##
##  Copyright 2019                     Martin Bies,       ULB Brussels
##
#! @Chapter Sheaf cohomology via my cohomology theorem
##
#########################################################################################

# global variable used to determine if Magma is to be used or not
#SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_FIELD := HomalgFieldOfRationalsInSingular();
SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_FIELD := HomalgFieldOfRationalsInMagma();

#############################################################
##
## Truncations of InternalHoms of FpGradedModules
##
#############################################################

InstallMethod( TruncateInternalHom,
               " for a toric variety, an f.p. graded module, an f.p. graded module, a bool ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsList, IsBool ],
  function( variety, a, b, degree, display_messages )
      local range, source, map;

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

      # inform about status
      if display_messages then
        Print( "Compute FpGradedModuleMorphism whose kernel is the InternalHom...\n" );
      fi;

      # determine morphism whose kernel is the InternalHom in question
      range := TensorProductOnMorphisms( IdentityMorphism( DualOnObjects( Source( RelationMorphism( a ) ) ) ),
                                         RelationMorphism( b ) );
      source := TensorProductOnMorphisms( IdentityMorphism( DualOnObjects( Range( RelationMorphism( a ) ) ) ),
                                          RelationMorphism( b ) );
      map := TensorProductOnMorphisms( DualOnMorphisms( RelationMorphism( a ) ),
                                       IdentityMorphism( Range( RelationMorphism( b ) ) ) );

      # inform about status again
      if display_messages then
        Print( "Truncate it now... \n" );
      fi;

      # and return the truncation
      return TruncateFPGradedModuleMorphism( variety,
                                             FreydCategoryMorphism( range, map, source ),
                                             degree,
                                             display_messages,
                                             SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_FIELD );

end );

InstallMethod( TruncateInternalHomToZero,
               " for a toric variety, an f.p. graded module, an f.p. graded module, a bool ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsBool ],
  function( variety, a, b, display_messages )

    return TruncateInternalHom( variety, a, b,
                                UnderlyingListOfRingElements( TheZeroElement( DegreeGroup( CoxRing( variety ) ) ) ),
                                display_messages );

end );

InstallMethod( TruncateInternalHomInParallel,
               " for a toric variety, an f.p. graded module, an f.p. graded module, a bool ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsList, IsBool ],
  function( variety, a, b, degree, display_messages )
      local range, source, map, Q;

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

      # inform about status
      if display_messages then
        Print( "Compute FpGradedModuleMorphism whose kernel is the InternalHom...\n" );
      fi;

      # determine morphism whose kernel is the InternalHom in question
      range := TensorProductOnMorphisms( IdentityMorphism( DualOnObjects( Source( RelationMorphism( a ) ) ) ),
                                         RelationMorphism( b ) );
      source := TensorProductOnMorphisms( IdentityMorphism( DualOnObjects( Range( RelationMorphism( a ) ) ) ),
                                          RelationMorphism( b ) );
      map := TensorProductOnMorphisms( DualOnMorphisms( RelationMorphism( a ) ),
                                       IdentityMorphism( Range( RelationMorphism( b ) ) ) );

      # inform about status again
      if display_messages then
        Print( "Truncate it now... \n" );
      fi;

      # and return the truncation
      return TruncateFPGradedModuleMorphismInParallel( variety,
                                             FreydCategoryMorphism( range, map, source ),
                                             degree,
                                             [ 2, 2, 3 ],
                                             display_messages,
                                             SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_FIELD );

end );

InstallMethod( TruncateInternalHomToZeroInParallel,
               " for a toric variety, an f.p. graded module, an f.p. graded module, a bool ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsBool ],
  function( variety, a, b, display_messages )

    return TruncateInternalHomInParallel( variety, a, b,
                                          UnderlyingListOfRingElements( TheZeroElement( DegreeGroup( CoxRing( variety ) ) ) ),
                                          display_messages );

end );

InstallMethod( TruncateInternalHomEmbedding,
               " for a toric variety, an f.p. graded module, an f.p. graded module, a bool ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsList, IsBool ],
  function( variety, a, b, degree, display_messages )
      local vector_space_pres_morphism;

      vector_space_pres_morphism := TruncateInternalHom( variety, a, b, degree, display_messages );

      if display_messages then
        Print( "Compute kernel embedding... \n" );
      fi;

      return KernelEmbedding( vector_space_pres_morphism );

end );

InstallMethod( TruncateInternalHomEmbeddingToZero,
               " for a toric variety, an f.p. graded module, an f.p. graded module, a bool ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsBool ],
  function( variety, a, b, display_messages )

    return TruncateInternalHomEmbedding( variety, a, b,
                                         UnderlyingListOfRingElements( TheZeroElement( DegreeGroup( CoxRing( variety ) ) ) ),
                                         display_messages );

end );

InstallMethod( TruncateInternalHomEmbeddingInParallel,
               " for a toric variety, an f.p. graded module, an f.p. graded module, a bool ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsList, IsBool ],
  function( variety, a, b, degree, display_messages )
      local vector_space_pres_morphism;

      vector_space_pres_morphism := TruncateInternalHomInParallel( variety, a, b, degree, display_messages );

      if display_messages then
        Print( "Compute kernel embedding... \n" );
      fi;

      return KernelEmbedding( vector_space_pres_morphism );

end );

InstallMethod( TruncateInternalHomEmbeddingToZeroInParallel,
               " for a toric variety, an f.p. graded module, an f.p. graded module, a bool ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsBool ],
  function( variety, a, b, display_messages )

    return TruncateInternalHomEmbeddingInParallel( variety, a, b,
                                         UnderlyingListOfRingElements( TheZeroElement( DegreeGroup( CoxRing( variety ) ) ) ),
                                         display_messages );

end );

InstallMethod( TruncateInternalHom,
               " for a toric variety, a f.p. graded left S-module, a f.p. graded left S-module",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsFpGradedLeftOrRightModulesMorphism, IsBool ],
  function( variety, mor1, mor2, display_messages )
      local ker1, ker2, map, bridge;

      # mor1: A -> A'
      # mor2: B -> B'

      # compute kernel embedding IntHom( A', B );
      if display_messages then
        Print( "Compute FpGradedModuleMorphism whose kernel is InternalHom( A', B )...\n" );
      fi;
      ker1 := InternalHomEmbeddingDegreeZeroOnObjects( variety, Range( mor1 ), Source( mor2 ), display_messages );

      # compute kernel embedding IntHom( A, B' );
      if display_messages then
        Print( "Compute FpGradedModuleMorphism whose kernel is InternalHom( A, B' )...\n" );
      fi;
      ker2 := InternalHomEmbeddingDegreeZeroOnObjects( variety, Source( mor1 ), Range( mor2 ), display_messages );

      # check for degenerate cases first
      if Dimension( Range( RelationMorphism( Range( ker1 ) ) ) ) = 0 then
        map := ZeroMorphism( VectorSpaceObject( 0, SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_FIELD ),
                             Range( RelationMorphism( Range( ker2 ) ) ) );
      elif Dimension( Range( RelationMorphism( Range( ker2 ) ) ) ) = 0 then
        map  := ZeroMorphism( Range( RelationMorphism( Range( ker1 ) ) ),
                              VectorSpaceObject( 0, SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_FIELD ) );
      else
        # and only truncate by brute force if necessary
        map := TensorProductOnMorphisms( DualOnMorphisms( MorphismDatum( mor1 ) ), MorphismDatum( mor2 ) );
        map := TruncateGradedRowOrColumnMorphism( variety,
                                                  map,
                                                  TheZeroElement( DegreeGroup( CoxRing( variety ) ) ),
                                                  display_messages,
                                                  SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_FIELD );
      fi;
      bridge := FreydCategoryMorphism( Range( ker1 ), map_vec_space_pres, Range( ker2 ) );

      if display_messages then
        Print( "Compute lift...\n" );
      fi;
      return Lift( PreCompose( ker1, bridge ), ker2 );

end );

InstallMethod( TruncateInternalHomEmbeddingInParallel,
               " for a toric variety, a f.p. graded left S-module, a f.p. graded left S-module",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsFpGradedLeftOrRightModulesMorphism, IsBool ],
  function( variety, mor1, mor2, display_messages )
      local ker1, ker2, map, bridge;

      # mor1: A -> A'
      # mor2: B -> B'

      # compute kernel embedding IntHom( A', B );
      if display_messages then
        Print( "Compute FpGradedModuleMorphism whose kernel is InternalHom( A', B )...\n" );
      fi;
      ker1 := InternalHomEmbeddingDegreeZeroOnObjectsParallel( variety, Range( mor1 ), Source( mor2 ), display_messages );

      # compute kernel embedding IntHom( A, B' );
      if display_messages then
        Print( "Compute FpGradedModuleMorphism whose kernel is InternalHom( A, B' )...\n" );
      fi;
      ker2 := InternalHomEmbeddingDegreeZeroOnObjectsParallel( variety, Source( mor1 ), Range( mor2 ), display_messages );

      # compute the bridge map
      if display_messages then
        Print( "Compute bridge map...\n" );
      fi;

      # check for degenerate cases first
      if Dimension( Range( RelationMorphism( Range( ker1 ) ) ) ) = 0 then
        map := ZeroMorphism( VectorSpaceObject( 0, SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_FIELD ),
                             Range( RelationMorphism( Range( ker2 ) ) ) );
      elif Dimension( Range( RelationMorphism( Range( ker2 ) ) ) ) = 0 then
        map  := ZeroMorphism( Range( RelationMorphism( Range( ker1 ) ) ),
                              VectorSpaceObject( 0, SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_FIELD ) );
      else
        # and only truncate by brute force if necessary
        map := TensorProductOnMorphisms( DualOnMorphisms( MorphismDatum( mor1 ) ), MorphismDatum( mor2 ) );
        map := TruncateGradedRowOrColumnMorphismInParallel( variety,
                                                            map,
                                                            TheZeroElement( DegreeGroup( CoxRing( variety ) ) ),
                                                            3,
                                                            display_messages,
                                                            SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_FIELD );
      fi;
      bridge := FreydCategoryMorphism( Range( ker1 ), map_vec_space_pres, Range( ker2 ) );

      # finally compute the lift
      if display_messages then
        Print( "Compute lift...\n" );
      fi;
      return Lift( PreCompose( ker1, bridge ), ker2 );

end );


#############################################################
##
## Section Specialised GradedExt methods
##
#############################################################

InstallMethod( TruncateGradedExt,
               " for an integer, a toric variety, two f.p. graded modules and a bool ",
               [ IsInt, IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsBool ],
  function( i, variety, module1, module2, display_messages )
    local mu, graded_hom_mapping;

    # check input
    if i < 0 then
      Error( "the integer i must be non-negative" );
      return;
    elif IsFpGradedLeftModulesObject( module2 ) <> IsFpGradedLeftModulesObject( module1 ) then
      Error( "the two modules must either both be left or both be right modules" );
      return;
    fi;

    # extract i-th morphism in resolution
    if display_messages then
      Print( "Extract 'i-th' morphism in the resolution of first module... \n" );
    fi;

    if i = 0 then
      mu := ZeroMorphism( module1, ZeroObject( CapCategory( module1 ) ) );
    else
      mu := UnderlyingZFunctorCell( MinimalFreeResolutionForCAP( module1 ) )!.differential_func( -i );
      mu := AsFreydCategoryMorphism( mu );
      mu := KernelEmbedding( CokernelProjection( mu ) );
    fi;

    # compute IntHom( Range( mu ), module2 )_0 -> IntHom( Source( mu ), module2 )_0
    if display_messages then
      Print( "Compute morphism IntHom( Range( mu ), module2 )_0 -> IntHom( Source( mu ), module2 )_0... \n \n \n \n" );
    fi;
    graded_hom_mapping := TruncateInternalHom( variety, mu, IdentityMorphism( module2 ), display_messages );

    # compute cokernel object of the above morphism
    if display_messages then
      Print( "Compute cokernel object... \n \n" );
    fi;
    return CokernelObject( graded_hom_mapping );

end );

InstallMethod( TruncateGradedExtInParallel,
               " for an integer, a toric variety, two f.p. graded modules and a bool ",
               [ IsInt, IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsBool ],
  function( i, variety, module1, module2, display_messages )
    local mu, graded_hom_mapping;

    # check input
    if i < 0 then
      Error( "the integer i must be non-negative" );
      return;
    elif IsFpGradedLeftModulesObject( module2 ) <> IsFpGradedLeftModulesObject( module1 ) then
      Error( "the two modules must either both be left or both be right modules" );
      return;
    fi;

    # extract i-th morphism in resolution
    if display_messages then
      Print( "Extract 'i-th' morphism in the resolution of first module... \n" );
    fi;

    if i = 0 then
      mu := ZeroMorphism( module1, ZeroObject( CapCategory( module1 ) ) );
    else
      mu := UnderlyingZFunctorCell( MinimalFreeResolutionForCAP( module1 ) )!.differential_func( -i );
      mu := AsFreydCategoryMorphism( mu );
      mu := KernelEmbedding( CokernelProjection( mu ) );
    fi;

    # compute IntHom( Range( mu ), module2 )_0 -> IntHom( Source( mu ), module2 )_0
    if display_messages then
      Print( "Compute morphism IntHom( Range( mu ), module2 )_0 -> IntHom( Source( mu ), module2 )_0... \n \n \n \n" );
    fi;
    graded_hom_mapping := TruncateInternalHomInParallel( variety, mu, IdentityMorphism( module2 ), display_messages );

    # compute cokernel object of the above morphism
    if display_messages then
      Print( "Compute cokernel object... \n \n" );
    fi;
    return CokernelObject( graded_hom_mapping );

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

# compute H^0 by applying my theorem
InstallMethod( H0,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool, IsBool, IsBool ],
  function( variety, module, display_messages, very_detailed_output, timings )
    local module_presentation, zero, ideal_infos, B_power, vec_space_morphism;

    # check if the input is valid
    if not IsValidInputForCohomologyComputations( variety ) then

      Error( "The variety has to be smooth, complete (or simplicial, projective if you allow for lazy checks)" );
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

# compute H^0 by applying my theorem
InstallMethod( H0Parallel,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool, IsBool, IsBool ],
  function( variety, module, display_messages, very_detailed_output, timings )
    local module_presentation, zero, ideal_infos, B_power, vec_space_morphism;

    # check if the input is valid
    if not IsValidInputForCohomologyComputations( variety ) then

      Error( "The variety has to be smooth, complete (or simplicial, projective if you allow for lazy checks)" );
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
                                  InternalHomDegreeZeroOnObjectsParallel,
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
InstallMethod( H0Parallel,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool, IsBool ],
  function( variety, module, display_messages, very_detailed_output )

    # by default never show very detailed output
    return H0Parallel( variety, module, display_messages, very_detailed_output, true );

end );


# convenience method
InstallMethod( H0Parallel,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool ],
  function( variety, module, display_messages )

    # by default never show very detailed output
    return H0Parallel( variety, module, display_messages, false, true );

end );

# convenience method
InstallMethod( H0Parallel,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ],
  function( variety, module )

    # by default show messages but not the very detailed output
    return H0Parallel( variety, module, true, false, true );

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

    # check if the input is valid
    if not IsValidInputForCohomologyComputations( variety ) then

      Error( "The variety has to be smooth, complete (or simplicial, projective if you allow for lazy checks)" );
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


# compute H^i by applying my theorem, but use parallelisation for speedup
InstallMethod( HiParallel,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsBool, IsBool, IsBool ],
  function( variety, module, index, display_messages, very_detailed_output, timings )
    local module_presentation, ideal_infos, B_power, zero, vec_space_morphism;

    # check if the input is valid
    if not IsValidInputForCohomologyComputations( variety ) then

      Error( "The variety has to be smooth, complete (or simplicial, projective if you allow for lazy checks)" );
      return;

    fi;

    # check if the index makes sense
    if ( index < 0 ) or ( index > Dimension( variety ) ) then

      Error( "the cohomological index must not be negative and must not exceed the dimension of the variety" );
      return;

    fi;

    # if we compute H0 hand it over to that method
    if index = 0 then
      return H0Parallel( variety, module, display_messages, very_detailed_output, timings );
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
                                  GradedExtDegreeZeroOnObjectsParallel,
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

InstallMethod( HiParallel,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsBool, IsBool ],
  function( variety, module, index, display_messages, very_detailed_output )

    # by default never show very detailed output
    return HiParallel( variety, module, index, display_messages, very_detailed_output, true );

end );

InstallMethod( HiParallel,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsBool ],
  function( variety, module, index, display_messages )

    # by default never show very detailed output
    return HiParallel( variety, module, index, display_messages, false, true );

end );

InstallMethod( HiParallel,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt ],
  function( variety, module, index )

    # by default display messages but suppress the very detailed output
    return HiParallel( variety, module, index, true, false, true );

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

    # check if the input is valid
    if not IsValidInputForCohomologyComputations( variety ) then

      Error( "The variety has to be smooth, complete (or simplicial, projective if you allow for lazy checks)" );
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


# compute all cohomology classes by my theorem
InstallMethod( AllHiParallel,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool, IsBool ],
  function( variety, module, display_messages, timings )
    local cohoms, i, total_time;

    # check if the input is valid
    if not IsValidInputForCohomologyComputations( variety ) then

      Error( "The variety has to be smooth, complete (or simplicial, projective if you allow for lazy checks)" );
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
      cohoms[ i ] := HiParallel( variety, module, i-1, display_messages, false, timings );
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

InstallMethod( AllHiParallel,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool ],
  function( variety, module, display_messages )

    return AllHiParallel( variety, module, display_messages, true );

end );

InstallMethod( AllHiParallel,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ],
  function( variety, module )

    return AllHiParallel( variety, module, true, true );

end );
