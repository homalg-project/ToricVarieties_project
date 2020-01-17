################################################################################################
##
##  VanishingSets.gi              SheafCohomologyOnToricVarieties package
##
##  Copyright 2019                Martin Bies,       ULB Brussels
##
#! @Chapter Vanishing sets on toric varieties
##
################################################################################################



###########################################
##
#! @Section GAP category for vanishing sets
##
###########################################

##
DeclareRepresentation( "IsVanishingSetRep",
                       IsVanishingSet and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfVanishingSets",
        NewFamily( "TheFamilyOfVanishingSets" ) );

BindGlobal( "TheTypeOfVanishingSets",
        NewType( TheFamilyOfVanishingSets,
                IsVanishingSetRep ) );



############################################
##
#! @Section Constructors
##
############################################

# vanishing set constructor
InstallMethod( VanishingSet,
               " for a toric variety, a list of affine semigroups and two integers",
               [ IsToricVariety, IsList, IsString ],
  function( variety, list_of_affine_semigroups, cohomological_index_specification )
    local test_list, vanishing_set;

    # if the vanishing set if formed from NO affine semigroups
    if Length( list_of_affine_semigroups ) = 0 then
      vanishing_set := rec();
      ObjectifyWithAttributes( vanishing_set, TheTypeOfVanishingSets,
                               ListOfUnderlyingAffineSemigroups, list_of_affine_semigroups,
                               EmbeddingDimension, Rank( ClassGroup( variety ) ),
                               CohomologicalSpecification, cohomological_index_specification,
                               AmbientToricVariety, variety
                              );
      SetIsFull( vanishing_set, true );
      return vanishing_set;
    fi;

    # if there is at least one affine semigroup, we need to make more tests
    test_list := List( [ 1 .. Length( list_of_affine_semigroups ) ], 
                       k -> EmbeddingDimension( list_of_affine_semigroups[ k ] ) );
    test_list := DuplicateFreeList( test_list );
    if Length( test_list ) > 1 then
      Error( "The affine semigroups are not embedded into isomorphic lattices" );
      return;
    elif test_list[ 1 ] <> Rank( ClassGroup( variety ) ) then
      Error( "The rank of the Class group does not match the dimensions of the affine semigroups" );
      return;
    fi;

    # tests passed, so create and return the vanishing set
    vanishing_set := rec();
    ObjectifyWithAttributes( vanishing_set, TheTypeOfVanishingSets,
                             ListOfUnderlyingAffineSemigroups, list_of_affine_semigroups,
                             EmbeddingDimension, Rank( ClassGroup( variety ) ),
                             CohomologicalSpecification, cohomological_index_specification,
                             AmbientToricVariety, variety
                            );
    SetIsFull( vanishing_set, false );
    return vanishing_set;

end );

# vanishing set constructor
InstallMethod( VanishingSet,
               " for a toric variety, a list of affine semigroups and two integers",
               [ IsToricVariety, IsList, IsInt ],
  function( variety, list_of_affine_semigroups, cohomological_index )
    local test_list, vanishing_set;

    # check if the cohomological index lies in the anticipated range
    if cohomological_index < 0 or cohomological_index > Dimension( variety ) then
      Error( "The cohomological index must be an integer between 0 and the dimension of the variety" );
      return;
    fi;

    # if the vanishing set if formed from NO affine semigroups
    if Length( list_of_affine_semigroups ) = 0 then
      vanishing_set := rec();
      ObjectifyWithAttributes( vanishing_set, TheTypeOfVanishingSets,
                               ListOfUnderlyingAffineSemigroups, list_of_affine_semigroups,
                               EmbeddingDimension, Rank( ClassGroup( variety ) ),
                               CohomologicalIndex, cohomological_index,
                               CohomologicalSpecification, Concatenation( "i = ", String( cohomological_index ) ),
                               AmbientToricVariety, variety
                              );
      SetIsFull( vanishing_set, true );
      return vanishing_set;
    fi;

    # if there is at least one affine semigroup, we need to make more tests
    test_list := List( [ 1 .. Length( list_of_affine_semigroups ) ], 
                       k -> EmbeddingDimension( list_of_affine_semigroups[ k ] ) );
    test_list := DuplicateFreeList( test_list );
    if Length( test_list ) > 1 then
      Error( "The affine semigroups are not embedded into isomorphic lattices" );
      return;
    elif test_list[ 1 ] <> Rank( ClassGroup( variety ) ) then
      Error( "The rank of the Class group does not match the dimensions of the affine semigroups" );
      return;
    fi;

    # tests passed, so create and return the vanishing set
    vanishing_set := rec();
    ObjectifyWithAttributes( vanishing_set, TheTypeOfVanishingSets,
                             ListOfUnderlyingAffineSemigroups, list_of_affine_semigroups,
                             EmbeddingDimension, Rank( ClassGroup( variety ) ),
                             CohomologicalIndex, cohomological_index,
                             CohomologicalSpecification, Concatenation( "i = ", String( cohomological_index ) ),
                             AmbientToricVariety, variety
                            );
    SetIsFull( vanishing_set, false );
    return vanishing_set;

end );



