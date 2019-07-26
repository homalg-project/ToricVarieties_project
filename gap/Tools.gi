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
## Section Turn toric variety and degree into a command string that we can pass to cohomCalg
##
##############################################################################################

# produce the command string that will be handed over to cohomCalg
InstallMethod( cohomCalgCommandString,
               " for toric varieties",
               [ IsToricVariety, IsList ],
  function( variety, degree )
    local bool1, bool2, output_string, weights_of_indeterminates, names_of_indeterminates, i, buffer, SR_ideal_generators;

    # step0: check if the toric variety can be treated with cohomCalg
    bool1 := IsSmooth( variety ) and IsComplete( variety );
    bool2 := IsProjective( variety ) and IsSimplicial( Fan( variety ) );
    if not ( bool1 or bool2 ) then

        Error( "The toric variety must be either (smooth, complete) or (simplicial, projective)" );
        return;

    fi;
    
    # step1: check for valid input
    if Rank( ClassGroup( variety ) ) = 0 then

      Error( "Currently not supported" );
      return;

    elif Rank( ClassGroup( variety ) ) <> Length( degree ) then

      Error( "The given list must have length equal to the rank of ClassGroup( variety )" );
      return;

    fi;

    for i in [ 1 .. Length( degree ) ] do

      if not IsInt( degree[ i ] ) then

        Error( "All entries of the given list must be integers" );
        return;

      fi;

    od;

    # step2: extract the weights of the variables in the Coxring and turn them into suitable strings
    weights_of_indeterminates := ShallowCopy( WeightsOfIndeterminates( CoxRing( variety ) ) );
    if Rank( ClassGroup( variety ) ) = 1 then

      for i in [ 1 .. Length( weights_of_indeterminates ) ] do

        # turn the homalg_module_element into a string
        buffer := String( weights_of_indeterminates[ i ] );

        # now add "(" and ")" before and after
        buffer := Concatenation( "( ", buffer, " )" );

        # and save the new version
        weights_of_indeterminates[ i ] := buffer;

      od;

    else

      for i in [ 1 .. Length( weights_of_indeterminates ) ] do

        # turn the homalg_module_element into a string
        buffer := String( weights_of_indeterminates[ i ] );

        # to match the expected format from cohomCalg, remove [ ] and replace them by ( )
        buffer := ReplacedString( buffer, "[", "(" );
        buffer := ReplacedString( buffer, "]", ")" );

        # and save the new version
        weights_of_indeterminates[ i ] := buffer;

      od;

    fi;

    # step3: add the 'GSLM weights' of the coordinates to the output_string
    output_string := "";
    for i in [ 1 .. Length( weights_of_indeterminates ) ] do

      output_string := Concatenation( output_string, "vertex u", String( i ), " | GLSM: ", 
                                      weights_of_indeterminates[ i ], "; " );

    od;

    # step4: add the Stanley-Reisner ideal to the output string
    output_string := Concatenation( output_string, " srideal " );
    SR_ideal_generators := String( EntriesOfHomalgMatrix( MatrixOfSubobjectGenerators( SRIdeal( variety ) ) ) );
    names_of_indeterminates := IndeterminatesOfPolynomialRing( CoxRing( variety ) );
    for i in [ 1 .. Length( names_of_indeterminates ) ] do
      SR_ideal_generators := ReplacedString( SR_ideal_generators,
                                             String( names_of_indeterminates[ i ] ), 
                                             Concatenation( "u", String( i ) ) 
                                            );
    od;
    output_string := Concatenation( output_string, SR_ideal_generators, "; " );

    # step5: switch the use of intermediate monomial file off
    output_string := Concatenation( output_string, "monomialfile off;" );

    # step6: add the bundle charges, i.e. the list degree
    buffer := String( degree );
    buffer := ReplacedString( buffer, "[", "(" );
    buffer := ReplacedString( buffer, "]", ")" );
    output_string := Concatenation( output_string, "ambientcohom O", buffer, ";" );

    # step7: add option that tells cohomCalg to treat this string as an input file
    output_string := Concatenation( "--in=", output_string );

    # step8: return the output_string
    return output_string;

end );

# produce the command string that will handed over to cohomCalg
InstallMethod( cohomCalgCommandString,
               " for toric varieties",
               [ IsToricVariety ],
  function( variety )

    return cohomCalgCommandString( variety, List( [ 1 .. Rank( ClassGroup( variety ) ) ], i -> 0 ) );

end );
