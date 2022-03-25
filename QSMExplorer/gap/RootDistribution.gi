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
        local index, Kbar3, genera, degrees, edges, total_genus, root, str, a, dir, nproc, number_processes;
        
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
        
        # determine the number of processors to determine how many threads we will initiate
        str := "";
        a := OutputTextString(str,true);
        dir := Directory( "/usr/bin" );
        nproc := Filename( dir, "nproc" );
        Process( DirectoryCurrent(), nproc, InputTextNone(), a, [ "--all" ] );
        number_processes := EvalString( str );
        
        # package data
        data := [genera, degrees, edges, total_genus, root, h0Min, h0Max, numNodesMin, numNodesMax, display_details, number_processes];
        
        # start the counter
        return CountPartialBlowupLimitRootDistribution(data);
        
end );


InstallMethod( CountPartialBlowupLimitRootDistribution, [IsList],
    function(data)
        local genera, degrees, edges, total_genus, root, h0_min, h0_max, numNodesMin, numNodesMax, display_details, number_processes, dir, bin, output_string, output, input_string, options, external_legs, i, result_file, input, result;
        
        # read out data
        genera := data[1];
        degrees := data[2];
        edges := data[3];
        total_genus := data[4];
        root := data[5];
        h0_min := data[6];
        h0_max := data[7];
        numNodesMin := data[8];
        numNodesMax := data[9];
        display_details := data[10];
        number_processes := data[11];
        
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
        options := Concatenation( options, String( total_genus ), " ", String( root ), " ", String( number_processes ), " ", String( h0_min ), " ", String( h0_max ), " ", String( numNodesMin ), " ", String( numNodesMax ), " 1" );
    
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
