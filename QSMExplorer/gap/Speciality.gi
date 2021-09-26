###############################################################################################
##
##  Speciality.gi            QSMExplorer package
##
##                                  Martin Bies
##                                  University of Pennsylvania
##
##                                  Muyang Liu
##                                  University of Pennsylvania
##
##  Copyright 2021
##
##  A package to explore one Quadrillion F-theory Standard Models
##
##  Check speciality of line bundles
##


##############################################################################################
##
##  Determine if line bundle on nodal curve is special.
##
##############################################################################################


InstallMethod( Speciality, [ IsList, IsList ],
  function( degrees, edges )
        
        return Speciality( degrees, edges, true );
        
end );


InstallMethod( Speciality, [ IsList, IsList, IsBool ],
  function( degrees, edges, details )
        local str, a, nproc, number_processes, dir, bin, result_file, output_string, output, input_string, input, options, i, special;
        
        # display important information about this algorithm
        if details then
            Print( "\n" );
            Print( "This method works ONLY for tree-like curves.\n");
            Print( "NO CHECK FOR BEING TREE-LIKE IS CURRENTLY CONDUCTED. THE USER IS RESPONSIBLE FOR PROVIDING VALID INPUT.\n");
            Print( "\n" );
            Print( "This algorithm was first formulated and its accuracy proven by Prof. Dr. Ron Donagi.\n" );
        fi;
        
        # determine the number of processors to determine how many threads we will initiate
        str := "";
        a := OutputTextString(str,true);
        dir := Directory( "/usr/bin" );
        nproc := Filename( dir, "nproc" );
        Process( DirectoryCurrent(), nproc, InputTextNone(), a, [ "--all" ] );
        number_processes := EvalString( str );
        
        # find the counter binary (and check if it exists)
        dir := FindRootCounterDirectory();
        bin := Filename( dir, "./specialityChecker" );
        if not IsExistingFile( bin ) then
            Error( "./specialityChecker is not available in designed folder" );
        fi;
        
        # prepare empty streams
        output_string := "";
        output := OutputTextUser();
        input_string := "";
        input := InputTextString( input_string );
                
        # options convey the necessary information about the nodal curve
        options := Concatenation( String( Length( degrees ) ), " " );
        for i in [ 1 .. Length( degrees ) ] do
            options := Concatenation( options, String( degrees[ i ] ), " " );
        od;
        options := Concatenation( options, String( Length( edges ) ), " " );
        for i in [ 1 .. Length( edges ) ] do
            options := Concatenation( options, String( edges[ i ][ 1 ] ), " ", String( edges[ i ][ 2 ] ), " " );
        od;
        if details then
            options := Concatenation( options, " 1" );
        else
            options := Concatenation( options, " -1" );
        fi;
        
        # trigger the binary
        Process( DirectoryCurrent(), bin, input, output, [ options ] );
        
        # check if the result file exists
        result_file := Filename( dir, "result.txt" );
        if not IsExistingFile( result_file ) then
            Error( "result.txt is not available in designed folder" );
        fi;
        
        # if yes, read the content and then remove this file
        input := InputTextFile(result_file);
        special := EvalString( ReadAll( input ) );
        CloseStream(input);
        RemoveFile( result_file );
        
        # nicely output the result
        if details then
            Print( "\n\n" );
            Print( "Result\n" );
            if special then
                Print( "(C,L) is SPECIAL.\n\n" );
            else
                Print( "(C,L) is NON-SPECIAL.\n\n" );
            fi;
        fi;
        
        # return the result
        return special;
        
end );
