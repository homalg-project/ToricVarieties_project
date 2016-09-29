########################################################################################
##
##  MyCohom.gi            ToricVarieties package
##
##  Copyright 2015- 2016, Sebastian Gutsche, TU Kaiserslautern
##                        Martin Bies,       ITP Heidelberg
##
#! @Chapter Methods to implement my improved cohomology theorems
##
#########################################################################################
# use a sufficient condition to tell if a sheaf cohomology class vanishes
InstallMethod( CriterionForVanishingSheafCohomologyClass,
               " for toric varieties, a graded module presentation for CAP, an integer and a list of integers",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsList ],
  function( variety, module, m, v )
    local vanishing_sets, n, k, l, bettis;

    # check that the variety matches our general requirements
    if not IsSmooth( variety ) then

      Error( "The variety has to be smooth and complete" );
      return;

    elif not IsComplete( variety ) then

      Error( "The variety has to be smooth and complete" );
      return;

    elif m < 0 or m > Dimension( variety ) then

      Error( "The cohomological index must be non-negative and must not exceed the dimension of the variety" );
      return;

    fi;

    # next compute the vanishing sets
    vanishing_sets := VanishingSets( variety );

    # compute the dimension of the variety
    n := Dimension( variety );

    # compute the Betti numbers of the module
    bettis := BettiTableForCAP( module );

    # now make checks
    for k in [ 0 .. n - m ] do

      # only if there are more betti numbers to analyse, proceed
      if Length( bettis ) > k then

        for l in [ 1 .. Length( bettis[ k + 1 ] ) ] do

          if not m + 1 + k > Length( vanishing_sets ) then

            if not PointContainedInVanishingSet( vanishing_sets[ m + k + 1 ], v - UnderlyingListOfRingElements( bettis[ k + 1 ][ l ] ) ) then
              return false;
            fi;

          fi;

        od;

      fi;

    od;

    # all checks passed, so return true
    return true;

end );

# use a sufficient condition to tell if a local cohomology class vanishes
InstallMethod( CriterionForVanishingLocalCohomologyClass,
               " for toric varieties, a graded module presentation for CAP, an integer, a list of integers",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsList ],
  function( variety, module, m, v )
    local vanishing_sets, n, k, l, bettis;

    # check that the variety matches our general requirements
    if not IsSmooth( variety ) then

      Error( "The variety has to be smooth and complete" );
      return;

    elif not IsComplete( variety ) then

      Error( "The variety has to be smooth and complete" );
      return;

    elif m < 0 or m > Dimension( variety ) + 1 then

      Error( "The cohomological index must be non-negative and must not exceed the dimension of the variety plus one" );
      return;

    fi;

    # if m = 2 ... n+1
    # if m = 2 ... n+1
    if m > 1 then

      return CriterionForVanishingSheafCohomologyClass( variety, module, m - 1, v );

    # if however m = 1 then
    # if however m = 1 then
    elif m = 1 then

      # compute the Betti numbers of the module
      bettis := BettiTableForCAP( module );

      # next compute the vanishing sets
      vanishing_sets := VanishingSets( variety );

      # now iterate over twists
      for l in [ 2 .. Length( bettis ) ] do

        for k in [ 1 .. Length( bettis[ l ] ) ] do

          # and check if the projective modules in the resolution satisfy certain conditions on the sheaf cohomology classes
          if not PointContainedInVanishingSet( vanishing_sets[ l ], v - UnderlyingListOfRingElements( bettis[ l ][ k ] ) ) then
            return false;
          fi;

        od;

      od;

      # if all tests are passed, return true
      return true;

    # finally if m = 0 then
    # finally if m = 0 then
    elif m = 0 then

      # compute the Betti numbers of the module
      bettis := BettiTableForCAP( module );

      # next compute the vanishing sets
      vanishing_sets := VanishingSets( variety );

      # now iterate over twists
      for l in [ 3 .. Length( bettis ) ] do

        for k in [ 1 .. Length( bettis[ l ] ) ] do

          # and check if the projective modules in the resolution satisfy certain conditions on the sheaf cohomology classes
          if not PointContainedInVanishingSet( vanishing_sets[ l-1 ], v - UnderlyingListOfRingElements( bettis[ l ][ k ] ) ) then
            return false;
          fi;

        od;

      od;

      # if all tests are passed, return true
      return true;

    fi;

