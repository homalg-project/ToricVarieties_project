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

InstallMethod( HiByCohomCalg,
               "for a toric variety and a list of degrees and a bool",
               [ IsToricVariety, IsInt, IsList ],
  function( variety, cohomologyIndex, degree_list )

    return AllHiByCohomCalg( variety, degree_list )[ cohomologyIndex + 1 ];

end );
