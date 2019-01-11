##########################################################################################
##
##  CohomologyFromResolution.gi        SheafCohomologyOnToricVarieties package
##
##  Copyright 2019                     Martin Bies,       ULB Brussels
##
#! @Chapter Cohomology of coherent sheaves from resolution
##
#########################################################################################


###################################################################################
##
##  Define Global variable
##
###################################################################################

SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_INTERNAL_INTEGER_RING_IN_SINGULAR := HomalgRingOfIntegersInSingular();


###################################################################################
##
##  Section Cohomologies of projective modules in a minimal free resolution
##
###################################################################################

# function that computes the cohomologies of all vector bundles in a minimal free resolution of a f.p. graded module
InstallMethod( CohomologiesList,
               " for a toric variety, two f.p. graded S-module, a boolean and an integer ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ],
  function( variety, module )
    local betti_table, coho_list, i, degrees, help_module;

    # check if the input is valid
    if not IsValidInputForCohomologyComputations( variety ) then

      Error( "The variety has to be smooth, complete (or simplicial, projective if you allow for lazy checks)" );

    fi;

    # extract Betti table
    betti_table := BettiTableForCAP( module );

    # now compute the cohomologies list
    coho_list := [];
    for i in [ 1 .. Length( betti_table ) ] do
      degrees := List( [ 1 .. Length( betti_table[ i ] ) ], k -> [ UnderlyingListOfRingElements( betti_table[ i ][ k ] ), 1 ] );
      help_module := CAPCategoryOfProjectiveGradedLeftModulesObject( degrees, CoxRing( variety ) );
      coho_list[ i ] := AllCohomologiesFromCohomCalg( variety, help_module, false );
    od;

    # then return coho_list
    return coho_list;

end );



#############################################################################################################
##
##  Section Deductions On Sheaf Cohomology From Cohomology Of projective modules in a minimal free resolution
##
#############################################################################################################


