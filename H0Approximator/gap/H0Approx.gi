###############################################################################################
##
##  H0Approx.gi         H0Approximator package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to estimate global sections of pullback line bundle on hypersurface curves in dP3
##
###############################################################################################


##############################################################################################
##
## Section Compute if a curve of given class is irreducible
##
##############################################################################################

InstallMethod( IsIrreducible,
               "a list",
               [ IsList, IsToricVariety ],
  function( curve, dP3 )
    local mysource, monoms, coeffs, poly, ideal, splits, result;

    # define a random source
    mysource := RandomSource(IsMersenneTwister, 42);;
    
    # find the defining polynomial with random coefficients between 1 and 20
    monoms := MonomsOfCoxRingOfDegreeByNormaliz( dP3, curve );
    coeffs := List( [ 1 .. Length( monoms ) ], i -> Random(mysource, 1, 20) );
    poly := Sum( List( [ 1 .. Length( monoms ) ], k -> coeffs[ k ] * monoms[ k ] ) );

    # compute number of split components
    ideal := HomalgMatrix( [ poly ], CoxRing( dP3 ) );
    ideal := LeftSubmodule( ideal );
    splits := PrimaryDecomposition( ideal );
    splits := List( [ 1 .. Length( splits ) ], i -> splits[ i ][ 2 ] );
    splits := Filtered( splits,  i -> not IsSubset( i, IrrelevantIdeal( dP3 ) ) );
    Error( "Test" );
    # decide if curve is split
    if Length( splits ) = 1 then
        result := true;
    else
        result := false;
    fi;
    
    # return the result
    return result;
    
end );

InstallMethod( DegreesOfComponents,
               "a list",
               [ IsList, IsToricVariety ],
  function( curve, dP3 )
    local mysource, monoms, coeffs, poly, ideal, splits, result, degs, i, dummy;

    # define a random source
    mysource := RandomSource(IsMersenneTwister, 42);;
    
    # find the defining polynomial with random coefficients between 1 and 20
    monoms := MonomsOfCoxRingOfDegreeByNormaliz( dP3, curve );
    coeffs := List( [ 1 .. Length( monoms ) ], i -> Random(mysource, 1, 20) );
    poly := Sum( List( [ 1 .. Length( monoms ) ], k -> coeffs[ k ] * monoms[ k ] ) );

    # compute number of split components
    ideal := HomalgMatrix( [ poly ], CoxRing( dP3 ) );
    ideal := LeftSubmodule( ideal );
    splits := PrimaryDecomposition( ideal );
    splits := List( [ 1 .. Length( splits ) ], i -> splits[ i ][ 2 ] );
    splits := Filtered( splits,  i -> not IsSubset( i, IrrelevantIdeal( dP3 ) ) );
    
    # compute degrees of the generators of the split components
    degs := [];
    for i in [ 1 .. Length( splits ) ] do
    
        # extract the degrees of the generators
        dummy := DegreesOfGenerators( splits[ i ] );
        
        # check if each ideal is principal - if not stop here
        if Length( dummy ) > 1 then
            return fail;
        fi;
        
        # slightly modify the degrees
        dummy := UnderlyingListOfRingElements( dummy[ 1 ] );
        
        # and append
        Append( degs, [ dummy ] );
        
    od;
    
    # return the result
    return degs;
    
end );



##############################################################################################
##
## Section Find the CounterDirectory
##
##############################################################################################

InstallMethod( FindCounterBinary,
               "",
               [ ],
  function( )
  local bin, package_directory, dir;
    
    # Initialse counter_directory with fail and try in the following to do better
    bin := fail;
    
    # Binary provided with H0Approximator package
    package_directory := DirectoriesPackageLibrary( "H0Approximator", "gap" );
    if Length( package_directory ) > 1 then
        # If there are at least two versions, then we cannot find the SpasmDirectory uniquely
        Error( "Found at least two versions of H0Approximator - unable to determine CounterDirectory" );
        return;
    else
        # create path to the binary
        dir := package_directory[ 1 ];
        dir := Directory( ReplacedString( Filename( dir, "" ), "gap/", "bin/" ) );
        bin := Filename( dir, "counter" );
        
        # check if the binary exists
        if not IsExistingFile( bin ) then
            Error( "Binary is not available in designed folder" );
        fi;
    fi;
    
    # return the result
    return bin;
    
end );


##############################################################################################
##
## Section Determine descendant level
##
##############################################################################################

