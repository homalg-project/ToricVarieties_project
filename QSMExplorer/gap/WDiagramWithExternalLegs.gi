###############################################################################################
##
##  WDiagramWithExternalLegs.gi            QSMExplorer package
##
##                                                              Martin Bies
##                                                              University of Pennsylvania
##
##                                                              Muyang Liu
##                                                              University of Pennsylvania
##
##  Copyright 2021
##
##  A package to explore one Quadrillion F-theory Standard Models
##
##  Computation of minimal roots and their distribution for arbitrary nodal curves with external legs.
##


##############################################################################################
##
##  Computation of root distributions on nodal curves with external legs.
##
##############################################################################################


InstallMethod( CountSimpleDistributionWithExternalLegs, [ ],
  function( )
        
        return CountDistributionWithExternalLegs( [ [ 0,0,0 ], [ 16, 16, 16 ], [ [0,1], [1,2], [2,0] ], 1, 8, 1, 8, [ 0, 0, 1 ], [ 2, 2, 4 ] ] );
        
end );


InstallMethod( CountDistributionWithExternalLegs, [ IsList ],
  function( data )
        local genera, degrees, edges, total_genus, root, min, max, external_legs, external_weights, str, a, nproc, number_processes, dir, bin, result_file, output_string, output, input_string, input, index, options, i, nr, nr_truncated;
        
        # extract data
        genera := data[ 1 ];
        degrees := data[ 2 ];
        edges := data[ 3 ];
        total_genus := data[ 4 ];
        root := data[ 5 ];
        min := data[ 6 ];
        max := data[ 7 ];
        external_legs := data[ 8 ];
        external_weights := data[ 9 ];
        
        # check that we receive as many external legs as weights
        if Length( external_legs ) <> Length( external_weights ) then
            Error( "The number of external legs and the number of provided external weights are different." );
            return -1;
        fi;
        
        # check that all external weights are meaningful
        for i in [ 1 .. Length( external_weights ) ] do
            if ( external_weights[ i ] < 1 ) or ( external_weights[ i ] > root - 1 ) then
                Error( Concatenation( "The external weights must not be smaller than 1 and not be bigger than the root (here ", String( root ), ")" ) );
                return -1;
            fi;
        od;
        
        # check if min is meaningful
        if ( min < 0 ) then
            Print( "Min must not be negative. Replaced by 0 in order to proceed.\n" );
            min := 0;
        fi;
        
        # check for degenerate case, i.e. where there are no roots
        if not IsInt( ( Sum( degrees ) - Sum( external_weights ) ) / root ) then
            return List( [ 1 .. 100 ], i -> 0);
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
        bin := Filename( dir, "./distributionCounter" );
        if not IsExistingFile( bin ) then
            Error( "./distributionCounter is not available in designed folder" );
        fi;
        
        # prepare empty streams
        output_string := "";
        output := OutputTextUser();
        input_string := "";
        input := InputTextString( input_string );
                
        # options convey the necessary information about the nodal curve
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
        options := Concatenation( options, String( Length( external_legs ) ), " " );
        for i in [ 1 .. Length( external_legs ) ] do
            options := Concatenation( options, String( external_legs[ i ] ), " " );
            options := Concatenation( options, String( external_weights[ i ] ), " " );
        od;
        options := Concatenation( options, String( total_genus ), " ", String( root ), " ", String( number_processes ), " ", String( min ), " ", String( max ) );
        
        # trigger the binary
        Process( DirectoryCurrent(), bin, input, output, [ options ] );
        
        # check if the result file exists
        result_file := Filename( dir, "result.txt" );
        if not IsExistingFile( result_file ) then
            Error( "result.txt is not available in designed folder" );
        fi;
        
        # if yes, read the content and then remove this file
        input := InputTextFile(result_file);
        nr := List( SplitString( ReadAll( input ), "\n" ), i -> EvalString( i ) );
        CloseStream(input);
        RemoveFile( result_file );
        
        # truncate the result and return it
        #nr_truncated := List( [ 1 .. limit - 2 ], i -> nr[ i ] );
        return nr;
  
end );
