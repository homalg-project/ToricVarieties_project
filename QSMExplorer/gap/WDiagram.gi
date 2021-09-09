###############################################################################################
##
##  WDiagrams.gi            QSMExplorer package
##
##                                    Martin Bies
##                                    University of Pennsylvania
##
##                                    Muyang Liu
##                                    University of Pennsylvania
##
##  Copyright 2021
##
##  A package to explore one Quadrillion F-theory Standard Models
##
##  Computation of minimal roots and their distribution for arbitrary nodal curves.
##

##############################################################################################
##
##  Computation of minimal roots
##
##############################################################################################


InstallMethod( CountMinimals, [ IsList, IsList, IsList, IsInt, IsInt ],
  function( genera, degrees, edges, total_genus, root )  
        local str, a, nproc, number_processes, dir, bin, result_file, output_string, output, input_string, input, index, options, i, nr;
        
        # determine the number of processors to determine how many threads we will initiate
        str := "";
        a := OutputTextString(str,true);
        dir := Directory( "/usr/bin" );
        nproc := Filename( dir, "nproc" );
        Process( DirectoryCurrent(), nproc, InputTextNone(), a, [ "--all" ] );
        number_processes := EvalString( str );
        
        # find the counter binary (and check if it exists)
        dir := FindRootCounterDirectory();
        bin := Filename( dir, "./min-counter" );
        if not IsExistingFile( bin ) then
            Error( "./distribution-counter is not available in designed folder" );
        fi;
        
        # prepare empty streams
        output_string := "";
        output := OutputTextUser();
        input_string := "";
        input := InputTextString( input_string );
        
        # options convey the necessary information about the graph
        options := Concatenation( String( Length( genera ) ), " " );
        for i in [ 1 .. Length( degrees ) ] do
            options := Concatenation( options, String( degrees[ i ] ), " " );
        od;
        for i in [ 1 .. Length( genera ) ] do
            options := Concatenation( options, String( genera[ i ] ), " " );
        od;
        options := Concatenation( options, String( Length( edges ) ), " " );
        for i in [ 1 .. Length( edges ) ] do
            options := Concatenation( options, String( edges[ i ][ 1 ] ), " ", String( edges[ i ][ 2 ] ), " " );
        od;
        options := Concatenation( options, String( total_genus ), " ", String( root ), " ", String( number_processes ) );
        
        # triggerthe binary
        Process( DirectoryCurrent(), bin, input, output, [ options ] );
        
         # check if the result file exists
        result_file := Filename( dir, "result.txt" );
        if not IsExistingFile( result_file ) then
            Error( "result.txt is not available in designed folder" );
        fi;
        
        # if yes, read the content
        input := InputTextFile(result_file);
        nr := EvalString( ReadAll(input) );
        CloseStream(input);
        RemoveFile( result_file );
        
        # return success
        return nr;
        
end );


InstallMethod( CountSimpleMinimals,
               "",
               [ ],
  function( )
        local str, a, nproc, number_processes, dir, bin, result_file, output_string, output, input_string, input, index, genera, degrees, edges, total_genus, root, options, i, nr;
        
        # determine the number of processors to determine how many threads we will initiate
        str := "";
        a := OutputTextString(str,true);
        dir := Directory( "/usr/bin" );
        nproc := Filename( dir, "nproc" );
        Process( DirectoryCurrent(), nproc, InputTextNone(), a, [ "--all" ] );
        number_processes := EvalString( str );
        
        # find the counter binary (and check if it exists)
        dir := FindRootCounterDirectory();
        bin := Filename( dir, "./min-counter" );
        if not IsExistingFile( bin ) then
            Error( "./distribution-counter is not available in designed folder" );
        fi;
        
        # prepare empty streams
        output_string := "";
        output := OutputTextUser();
        input_string := "";
        input := InputTextString( input_string );
        
        # specify data of diagram
        genera := [ 0,0,0 ];
        degrees := [ 16, 16, 16 ];
        edges := [ [0,1], [1,2], [2,0] ];
        total_genus := 1;
        root := 8;
        
        # options convey the necessary information about the graph
        options := Concatenation( String( Length( genera ) ), " " );
        for i in [ 1 .. Length( degrees ) ] do
            options := Concatenation( options, String( degrees[ i ] ), " " );
        od;
        for i in [ 1 .. Length( genera ) ] do
            options := Concatenation( options, String( genera[ i ] ), " " );
        od;
        options := Concatenation( options, String( Length( edges ) ), " " );
        for i in [ 1 .. Length( edges ) ] do
            options := Concatenation( options, String( edges[ i ][ 1 ] ), " ", String( edges[ i ][ 2 ] ), " " );
        od;
        options := Concatenation( options, String( total_genus ), " ", String( root ), " ", String( number_processes ) );
        
        # triggerthe binary
        Process( DirectoryCurrent(), bin, input, output, [ options ] );
        
         # check if the result file exists
        result_file := Filename( dir, "result.txt" );
        if not IsExistingFile( result_file ) then
            Error( "result.txt is not available in designed folder" );
        fi;
        
        # if yes, read the content
        input := InputTextFile(result_file);
        nr := EvalString( ReadAll(input) );
        CloseStream(input);
        RemoveFile( result_file );
        
        # return success
        return nr;
        
end );


