#############################################################################
##
##  MaxSplits.gi        H0Approximator package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to estimate global sections of a pullback line bundle on hypersurface curves in dP3
##
#############################################################################


##############################################################################################
##
## Install elementary topological functions on dP3
##
##############################################################################################

# intersection number
InstallMethod( IntersectionNumber,
               "a list, a list",
               [ IsList, IsList ],
  function( c1, c2 )
    
    return c1[ 1 ] * c2[ 1 ] - c1[ 2 ] * c2[ 2 ] - c1[ 3 ] * c2[ 3 ] - c1[ 4 ] * c2[ 4 ];
    
end );


# compute genus of a curve
InstallMethod( Genus,
               "a list",
               [ IsList ],
    function( class )
    
        return 1/2 * ( IntersectionNumber( [ - 3 +class[ 1 ], 1 + class[ 2 ], 1 + class[ 3 ], 1 + class[ 4 ] ], class ) + 2 );
    
end );


# compute line bundle degree on a curve
InstallMethod( LineBundleDegree,
               "a list, a list",
               [ IsList, IsList ],
    function( curve, bundle )
    
        return curve[ 1 ] * bundle[ 1 ] - curve[ 2 ] * bundle[ 2 ] - curve[ 3 ] * bundle[ 3 ] - curve[ 4 ] * bundle[ 4 ];
    
end );



##############################################################################################
##
#! @Section Check if a curve class if a power of a rigid divisor
##
##############################################################################################

InstallMethod( IsE1Power,
               "a list",
               [ IsList ],
    function( curve )
        
        if curve[ 1 ] <> 0 then
            return false;
        fi;
        if curve[ 2 ] = 0 then
            return false;
        fi;
        if curve[ 3 ] <> 0 then
            return false;
        fi;
        if curve[ 4 ] <> 0 then
            return false;
        fi;
        return true;
        
end );

InstallMethod( IsE2Power,
               "a list",
               [ IsList ],
    function( curve )
        
        if curve[ 1 ] <> 0 then
            return false;
        fi;
        if curve[ 2 ] <> 0 then
            return false;
        fi;
        if curve[ 3 ] = 0 then
            return false;
        fi;
        if curve[ 4 ] <> 0 then
            return false;
        fi;
        return true;
        
end );

InstallMethod( IsE3Power,
               "a list",
               [ IsList ],
    function( curve )
        
        if curve[ 1 ] <> 0 then
            return false;
        fi;
        if curve[ 2 ] <> 0 then
            return false;
        fi;
        if curve[ 3 ] <> 0 then
            return false;
        fi;
        if curve[ 4 ] = 0 then
            return false;
        fi;
        return true;
        
end );

InstallMethod( IsE4Power,
               "a list",
               [ IsList ],
    function( curve )
        local a;
        
        a := curve[ 1 ];
        if a < 1 then
            return false;
        fi;
        if curve[ 2 ] <> -a then
            return false;
        fi;
        if curve[ 3 ] <> -a then
            return false;
        fi;
        if curve[ 4 ] <> 0 then
            return false;
        fi;
        return true;
        
end );

InstallMethod( IsE5Power,
               "a list",
               [ IsList ],
    function( curve )
        local a;
        
        a := curve[ 1 ];
        if a < 1 then
            return false;
        fi;
        if curve[ 2 ] <> -a then
            return false;
        fi;
        if curve[ 3 ] <> 0 then
            return false;
        fi;
        if curve[ 4 ] <> -a then
            return false;
        fi;
        return true;
        
end );

InstallMethod( IsE6Power,
               "a list",
               [ IsList ],
    function( curve )
        local a;
        
        a := curve[ 1 ];
        if a < 1 then
            return false;
        fi;
        if curve[ 2 ] <> 0 then
            return false;
        fi;
        if curve[ 3 ] <> -a then
            return false;
        fi;
        if curve[ 4 ] <> -a then
            return false;
        fi;
        return true;
        
end );

InstallMethod( IsRigidPower,
               "a list",
               [ IsList ],
    function( curve )
        
        if IsE1Power( curve ) then
            return true;
        fi;
        if IsE2Power( curve ) then
            return true;
        fi;
        if IsE3Power( curve ) then
            return true;
        fi;
        if IsE4Power( curve ) then
            return true;
        fi;
        if IsE5Power( curve ) then
            return true;
        fi;
        if IsE6Power( curve ) then
            return true;
        fi;
        return false;
        
end );


##############################################################################################
##
## Topological section counter
##
##############################################################################################

