#############################################################################
##
##  Functions.gi        TopcomInterface package
##                      Martin Bies
##
##  Copyright 2019      ULB Brussels
##
##  A package to communicate with the software Topcom
##
#############################################################################



##############################################################################################
##
#! @Section Install functions to communicate with Topcom
##
##############################################################################################

# compute the maps in a minimal free resolution of a f.p. graded module presentation
InstallMethod( points2allfinetriangs,
               "a list of points",
               [ IsList ],
  function( points )

  local topcomBinary, trias_string, output, command_string, input;

    # find the topcom binary
    topcomBinary := FindTopcomBinary( "points2allfinetriangs" );

    # prepare to launch topcom
    trias_string := "";
    output := OutputTextString( trias_string, true );
    command_string := Concatenation( String( points ), " [] " );
    input := InputTextString(command_string);

    # execute topcom
    Process( DirectoryCurrent(), topcom, input, output, [ "--regular" ] );

    # now process the triangulations
    trias_string := ReplacedString( trias_string, "{", "[" );
    trias_string := ReplacedString( trias_string, "}", "]" );
    RemoveCharacters( trias_string, "\n" );

    # finally evaluate this string
    trias := EvalString( trias_string );
    # this fails if trias_string = "". The latter is the case if there does not exists a triangulation.

    return trias;

end );
