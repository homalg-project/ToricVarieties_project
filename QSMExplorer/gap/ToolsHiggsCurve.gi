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
        local index, Kbar3, genera, degrees_H1, degrees_H2, degrees_H3, edges, total_genus, root, external_legs, external_edges, i, j, dist_H1, dist_H2, dist_H3, weights, total, r, r_new, w, dist;
        
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
        degrees_H1 := ( 12 + 3 * Kbar3 ) * EvalString( data.CiDegreeKbar );
        degrees_H2 := ( -18 + 3 * Kbar3 ) * EvalString( data.CiDegreeKbar );
        degrees_H3 := ( 12 + 3 * Kbar3 ) * EvalString( data.CiDegreeKbar );
        edges := EvalString( data.EdgeList );
        total_genus := Int( Kbar3/2 + 1 );
        root := 2 * Kbar3;
        
        # construct the external legs
        external_legs := 2 * EvalString( data.CiDegreeKbar );
        external_edges := [];
        for i in [ 1 .. Length( external_legs ) ] do
            for j in [ 1 .. external_legs[ i ] ] do
                external_edges := Concatenation( external_edges, [i-1] );
            od;
        od;
        
        # start the loop over the roots on H1 (and H3)
        dist_H1 := [];
        weights := Tuples( [ 1 .. root-1 ], Length( external_edges ) );
        i := 0;
        r := -1;
        total := Length( weights );
        Print( Concatenation( "Total number of external weight assignments on H1: ", String( total ), "\n" ) );
        for w in weights do
                
                # compute distribution
                dist := CountDistributionWithExternalLegs( [ genera, degrees_H1, edges, total_genus, root, h0Min, h0Max, external_edges, w ], false );
                if ForAll( dist, IsZero ) then
                    Append( dist_H1, "t" );
                else
                    Append( dist_H1, [ dist ] );
                fi;
                
                # update progress
                i := i +1;
                r_new := Int( Float( i * 100 / total ) );
                if ( r_new > r ) then
                    r := r_new;
                    Print( Concatenation( String( r ), "%\n" ) );
                fi;
                
        od;
        dist_H3 := dist_H1;
        
        # start the loop over the roots on H2
        dist_H2 := [];
        Print( Concatenation( "Total number of external weight assignments on H2: ", String( total ), "\n" ) );
        for w in weights do
                
                # compute distribution
                dist := CountDistributionWithExternalLegs( [ genera, degrees_H2, edges, total_genus, root, h0Min, h0Max, external_edges, w ], false );
                if ForAll( dist, IsZero ) then
                    Append( dist_H2, "t" );
                else
                    Append( dist_H2, [ dist ] );
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
        return [ weights, dist_H1, dist_H2, dist_H3 ];
        
end );


##############################################################################################
##
##  Find root distribution for all influxes on quark-doublet curve
##
##############################################################################################


InstallMethod( LimitRootDistributionForAllExternalInfluxesInQSM, [ IsInt, IsInt, IsInt ],
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
        return LimitRootDistributionForAllExternalInfluxesInQSM( index, h0Min, h0Max, EvalString( str ) );
        
end );