####################################
##
## String
##
####################################

InstallMethod( String,
              [ IsVanishingSet ],
  function( vanishing_set )

    if IsFull( vanishing_set ) then
      if HasCohomologicalIndex( vanishing_set ) then
        return Concatenation( "A full vanishing set in Z^", 
                              String( EmbeddingDimension( vanishing_set ) ),
                              " for cohomological index ",
                              String( CohomologicalIndex( vanishing_set ) )
                             );
      elif HasCohomologicalSpecification( vanishing_set ) then
        return Concatenation( "A full vanishing set in Z^", 
                              String( EmbeddingDimension( vanishing_set ) ),
                              " for cohomological specification ",
                              CohomologicalSpecification( vanishing_set )
                             );
      fi;
    else
      if HasCohomologicalIndex( vanishing_set ) then
        return Concatenation( "A non-full vanishing set in Z^", 
                              String( EmbeddingDimension( vanishing_set ) ),
                              " for cohomological index ",
                              String( CohomologicalIndex( vanishing_set ) )
                             );
      elif HasCohomologicalSpecification( vanishing_set ) then
        return Concatenation( "A non-full vanishing set in Z^", 
                              String( EmbeddingDimension( vanishing_set ) ),
                              " for cohomological specification ",
                              CohomologicalSpecification( vanishing_set )
                             );
      fi;
    fi;

end );



####################################
##
## Display
##
####################################

InstallMethod( Display,
               [ IsVanishingSet ],
  function( vanishing_set )
    local i;

    if IsFull( vanishing_set) then
      Print( String( vanishing_set ) );
    elif Length( ListOfUnderlyingAffineSemigroups( vanishing_set) ) = 1 then
        Print( Concatenation( String( vanishing_set ), 
                              " formed from the points NOT contained in the following affine semigroup: \n \n" ) );
        Display( ListOfUnderlyingAffineSemigroups( vanishing_set )[ 1 ] );
        Print( " \n \n" );
    else
      Print( Concatenation( String( vanishing_set ), 
                            " formed from the points NOT contained in the following ",
                            String( Length( ListOfUnderlyingAffineSemigroups( vanishing_set ) ) ),
                            " affine semigroups: \n \n" ) );
      for i in [ 1 .. Length( ListOfUnderlyingAffineSemigroups( vanishing_set ) ) ] do
          Print( Concatenation( "Affine semigroup ", String( i ), ": \n" ) );
          Display( ListOfUnderlyingAffineSemigroups( vanishing_set )[ i ] );
          Print( "\n" );
      od;
    fi;

end );



####################################
##
## ViewObj
##
####################################

InstallMethod( ViewObj,
               [ IsVanishingSet ],
  function( vanishing_set )

    Print( Concatenation( "<", String( vanishing_set ), ">" ) );

end );



###############################################
##
## Computation of vanishing sets from cohomCalg
##
###############################################

