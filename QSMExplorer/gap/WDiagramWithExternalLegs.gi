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

InstallMethod( CountDistributionWithExternalLegs, [ IsList ],
    function( data )
        
        return CountDistributionWithExternalLegs( data, true );
        
end );

InstallMethod( CountDistributionWithExternalLegs, [ IsList, IsBool ],
  function( data, display_details )
        local genera, degrees, edges, total_genus, root, min, max, external_legs, external_weights, str, a, nproc, number_processes, dir, bin, result_file, output_string, output, input_string, input, options, i, nr;
        
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
        
        # Check that we receive as many degrees as genera
        if Length( degrees ) <> Length( genera ) then
            Error( "The number of degrees must match the number of genera." );
            return -1;
        fi;
        
        # Check that the genera and degrees are suitable integers
        for i in [ 1 .. Length( degrees ) ] do
            if not IsInt( degrees[ i ] ) then
                Error( "The degrees must be integers." );
                return -1;
            fi;
            if not IsInt( genera[ i ] ) then
                Error( "The genera must be integers." );
                return -1;
            fi;
            if genera[ i ] < 0 then
                Error( "The genera must be non-negative." );
                return -1;
            fi;
        od;
        
        # Check edges
        for i in [ 1 .. Length( edges ) ] do
            if ( not IsList( edges[ i ] ) ) then
                Error( "Each edges must be a list." );
                return -1;
            fi;
            if ( ( Length( edges[ i ] ) > 2 ) or ( Length( edges[ i ] ) < 2 ) ) then                
                Error( "Each edges must consist of exactly two integers." );
                return -1;
            fi;
            if ( not IsInt( edges[ i ][ 1 ] ) ) or ( not IsInt( edges[ i ][ 2 ] ) ) then
                Error( "Each edge must consist of exactly two integers." );
                return -1;            
            fi;
            if ( ( edges[ i ][ 1 ] < 0 ) or ( edges[ i ][ 1 ] >= Length( genera ) ) ) then
                Error( Concatenation( "Vertices are labeled from 0 to ", String( Length( genera ) - 1 ), "." ) );
                return -1;            
            fi;
            if ( ( edges[ i ][ 2 ] < 0 ) or ( edges[ i ][ 2 ] >= Length( genera ) ) ) then
                Error( Concatenation( "Vertices are labeled from 0 to ", String( Length( genera ) - 1 ), "." ) );
                return -1;            
            fi;
        od;
        
        # Check total genus
        if not IsInt( total_genus ) then
            Error( "Total genus must be a non-negative integer." );
            return -1;                    
        fi;
        if ( total_genus < 0 ) then
            Error( "Total genus must be a non-negative integer." );
            return -1;                    
        fi;
        
        # Check root
        if not IsInt( root ) then
            Error( "Root must be a non-negative integer." );
            return -1;                    
        fi;
        if ( root < 0 ) then
            Error( "Root must be a non-negative integer." );
            return -1;                    
        fi;
        
        # Check min, max
        if ( ( not IsInt( min ) ) or ( not IsInt( max ) ) ) then
            Error( "Min and max must be non-negative integers." );
            return -1;                    
        fi;
        if ( max < min ) then
            Error( "Min must not exceed max." );
            return -1;                    
        fi;
        
        # Check that we received well-defined external_legs and external_weights
        if Length( external_legs ) <> Length( external_weights ) then
            Error( "The number of external legs and the number of provided external weights are different." );
            return -1;
        fi;
        for i in [ 1 .. Length( external_legs ) ] do
            if ( not IsInt( external_legs[ i ] ) ) then
                Error( Concatenation( "External legs are specified by integers corresponding to vertices of the diagram, i.e. must be integers between 0 and ", String( Length( genera) - 1 ), ")" ) );
                return -1;            
            fi;
            if ( ( external_legs[ i ] < 0 ) or ( external_legs[ i ] > Length( genera ) - 1 ) ) then
                Error( Concatenation( "External legs are specified by integers corresponding to vertices of the diagram, i.e. must be integers between 0 and ", String( Length( genera) - 1 ), ")" ) );
                return -1;
            fi;        
        od;
        for i in [ 1 .. Length( external_weights ) ] do
            if ( not IsInt( external_weights[ i ] ) ) then
                Error( "The external weights are integers." );
                return -1;
            fi;        
            if ( external_weights[ i ] < 1 ) or ( external_weights[ i ] > root - 1 ) then
                Error( Concatenation( "The external weights must not be smaller than 1 and not be bigger than the root (here ", String( root ), ")" ) );
                return -1;
            fi;
        od;
        
        # Check if min and max are meaningful
        if ( min < 0 ) then
            Print( "Min must not be negative. Replaced by 0 in order to proceed.\n" );
            min := 0;
        fi;
        if ( max < 0 ) then
            Print( "Max must not be negative. Therefore, min and max are replaced by 0 in order to proceed.\n" );
            min := 0;
            max := 0;
        fi;
        
        # Check for degenerate case, i.e. where there are no roots
        if not IsInt( ( Sum( degrees ) - Sum( external_weights ) ) / root ) then
            return List( [ min .. max ], i -> 0);
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
        
        # display details?
        if display_details then
            options := Concatenation( options, " ", String( 1 ) );
        else
            options := Concatenation( options, " ", String( -1 ) );
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
        nr := EvalString( ReadAll( input ) );
        CloseStream(input);
        RemoveFile( result_file );
        
        # return result
        return nr;
  
end );
