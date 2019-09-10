#############################################################################
##
##  Functions.gi        cohomCalgInterface package
##                      Martin Bies
##
##  Copyright 2019      ULB Brussels
##
##  A package to communicate with the software cohomCalg
##
#############################################################################


##############################################################################################
##
## Install functions to communicate with cohomCalg
##
##############################################################################################

# decide if i-th cohomology vanishes
InstallMethod( VanishingHiByCohomCalg,
               [ IsToricVariety, IsList, IsInt ],
  function( variety, degree, cohomology_index )
    local hi, vanish;

    # compute i-th cohomology
    hi := HiByCohomCalg( variety, [[degree,1]], cohomology_index );

    # and return the result
    vanish := false;
    if hi = 0 then
      vanish := true;
    fi;
    return vanish;

end );

# Compute all sheaf cohomologies by use of cohomCalg
InstallMethod( AllHiByCohomCalg,
               "for a toric variety and a list of degrees and a bool",
               [ IsToricVariety, IsList ],
  function( variety, degree_list )
    local cohomCalgDirectory, cohomCalg, stdin, stdout, outputs, i, buffer, 
         position, command_string, dimensions, Q;

    # check if the variety gives us a valid input
    if not ( ( IsComplete( variety) and IsSmooth( variety ) ) or
             ( IsSimplicial( Fan( variety ) ) and IsProjective( variety ) ) ) then 

      Error( "The variety has to be smooth, complete or simplicial, projective" );
      return;

    fi;

    # identify the location of cohomcalg
    cohomCalg := cohomCalgBinary( );

    # set up communication channels
    stdin := InputTextUser();
    outputs := List( [ 1 .. Length( degree_list ) ] );

    # iterate over all degree layers
    for i in [ 1 .. Length( degree_list ) ] do

      buffer := "";
      stdout := OutputTextString( buffer, true );

      # this is the string that we need to address cohomCalg
      # not that the degrees used by CAP describe the degree of the generators of the module
      # this is related by (-1) to the degree of the corresponding bundle, as used by cohomCalg
      command_string := cohomCalgCommandString( variety, degree_list[ i ][ 1 ] );

      # execute cohomCalg with the 'input file' described by the command_string
      # we use the integrated mode, so that only the necessary output is generated
      Process( cohomCalg[1], cohomCalg[2], stdin, stdout, ["--integrated", command_string ] );

      # make a number of adjustments to this string
      buffer := ReplacedString( buffer, "{", "[" );
      buffer := ReplacedString( buffer, "}", "]" );

      # check if something went wrong during the computation
      if buffer[ 2 ] = 'F' then

        Error( Concatenation( "cohomCalg experienced an error while computing the cohomologies of the bundle ",
                              String( degree_list[ i ][ 1 ] ) ) );
        return;

      else

        buffer[ 2 ] := 't';

      fi;

      # cut off the information, which specifies which rationoms contribute to which cohomology classes
      position := Positions( buffer, '[' )[ 4 ];
      buffer := List( [ 1 .. position-2 ], j -> buffer[ j ] );
      Add( buffer, ']' );
      Add( buffer, ']' );

      # now evaluate the string buffer
      buffer := EvalString( buffer );

      # and assign this new value
      outputs[ i ] := degree_list[ i ][ 2 ] * buffer[ 2 ][ 1 ];

    od;

    # now return the cohomology dimensions
    return Sum( outputs );

end );

# Compute just a single sheaf cohomology by use of cohomCalg
InstallMethod( HiByCohomCalg,
               "for a toric variety and a list of degrees and a bool",
               [ IsToricVariety, IsInt, IsList ],
  function( variety, cohomologyIndex, degree_list )

    return AllHiByCohomCalg( variety, degree_list )[ cohomologyIndex + 1 ];

end );

# Use cohomCalg to extract the denomiators of the rationoms which contribute to the cohomology classes.
# Note: Ambigious monomial contributions are not supported.
InstallMethod( ContributingDenominators,
               " for toric varieties",
               [ IsToricVariety ],
  function( variety )
    local command_string, cohomCalgDirectory, cohomCalg, stdin, stdout, output_string, start, diff, output_string_reduced,
         contributing_monomials, index, collector, i;

    # this the string that we need to address cohomCalg
    command_string := cohomCalgCommandString( variety );

    cohomCalg := cohomCalgBinary( );

    # set up communication channels
    stdin := InputTextUser();
    output_string := "";
    stdout := OutputTextString( output_string, true );

    # execute cohomCalg with the 'input file' described by the command_string
    Process( cohomCalg[1], cohomCalg[2], stdin, stdout, ["--verbose2", command_string ] );

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

      return fail;

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
