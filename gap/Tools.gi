#############################################################################
##
##  Tools.gi            cohomCalgInterface package
##                      Martin Bies
##
##  Copyright 2019      ULB Brussels
##
##  A package to communicate with the software cohomCalg
##
#############################################################################



##############################################################################################
##
## Section Find cohomCalgBinary
##
##############################################################################################

InstallMethod( cohomCalgBinary,
               "a string -- name of TopcomBinary",
               [ ],
  function( )
    local arch, linux, apple, dir, cohomcalg;
    
    arch := GAPInfo.Architecture;

    linux := "x86_64-pc-linux";
    apple := "x86_64-apple-darwin";
    
    if arch{[ 1 .. 15 ]} = linux then
        arch := linux;
    elif arch{[ 1 .. 19 ]} = apple then
        arch := apple;
    fi;
    
    arch := Concatenation( "cohomCalg/", arch );
    
    dir := DirectoriesPackageLibrary( "SheafCohomologyOnToricVarieties", arch )[ 1 ];
    
    cohomcalg := Filename( dir, "cohomcalg" );
    
    if not IsExistingFile( cohomcalg ) then
        Error( "no cohomcalg binary found in the subdirectory ", arch );
    fi;
    
    return [ dir, cohomcalg ];
    
end );


##############################################################################################
##
##  Section Execute topcom
##
##############################################################################################

# Execute topcom
InstallMethod( ExecuteTopcom,
               "input1, input2 and a list of options",
               [ IsDirectory, IsString, IsList, IsList, IsList ],
  function( topcomDirectory, name_of_binary, input1, input2, options_list )

  local topcomBinary, output_string, output, input_string, input, options, i, trias;

    # setup filename for this file
    topcomBinary := Filename( topcomDirectory, name_of_binary );
    if IsExistingFile( topcomBinary ) = false then
        Error( Concatenation( "could not find the binary ", name_of_binary, " provided by topcom" ) );
    fi;
  
    # prepare to launch topcom
    output_string := "";
    output := OutputTextString( output_string, true );
    input_string := Concatenation( String( input1 ), " ", String( input2 )," " );
    input := InputTextString( input_string );
    options := "";
    for i in [ 1 .. Length( options_list ) ] do
      options := Concatenation( options, "--", String( options_list[ i ] ), " " );
    od;
    
    # execute topcom
    Process( DirectoryCurrent(), topcomBinary, input, output, [ options ] );

    # now process the triangulations
    output_string := ReplacedString( output_string, "{", "[" );
    output_string := ReplacedString( output_string, "}", "]" );
    RemoveCharacters( output_string, "\n" );

    # finally return the result
    return output_string;

end );