InstallMethod( DescendantLevel,
               "for a list",
               [ IsList ],
    function( curve )
        local rays, max_cones, weights, vars, dP3, exp;
        
        # create dP3 with canonical grading
        rays := [ [ 1, 0 ], [ 1, 1 ], [ 0, -1 ], [ 0, 1 ], [ -1, 0 ], [ -1, -1 ] ];
        max_cones := [ [ 1,2 ],[ 1,3 ],[ 2,4 ],[ 4,5 ],[ 3,6 ],[ 5,6 ] ];
        weights := [ [1,-1,-1,0], [0,1,0,0], [0,0,1,0], [1,-1,0,-1], [0,0,0,1], [1,0,-1,-1] ];
        vars := "x1,x2,x3,x4,x6,x5";
        dP3 := ToricVariety( rays, max_cones, weights, vars );
        
        # extract the exponents for the monomials that form this curve
        exp := Exponents( dP3, curve );
        
        # find the largest exponent
        return Maximum( Flat( exp ) );
        
end );


##############################################################################################
##
## Section Approx spectrum
##
##############################################################################################

InstallMethod( RoughApproximationWithSetups,
               "for two lists",
               [ IsList, IsList ],
    function( curve, bundle )
    local level, counterBinary, output_string, output, input_string, input, options, data, i, h0_estimates, spectrum;
    
    # inform that we are starting
    Print( Concatenation( "(*) Curve: ", String( curve ), "\n" ) );
    Print( Concatenation( "(*) Bundle: ", String( bundle ), "\n" ) );
    
    # identify descendantLevel
    level := DescendantLevel( curve );
    
    # and call the c++-program
    counterBinary := FindCounterBinary();
    
    # prepare output_stream to launch Spasm
    output_string := "";
    output := OutputTextString( output_string, true );
    
    # prepare input_stream to launch Spasm
    input_string := "";
    input := InputTextString( input_string );
    
    # options string
    options := Concatenation( String( curve[ 1 ] ), " ", String( curve[ 2 ] ), " ", String( curve[ 3 ] ), " ", String( curve[ 4 ] ), " " );
    options := Concatenation( options, " ", String( bundle[ 1 ] ), " ", String( bundle[ 2 ] ), " ", String( bundle[ 3 ] ), " ", String( bundle[ 4 ] ), " " );
    options := Concatenation( options, " ", String( level ), " 0" );
    
    # execute Spasm
    Process( DirectoryCurrent(), counterBinary, input, output, [ options ] );

    # process the obtained data
    data := EvalString( output_string );
    
    Print( Concatenation( "(*) ", String( Length( data ) ), " rough approximations\n" ) );
    
    h0_estimates := List( [ 1 .. Length( data ) ], i -> data[ i ][ Length( data[ i ] ) ] );
    spectrum := SortedList( DuplicateFreeList( h0_estimates ) );
    
    # inform about the spectrum obtained
    Print( Concatenation( "(*) Rough spectrum estimate: ", String( spectrum ), "\n" ) );
    for i in [ 1 .. Length( spectrum ) ] do
        Print( Concatenation( "     (x) h0 = ", String( spectrum[ i ] ), ": ", String( Length( Positions( h0_estimates, spectrum[ i ] ) ) ), "\n" ) );
    od;
    
    # return result
    return [ data, spectrum ];
    
end );

InstallMethod( RoughApproximation,
               "for two lists",
               [ IsList, IsList ],
    function( curve, bundle )
    
        return RoughApproximationWithSetups( curve, bundle )[ 2 ];
    
end );

