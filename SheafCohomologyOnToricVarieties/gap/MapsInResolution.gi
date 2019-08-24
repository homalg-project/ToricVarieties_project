##########################################################################################
##
##  MapsInResolution.gi                SheafCohomologyOnToricVarieties package
##
##  Copyright 2019                     Martin Bies,       ULB Brussels
##
#! @Chapter Maps In Resolution
##
#########################################################################################



##############################################################################################
##
#! @Section Compute maps in minimal free resolution of a sheaf
##
##############################################################################################

# compute the maps in a minimal free resolution of a f.p. graded module presentation
InstallMethod( MapsInResolution,
               " a toric variety, a f.p. graded S-module",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ],
  function( variety, module )
    local module_presentation, res, alphas, i, non_trivial_morphism, dummy_map, induced_cohomology_maps, dummy_maps;

    # check that the input is valid to work with
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

    # compute resolution of module_presentation and extract all vector bundle morphisms in it
    res := MinimalFreeResolutionForCAP( module_presentation );
    alphas := [];
    i := -1;
    non_trivial_morphism := true;
    while non_trivial_morphism do
      # extract the dummy map
      dummy_map := UnderlyingZFunctorCell( res )!.differential_func( i );

      # analyse it
      if Rank( Source( dummy_map ) ) = 0 then
        non_trivial_morphism := false;
      else
        Append( alphas, [ dummy_map ] );
      fi;

      # and decrese i for the next iteration
      i := i -1;
    od;

    # now iterate over the maps alpha and compute the induced maps between their sheaf cohomologies
    #induced_cohomology_maps := [];
    #for i in [ 1 .. Length( alphas ) ] do
    #  Print( Concatenation( "Compute the induced cohomology maps for the morphism ", String( i ), "... \n \n" ) );
    #  dummy_maps := InducedCohomologyMaps( variety, alphas[ i ] );
    #  Append( induced_cohomology_maps, [ dummy_maps ] );
    #  Print( "\n" );
    #  Print( Concatenation( "Done with the induced cohomology maps for the morphism ", String( i ), "... \n \n" ) );
    #od;

    # return the computed maps
    #return [ alphas, induced_cohomology_maps ];
    return alphas;

end );

# compute the maps in a minimal free resolution of a f.p. graded module presentation
InstallMethod( InducedCohomologyMaps,
               " a toric variety, a map of free f.p. graded S-modules",
               [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftModulesMorphism ],
  function( variety, map )
    local zero, maps, d, Himap, source, range, B1, B2, bigger_ideal, epsilon, source_of_map, range_of_map, mapping_of_map, mapping;

    # determine the zero in the Cox ring
    zero := List( [ 1 .. Rank( ClassGroup( variety ) ) ], i -> 0 );

    # initialise the list of induced cohomology maps as empty list
    # we then append the various maps one after the other
    maps := [];

    # case H0:
    Print( "Start computation for H0... \n" );
    Himap := UnderlyingVectorSpaceMorphism( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism( variety, map, zero, true ) );
    Append( maps, [ Himap ] );
    Print( "Done for H0... \n \n" );

    # cases Hd with 1 <= d <= Dimension( variety )
    for d in [ 1 .. Dimension( variety ) ] do

      # inform about status of computation
      Print( Concatenation( "Start computation for H", String( d ), "... \n" ) );

      # extract source and range as f.p. graded S-modules
      source := Source( map );
      source := ApplyFunctor( EmbeddingOfProjCategory( CapCategory( source ) ), source );
      range := Range( map );
      range := ApplyFunctor( EmbeddingOfProjCategory( CapCategory( range ) ), range );

      # determine the ideals needed to compute the d-th cohomology of these module presentations
      B1 := SHEAF_COHOMOLOGY_INTERNAL_FIND_IDEAL( variety, source, d );
      B2 := SHEAF_COHOMOLOGY_INTERNAL_FIND_IDEAL( variety, source, d );

      # use the 'bigger' ideal
      if B1[ 1 ] >= B2[ 1 ] then
        bigger_ideal := B1[ 3 ];
        Print( Concatenation( "found e = ", String( B1[ 1 ] ), "\n" ) );
      else
        bigger_ideal := B2[ 3 ];
        Print( Concatenation( "found e = ", String( B2[ 1 ] ), "\n" ) );
      fi;

      # compute resolution of this bigger ideal and extract the d-th morphism in this resolution
      epsilon := UnderlyingZFunctorCell( MinimalFreeResolutionForCAP( bigger_ideal ) )!.differential_func( -d );

      # now construct the induced map Ext^i( bigger_ideal, source ) -> Ext^i( bigger_ideal, range )
      # start by its source
      source_of_map := TensorProductOnMorphisms( DualOnMorphisms( epsilon ), IdentityMorphism( Source( map ) ) );
      source_of_map := CAPPresentationCategoryObject( source_of_map );
      range_of_map := TensorProductOnMorphisms( DualOnMorphisms( epsilon ), IdentityMorphism( Range( map ) ) );
      range_of_map := CAPPresentationCategoryObject( range_of_map );
      mapping_of_map := TensorProductOnMorphisms( IdentityMorphism( Range( DualOnMorphisms( epsilon ) ) ), map );

      # construct the mapping
      mapping := CAPPresentationCategoryMorphism( source_of_map, mapping_of_map, range_of_map );

      # finally truncate this map to degree zero
      Himap := UnderlyingVectorSpaceMorphism( DegreeXLayerOfGradedLeftOrRightModulePresentationMorphism( variety, mapping, zero, true ) );

      # and append to maps
      Append( maps, [ Himap ] );

      # inform about the status of the computation
      Print( Concatenation( "Done for H", String( d ), "... \n \n" ) );
    od;

    # return the results
    return maps;

end );
