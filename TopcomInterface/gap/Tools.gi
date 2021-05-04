#############################################################################
##
##  Tools.gi            TopcomInterface package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to communicate with the software Topcom
##
#############################################################################



##############################################################################################
##
## Section Find the TopcomDirectory
##
##############################################################################################

InstallMethod( FindTopcomDirectory,
               "a string -- name of TopcomBinary",
               [ ],
  function( )  
  local sys_programs, which, path, output, input, path_steps, directory;
  
    # find the program "which"
    sys_programs := DirectoriesSystemPrograms();
    which := Filename( sys_programs, "which" );
    if IsExistingFile( which ) = false then
        Error( "program which not found" );
    fi;

    # find path to the topcom file 
    path := "";
    output := OutputTextString( path, true );
    input := InputTextUser();
    Process( DirectoryCurrent(), which, input, output, [ "points2chiro" ] );
    # we use the hard-coded name "points2chiro", as this is one of the many methods provided by topcom

    # process the output
    RemoveCharacters( path, "\n" );
    path_steps := SplitString( path, "/" );
    path_steps := List( [ 1 .. Length( path_steps ) - 1 ], i -> Concatenation( path_steps[ i ], "/" ) );
    directory := Directory( Concatenation( path_steps ) );

    # return the directory
    return directory;

end );



##############################################################################################
##
##  Section Execute topcom
##
##############################################################################################

# Execute topcom
InstallMethod( ExecuteTopcomForPoints,
               "directory, executable binary, input1, input2 and a list of options",
               [ IsDirectory, IsString, IsList, IsList, IsList ],
  function( topcomDirectory, name_of_binary, input1, input2, options_list )

  local topcomBinary, output_string, output, input_string, input, options, supported_options, i, trias;

    # setup filename for this file
    topcomBinary := Filename( topcomDirectory, name_of_binary );
    if IsExistingFile( topcomBinary ) = false then
        Error( Concatenation( "could not find the binary ", name_of_binary, " provided by topcom" ) );
    fi;
  
    # prepare output_stream to launch topcom
    output_string := "";
    output := OutputTextString( output_string, true );

    # prepare input_stream to launch topcom
    input_string := Concatenation( String( input1 ), " ", String( input2 )," " );
    input := InputTextString( input_string );
    
    # introduce the options currently supported by topcom and this interface
    supported_options := [ "checktriang", "flipdeficiency", "heights", "noinsertion", 
                           "reducepoints", "regular", "nonregular", "memopt", "soplex", "dump" ];

    # check that all options provided are currently supported
    for i in [ 1 .. Length( options_list ) ] do
        if Position( supported_options, options_list[ i ] ) = fail then
            Error( Concatenation( "option ", options_list[ i ], " is currently not supported by TopcomInterface" ) );            
        fi;
    od;

    # prepare options to be handed to topcom
    options := "";
    for i in [ 1 .. Length( options_list ) ] do
      options := Concatenation( options, "--", String( options_list[ i ] ), " " );
    od;
    
    # execute topcom
    Process( DirectoryCurrent(), topcomBinary, input, output, [ options ] );
    
    # now process the triangulations
    output_string := ReplacedString( output_string, "}\n{", "],[" );
    output_string := ReplacedString( output_string, "{", "[" );
    output_string := ReplacedString( output_string, "}", "]" );
    RemoveCharacters( output_string, "\n" );

    # finally return the result
    return output_string;

end );

# Execute topcom
InstallMethod( ExecuteTopcomForChiro,
               "directory, executable binary, input1, input2 and a list of options",
               [ IsDirectory, IsString, IsString, IsList, IsList ],
  function( topcomDirectory, name_of_binary, input1, input2, options_list )

  local topcomBinary, output_string, output, input_string, input, options, supported_options, i, trias;

    # setup filename for this file
    topcomBinary := Filename( topcomDirectory, name_of_binary );
    if IsExistingFile( topcomBinary ) = false then
        Error( Concatenation( "could not find the binary ", name_of_binary, " provided by topcom" ) );
    fi;
  
    # prepare output_stream to launch topcom
    output_string := "";
    output := OutputTextString( output_string, true );

    # prepare input_stream to launch topcom
    input_string := Concatenation( input1, " ", String( input2 )," " );
    input := InputTextString( input_string );
    
    # introduce the options currently supported by topcom and this interface
    supported_options := [ "checktriang", "flipdeficiency", "heights", "noinsertion", 
                           "reducepoints", "regular", "nonregular", "memopt", "soplex", "dump" ];

    # check that all options provided are currently supported
    for i in [ 1 .. Length( options_list ) ] do
        if Position( supported_options, options_list[ i ] ) = fail then
            Error( Concatenation( "option ", options_list[ i ], " is currently not supported by TopcomInterface" ) );            
        fi;
    od;

    # prepare options to be handed to topcom
    options := "";
    for i in [ 1 .. Length( options_list ) ] do
      options := Concatenation( options, "--", String( options_list[ i ] ), " " );
    od;
    
    # execute topcom
    Process( DirectoryCurrent(), topcomBinary, input, output, [ options ] );
    
    # now process the triangulations
    output_string := ReplacedString( output_string, "}\n{", "],[" );
    output_string := ReplacedString( output_string, "{", "[" );
    output_string := ReplacedString( output_string, "}", "]" );
    RemoveCharacters( output_string, "\n" );

    # finally return the result
    return output_string;

end );