# function that computes the cohomologies of all vector bundles in a minimal free resolution of a f.p. graded module
InstallMethod( AnalyseShortExactSequence,
               " for a list of 3 lists ",
               [ IsList ],
  function( cohomologies_list )
    local len, unknown_cohomologies, unknown_indices, i, j, long_exact_sequence, pos, simplifier, pos_variable, sign,
         zero_ending_exact_sequence_list, dummy_list, tester, constraint, constraints_list, index, var_pos;

    # step 0: initialise variables
    # step 0: initialise variables
    len := Length( cohomologies_list[ 2 ] );
    unknown_cohomologies := cohomologies_list[ 1 ];

    # step 1: use vanishing result on the unknown_cohomologies
    # step 1: use vanishing result on the unknown_cohomologies
    for i in [ 1 .. len - 1 ] do

      if cohomologies_list[ 2 ][ i ] = 0 and cohomologies_list[ 3 ][ i + 1 ] = 0 then
        unknown_cohomologies[ i ] := 0;
      fi;

    od;

    if cohomologies_list[ 2 ][ len ] = 0 then
      unknown_cohomologies[ len ] := 0;
    fi;

    # for later use, remember which cohomology classes are not yet known/constraint by this vanishing result
    unknown_indices := [];
    for i in [ 1 .. len ] do
      if unknown_cohomologies[ i ] <> 0 then
        Add( unknown_indices, i );
      fi;
    od;

    # check if a further simpliciation on the unknown_cohomologies is possible
    simplifier := false;
    if ( cohomologies_list[ 3 ][ 1 ] <> 0 and cohomologies_list[ 2 ][ 1 ] = 0 ) then

      simplifier := true;

    fi;


    # step2: split the long exact sequence of vector spaces into shorter ones (if possible) which start/end with zeros as well
    #        and use these sequences to draw conclusions on the unknown cohomologies
    # step2: split the long exact sequence of vector spaces into shorter ones (if possible) which start/end with zeros as well
    #        and use these sequences to draw conclusions on the unknown cohomologies

    # compute the long exact sequence of vector spaces
    long_exact_sequence := List( [ 1 .. 3 * len + 2 ], k -> "?" );
    long_exact_sequence[ 1 ] := 0;
    for i in [ 1 .. len ] do
      long_exact_sequence[ 3 * i - 1 ] := cohomologies_list[ 3 ][ i ];
      long_exact_sequence[ 3 * i ] := cohomologies_list[ 2 ][ i ];
      long_exact_sequence[ 3 * i + 1 ] := unknown_cohomologies[ i ];
    od;
    long_exact_sequence[ 3 * len + 2 ] := 0;

    # find the positions of zeros therein
    pos := Positions( long_exact_sequence, 0 );

    # initialise the list of short sequences which start/end with zeros
    # we obtain at most Length( pos ) - 1 such sequences, so we scan as follows
    zero_ending_exact_sequence_list := [];
    constraints_list := [];
    for i in [ 1 .. Length( pos ) - 1 ] do

      # construct dummy list
      dummy_list := List( [ 1 .. pos[ i + 1 ] - pos[ i ] + 1 ], k -> long_exact_sequence[ k + pos[ i ] - 1 ] );

      # set tester to false
      tester := false;

      # now check if at least one the unknown_cohomologies is contained in this exact sequence, and if so set tester := true;
      for j in [ 1 .. Length( unknown_indices ) ] do
        if Position( dummy_list, unknown_cohomologies[ unknown_indices[ j ] ] ) <> fail then
          tester := true;
          index := unknown_indices[ j ];
        fi;
      od;

      # now add this sequence only if at least one unknown cohomology is contained in the list
      if tester then

        # in this sequence, we check if a simplification is possible
        if simplifier then

          for j in [ 1 .. Length( dummy_list ) ] do

            # check if dummy_list[ j ] contains cohomologies_list[ 3 ][ 1 ], which happens to vanish 
            pos_variable := PositionSublist( String( dummy_list[ j ] ), String( cohomologies_list[ 3 ][ 1 ] ) );
            if pos_variable <> fail then

              # now we need to determine the sign with which this variable appear, so that we can either add or
              # subtract it

              # if the varables appears at position 1, then it comes with sign '+', so we subtract it
              if pos_variable = 1 then
                dummy_list[ j ] := dummy_list[ j ] - cohomologies_list[ 3 ][ 1 ];
              else

                # otherwise there must be a sign in front of it
                sign := String( dummy_list[ j ] )[ pos_variable - 1 ];

                # and react accordingly
                if sign = '+' then 
                  dummy_list[ j ] := dummy_list[ j ] - cohomologies_list[ 3 ][ 1 ];
                else
                  dummy_list[ j ] := dummy_list[ j ] + cohomologies_list[ 3 ][ 1 ];
                fi;

              fi;

            fi;

          od;

        fi;

        # add the dummy_list as zero_ending_exact_sequence
        Add( zero_ending_exact_sequence_list, dummy_list );

        # solve the constraint for the variable vars[ j ] that appears in this sequence
        var_pos := Position( dummy_list, unknown_cohomologies[ index ] );
        if IsEvenInt( var_pos ) then
          dummy_list := List( [ 1 .. Length( dummy_list ) ], k -> (-1)^(k+1) * dummy_list[ k ] );
        else
          dummy_list := List( [ 1 .. Length( dummy_list ) ], k -> (-1)^k * dummy_list[ k ] );
        fi;
        Remove( dummy_list, var_pos );
        constraint := [ index, Sum( dummy_list ) ];
        Add( constraints_list, constraint );

      fi;

    od;

    # finally apply the obtained constraints on the unknown cohomologies
    for i in [ 1 .. Length( constraints_list ) ] do
      unknown_cohomologies[ constraints_list[ i ][ 1 ] ] := constraints_list[ i ][ 2 ];
    od;

    # return the unknown_cohomologies
    return unknown_cohomologies;
    #return [ unknown_indices, unknown_cohomologies, long_exact_sequence, zero_ending_exact_sequence_list, constraints_list ];
    #return [ unknown_cohomologies, constraints_list, new_constraints_list ];

end );


