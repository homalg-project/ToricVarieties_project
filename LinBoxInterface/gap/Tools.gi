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
  local linbox_directory, package_directory;
    
    # Initialse spasm_directory with fail and try in the following to do better
    linbox_directory := fail;
    
    # There might be a file in the PackageFolder in which the path to Spasm is noted down
    # So try to set up a stream to that file
    package_directory := DirectoriesPackageLibrary( "LinBoxInterface", "gap" );
    if Length( package_directory ) > 1 then
        # If there are at least two versions, then we cannot find the SpasmDirectory uniquely
        Error( "Found at least two versions of LinBoxInterface - unable to determine LinBoxDirectory" );
        return;
    fi;
    package_directory := package_directory[ 1 ];
    linbox_directory := Directory( ReplacedString( Filename( package_directory, "" ), "gap/", "bin/" ) );
    
    # return the result
    return linbox_directory;
    
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
    input_directory := FindLinboxDirectory();
    input_file := Filename( input_directory, "input.sms" );
    AppendTo( input_file, input_data );
    
    # execute LinBox
    Process( DirectoryCurrent(), LinboxBinary, input, output, [ input_file ] );
    
    # remove the input file
    RemoveFile( input_file );
    
    # remove additional temporary file written by linbox (to be removed eventually)
    input_file := Filename( DirectoryCurrent(), "gmon.out" );
    if IsExistingFile( input_file ) then
        RemoveFile( input_file );
    fi;
    
    # return the output
    return output_string;
    
end );
