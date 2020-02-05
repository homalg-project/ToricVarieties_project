#############################################################################
##
##  Tools.gi            SparseMatrices package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to handle sparse matrices in gap
##
#############################################################################



##############################################################################################
##
## Section Find the SmastoDirectory
##
##############################################################################################


InstallMethod( FindSmastoDirectory,
               "",
               [ ],
  function( )
  local smasto_directory, package_directory, file, sys_programs, which, path, output, input, path_steps;
    
    # Initialse spasm_directory with fail and try in the following to do better
    smasto_directory := fail;
    
    # There might be a file in the PackageFolder in which the path to Spasm is noted down
    # So try to set up a stream to that file
    package_directory := DirectoriesPackageLibrary( "SparseMatrices", "gap" );
    if Length( package_directory ) > 1 then
        # If there are at least two versions, then we cannot find the SpasmDirectory uniquely
        Error( "Found at least two versions of SparseMatrices - unable to determine SmastoDirectory" );
        return;
    fi;
    package_directory := package_directory[ 1 ];
    file := Filename( package_directory, "SmastoDirectory.txt" );
    
    # Now figure out what our options are
    if IsExistingFile( file ) then
        
        # This file contains the directory to the spasm programs
        input := InputTextFile(file);
        smasto_directory := Directory( Chomp( ReadAll( input ) ) );
        CloseStream(input);
        
    else
        
        # try to find the program "which"
        sys_programs := DirectoriesSystemPrograms();
        which := Filename( sys_programs, "which" );
        if IsExistingFile( which ) then
        
            # set up variables
            path := "";
            output := OutputTextString( path, true );
            input := InputTextUser();
            
            # and use which to find "sms-adjoin" script, installed by smasto
            Process( DirectoryCurrent(), which, input, output, [ "sms-adjoin" ] );
            
            # in case we found a result, path is not empty
            if Length( path ) > 0 then
                
                # process the output
                RemoveCharacters( path, "\n" );
                path_steps := SplitString( path, "/" );
                path_steps := List( [ 1 .. Length( path_steps ) - 1 ], i -> Concatenation( path_steps[ i ], "/" ) );
                smasto_directory := Directory( Concatenation( path_steps ) );
                
            fi;
        
        fi;
        
    fi;
    
    # check if we were successful and otherwise raise and error
    if smasto_directory = fail then
        Error( "Could not find the SmastoDirectory" );
    fi;
    
    # return the result
    return smasto_directory;
    
end );

InstallMethod( SetSmastoDirectory,
               "a string",
               [ IsString ],
  function( path )
    local package_directory, file;

    # We want to write a file to the PackageFolder in which we store the location of Spasm
    package_directory := DirectoriesPackageLibrary( "SparseMatrices", "gap" );
    if Length( package_directory ) > 1 then
        # If there are at least two versions, then we cannot know in which folder to write
        Error( "Found at least two versions of SparseMatrices - unable to set SmastoDirectory" );
        return;
    fi;
    package_directory := package_directory[ 1 ];
    file := Filename( package_directory, "SmastoDirectory.txt" );
    
    # Now create this file/overwrite any existing such file
    PrintTo( file, path );
    
    # Signal sucess
    Print( "Smasto directory set successfully \n" );
    return true;
    
end );


##############################################################################################
##
##  Section Execute Spasm
##
##############################################################################################

# Execute Spasm
InstallMethod( ExecuteSmasto,
               "directory, executable binary, input and a list of options",
               [ IsDirectory, IsString, IsList, IsList, IsList ],
  function( SmastoDirectory, name_of_binary, input_list, options_list, values_list )
  local SmastoBinary, output_string, output, input_string, input, options, supported_options, i;
    
    # setup filename for this file
    SmastoBinary := Filename( SmastoDirectory, name_of_binary );
    if IsExistingFile( SmastoBinary ) = false then
        Error( Concatenation( "could not find the binary ", name_of_binary, " provided by Smasto" ) );
    fi;
    
    # prepare output_stream to launch Spasm
    output_string := "";
    output := OutputTextString( output_string, true );
    
    # prepare input_stream to launch Spasm
    input_string := Concatenation( String( input_list ), " " );
    input := InputTextString( input_string );
    
    # prepare options to be handed over to Spasm
    options := [];
    for i in [ 1 .. Length( options_list ) ] do
        if values_list[ i ] = "no-value" then
            Append( options, [ options_list[ i ] ] );
        else
            Append( options, [ options_list[ i ], values_list[ i ] ] );
        fi;
    od;
    
    # execute Smasto
    Process( DirectoryCurrent(), SmastoBinary, input, output, options );
    
    # return the output
    return output_string;
    
end );
