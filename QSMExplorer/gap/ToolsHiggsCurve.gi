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
##  Find root distribution for all external weights on quark-doublet curve
##
##############################################################################################


InstallMethod( LimitRootDistributionForAllExternalWeightsInQSM, [ IsInt, IsInt, IsInt ],
    function( index, h0Min, h0Max )
        local str, a, dir, nproc;
        
        # set up output stream
        str := "";
        a := OutputTextString(str,true);
        
        # path to nproc
        dir := Directory( "/usr/bin" );
        nproc := Filename( dir, "nproc" );
        
        # execute nproc to find number of processors
        Process( DirectoryCurrent(), nproc, InputTextNone(), a, [ "--all" ] );
        
        # str now contains the number of processors upon evaluation of this string
        return LimitRootDistributionForAllExternalWeightsInQSM( index, h0Min, h0Max, EvalString( str ) );
        
end );

InstallMethod( LimitRootDistributionForAllExternalWeightsInQSM, [ IsInt, IsInt, IsInt, IsInt ],
    function( index, h0Min, h0Max, number_processes )
        local data;
        
        data := ReadQSM( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return LimitRootDistributionWithExternalLegs( data, h0Min, h0Max, number_processes );
        fi;
        
end );

InstallMethod( LimitRootDistributionForAllExternalWeightsInQSMByPolytope, [ IsInt, IsInt, IsInt ],
    function( index, h0Min, h0Max )
        local str, a, dir, nproc;
        
        # set up output stream
        str := "";
        a := OutputTextString(str,true);
        
        # path to nproc
        dir := Directory( "/usr/bin" );
        nproc := Filename( dir, "nproc" );
        
        # execute nproc to find number of processors
        Process( DirectoryCurrent(), nproc, InputTextNone(), a, [ "--all" ] );
        
        # issue the run
        return LimitRootDistributionForAllExternalWeightsInQSMByPolytope( index, h0Min, h0Max, EvalString( str ) );
        
end );

InstallMethod( LimitRootDistributionForAllExternalWeightsInQSMByPolytope, [ IsInt, IsInt, IsInt, IsInt ],
    function( index, h0Min, h0Max, number_processes )
        local data;
        
        data := ReadQSMByPolytope( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return LimitRootDistributionWithExternalLegs( data, h0Min, h0Max, number_processes );
        fi;
        
end );


InstallMethod( LimitRootDistributionWithExternalLegs, [ IsRecord, IsInt, IsInt, IsInt ],
    function( data, h0Min, h0Max, number_processes )
        local index, Kbar3, genera, degrees, edges, total_genus, root, external_legs, external_edges, i, j, result_list, weights, total, r, r_new, w, dist;
        
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
        
        # start the loop
        result_list := [];
        weights := Tuples( [ 1 .. root-1 ], Length( external_edges ) );
        i := 0;
        r := -1;
        total := Length( weights );
        Print( Concatenation( "Total number of external weight assignments: ", String( total ), "\n" ) );
        for w in weights do
                
                # compute distribution
                dist := CountDistributionWithExternalLegs( [ genera, degrees, edges, total_genus, root, h0Min, h0Max, external_edges, w ], false );
                if ForAll( dist, IsZero ) then
                    Append( result_list, "t" );
                else
                    Append( result_list, [ dist ] );
                fi;
                
                # update progress
                i := i +1;
                r_new := Int( Float( i * 100 / total ) );
                if ( r_new > r ) then
                    r := r_new;
                    Print( Concatenation( String( r ), "%\n" ) );
                fi;
                
        od;
        
        # return all results
        return [ weights, result_list ];
        
end );
