#############################################################################
##
##  VanishingSets.gi     ToricVarieties       Martin Bies
##
##  Copyright 2015- 2016, Sebastian Gutsche, TU Kaiserslautern
##                        Martin Bies,       ITP Heidelberg
##
##  Computation of vanishing sets
##
#############################################################################



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
          Print( " \n \n" );
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

# produce the command string that will be used to trigger cohomCalg to compute the cohomologies of a certain line bundle
InstallMethod( TORIC_VARIETIES_INTERNAL_COHOMCALG_COMMAND_STRING,
               " for toric varieties",
               [ IsToricVariety, IsList ],
  function( variety, degree )
    local output_string, weights_of_indeterminates, i, buffer, SR_ideal_generators;

    # step1: check for valid input
    if Rank( ClassGroup( variety ) ) = 0 then

      Error( "Currently not supported" );
      return;

    elif Rank( ClassGroup( variety ) ) <> Length( degree ) then

      Error( "The given list must have length equal to the rank of ClassGroup( variety )" );
      return;

    fi;

    for i in [ 1 .. Length( degree ) ] do

      if not IsInt( degree[ i ] ) then

        Error( "All entries of the given list must be integers" );
        return;

      fi;

    od;

    # step2: extract the weights of the variables in the Coxring and turn them into suitable strings
    weights_of_indeterminates := ShallowCopy( WeightsOfIndeterminates( CoxRing( variety ) ) );
    if Rank( ClassGroup( variety ) ) = 1 then

      for i in [ 1 .. Length( weights_of_indeterminates ) ] do

        # turn the homalg_module_element into a string
        buffer := String( weights_of_indeterminates[ i ] );

        # now add "(" and ")" before and after
        buffer := Concatenation( "( ", buffer, " )" );      

        # and save the new version
        weights_of_indeterminates[ i ] := buffer;

      od;

    else

      for i in [ 1 .. Length( weights_of_indeterminates ) ] do

        # turn the homalg_module_element into a string
        buffer := String( weights_of_indeterminates[ i ] );

        # to match the expected format from cohomCalg, remove [ ] and replace them by ( )
        buffer := ReplacedString( buffer, "[", "(" );
        buffer := ReplacedString( buffer, "]", ")" );

        # and save the new version
        weights_of_indeterminates[ i ] := buffer;

      od;

    fi;

    # step3: add the 'GSLM weights' of the coordinates to the output_string
    output_string := "";
    for i in [ 1 .. Length( weights_of_indeterminates ) ] do

      output_string := Concatenation( output_string, "vertex u", String( i ), " | GLSM: ", 
                                      weights_of_indeterminates[ i ], "; " );

    od;

    # step4: add the Stanley-Reisner ideal to the output string
    output_string := Concatenation( output_string, " srideal " );
    SR_ideal_generators := String( EntriesOfHomalgMatrix( MatrixOfSubobjectGenerators( SRIdeal( variety ) ) ) );
    RemoveCharacters( SR_ideal_generators, "_" );
    SR_ideal_generators := ReplacedString( SR_ideal_generators, "x", "u" );
    output_string := Concatenation( output_string, SR_ideal_generators, "; " );

    # step5: switch the use of intermediate monomial file off
    output_string := Concatenation( output_string, "monomialfile off;" );

    # step6: add the bundle charges, i.e. the list degree
    buffer := String( degree );
    buffer := ReplacedString( buffer, "[", "(" );
    buffer := ReplacedString( buffer, "]", ")" );
    output_string := Concatenation( output_string, "ambientcohom O", buffer, ";" );

    # step7: add option that tells cohomCalg to treat this string as an input file
    output_string := Concatenation( "--in=", output_string );

    # step7: return the output_string
    return output_string;

end );

# produce the command string that will be used to trigger cohomCalg to compute the cohomologies of the structure sheaf
InstallMethod( TORIC_VARIETIES_INTERNAL_COHOMCALG_COMMAND_STRING,
               " for toric varieties",
               [ IsToricVariety ],
  function( variety )

    return TORIC_VARIETIES_INTERNAL_COHOMCALG_COMMAND_STRING( variety,
                                                              List( [ 1 .. Rank( ClassGroup( variety ) ) ], i -> 0 )
                                                             );

end );

