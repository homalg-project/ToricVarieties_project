#############################################################################
##
##  Tools.gi            TopcomInterface package
##                      Martin Bies
##
##  Copyright 2019      ULB Brussels
##
##  A package to communicate with the software Topcom
##
#############################################################################


##############################################################################################
##
#! @Section Find the TopcomDirectory
##
##############################################################################################

InstallMethod( FindTopcomBinary, 
               "a string -- name of TopcomBinary",
               [ IsString ],
  function( name_of_binary )  
  local sys_programs, path, output, input, path_steps, directory, topcomBinary;
  
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
    Process( DirectoryCurrent(), which, input, output, [ name_of_binary ] );

    # process the output
    RemoveCharacters( path, "\n" );
    path_steps := SplitString( path, "/" );
    path_steps := List( [ 1 .. Length( path_steps ) - 1 ], i -> Concatenation( path_steps[ i ], "/" ) );
    directory := Directory( Concatenation( path_steps ) );

    # setup filename for this file
    topcomBinary := Filename( directory, name_of_binary );
    if IsExistingFile( topcomBinary ) = false then
        Error( Concatenation( "could not find the binary ", name_of_binary, " provided by topcom" ) );
    fi;
  
    # return the filename
    return topcom;

end );