InstallMethod( TurnDenominatorIntoShiftedSemigroup,
               "for monoms in the Cox ring of a toric variety",
               [ IsToricVariety, IsString ],
  function( variety, monom )
    local present_variables, i, generators, cone, Hpresentation, offset;

    # (1) figure out which variables appear in the monom
    present_variables := List( [ 1 .. Length( Indeterminates( CoxRing( variety ) ) ) ], x -> 0 );
    for i in [ 1 .. Length( present_variables ) ] do

      if PositionSublist( monom, Concatenation( "u", String( i ) ) ) <> fail then
        present_variables[ i ] := 1;
      fi;

    od;

    # (2) compute the generators
    generators := List( [ 1 .. Length( Indeterminates( CoxRing( variety ) ) ) ] );
    for i in [ 1 .. Length( Indeterminates( CoxRing( variety ) ) ) ] do

      if present_variables[ i ] = 1 then

        generators[ i ] := ( -1 ) * UnderlyingListOfRingElements( WeightsOfIndeterminates( CoxRing( variety ) )[ i ] );

      else

        generators[ i ] := UnderlyingListOfRingElements( WeightsOfIndeterminates( CoxRing( variety ) )[ i ] );

      fi;

    od;
    generators := DuplicateFreeList( generators );

    # (3) compute the offset
    offset := List( [ 1 .. Rank( ClassGroup( variety ) ) ], x -> 0 );
    for i in [ 1 .. Length( present_variables ) ] do
      if present_variables[ i ] = 1 then
        offset := offset - UnderlyingListOfRingElements( WeightsOfIndeterminates( CoxRing( variety ) )[ i ] );
      fi;
    od;

    # and return the affine semigroup
    return AffineSemigroupForPresentationsByProjectiveGradedModules( SemigroupForPresentationsByProjectiveGradedModules( generators ),
                                                              offset );

end );

# use cohomCalg to extract the denomiators that contribute to the individual cohomology classes
# this is a convience method
InstallMethod( VanishingSets,
               " for toric varieties",
               [ IsToricVariety ],
  function( variety )
    local serre_duality_to_be_used;

    if not IsValidInputForAdditionsForToricVarieties( variety ) then

      Error( "The variety has to be smooth, complete (or simplicial, projective if you allow for lazy checks)" );
      return;

    fi;

    # check if we can use Serre
    serre_duality_to_be_used := IsSmooth( variety );

    # and compute the vanishing sets
    return ComputeVanishingSets( variety, serre_duality_to_be_used );

end );