# return generic number of sections based on genus g and degree d
InstallMethod( Sections,
               "an integer, an integer",
               [ IsInt, IsInt ],
    function( genus, degree )
        local chi, h0;
        
        # compute the chiral index
        chi := degree - genus + 1;
        
        # return generic number of sections
        if chi < 0 then
            h0 := 0;
        else
            h0 := chi;
        fi;
        
        # return result
        return h0;
        
end );


##############################################################################################
##
## Local section analyser
##
##############################################################################################

# intersection points among all split components
InstallMethod( IntersectionMatrix,
               "a list",
               [ IsList ],
    function( splits )
        local intersection_matrix, dummy, i, j;
        
        # compute the intersection numbers between all components
        intersection_matrix := [];
        for i in [ 1 .. Length( splits ) ] do
            dummy := [];
            for j in [ 1 .. Length( splits ) ] do
                Append( dummy, [ IntersectionNumber( splits[ i ], splits[ j ] ) ] );
            od;
            Append( intersection_matrix, [ dummy ] );
        od;
        
        # return combined information
        return intersection_matrix;
        
end );


# intersection points among all split components
InstallMethod( IntersectionsAmongCurveComponents,
               "a list",
               [ IsList ],
    function( splits )
        local intersections, i, j, count;
        
        # compute the overall intersection points
        intersections := [];
        for i in [ 1 .. Length( splits ) ] do
            count := 0;
            for j in [ 1 .. Length( splits ) ] do
                if i <> j then
                    count := count + IntersectionNumber( splits[ i ], splits[ j ] );
                fi;
            od;
            Append( intersections, [ count ] );
        od;
        
        # return combined information
        return intersections;
        
end );


# naive global section count
InstallMethod( EstimateGlobalSections,
               "a list, a list",
               [ IsList, IsList ],
    function( loc_sec, intersections )
        local glued_sections, i;
        
        # identify the number of glueable sections
        glued_sections := [];
        for i in [ 1 .. Length( loc_sec ) ] do
            if not IsInt( loc_sec[ i ] ) then
                Append( glued_sections, [ "NA" ] );
            else
                if loc_sec[ i ] <= intersections[ i ] then
                    Append( glued_sections, [ 0 ] );
                else
                    Append( glued_sections, [ loc_sec[ i ] - intersections[ i ] ] );
                fi;
            fi;
        od;
        
        # return result
        return glued_sections;
        
end );


# analyse a curve splitting
InstallMethod( IsSimpleSetup,
               "a list, a list",
               [ IsList, IsList ],
    function( splits, local_sections )
        local result, i, j;

        # check if this setup is simple enough
        result := true;
        for i in [ 1 .. Length( local_sections ) ] do
            if local_sections[ i ] <> 0 then
                for j in [ 1 .. Length( local_sections ) ] do
                    if ( i <> j ) and ( IntersectionNumber( splits[ i ], splits[ j ] ) <> 0 ) and ( local_sections[ j ] <> 0 ) then
                        result := false;
                    fi;
                od;
            fi;
        od;
        
        # return result
        return result;
end );

# analyse a curve splitting
InstallMethod( AnalyzeBundleOnCurve,
               "a list, a list",
               [ IsList, IsList ],
    function( splits, bundle )
        
        return AnalyzeBundleOnCurve( splits, bundle, 0 );
        
end );

# analyse a curve splitting
InstallMethod( AnalyzeBundleOnCurve,
               "a list, a list, an integer",
               [ IsList, IsList, IsInt ],
    function( splits, bundle, verbose )
        local i, genera, degrees, sections, intersection_matrix, intersections, naive_count, naive_global_sections;
        
        # compute genera, degrees and sections
        genera := List( [ 1 .. Length( splits ) ], i -> Genus( splits[ i ] ) );
        degrees := List( [ 1 .. Length( splits ) ], i -> LineBundleDegree( splits[ i ], bundle ) );
        sections := List( [ 1 .. Length( splits ) ], i -> Sections( genera[ i ], degrees[ i ] ) );
        intersection_matrix := IntersectionMatrix( splits );
        intersections := IntersectionsAmongCurveComponents( splits );
        
        # check if this is a simple setup
        naive_count := "NA";
        naive_global_sections := "NA";
        if IsSimpleSetup( splits, sections ) then
            
            # estimate glueable sections on each component
            naive_count := EstimateGlobalSections( sections, intersections );
            
            # check if we can estimate overall number of global sections
            if ForAll( naive_count, IsInt ) then
                naive_global_sections := Sum( naive_count );
            fi;
        fi;
        
        # inform on the result of analyzing the global sections
        if ( verbose > 1 ) and ( naive_global_sections <> "NA" ) then
            Print( "------------------------------------------------------------------------\n\n" );
            Print( Concatenation( "Splits: ", String( splits ), "\n" ) );
            Print( Concatenation( "Genera: ", String( genera ) ), "\n" );
            Print( Concatenation( "Degrees: ", String( degrees ) ), "\n" );
            Print( Concatenation( "Local sections: ", String( sections ) ), "\n" );
            Print( Concatenation( "Intersection matrix: ", String( intersection_matrix ) ), "\n" );
            Print( Concatenation( "Intersection counts: ", String( intersections ) ), "\n" );
            Print( Concatenation( "Gluable local sections: ", String( naive_count ) ), "\n" );
            Print( Concatenation( "Global sections (naively): ", String( naive_global_sections ) ), "\n" );
            Print( "\n" );
        fi;
        
        # return estimate of global sections
        return naive_global_sections;
        
end );


