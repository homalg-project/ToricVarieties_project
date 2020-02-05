#############################################################################
##
##  Tools2.gi           LinBoxInterface package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to communicate with the software LinBox
##
#############################################################################



##############################################################################################
##
## Section Find the LinboxDirectory
##
##############################################################################################


InstallMethod( FindLinboxDirectory,
               "",
               [ ],
  function( )
  local linbox_directory, package_directory, file, sys_programs, which, path, output, input, path_steps;
    
    # Initialse linbox_directory with fail and try in the following to do better
    linbox_directory := fail;
    
    # There might be a file in the PackageFolder in which the path to Linbox is noted down
    # So try to set up a stream to that file
    package_directory := DirectoriesPackageLibrary( "LinBoxInterface", "gap" );
    if Length( package_directory ) > 1 then
        # If there are at least two versions, then we cannot find the LinBoxDirectory uniquely
        Error( "Found at least two versions of LinBoxInterface - unable to determine LinBoxDirectory" );
        return;
    fi;
    package_directory := package_directory[ 1 ];
    file := Filename( package_directory, "LinboxDirectory.txt" );
    
    # Now figure out what our options are
    if IsExistingFile( file ) then
        
        # This file contains the directory to the linbox programs
        input := InputTextFile(file);
        linbox_directory := Directory( Chomp( ReadAll( input ) ) );
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
            
            # and use which to find "kernel" script, installed by linbox
            Process( DirectoryCurrent(), which, input, output, [ "nullspacebasis" ] );
            
            # in case we found a result, path is not empty
            if Length( path ) > 0 then
                
                # process the output
                RemoveCharacters( path, "\n" );
                path_steps := SplitString( path, "/" );
                path_steps := List( [ 1 .. Length( path_steps ) - 1 ], i -> Concatenation( path_steps[ i ], "/" ) );
                linbox_directory := Directory( Concatenation( path_steps ) );
                
            fi;
        
        fi;
        
    fi;
    
    # check if we were successful and otherwise raise and error
    if linbox_directory = fail then
        Error( "Could not find the LinboxDirectory" );
    fi;
    
    # return the result
    return linbox_directory;
    
end );

InstallMethod( SetLinboxDirectory,
               "a string",
               [ IsString ],
  function( path )
    local package_directory, file;

    # We want to write a file to the PackageFolder in which we store the location of LinBox
    package_directory := DirectoriesPackageLibrary( "LinBoxInterface", "gap" );
    if Length( package_directory ) > 1 then
        # If there are at least two versions, then we cannot know in which folder to write
        Error( "Found at least two versions of LinBoxInterface - unable to set LinBoxDirectory" );
        return;
    fi;
    package_directory := package_directory[ 1 ];
    file := Filename( package_directory, "LinboxDirectory.txt" );
    
    # Now create this file/overwrite any existing such file
    PrintTo( file, path );
    
    # Signal sucess
    Print( "Linbox directory set successfully \n" );
    return true;
    
end );


##############################################################################################
##
##  Section Execute Linbox
##
##############################################################################################

# Execute Linbox
InstallMethod( ExecuteLinbox,
               "directory, executable binary, input and a list of options",
               [ IsDirectory, IsString, IsList ],
  function( LinboxDirectory, name_of_binary, input_data )
    local LinboxBinary, output_string, output, input_string, input, input_directory, input_file;
    
    # setup filename for this file
    LinboxBinary := Filename( LinboxDirectory, name_of_binary );
    if IsExistingFile( LinboxBinary ) = false then
        Error( Concatenation( "could not find the binary ", name_of_binary, " provided by Linbox" ) );
    fi;
    
    # prepare output_stream to launch LinBox
    output_string := "";
    output := OutputTextString( output_string, true );
    
    # prepare an empty input
    input_string := "";
    input := InputTextString( input_string );
    
    # create input file
    input_directory := DirectoryCurrent();
    input_file := Filename( input_directory, "input.sms" );
    AppendTo( input_file, input_data );
    
    # execute LinBox
    Process( DirectoryCurrent(), LinboxBinary, input, output, [ input_file ] );
    
    # remove the input file
    RemoveFile( input_file );
    
    # remove additional temporary file written by linbox (to be removed eventually)
    input_file := Filename( input_directory, "gmon.out" );
    if IsExistingFile( input_file ) then
        RemoveFile( input_file );
    fi;
    
    # return the output
    return output_string;
    
end );
