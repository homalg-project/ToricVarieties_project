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


InstallMethod( FindSpasmDirectory,
               "",
               [ ],
  function( )
  local spasm_directory, package_directory;
    
    # Initialse spasm_directory with fail and try in the following to do better
    spasm_directory := fail;
    
    # There might be a file in the PackageFolder in which the path to Spasm is noted down
    # So try to set up a stream to that file
    package_directory := DirectoriesPackageLibrary( "SpasmInterface", "gap" );
    if Length( package_directory ) > 1 then
        # If there are at least two versions, then we cannot find the SpasmDirectory uniquely
        Error( "Found at least two versions of SpasmInterface - unable to determine SpasmDirectory" );
        return;
    fi;
    package_directory := package_directory[ 1 ];
    spasm_directory := Directory( ReplacedString( Filename( package_directory, "" ), "gap/", "bin/" ) );
    
    # return the result
    return spasm_directory;
    
end );


##############################################################################################
##
##  Section Execute Spasm
##
##############################################################################################

# Execute Spasm
InstallMethod( ExecuteSpasm,
               "directory, executable binary, input and a list of options",
               [ IsDirectory, IsString, IsList, IsList, IsList ],
  function( SpasmDirectory, name_of_binary, input_list, options_list, values_list )

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
    supported_options := [ "--matrix", "--modulus" ];
    
    # check that all options provided are currently supported
    for i in [ 1 .. Length( options_list ) ] do
        if Position( supported_options, options_list[ i ] ) = fail then
            Error( Concatenation( "option ", options_list[ i ], " is currently not supported by SpasmInterface" ) );
        fi;
    od;
    
    # prepare options to be handed over to Spasm
    options := [];
    for i in [ 1 .. Length( options_list ) ] do
        if values_list[ i ] = "no-value" then
            Append( options, [ options_list[ i ] ] );
        else
            Append( options, [ options_list[ i ], values_list[ i ] ] );
        fi;
    od;
    
    # execute Spasm
    Process( DirectoryCurrent(), SpasmBinary, input, output, options );
    
    # return the output
    return output_string;
    
end );
