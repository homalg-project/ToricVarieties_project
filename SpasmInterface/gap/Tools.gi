#############################################################################
##
##  Tools.gi            SpasmInterface package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to communicate with the software Spasm
##
#############################################################################



##############################################################################################
##
## Section Find the SpasmDirectory
##
##############################################################################################

# Here, a hard coded path to the spasm interface can be provided if needed.
# By default it is assumed that this is not necessary and this variable is set to fail.
SPASM_INTERFACE_SPASM_DIRECTORY := fail;
# However, if you need to set this directory explicitly, then this would look as follows:
# SPASM_INTERFACE_SPASM_DIRECTORY := Directory( "path" );
# where path is the full path to the spasm directory. For example if this was /home/spasm,
# then we would use
# SPASM_INTERFACE_SPASM_DIRECTORY := Directory( "/home/spasm/" );

InstallMethod( FindSpasmDirectory,
               "a string -- name of SpasmBinary",
               [ ],
  function( )
  local directory, sys_programs, which, path, output, input, path_steps;
    
    if SPASM_INTERFACE_SPASM_DIRECTORY <> fail then
        
        directory := SPASM_INTERFACE_SPASM_DIRECTORY;
        
    else
        
        # find the program "which"
        sys_programs := DirectoriesSystemPrograms();
        which := Filename( sys_programs, "which" );
        if IsExistingFile( which ) = false then
            Error( "program which not found" );
        fi;
        
        # find path to the Spasm file 
        path := "";
        output := OutputTextString( path, true );
        input := InputTextUser();
        Process( DirectoryCurrent(), which, input, output, [ "kernel" ] );
        # we use the hard-coded name "kernel", as this is one of the many methods provided by Spasm
        
        # process the output
        RemoveCharacters( path, "\n" );
        path_steps := SplitString( path, "/" );
        path_steps := List( [ 1 .. Length( path_steps ) - 1 ], i -> Concatenation( path_steps[ i ], "/" ) );
        directory := Directory( Concatenation( path_steps ) );
        
    fi;
    
    # return the directory
    return directory;
    
end );



##############################################################################################
##
##  Section Execute Spasm
##
##############################################################################################

# Execute Spasm
InstallMethod( ExecuteSpasm,
               "directory, executable binary, input and a list of options",
               [ IsDirectory, IsString, IsList, IsList ],
  function( SpasmDirectory, name_of_binary, input_list, options_list )

  local SpasmBinary, output_string, output, input_string, input, options, supported_options, i;

    # setup filename for this file
    SpasmBinary := Filename( SpasmDirectory, name_of_binary );
    if IsExistingFile( SpasmBinary ) = false then
        Error( Concatenation( "could not find the binary ", name_of_binary, " provided by Spasm" ) );
    fi;
  
    # prepare output_stream to launch Spasm
    output_string := "";
    output := OutputTextString( output_string, true );

    # prepare input_stream to launch Spasm
    input_string := Concatenation( String( input_list ), " " );
    input := InputTextString( input_string );
    
    # introduce the options currently supported by Spasm and this interface
    supported_options := [ "matrix" ];

    # check that all options provided are currently supported
    for i in [ 1 .. Length( options_list ) ] do
        if Position( supported_options, options_list[ i ] ) = fail then
            Error( Concatenation( "option ", options_list[ i ], " is currently not supported by SpasmInterface" ) );
        fi;
    od;

    # prepare options to be handed over to Spasm
    options := "";
    for i in [ 1 .. Length( options_list ) -1 ] do
      options := Concatenation( options, "--", String( options_list[ i ] ), " " );
    od;
    options := Concatenation( options, "--", String( options_list[ Length( options_list ) ] ) );

    # execute Spasm
    Process( DirectoryCurrent(), SpasmBinary, input, output, [ options ] );
    
    # return the output
    return output_string;

end );