end );

InstallMethod( Criterion,
               " for toric varieties, two graded module presentations for CAP, and an integer",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsGradedLeftOrRightModulePresentationForCAP, IsInt ],
  function( variety, module1, module2, m )
    local bettis_module2, u, j;

    # check that the variety matches our general requirements
    if not IsSmooth( variety ) then

      Error( "The variety has to be smooth and complete" );
      return;

    elif not IsComplete( variety ) then

      Error( "The variety has to be smooth and complete" );
      return;

    elif m < 0 or m > Dimension( variety ) then

      Error( "The cohomological index must be non-negative and must not exceed the dimension of the variety" );
      return;

    fi;

    # otherwise compute the betti numbers of module2
    bettis_module2 := BettiTableForCAP( module2 );

    # now iterate to perform tests on the vanishing of sheaf cohomology
    for u in [ 1 .. m ] do

      # only proceed if module2 has b_{m-u}
      if Length( bettis_module2 ) >= m - u + 1 then

        # then iterate over all these betti numbers
        for j in [ 1 .. Length( bettis_module2[ m - u + 1 ] ) ] do

          # check if H^u( N( a_{m-u,j}(M) ) ) = 0
          if not CriterionForVanishingSheafCohomologyClass( variety,
                                                            module1,
                                                            u,
                                                            UnderlyingListOfRingElements( bettis_module2[ m - u + 1 ][ j ] ) 
                                                           ) then
            return false;
          fi;

          # check if H^{u-1}( N( a_{m-u,j}(M) ) ) = 0
          if u > 1 then

            if not CriterionForVanishingSheafCohomologyClass( variety,
                                                              module1,
                                                              u,
                                                              UnderlyingListOfRingElements( bettis_module2[ m - u + 1 ][ j ] )
                                                             ) then
              return false;
            fi;

          fi;

        od;

      fi;

    od;

    # now perform checks on the local cohomology

    # test that the chain morphism at position m - 1 is an epi by checking the vanishing of local cohomology
    #if m > 0 and Length( bettis_module2 ) >= m then

      #for j in [ 1 .. Length( bettis_module2[ m ] ) ] do

        #if not CriterionForVanishingLocalCohomologyClass( variety,
        #                                                  module1,
        #                                                  1,
        #                                                  UnderlyingListOfRingElements( bettis_module2[ m ][ j ] )
        #                                                 ) then
        #  return false;
        #fi;

      #od;

    #fi;

    # test that the chain morphism at position m is an iso by checking the vanishing of local cohomology
    if Length( bettis_module2 ) >= m + 1 then

      for j in [ 1 .. Length( bettis_module2[ m + 1 ] ) ] do

        if not CriterionForVanishingLocalCohomologyClass( variety,
                                                          module1,
                                                          0,
                                                          UnderlyingListOfRingElements( bettis_module2[ m + 1 ][ j ] )
                                                         ) then
          return false;
        fi;

        if not CriterionForVanishingLocalCohomologyClass( variety,
                                                          module1,
                                                          1,
                                                          UnderlyingListOfRingElements( bettis_module2[ m + 1 ][ j ] )
                                                         ) then
          return false;
        fi;

      od;

    fi;

    # all tests passed, so return true
    return true;

end );




















# experimental methods