# use cohomCalg to extract the denomiators that contribute to the individual cohomology classes
# [note: ambigious monomial contributions are not yet supported, but it should not be too hard to achieve this]
InstallMethod( ContributingDenominators,
               " for toric varieties",
               [ IsToricVariety ],
  function( variety )
    local command_string, cohomCalgDirectory, cohomCalg, stdin, stdout, output_string, start, diff, output_string_reduced,
         contributing_monomials, index, collector, i;

    # this the string that we need to address cohomCalg
    command_string := TORIC_VARIETIES_INTERNAL_COHOMCALG_COMMAND_STRING( variety );

    # HARD_CODED PATH CHOICE! MAKE SURE THERE IS A UNIQUE 'SHEAF COHOMOLOGY ON TORIC VARIETIES' INSTALLED!
    cohomCalgDirectory := DirectoriesPackageLibrary( "SheafCohomologyOnToricVarieties", "cohomCalg" )[ 1 ];
    cohomCalg := Filename( cohomCalgDirectory, "cohomcalg" );

    # set up communication channels
    stdin := InputTextUser();
    output_string := "";
    stdout := OutputTextString( output_string, true );

    # execute cohomCalg with the 'input file' described by the command_string
    Process( cohomCalgDirectory, cohomCalg, stdin, stdout, ["--verbose2", command_string ] );

    # now process the string "output_string"
    # we first roughly cut off all the information that we do not need
    start := PositionSublist( output_string, "Final" );
    diff := PositionSublist( output_string, "rationals" ) - start;
    output_string_reduced := List( [ 1 .. diff ], x -> output_string[ x + start ] );

    # now we cut more accurately
    start := Positions( output_string_reduced, '\n' )[ 3 ];
    diff := Length( output_string_reduced ) - start;
    output_string_reduced := List( [ 1 .. diff ], x -> output_string_reduced[ x + start ] );

    # next split the string at every occurance of \n, to obtain a 'nice' list
    output_string_reduced := SplitString( output_string_reduced, '\n' );

    # remove whitespaces
    output_string_reduced := List( output_string_reduced, x -> NormalizedWhitespace( x ) );

    # and remove the last 3 lines
    Remove( output_string_reduced );
    Remove( output_string_reduced );
    Remove( output_string_reduced );

    # check if an ambigous monomial contribution has been detected - for now I do not support this
    if not output_string_reduced[ Length( output_string_reduced ) ] = 
      "There are no ambiguous contribution monomials to the variety." then

      Error( "I do not support ambigious monomial contributions yet" );
      return;

    fi;

    # else we are in business
    contributing_monomials := List( [ 1 .. Dimension( variety ) + 1 ] );
    index := 1;
    collector := [];
    for i in [ 2 .. Length( output_string_reduced ) - 1 ] do

      # check if contributions to the next cohomology class are to be added
      if output_string_reduced[ i ][ 1 ] = 'H' then

        # add the collected information
        contributing_monomials[ index ] := collector;

        # now reset the collector
        collector := [];

        # and increase the cohomology index
        index := index + 1;

      else

        # we found a new contribution to the cohomology classes

        # this may be listed with multiplicity, but we do not care about the multiplicity here
        # so whenever we find a multiplicity, we will delete it
        if PositionSublist( output_string_reduced[ i ], "factor" ) <> fail then
          Add( collector, List( [ 1 .. PositionSublist( output_string_reduced[ i ], "factor" ) - 2 ], x -> output_string_reduced[ i ][ x ] ) );
        else
          Add( collector, output_string_reduced[ i ] );
        fi;

      fi;

      # add special check for the last run
      if i = Length( output_string_reduced) - 1 then

        contributing_monomials[ index ] := collector;

      fi;

    od;

    # return value
    return contributing_monomials;

end );

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
    return AffineSemigroupForGradedModulePresentationsForCAP( SemigroupForGradedModulePresentationsForCAP( generators ),
                                                              offset );

end );

# use cohomCalg to extract the denomiators that contribute to the individual cohomology classes
# this is a convience method
InstallMethod( VanishingSets,
               " for toric varieties",
               [ IsToricVariety ],
  function( variety )
    local serre_duality_to_be_used;

    # check input
    if not ( ( IsSmooth( variety ) and IsComplete( variety ) ) 
             or ( IsProjective( variety ) and IsSimplicial( variety ) ) ) then
      Error( "only implemented for (smooth, complete) and for (projective, simplicial) toric varieties" );
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

    # check input
    if not ( ( IsSmooth( variety ) and IsComplete( variety ) ) 
             or ( IsProjective( variety ) and IsSimplicial( variety ) ) ) then
      Error( "only implemented for (smooth, complete) and for (projective, simplicial) toric varieties" );
      return;
    fi;

    # compute the denominator contributions first
    denominator_contributions := ContributingDenominators( variety );

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
          new_affine_semigroups_list[ j ] := AffineSemigroupForGradedModulePresentationsForCAP(
                                                                  SemigroupForGradedModulePresentationsForCAP( new_gens ),
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