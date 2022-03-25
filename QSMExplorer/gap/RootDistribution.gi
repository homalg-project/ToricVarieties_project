###############################################################################################
##
##  RootDistribution.gi            QSMExplorer package
##
##                      Martin Bies
##                      University of Pennsylvania
##
##  Copyright 2022
##
##  A package to explore one Quadrillion F-theory Standard Models
##
#! @Chapter Tools for computing root bundle distributions in the Quadrillion F-theory Standard Models
##

##############################################################################################
##
##  Count minimal limit roots
##
##############################################################################################

InstallMethod( CountMinimalLimitRootsOfQSM, [ IsInt ],
    function( index )
        local data;
        
        data := ReadQSM( index );
        if ( data <> fail ) then
            return List( CountPartialBlowupLimitRootDistribution( data, 0, 3, 0, 0, true )[ 1 ], k -> k[1] );
        fi;
        
end );

InstallMethod( CountMinimalLimitRootsOfQSM, [ IsInt, IsBool ],
    function( index, display_details )
        local data;
        
        data := ReadQSM( index );
        if ( data <> fail ) then
            return List( CountPartialBlowupLimitRootDistribution( data, 0, 3, 0, 0, display_details )[ 1 ], k -> k[1] );
        fi;
        
end );

InstallMethod( CountMinimalLimitRootsOfQSMByPolytope, [ IsInt ],
    function( index )
        local data, res;
        
        data := ReadQSMByPolytope( index );
        if ( data <> fail ) then
            return List( CountPartialBlowupLimitRootDistribution( data, 0, 3, 0, 0, false )[ 1 ], k -> k[1] );
        fi;
    
end );

InstallMethod( CountMinimalLimitRootsOfQSMByPolytope, [ IsInt, IsBool ],
    function( index, display_details )
        local data;
        
        data := ReadQSMByPolytope( index );
        if ( data <> fail ) then
            return List( CountPartialBlowupLimitRootDistribution( data, 0, 3, 0, 0, display_details )[ 1 ], k -> k[1] );
        fi;
    
end );



##############################################################################################
##
##  Count distribution of limit roots
##
##############################################################################################

InstallMethod( CountMinimalLimitRootDistributionOfQSM, [ IsInt, IsInt, IsInt ],
    function( index, h0Min, h0Max )
        local data;
        
        data := ReadQSM( index );
        if ( data <> fail ) then
            return Concatenation( List( [ 0 .. h0Min-1 ], i -> 0 ), List( CountPartialBlowupLimitRootDistribution( data, h0Min, h0Max, 0, 0, true )[ 1 ], k -> k[1] ) );
        fi;
        
end );

InstallMethod( CountMinimalLimitRootDistributionOfQSM, [ IsInt, IsInt, IsInt, IsBool ],
    function( index, h0Min, h0Max, display_details )
        local data;
        
        data := ReadQSM( index );
        if ( data <> fail ) then
            return Concatenation( List( [ 0 .. h0Min-1 ], i -> 0 ), List( CountPartialBlowupLimitRootDistribution( data, h0Min, h0Max, 0, 0, display_details )[ 1 ], k -> k[1] ) );
        fi;
        
end );

InstallMethod( CountMinimalLimitRootDistributionOfQSMByPolytope, [ IsInt, IsInt, IsInt ],
    function( index, h0Min, h0Max )
        local data;
        
        data := ReadQSMByPolytope( index );
        if ( data <> fail ) then
            return Concatenation( List( [ 0 .. h0Min-1 ], i -> 0 ), List( CountPartialBlowupLimitRootDistribution( data, h0Min, h0Max, 0, 0, true )[ 1 ], k -> k[1] ) );
        fi;
        
end );

InstallMethod( CountMinimalLimitRootDistributionOfQSMByPolytope, [ IsInt, IsInt, IsInt, IsBool ],
    function( index, h0Min, h0Max, display_details )
        local data;
        
        data := ReadQSMByPolytope( index );
        if ( data <> fail ) then
            return Concatenation( List( [ 0 .. h0Min-1 ], i -> 0 ), List( CountPartialBlowupLimitRootDistribution( data, h0Min, h0Max, 0, 0, display_details )[ 1 ], k -> k[1] ) );
        fi;
        
end );