# compute H^i by applying the theorem from Greg Smith
InstallMethod( MyHiForCAP,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsBool, IsBool, IsBool ],
  function( variety, module, index, saturation_wished, fast_algorithm_wished, display_messages )
    local deg, ideal_generators, B, mSat, e, new_gens, B_power, zero, vec_space_morphism;

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
    while not Criterion( variety, PresentationForCAP( B ), mSat, index ) do
      # compute higher ideal power
      e := e + 1;
      new_gens := List( [ 1 .. Length( ideal_generators ) ], k -> ideal_generators[ k ]^e );
      B := GradedLeftSubmoduleForCAP( TransposedMat( [ new_gens ] ), CoxRing( variety ) );
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
    # can optimise these lines...
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

InstallMethod( MyHiForCAP,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsBool, IsBool ],
  function( variety, module, index, saturation_wished, fast_algorithm_wished )

    return HiByGSForCAP( variety, module, index, saturation_wished, fast_algorithm_wished, false );

end );

InstallMethod( MyHiForCAP,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsBool ],
  function( variety, module, index, saturation_wished )

    return HiByGSForCAP( variety, module, index, saturation_wished, true, false );

end );

InstallMethod( MyHiForCAP,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt ],
  function( variety, module, index )

    return HiByGSForCAP( variety, module, index, false, true, false );

end );










# yet more experimental methods

InstallMethod( PrintE1SheetToTerminal,
               " for a toric variety and a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ],
  function( variety, module )
    local cohomologies, cohomologies2;

    # check that the input is valid to work with
    if not IsSmooth( variety ) then

      Error( "Variety must be smooth" );
      return;

    elif not IsProjective( variety ) then

      Error( "Variety must be projective (which implies completness)" );
      return;

    fi;

    # next compute the cohomology classes of the vector bundles in this resolution by use of cohomCalg
    cohomologies := CohomologiesList( variety, module );

    # invert the order to have the cohomologies displayed nicely
    cohomologies2 := List( [ 1 .. Length( cohomologies ) ], k -> cohomologies[ Length( cohomologies ) - k + 1 ] );

    # now form a HomalgMatrix from it to display the content nicely
    Display( HomalgMatrix( cohomologies2, HOMALG_MATRICES.ZZ ) );

    # done, so return true
    return true;

end );

# compute H^i by applying Koszul resolution and truncation by ample point such that E_1-sheet of Koszul spectral sequence degenerates
# I do not yet know if this is always possible, but it seems likely at least
InstallMethod( MyHiForCAPFromKoszul,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt ],
  function( variety, module, index )
    local deg, ideal_generators,  mSat, e, B, truncated_mSat, gens;

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

    # and identify the ideal generators
    ideal_generators := DegreeXLayer( variety, deg );

    # handle the case that mSat is an ideal
    if IsGradedLeftOrRightIdealForCAP( module ) then
      mSat := PresentationForCAP( module );
    else
      mSat := module;
    fi;

    # now iterate over the integers and compute the cohomology classes on the E1-sheet of the Koszul spectral sequence by use of cohomCalg
    # print them to the terminal for me to examine
    e := 0;
    while e < 5 do

      # inform what integer we are at
      Print( Concatenation( "Analyse e = ", String( e ), ": \n" ) );

      # compute ideal power
      gens := List( [ 1 .. Length( ideal_generators ) ], k -> ideal_generators[ k ]^e );
      B := GradedLeftSubmoduleForCAP( TransposedMat( [ gens ] ), CoxRing( variety ) );

      #Error( "Test" );

      # now truncate mSat by tensoring it with the ideal B
      truncated_mSat := mSat * PresentationForCAP( B );
      #FullInformation( MinimalFreeResolutionForCAP( truncated_mSat ) );
      #Print( "\n" );

      # now print the E1-sheet
      PrintE1SheetToTerminal( variety, truncated_mSat );
      Print( "\n \n" );

      # now increase e
      e := e + 1;

    od;

    # and inform that we are done now
    Print( "Analyse complete \n" );

end );