InstallMethod( LimitRootDistributionForAllExternalInfluxesInQSM, [ IsInt, IsInt, IsInt, IsInt ],
    function( index, h0Min, h0Max, number_processes )
        local data;
        
        data := ReadQSM( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return LimitRootDistributionForAllInfluxes( data, h0Min, h0Max, number_processes );
        fi;
        
end );

InstallMethod( LimitRootDistributionForAllExternalInfluxesInQSMByPolytope, [ IsInt, IsInt, IsInt ],
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
        return LimitRootDistributionForAllExternalInfluxesInQSMByPolytope( index, h0Min, h0Max, EvalString( str ) );
        
end );

InstallMethod( LimitRootDistributionForAllExternalInfluxesInQSMByPolytope, [ IsInt, IsInt, IsInt, IsInt ],
    function( index, h0Min, h0Max, number_processes )
        local data;
        
        data := ReadQSMByPolytope( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return LimitRootDistributionForAllInfluxes( data, h0Min, h0Max, number_processes );
        fi;
        
end );


InstallMethod( LimitRootDistributionForAllInfluxes, [ IsRecord, IsInt, IsInt, IsInt ],
    function( data, h0Min, h0Max, number_processes )
        local index, Kbar3, genera, degrees_H1, degrees_H2, degrees_H3, edges, total_genus, root, external_legs, external_edges, i, j, influx_data, influxes, nr_external, min, max, all_influxes_on_component, some_external_weights, influxes_for_some_external_weights, weights_for_all_influxes_on_component, dist_H1, dist_H2, f, dist_H3, total, r, r_new, w, dist;
        
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
        degrees_H1 := ( 12 + 3 * Kbar3 ) * EvalString( data.CiDegreeKbar );
        degrees_H2 := ( -18 + 3 * Kbar3 ) * EvalString( data.CiDegreeKbar );
        degrees_H3 := ( 12 + 3 * Kbar3 ) * EvalString( data.CiDegreeKbar );
        edges := EvalString( data.EdgeList );
        total_genus := Int( Kbar3/2 + 1 );
        root := 2 * Kbar3;
        
        # construct the external legs
        external_legs := 2 * EvalString( data.CiDegreeKbar );
        external_edges := [];
        for i in [ 1 .. Length( external_legs ) ] do
            for j in [ 1 .. external_legs[ i ] ] do
                external_edges := Concatenation( external_edges, [i-1] );
            od;
        od;
        
        # determine all possible influxes on each component and a corresponding weight assignment
        influx_data := [];
        for i in [ 1 .. Length( genera ) ] do
            
            # number of external legs
            nr_external := external_legs[ i ];
            
            # min and max influx 
            min := nr_external;
            max := nr_external * ( root - 1 );
            all_influxes_on_component := [ min .. max ];
            
            # generate possible weight assignments, which cover all influxes
            some_external_weights := UnorderedTuples( [ 1 .. root ], nr_external );
            
            # compute the influxes for each of these external_weights
            influxes_for_some_external_weights := List( [ 1 .. Length( some_external_weights ) ], j -> Sum( some_external_weights[ j ] ) );
            
            # find an external weight assignment for each influx
            weights_for_all_influxes_on_component := List( [ min .. max ], i -> some_external_weights[ Position( influxes_for_some_external_weights, i ) ] );
            
            # save this information
            Append( influx_data, [ [ all_influxes_on_component, weights_for_all_influxes_on_component ] ] );
            
        od;

        # prepare for the scan
        influxes := Cartesian( List( [ 1 .. Length( genera ) ], i -> influx_data[ i ][ 1 ] ) );
        i := 0;
        r := -1;
        total := Length( influxes );
        Print( Concatenation( "Total number of influxes: ", String( total ), "\n" ) );
        
        # start the loop over the roots on H1 (and H3)
        Print( "Start loop for H1 and H2\n" );
        dist_H1 := [];
        dist_H2 := [];
        
        for f in influxes do
                
                # construct a weight for the influx f
                w := [];
                for i in [ 1 .. Length( f ) ] do
                    Append( w, influx_data[ i ][ 2 ][ Position( influx_data[ i ][ 1 ],f[ i ] ) ] );
                od;
                
                # compute distribution
                dist := CountDistributionWithExternalLegs( [ genera, degrees_H1, edges, total_genus, root, h0Min, h0Max, external_edges, w ], false );
                if ForAll( dist, IsZero ) then
                    Append( dist_H1, "t" );
                else
                    Append( dist_H1, [ dist ] );
                fi;
                
                # compute distribution
                dist := CountDistributionWithExternalLegs( [ genera, degrees_H2, edges, total_genus, root, h0Min, h0Max, external_edges, w ], false );
                if ForAll( dist, IsZero ) then
                    Append( dist_H2, "t" );
                else
                    Append( dist_H2, [ dist ] );
                fi;
                
                # update progress
                i := i +1;
                r_new := Int( Float( i * 100 / total ) );
                if ( r_new > r ) then
                    r := r_new;
                    Print( Concatenation( String( r ), "%\n" ) );
                fi;
                
        od;
        
        # obtain distribution on H3 from that on H1
        dist_H3 := dist_H1;
        
        # return all results
        return [ influxes, dist_H1, dist_H2, dist_H3 ];
        
end );