##############################################################################################
##
##  Count distribution of partial blowup limit roots
##
##############################################################################################

InstallMethod( CountPartialBlowupLimitRootDistributionOfQSM, [ IsInt, IsInt, IsInt ],
    function( index, h0Min, h0Max )
        local data;
        
        data := ReadQSM( index );
        if ( data <> fail ) then
            return CountPartialBlowupLimitRootDistribution( data, h0Min, h0Max, 0, Length( EvalString( data.EdgeList ) ), true );
        fi;
        
end );

InstallMethod( CountPartialBlowupLimitRootDistributionOfQSM, [ IsInt, IsInt, IsInt, IsBool ],
    function( index, h0Min, h0Max, display_details )
        local data;
        
        data := ReadQSM( index );
        if ( data <> fail ) then
            return CountPartialBlowupLimitRootDistribution( data, h0Min, h0Max, 0, Length( EvalString( data.EdgeList ) ), display_details );
        fi;
        
end );

InstallMethod( CountPartialBlowupLimitRootDistributionOfQSMByPolytope, [ IsInt, IsInt, IsInt ],
    function( index, h0Min, h0Max )
        local data;
        
        data := ReadQSMByPolytope( index );
        if ( data <> fail ) then
            return CountPartialBlowupLimitRootDistribution( data, h0Min, h0Max, 0, Length( EvalString( data.EdgeList ) ), true );
        fi;
        
end );

InstallMethod( CountPartialBlowupLimitRootDistributionOfQSMByPolytope, [ IsInt, IsInt, IsInt, IsBool ],
    function( index, h0Min, h0Max, display_details )
        local data;
        
        data := ReadQSMByPolytope( index );
        if ( data <> fail ) then
            return CountPartialBlowupLimitRootDistribution( data, h0Min, h0Max, 0, Length( EvalString( data.EdgeList ) ), display_details );
        fi;
        
end );

InstallMethod( CountPartialBlowupLimitRootDistribution, [ IsRecord, IsInt, IsInt, IsInt, IsInt, IsBool ],
    function( data, h0Min, h0Max, numNodesMin, numNodesMax, display_details )
        local index, Kbar3, genera, degrees, edges, total_genus, root, min, max, external_legs, external_weights, str, a, nproc, number_processes, dir, bin, result_file, output_string, output, input_string, input, options, i, result;
        
        # trigger warning if needed
        index := Int( data.PolyInx );
        if ( Position( [ 8, 4, 134, 128, 130, 136, 236, 88, 110, 272, 274, 387, 798, 808, 810, 812, 254, 52, 302, 786, 762, 417, 838, 782, 377, 499, 503, 1348, 882, 1340, 1879, 1384, 856 ], index ) = fail ) then
            
            Print( "\n\n" );
            Print( "WARNING:\n" );
            Print( "The root counting data for this polytope has not (yet) been optimized. The computation may take a long time.\n" );
            Print( "WARNING:\n\n" );
            
        fi;
        
        # read-out the record/fix the required data
        Kbar3 := Int( data.Kbar3 );
        genera := EvalString( data.CiGenus );
        degrees := ( 6 + Kbar3 ) * EvalString( data.CiDegreeKbar );
        edges := EvalString( data.EdgeList );
        total_genus := Int( Kbar3/2 + 1 );
        root := 2 * Kbar3;
        min := h0Min;
        max := h0Max;
        external_legs := [];
        external_weights := [];
        
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
        dir := FindPartialBlowupRootCounterDirectory();
        bin := Filename( dir, "./partialBlowups" );
        if not IsExistingFile( bin ) then
            Error( "./partialBlowups is not available in designed folder" );
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
        options := Concatenation( options, String( total_genus ), " ", String( root ), " ", String( number_processes ), " ", String( min ), " ", String( max ), " ", String( numNodesMin ), " ", String( numNodesMax ) );
        
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
        result := EvalString( ReadAll( input ) );
        CloseStream(input);
        RemoveFile( result_file );
        
        # return result
        return result;        
        
        
        
end );