##############################################################################################
##
##  Computation of distributions
##
##############################################################################################


InstallMethod( CountDistribution, [ IsList, IsList, IsList, IsInt, IsInt, IsInt ],
  function( genera, degrees, edges, total_genus, root, limit )  
        local str, a, nproc, number_processes, dir, bin, result_file, output_string, output, input_string, input, index, options, i, nr, nr_truncated;
        
        # determine the number of processors to determine how many threads we will initiate
        str := "";
        a := OutputTextString(str,true);
        dir := Directory( "/usr/bin" );
        nproc := Filename( dir, "nproc" );
        Process( DirectoryCurrent(), nproc, InputTextNone(), a, [ "--all" ] );
        number_processes := EvalString( str );
        
        # find the counter binary (and check if it exists)
        dir := FindRootCounterDirectory();
        bin := Filename( dir, "./distribution-counter" ); #<- to be adjusted!
        if not IsExistingFile( bin ) then
            Error( "./distribution-counter is not available in designed folder" );
        fi;
        
        # prepare empty streams
        output_string := "";
        output := OutputTextUser();
        input_string := "";
        input := InputTextString( input_string );
        
        # options convey the necessary information about the graph
        options := Concatenation( String( Length( genera ) ), " " );
        for i in [ 1 .. Length( degrees ) ] do
            options := Concatenation( options, String( degrees[ i ] ), " " );
        od;
        for i in [ 1 .. Length( genera ) ] do
            options := Concatenation( options, String( genera[ i ] ), " " );
        od;
        options := Concatenation( options, String( Length( edges ) ), " " );
        for i in [ 1 .. Length( edges ) ] do
            options := Concatenation( options, String( edges[ i ][ 1 ] ), " ", String( edges[ i ][ 2 ] ), " " );
        od;
        options := Concatenation( options, String( total_genus ), " ", String( root ), " ", String( number_processes ), " ", String( limit ) );
        
        # triggerthe binary
        Process( DirectoryCurrent(), bin, input, output, [ options ] );
        
        # check if the result file exists
        result_file := Filename( dir, "result.txt" );
        if not IsExistingFile( result_file ) then
            Error( "result.txt is not available in designed folder" );
        fi;
        
        # if yes, read the content
        input := InputTextFile(result_file);
        nr := List( SplitString( ReadAll( input ), "\n" ), i -> EvalString( i ) );
        CloseStream(input);
        RemoveFile( result_file );
        
        # truncate result to display the values desired by the user
        nr_truncated := List( [ 1 .. limit - 2 ], i -> nr[ i ] );
        
        # return result
        return nr_truncated;
  
end );


InstallMethod( CountSimpleDistribution,
               "",
               [ ],
  function( )
        local str, a, nproc, number_processes, dir, bin, result_file, output_string, output, input_string, input, index, genera, degrees, edges, total_genus, root, options, i, nr, nr_truncated, limit;
        
        # determine the number of processors to determine how many threads we will initiate
        str := "";
        a := OutputTextString(str,true);
        dir := Directory( "/usr/bin" );
        nproc := Filename( dir, "nproc" );
        Process( DirectoryCurrent(), nproc, InputTextNone(), a, [ "--all" ] );
        number_processes := EvalString( str );
        
        # find the counter binary (and check if it exists)
        dir := FindRootCounterDirectory();
        bin := Filename( dir, "./distribution-counter" ); #<- to be adjusted!
        if not IsExistingFile( bin ) then
            Error( "./distribution-counter is not available in designed folder" );
        fi;
        
        # prepare empty streams
        output_string := "";
        output := OutputTextUser();
        input_string := "";
        input := InputTextString( input_string );
        
        # specify data of diagram
        genera := [ 0,0,0 ];
        degrees := [ 16, 16, 16 ];
        edges := [ [0,1], [1,2], [2,0] ];
        total_genus := 1;
        root := 8;
        limit := 8;
        
        # options convey the necessary information about the graph
        options := Concatenation( String( Length( genera ) ), " " );
        for i in [ 1 .. Length( degrees ) ] do
            options := Concatenation( options, String( degrees[ i ] ), " " );
        od;
        for i in [ 1 .. Length( genera ) ] do
            options := Concatenation( options, String( genera[ i ] ), " " );
        od;
        options := Concatenation( options, String( Length( edges ) ), " " );
        for i in [ 1 .. Length( edges ) ] do
            options := Concatenation( options, String( edges[ i ][ 1 ] ), " ", String( edges[ i ][ 2 ] ), " " );
        od;
        options := Concatenation( options, String( total_genus ), " ", String( root ), " ", String( number_processes ), " ", String( limit ) );
        
        # triggerthe binary
        Process( DirectoryCurrent(), bin, input, output, [ options ] );
        
        # check if the result file exists
        result_file := Filename( dir, "result.txt" );
        if not IsExistingFile( result_file ) then
            Error( "result.txt is not available in designed folder" );
        fi;
        
        # if yes, read the content
        input := InputTextFile(result_file);
        nr := List( SplitString( ReadAll( input ), "\n" ), i -> EvalString( i ) );
        CloseStream(input);
        RemoveFile( result_file );
        
        # truncate result to display the values desired by the user
        nr_truncated := List( [ 1 .. limit - 2 ], i -> nr[ i ] );
        
        # return result
        return nr_truncated;

end );