# use cohomCalg to extract the denomiators that contribute to the individual cohomology classes
# this is the generic method
InstallMethod( ComputeVanishingSets,
               " for toric varieties",
               [ IsToricVariety, IsBool ],
  function( variety, serre_duality_to_be_used )
    local denominator_contributions, v_rec, cutoff, i, j, k, l, affine_semigroups_list, helper, found, rays_helper,
         rays_comparer, pos, search, K_bundle, new_affine_semigroups_list, new_gens, new_offset;

    if not IsValidInputForAdditionsForToricVarieties( variety ) then

      Error( "The variety has to be smooth, complete (or simplicial, projective if you allow for lazy checks)" );
      return;

    fi;

    # compute the denominator contributions first
    denominator_contributions := ContributingDenominators( variety );

    # check if this computation succeeded
    if denominator_contributions = fail then
      Print( "Contributing denominators could not be determined uniquely. \n" );
      Print( "Possible origin -- ambigious monomial contributions. \n" );
      return fail;
    fi;

    # initialise v_rec
    v_rec := rec();

    # determine cutoff
    if not serre_duality_to_be_used then
      cutoff := Dimension( variety );
    else
      if IsInt( Dimension( variety ) / 2 ) then
        cutoff := Dimension( variety ) / 2;
      else
        cutoff := Int( Dimension( variety ) / 2 ) + 1;
      fi;
    fi;

    # note that i runs from 1 to cutoff +1 (i.e. we iterate over H^{i-1}
    for i in [ 1 .. cutoff+1 ] do

      if Length( denominator_contributions[ i ] ) = 0 then
        v_rec.(String(i-1)) := VanishingSet( variety, [], i-1 );
      elif Length( denominator_contributions[ i ] ) = 1 then
        v_rec.(String(i-1)) := VanishingSet( variety, 
                               [ TurnDenominatorIntoShiftedSemigroup( variety, denominator_contributions[ i ][ 1 ] ) ],
                               i-1 );
      else
        affine_semigroups_list := [ TurnDenominatorIntoShiftedSemigroup( variety, denominator_contributions[ i ][ 1 ] ) ];
        for j in [ 1 .. Length( denominator_contributions[ i ] ) ] do
          helper := TurnDenominatorIntoShiftedSemigroup( variety, denominator_contributions[ i ][ j ] );
          found := false;
          k := 1;
          while not found do

            # check if we found this affine semigroup before already
            # if so 'delete' it and otherwise add it

            # note that all affine semigroups encountered here are initiated from generators - never from h-constraints
            if Offset( helper ) = Offset( affine_semigroups_list[ k ] ) then

              # pick rays of helper
              rays_helper := GeneratorList( UnderlyingSemigroup( helper ) );
              rays_comparer := ShallowCopy( GeneratorList( UnderlyingSemigroup( affine_semigroups_list[ k ] ) ) );

              # check if they are of the same length
              if Length( rays_helper ) = Length( rays_comparer ) then

                # and now compare them (up to potential permutations)
                search := true;
                l := 1;
                while search do

                  # find rays_helper[ l ] in rays_comparer
                  pos := Position( rays_comparer, rays_helper[ l ] );

                  # if we do not find it no need to keep comparing
                  if pos = fail then
                    search := false;
                  # however if we find this ray generator we remove it from rays_comparer
                  else
                    Remove( rays_comparer, pos );
                  fi;

                  # increase l
                  l := l+1;

                  # check if we reached the end of rays_helper
                  if l > Length( rays_helper ) then
                    # terminate this search
                    search := false;
                    # if we found all ray_generators of rays_helper in rays_comparer and rays_comparer has no more
                    # than these elements, we have a match
                    if Length( rays_comparer ) = 0 then
                      found := true;
                    fi;
                  fi;

                od;

              fi;

            fi;


            # increase k
            k := k +1;

            # check if we have checked all semigroups
            if k > Length( affine_semigroups_list ) then
              if not found then
                # the affine_semigroup was not found in the list, hence add it
                affine_semigroups_list[ Length( affine_semigroups_list ) + 1 ] := helper;
              fi;

              # and turn found into true to end the search loop
              found := true;

            fi;
          od;

        od;

        # form the vanishing set of cohomological index i-1
        v_rec.(String(i-1)) := VanishingSet( variety, affine_semigroups_list, i-1 );

      fi;

    od;

    # now use serre-duality
    if serre_duality_to_be_used then

      # compute canonical bundle
      K_bundle := (-1) * Sum( List( WeightsOfIndeterminates( CoxRing( variety ) ),
                                                              k -> UnderlyingListOfRingElements( k ) ) );
      # and use it to determine the other vanishing sets
      for i in [ cutoff .. Dimension( variety ) ] do

        # extract the list of affine semigroup for the 'other' cohomology class
        affine_semigroups_list := ListOfUnderlyingAffineSemigroups( v_rec.(String( Dimension( variety ) - i )) );
        new_affine_semigroups_list := [];

        # now iterate over them and manipulate each group accordingly
        for j in [ 1 .. Length( affine_semigroups_list ) ] do
          new_gens := (-1) * GeneratorList( UnderlyingSemigroup( affine_semigroups_list[ j ] ) );
          new_offset := K_bundle - Offset( affine_semigroups_list[ j ] );
          new_affine_semigroups_list[ j ] := AffineSemigroupForPresentationsByProjectiveGradedModules(
                                                                  SemigroupForPresentationsByProjectiveGradedModules( new_gens ),
                                                                  new_offset );
        od;

        # now define the new vanishing_set
        v_rec.(String(i)) := VanishingSet( variety, new_affine_semigroups_list, i );

      od;

    fi; # <- end of Serre-duality use

    # finally return the vanishing sets
    return v_rec;

end );

# check if a point (= element of the class group) is contained in the improved vanishing set
InstallMethod( PointContainedInVanishingSet,
               " for a vanishing set and a point",
               [ IsVanishingSet, IsList ],
  function( vanishing_set, point )
    local i;

    # check if the point lies in the same lattice as all shifted semigroups
    if Length( point ) <> EmbeddingDimension( vanishing_set ) then
      Error( "The point and the vanishing sets are embedded into different lattices" );
      return;
    fi;

    # check if the vanishing set is full, i.e. if all points are automatically contained, 
    # in this case return true
    if IsFull( vanishing_set ) then
      return true;
    fi;

    # now check that the point is NOT contained in any of the affine semigroups
    for i in [ 1 .. Length( ListOfUnderlyingAffineSemigroups( vanishing_set ) ) ] do
      if PointContainedInAffineSemigroup( ListOfUnderlyingAffineSemigroups( vanishing_set )[ i ], point ) then
        return false;
      fi;
    od;

    # if this is the case, then return true
    return true;

end );
