###############################################################################################
##
##  ToolsHiggsCurve.gi              QSMExplorer package
##
##                                              Martin Bies
##                                              University of Pennsylvania
##
##                                              Muyang Liu
##                                              University of Pennsylvania
##
##  Copyright 2021
##
##  A package to explore one Quadrillion F-theory Standard Models
##
##  Tools for investigation of the Higgs curve in one Quadrillion F-theory Standard Models
##

##############################################################################################
##
##  Find root distribution on Higgs curve
##
##############################################################################################

InstallMethod( LimitRootDistributionForHiggsCurveInQSM, [ IsInt, IsInt ],
    function( index, h0Max )
        local data;
        
        data := ReadQSM( index );
        if ( data <> fail ) then
            return LimitRootDistributionHiggs( data, h0Max, true );
        fi;
        
end );

InstallMethod( LimitRootDistributionForHiggsCurveInQSMByPolytope, [ IsInt, IsInt ],
    function( index, h0Max )
        local data;
        
        data := ReadQSMByPolytope( index );
        if ( data <> fail ) then
            return LimitRootDistributionHiggs( data, h0Max, true );
        fi;
        
end );

InstallMethod( LimitRootDistributionHiggs, [ IsRecord, IsInt, IsBool ],
    function( data, h0Max, display_details )
        local Kbar3, genera, degrees_H1, degrees_H2, edges, total_genus, root, external_legs, external_edges, i, j, dir, bin, output, output_string, input, input_string, options, str, a, nproc, number_processes;
        
        # read-out the record for the required data
        Kbar3 := Int( data.Kbar3 );
        genera := EvalString( data.CiGenus );
        degrees_H1 := ( 12 + 3 * Kbar3 ) * EvalString( data.CiDegreeKbar );
        degrees_H2 := ( -18 + 3 * Kbar3 ) * EvalString( data.CiDegreeKbar );
        edges := EvalString( data.EdgeList );
        total_genus := Int( Kbar3/2 + 1 );
        root := 2 * Kbar3;
        
        # construct the external legs
        external_legs := 2 * EvalString( data.CiDegreeKbar );
        
        # find the number of processes
        str := "";
        a := OutputTextString(str,true);
        dir := Directory( "/usr/bin" );
        nproc := Filename( dir, "nproc" );
        Process( DirectoryCurrent(), nproc, InputTextNone(), a, [ "--all" ] );
        number_processes := EvalString( str );
        
        # prepare empty streams for communication with Cpp
        output_string := "";
        output := OutputTextString( output_string, true );
        input_string := "";
        input := InputTextString( input_string );        
        
        # find the counter binary (and check if it exists)
        dir := FindRootCounterDirectory();
        bin := Filename( dir, "./distributionCounterHiggsCurve" );
        if not IsExistingFile( bin ) then
            Error( "./distributionCounterHiggsCurve is not available in designed folder" );
        fi;
        
        # options convey the necessary information about the nodal curve
        options := Concatenation( String( Length( genera ) ), " " );
        for i in [ 1 .. Length( degrees_H1 ) ] do
            options := Concatenation( options, String( degrees_H1[ i ] ), " " );
        od;
        for i in [ 1 .. Length( degrees_H2 ) ] do
            options := Concatenation( options, String( degrees_H2[ i ] ), " " );
        od;
        for i in [ 1 .. Length( genera ) ] do
            options := Concatenation( options, String( genera[ i ] ), " " );
        od;
        options := Concatenation( options, String( Length( edges ) ), " " );
        for i in [ 1 .. Length( edges ) ] do
            options := Concatenation( options, String( edges[ i ][ 1 ] ), " ", String( edges[ i ][ 2 ] ), " " );
        od;
        for i in [ 1 .. Length( external_legs ) ] do
            options := Concatenation( options, String( external_legs[ i ] ), " " );
        od;
        options := Concatenation( options, String( total_genus ), " ", String( root ), " ", String( number_processes ), " ", String( h0Max ) );
        if display_details then
            options := Concatenation( options, " ", String( 1 ) );
        else
            options := Concatenation( options, " ", String( -1 ) );
        fi;
        
        # trigger the binary
        Process( DirectoryCurrent(), bin, input, output, [ options ] );
        
        # TODO: Cast output string to list of integers...
        return output_string;
        
        #if display_details then
        #    output_string := SplitString( output_string, ']' )[ 2 ];
        #fi;
        #output_string := SplitString( output_string, "\n" );
        #nr := [];
        #for i in [ 1 .. Length( output_string ) ] do
        #    if Length( output_string[ i ] ) > 0 then
        #        Append( nr, [ EvalString( output_string[ i ] ) ] );
        #    fi;
        #od;
        
        # return result
        #return nr;
        
        
end );