##############################################################################################
##
## Max-split-analyser
##
##############################################################################################

InstallMethod( MaximallyDegenerateCurves,
               "a list",
               [ IsList ],
    function( curve )
        local rays, max_cones, weights, vars, dP3, exp, w, max_splits, i, dummy, j;
        
        # create dP3 with canonical grading
        rays := [ [ 1, 0 ], [ 1, 1 ], [ 0, -1 ], [ 0, 1 ], [ -1, 0 ], [ -1, -1 ] ];
        max_cones := [ [ 1,2 ],[ 1,3 ],[ 2,4 ],[ 4,5 ],[ 3,6 ],[ 5,6 ] ];
        weights := [ [1,-1,-1,0], [0,1,0,0], [0,0,1,0], [1,-1,0,-1], [0,0,0,1], [1,0,-1,-1] ];
        vars := "x1,x2,x3,x4,x6,x5";
        dP3 := ToricVariety( rays, max_cones, weights, vars );
        
        exp := Exponents( dP3, curve );
        w := List( WeightsOfIndeterminates( CoxRing( dP3 ) ), i -> UnderlyingListOfRingElements( i ) );
        
        max_splits := [];
        for i in [ 1 .. Length( exp ) ] do
            dummy := [];
            for j in [ 1 .. Length( exp[ i ] ) ] do
                if exp[ i ][ j ] <> 0 then
                    Append( dummy, [ exp[ i ][ j ] * w[ j ] ] );
                fi;
            od;
            Append( max_splits, [ dummy ] );
        od;
        
        return max_splits;
end );


# Compute all splittings of a curve and analyse them with regards to a given bundle
InstallMethod( EstimateGlobalSectionsOfBundleOnMaximallyDegenerateCurves,
               "a list, a list",
               [ IsList, IsList ],
    function( curve, bundle )
        
        return EstimateGlobalSectionsOfBundleOnMaximallyDegenerateCurves( curve, bundle, 0 );
        
end );


# Compute all splittings of a curve and analyse them with regards to a given bundle
InstallMethod( EstimateGlobalSectionsOfBundleOnMaximallyDegenerateCurves,
               "a list, a list, an integer",
               [ IsList, IsList, IsInt ],
    function( curve, bundle, verbose )
        local desc, i, sections, analysed_setups, spectrum;
        
        # compute the descendants
        desc := MaximallyDegenerateCurves( curve );
        
        # inform how many maximally degenerate curves we analyse
        if verbose > 0 then
            Print( "\n" );
        fi;
        
        # estimate global sections on each curve
        spectrum := [];
        analysed_setups := 0;
        for i in [ 1 .. Length( desc ) ] do
            
            sections := AnalyzeBundleOnCurve( desc[ i ], bundle, verbose );
            
            if sections <> "NA" then
                Append( spectrum, [ sections ] );
                analysed_setups := analysed_setups + 1;
            fi;
            
        od;
        
        # process spectrum: sort it and remove duplicates
        spectrum := DuplicateFreeList( spectrum );
        Sort( spectrum );
        
        # display expected spectrum
        if verbose > 1 then
            Print( "------------------------------------------------------------------------\n\n" );
        fi;
        if verbose > 0 then
            Print( Concatenation( "Analyse bundle on ", String( Length( desc ) ), " degenerate curves...\n" ) );
            Print( Concatenation( "Estimated spectrum on ", String( analysed_setups ), " curves\n" ) );
            Print( Concatenation( "Spectrum estimate: ", String( spectrum ), "\n\n" ) );
        fi;
        
        # return spectrum
        return spectrum;
        
end );