##############################################################################################
##
##  Counting distribution of limit roots with external legs
##
##############################################################################################


InstallMethod( CountLimitRootDistributionWithExternalLegsOfQSM, [ IsInt, IsInt, IsInt, IsList ],
    function( index, h0Min, h0Max, external_weights )
        local data;
        
        data := ReadQSM( index );
        if ( data <> fail ) then
            return CountLimitRootDistributionWithExternalLegs( data, h0Min, h0Max, external_weights, true );
        fi;
        
end );

InstallMethod( CountLimitRootDistributionWithExternalLegsOfQSM, [ IsInt, IsInt, IsInt, IsList, IsBool ],
    function( index, h0Min, h0Max, external_weights, display_details )
        local data;
        
        data := ReadQSM( index );
        if ( data <> fail ) then
            return CountLimitRootDistributionWithExternalLegs( data, h0Min, h0Max, external_weights, display_details );
        fi;
        
end );

InstallMethod( CountLimitRootDistributionWithExternalLegsOfQSMByPolytope, [ IsInt, IsInt, IsInt, IsList ],
    function( index, h0Min, h0Max, external_weights )
        local data;
        
        data := ReadQSMByPolytope( index );
        if ( data <> fail ) then
            return CountLimitRootDistributionWithExternalLegs( data, h0Min, h0Max, external_weights, true );
        fi;
        
end );

InstallMethod( CountLimitRootDistributionWithExternalLegsOfQSMByPolytope, [ IsInt, IsInt, IsInt, IsList, IsBool ],
    function( index, h0Min, h0Max, external_weights, display_details )
        local data;
        
        data := ReadQSMByPolytope( index );
        if ( data <> fail ) then
            return CountLimitRootDistributionWithExternalLegs( data, h0Min, h0Max, external_weights, display_details );
        fi;
        
end );

InstallMethod( CountLimitRootDistributionWithExternalLegs, [ IsRecord, IsInt, IsInt, IsList, IsBool ],
    function( data, h0Min, h0Max, external_weights, display_details )
        local index, Kbar3, genera, degrees, edges, total_genus, root, count, external_legs, external_edges, i, j;
        
        # trigger warning if needed
        index := Int( data.PolyInx );
        if ( Position( [ 8, 4, 134, 128, 130, 136, 236, 88, 110, 272, 274, 387, 798, 808, 810, 812, 254, 52, 302, 786, 762, 417, 838, 782, 377, 499, 503, 1348, 882, 1340, 1879, 1384, 856 ], index ) = fail ) then
            
            Print( "\n\n" );
            Print( "WARNING:\n" );
            Print( "The root counting data for this polytope has not (yet) been optimized. The computation may take a long time.\n" );
            Print( "WARNING:\n\n" );
            
        fi;
        
        # read-out the record for the required data
        Kbar3 := Int( data.Kbar3 );
        genera := EvalString( data.CiGenus );
        degrees := ( 6 + Kbar3 ) * EvalString( data.CiDegreeKbar );
        edges := EvalString( data.EdgeList );
        total_genus := Int( Kbar3/2 + 1 );
        root := 2 * Kbar3;
        
        # construct the external legs
        external_legs := EvalString( data.CiDegreeKbar );
        external_edges := [];
        for i in [ 1 .. Length( external_legs ) ] do
            for j in [ 1 .. external_legs[ i ] ] do
                external_edges := Concatenation( external_edges, [i-1] );
            od;
        od;
        
        # check if the external legs are meaningful
        if ( Length( external_weights ) <> Length( external_edges ) ) then
            Error( "You must specify exactly as many external weights as there are external legs." );
        fi;
        for i in [ 1 .. Length( external_weights ) ] do
            if ( ( external_weights[ i ] < 1 ) or ( external_weights[ i ] > root - 1 ) ) then
                Error( Concatenation( "The weights are integers that are at least 1 and at most ", String( root ), " - 1." ) );
            fi;
        od;
        
        # call other function to compute this root distribution
        return CountDistributionWithExternalLegs( [ genera, degrees, edges, total_genus, root, h0Min, h0Max, external_edges, external_weights ], display_details );
        
end );