InstallMethod( FineApproximationWithSetups,
               "for two lists",
               [ IsList, IsList ],
    function( curve, bundle )
    local data, rays, max_cones, weights, vars, dP3, final_setups, final_h0_estimates, i, component, degs, spectrum, splits, j, genera, degrees, sections, intersections,
         glueable_sections, estimate, dummy;
    
    data := RoughApproximationWithSetups( curve, bundle )[ 1 ];
    Print( "(*) Checking irreducibility of curves...\n" );
    
    # create dP3 with canonical grading
    rays := [ [ 1, 0 ], [ 1, 1 ], [ 0, -1 ], [ 0, 1 ], [ -1, 0 ], [ -1, -1 ] ];
    max_cones := [ [ 1,2 ],[ 1,3 ],[ 2,4 ],[ 4,5 ],[ 3,6 ],[ 5,6 ] ];
    weights := [ [1,-1,-1,0], [0,1,0,0], [0,0,1,0], [1,-1,0,-1], [0,0,0,1], [1,0,-1,-1] ];
    vars := "x1,x2,x3,x4,x6,x5";
    dP3 := ToricVariety( rays, max_cones, weights, vars );
    
    # iterate over data and check which "remainder" curves are irreducible
    final_setups := [];
    final_h0_estimates := [];
    for i in [ 1 .. Length( data ) ] do
       
       # extract first component, perform primary decomposition
       component := [ data[ i ][ 1 ], data[ i ][ 2 ], data[ i ][ 3 ], data[ i ][ 4 ] ];
       degs := DegreesOfComponents( component, dP3 );
       
       # if all components are principal continue
       if degs <> fail then
            
            # just one component -> we are finished
            if ( Length( degs ) = 1 ) then
                Append( final_setups, [ [ data[ i ], true ] ] );
                Append( final_h0_estimates, [ data[ i ][ Length( data[ i ] ) ] ] );
            fi;
            
            # more than one component
            if ( Length( degs ) > 1 ) then
                
                # more than one component
                # only continue if all are non-rigid powers
                if not ( ForAny( degs, IsRigidPower ) ) then
                    
                    # prepare list of split components
                    splits := degs;
                    Append( splits, [ [ 0, data[ i ][ 5 ], 0, 0 ] ] );
                    Append( splits, [ [ 0, 0, data[ i ][ 6 ], 0 ] ] );
                    Append( splits, [ [ 0, 0, 0, data[ i ][ 7 ] ] ] );
                    Append( splits, [ [ data[ i ][ 8 ], - data[ i ][ 8 ], - data[ i ][ 8 ], 0 ] ] );
                    Append( splits, [ [ data[ i ][ 9 ], - data[ i ][ 9 ], 0, - data[ i ][ 9 ] ] ] );
                    Append( splits, [ [ data[ i ][ 10 ], 0, - data[ i ][ 10 ], - data[ i ][ 10 ] ] ] );
                    
                    # compute topological data anew
                    genera := List( [ 1 .. Length( splits ) ], i -> Genus( splits[ i ] ) );
                    degrees := List( [ 1 .. Length( splits ) ], i -> LineBundleDegree( splits[ i ], bundle ) );
                    sections := List( [ 1 .. Length( splits ) ], i -> Sections( genera[ i ], degrees[ i ] ) );
                    intersections := IntersectionsAmongCurveComponents( splits );
                    
                    # check if this is a simple setup and if so, estimate h0
                    if IsSimpleSetup( splits, sections ) then
                        
                        # estimate glueable sections on each component
                        glueable_sections := EstimateGlobalSections( sections, intersections );
                        
                        # check if we can estimate overall number of global sections
                        if ForAll( glueable_sections, IsInt ) then
                            
                            # estimate h0
                            estimate := Sum( glueable_sections );
                            
                            # prepare data
                            dummy := data[ i ];
                            Remove( dummy );
                            Append( dummy, [ estimate ] );
                            
                            # and append it
                            Append( final_setups, [ [ dummy, false ] ] );
                            Append( final_h0_estimates, [ estimate ] );
                            
                        fi;
                    elif Length(splits) = 2 then
                    
                        if sections[1] + sections[2] - intersections[1] >= 0 then
                        
                            # estimate h0
                            estimate := sections[1] + sections[2] - intersections[1];
                            
                            # prepare data
                            dummy := data[ i ];
                            Remove( dummy );
                            Append( dummy, [ estimate ] );
                            
                            # and append it
                            Append( final_setups, [ [ dummy, false ] ] );
                            Append( final_h0_estimates, [ estimate ] );
                            
                        fi;
                    fi;
                fi;
            fi;
       fi;
    od;
    
    # compute spectrum estimate
    spectrum := SortedList( DuplicateFreeList( final_h0_estimates ) );
    
    # inform about the spectrum obtained
    Print( Concatenation( "(*) ", String( Length( final_setups ) ), " fine approximations\n" ) );
    Print( Concatenation( "(*) Fine spectrum estimate: ", String( spectrum ), "\n" ) );
    for i in [ 1 .. Length( spectrum ) ] do
        Print( Concatenation( "     (x) h0 = ", String( spectrum[ i ] ), ": ", String( Length( Positions( final_h0_estimates, spectrum[ i ] ) ) ), "\n" ) );
    od;
    
    # return result
    return [ final_setups, spectrum ];
    
end );

InstallMethod( FineApproximation,
               "for two lists",
               [ IsList, IsList ],
    function( curve, bundle )
    
        return FineApproximationWithSetups( curve, bundle )[ 2 ];
    
end );