# function that computes the cohomologies of all vector bundles in a minimal free resolution of a f.p. graded module
InstallMethod( DeductionOfSheafCohomologyFromResolution,
               " for a toric variety, two f.p. graded S-module, a boolean and an integer ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool ],
  function( variety, module, print_deduction )
    local cohomologies_list, len, number_of_unknown_cohomologies, vars, ring, short_exact_sequences_list, dummy, intermediate_coh, i, j, s;

    # check if the input is valid
    if not IsValidInputForCohomologyComputations( variety ) then

      Error( "The variety has to be smooth, complete (or simplicial, projective if you allow for lazy checks)" );
      return;

    elif not IsIdenticalObj( CoxRing( variety ), UnderlyingHomalgGradedRing( UnderlyingMorphism( module ) ) ) then

      Error( "The module is not defined over (the Cox ring of) the given variety" );
      return;

    fi;

    # step 0: check for degenerate case, i.e. the relation module is zero so that we can use cohomCalg to compute the dimension of the
    # step 0: sheaf cohomologies immediately
    if IsZero( Source( UnderlyingMorphism( module ) ) ) then

      if print_deduction then
        Print( "This is a projective module. So we used cohomCalg immediately to deduce the sheaf cohomologies. \n" );
      fi;

      return AllCohomologiesFromCohomCalg( variety, module );

    fi;

    # step 0: compute the cohomologies list
    cohomologies_list := CohomologiesList( variety, module );
    len := Length( cohomologies_list );

    # step 1: generate as many formal variables as we need to treat the yet-unknown cohomologies
    number_of_unknown_cohomologies := ( Dimension( variety ) + 1 ) * ( len - 1 );
    vars := List( [ 1 .. number_of_unknown_cohomologies ], k -> Concatenation( "a", String( k ) ) );
    ring := SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_INTERNAL_INTEGER_RING_IN_SINGULAR * vars;
    vars := IndeterminatesOfPolynomialRing( ring );

    # step 2: split into short exact sequences and analyse those sequences
    short_exact_sequences_list := List( [ 1 .. len - 1 ] );
    dummy := List( [ 1 .. Dimension( variety ) + 1 ], k -> vars[ k ] );
    short_exact_sequences_list[ 1 ] := [ dummy, cohomologies_list[ len - 1 ], cohomologies_list[ len ] ];
    intermediate_coh := AnalyseShortExactSequence( short_exact_sequences_list[ 1 ] );
    for i in [ 2 .. len - 1 ] do

      dummy := List( [ 1 .. Dimension( variety ) + 1 ], k -> vars[ ( i-1 ) * ( Dimension( variety ) + 1 ) + k ] );
      short_exact_sequences_list[ i ] := [ dummy, cohomologies_list[ len - i ], intermediate_coh ];
      intermediate_coh := AnalyseShortExactSequence( short_exact_sequences_list[ i ] );

    od;

    # step 3: print details on the computation if wished for
    if print_deduction then

      # print rough information about the resolution
      Print( "Used the following resolution: \n" );
      Print( "------------------------------ \n \n" );

      s := "F \t <- \t";
      for j in [ 1 .. Length( cohomologies_list ) ] do
        if j <> Length( cohomologies_list ) then
          Append( s, Concatenation( "V", String( Length( cohomologies_list ) - j + 1 ), " \t <- \t " ) );
        else
          Append( s, Concatenation( "V", String( Length( cohomologies_list ) - j + 1 ), "\n" ) );
        fi;
      od;
      Print( s );

      for i in [ 1 .. Dimension( variety ) + 1 ] do
        Print( "? \t \t " );
        for j in [ 1 .. Length( cohomologies_list ) ] do
          if j <> Length( cohomologies_list ) then
            Print( Concatenation( String( cohomologies_list[ j ][ i ] ), " \t \t " ) );
          else
            Print( Concatenation( String( cohomologies_list[ j ][ i ] ), "\n" ) );
          fi;
        od;
      od;

      Print( "\n\n");
      Print( "We split it into the following short exact sequences: \n" );
      Print( "----------------------------------------------------- \n \n" );

      # indicate the sequence
      if Length( short_exact_sequences_list ) <> 1 then
        Print( "I1 \t <-  \t V2 \t <-  \t V1: \n" );
      else
        Print( "F \t <-  \t V2 \t <-  \t V1: \n" );
      fi;

      # and write out the cohomologies
      for j in [ 1 .. Dimension( variety ) + 1 ] do
        Print( Concatenation( String( short_exact_sequences_list[ 1 ][ 1 ][ j ] ), " \t \t ",
                              String( short_exact_sequences_list[ 1 ][ 2 ][ j ] ), " \t \t ",
                              String( short_exact_sequences_list[ 1 ][ 3 ][ j ] ), " \n" ) );
      od;

      Print( "\n");

      # print information about the remaining short exact sequences
      for i in [ 2 .. Length( short_exact_sequences_list ) ] do

        if i <> Length( short_exact_sequences_list ) then
          Print( Concatenation( "I", String( i ), "\t <- \t V", String( i+1 ), " \t <- \t I", String( i-1 ), "\n" ) );
        else
          Print( Concatenation( "F \t <- \t V", String( i+1 ), " \t <- \t I", String( i-1 ), "\n" ) );
        fi;

        for j in [ 1 .. Dimension( variety ) + 1 ] do
          Print( Concatenation( String( short_exact_sequences_list[ i ][ 1 ][ j ] ), " \t \t ",
                                String( short_exact_sequences_list[ i ][ 2 ][ j ] ), " \t \t ",
                                String( short_exact_sequences_list[ i ][ 3 ][ j ] ), " \n" ) );
        od;

        # make sure the sequence is nicely separated from the following one
        Print( "\n \n");

      od;

    fi;

    # step 4: return the result
    return short_exact_sequences_list[ Length( short_exact_sequences_list ) ][ 1 ];

end );

# function that computes the cohomologies of all vector bundles in a minimal free resolution of a f.p. graded module
InstallMethod( DeductionOfSheafCohomologyFromResolution,
               " for a toric variety, two f.p. graded S-module, a boolean and an integer ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ],
  function( variety, module )

    return DeductionOfSheafCohomologyFromResolution( variety, module, false );

end );
