###############################################################################################
##
##  Tools.gi            QSMExplorer package
##
##                      Martin Bies
##                      University of Pennsylvania
##
##                      Muyang Liu
##                      University of Pennsylvania
##
##  Copyright 2021
##
##  A package to explor one Quadrillion F-theory Standard Models
##
###############################################################################################


##############################################################################################
##
## Find external files, scripts and binaries
##
##############################################################################################


InstallMethod( FindDataBase,
               "",
               [ ],
  function( )
  local path, package_directory, dir;
    
    # Initialse path as fail and try in the following to do better
    path := fail;
    
    # data provided with H0Approximator package
    package_directory := DirectoriesPackageLibrary( "QSMExplorer", "data" );
    if Length( package_directory ) > 1 then
        
        Error( "Found at least two versions of QSMExplorer - unable to determine database" );
        return;
        
    else
        # create path to the binary
        dir := package_directory[ 1 ];
        path := Filename( dir, "Database.csv" );
        
        # check if the binary exists
        if not IsExistingFile( path ) then
            Error( "Database.csv is not available in designed folder" );
        fi;
    fi;
    
    # return the result
    return path;
    
end );


InstallMethod( FindDualGraphScript,
               "",
               [ ],
  function( )
  local script, package_directory, dir;
    
    # Initialse script as fail and try in the following to do better
    script := fail;
    
    # script provided with QSMExplorer package
    package_directory := DirectoriesPackageLibrary( "QSMExplorer", "bin/DualGraph" );
    if Length( package_directory ) > 1 then
        
        Error( "Found at least two versions of QSMExplorer - unable to determine DualGraph.py" );
        return;
        
    else
        # create path to the binary
        dir := package_directory[ 1 ];
        script := Filename( dir, "./DualGraph.py" );
        
        # check if the binary exists
        if not IsExistingFile( script ) then
            Error( "DualGraph.py is not available in designed folder" );
        fi;
    fi;
    
    # return the result
    return script;
    
end );


InstallMethod( FindRootCounterDirectory,
               "",
               [ ],
  function( )
  local package_directory, dir;
    
    # Initialse binary as fail and try in the following to do better
    dir := fail;
    
    # Binary provided with QSMExplorer package
    package_directory := DirectoriesPackageLibrary( "QSMExplorer", "bin/RootCounterHiggs/RootCounter" );
    if Length( package_directory ) > 1 then
        
        Error( "Found at least two versions of QSMExplorer - unable to determine ./distributionCounter" );
        return;
        
    else
        dir := package_directory[ 1 ];
    fi;
    
    # return the result
    return dir;
    
end );


InstallMethod( FindPartialBlowupRootCounterDirectory,
               "",
               [ ],
  function( )
  local package_directory, dir;
    
    # Initialse binary as fail and try in the following to do better
    dir := fail;
    
    # Binary provided with QSMExplorer package
    package_directory := DirectoriesPackageLibrary( "QSMExplorer", "bin/PartialBlowups" );
    if Length( package_directory ) > 1 then
        
        Error( "Found at least two versions of QSMExplorer - unable to determine ./partialBlowups" );
        return;
        
    else
        dir := package_directory[ 1 ];
    fi;
    
    # return the result
    return dir;
    
end );


InstallMethod( FindPartialBlowupRootCounterFromTreelikeAnalysisDirectory,
               "",
               [ ],
  function( )
  local package_directory, dir;
    
    # Initialse binary as fail and try in the following to do better
    dir := fail;
    
    # Binary provided with QSMExplorer package
    package_directory := DirectoriesPackageLibrary( "QSMExplorer", "bin/PartialBlowups" );
    if Length( package_directory ) > 1 then
        
        Error( "Found at least two versions of QSMExplorer - unable to determine ./partialBlowupsAllTrees" );
        return;
        
    else
        dir := package_directory[ 1 ];
    fi;
    
    # return the result
    return dir;
    
end );


InstallMethod( FindSpecialityDirectory,
               "",
               [ ],
  function( )
  local package_directory, dir;
    
    # Initialse binary as fail and try in the following to do better
    dir := fail;
    
    # Binary provided with QSMExplorer package
    package_directory := DirectoriesPackageLibrary( "QSMExplorer", "bin/Speciality" );
    if Length( package_directory ) > 1 then
        
        Error( "Found at least two versions of QSMExplorer - unable to determine ./specialityChecker" );
        return;
        
    else
        dir := package_directory[ 1 ];
    fi;
    
    # return the result
    return dir;
    
end );


InstallMethod( FindHiggsRootCounterDirectory,
               "",
               [ ],
  function( )
  local package_directory, dir;
    
    # Initialse binary as fail and try in the following to do better
    dir := fail;
    
    # Binary provided with QSMExplorer package
    package_directory := DirectoriesPackageLibrary( "QSMExplorer", "bin/RootCounterHiggs" );
    if Length( package_directory ) > 1 then
        
        Error( "Found at least two versions of QSMExplorer - unable to determine ./distributionCounterHiggsCurve" );
        return;
        
    else
        dir := package_directory[ 1 ];
    fi;
    
    # return the result
    return dir;
    
end );


##############################################################################################
##
##  Read information from database
##
##############################################################################################


InstallMethod( ReadQSM,
               "an integer",
               [ IsInt ],
    function( index )
        local file;
        
        # find the path to the database
        file := FindDataBase();
        
        # check if the index is in the correct range
        if ( index < 1 ) or ( index > 708 ) then
            Print( "The QSM with the specified index does not exist.\n" );
            return fail;
        fi;
        
        # continue if this was successful
        if (file = fail ) then
            return fail;
        else
            
            return ReadCSV( file, "," )[ index ];
            
        fi;
        
end );


InstallMethod( ReadQSMByPolytope,
               "an integer",
               [ IsInt ],
    function( index )
        local file, data, poly_list, pos;
        
        # find the path to the database
        file := FindDataBase();
        
        # continue if this was successful
        if (file = fail ) then
            Print( "The QSM with the specified polytope does not exist.\n" );
            return fail;
        else
            
            # read data
            data := ReadCSV( file, "," );
            
            # create list with polytope indices
            poly_list := List( [ 1 .. Length( data ) ], i -> data[ i ].PolyInx );
            
            # find first occurance of index in this list
            pos := Position( poly_list, index );
            
            # check what to return
            if ( pos = fail ) then
                return fail;
            fi;
            
            # otherwise, return data at position pos
            return data[ pos ];
            
        fi;
        
end );


##############################################################################################
##
##  Information about polytope and its triangulation
##
##############################################################################################

InstallMethod( PolytopeOfQSM,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSM( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return Polytope( EvalString( String( data.PolytopeVertices ) ) );
        fi;
        
end );

InstallMethod( PolytopeOfQSMByPolytope,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSMByPolytope( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return Polytope( EvalString( String( data.PolytopeVertices ) ) );
        fi;
        
end );


InstallMethod( TriangulationEstimateInQSM,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSM( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return EvalString( String( data.TriangulationEstimate ) );
        fi;
        
end );

InstallMethod( TriangulationEstimateInQSMByPolytope,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSMByPolytope( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return EvalString( String( data.TriangulationEstimate ) );
        fi;
        
end );


InstallMethod( MaxLatticePtsInFacetInQSM,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSM( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return EvalString( String( data.MaxLatticePtsInFacet ) );
        fi;
        
end );

InstallMethod( MaxLatticePtsInFacetInQSMByPolytope,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSMByPolytope( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return EvalString( String( data.MaxLatticePtsInFacet ) );
        fi;
        
end );


InstallMethod( TriangulatonQuickForQSM,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSM( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return EvalString( LowercaseString( String( data.TriangQuick ) ) );
        fi;
        
end );

InstallMethod( TriangulationQuickForQSMByPolytope,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSMByPolytope( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return EvalString( LowercaseString( String( data.TriangQuick ) ) );
        fi;
        
end );


##############################################################################################
##
##  Section Base space
##
##############################################################################################


InstallMethod( BaseSpaceOfQSM,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSM( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return BaseSpace( data );
        fi;
        
end );

InstallMethod( BaseSpaceOfQSMByPolytope,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSMByPolytope( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return BaseSpace( data );
        fi;
        
end );


InstallMethod( BaseSpace, [ IsRecord ],
    function( data )
        local rays, max_cones, m, map, epi, weights, vars;
        
        # read-out rays and max_cones
        rays := EvalString( String( data.RayGeneratorsOfB3 ) );
        max_cones := EvalString( String( data.TriangulationOfB3 ) );
        
        # fix the grading
        m := Involution( HomalgMatrix( rays, HOMALG_MATRICES.ZZ ) );
        map := HomalgMap( m, NrRows( m ) * HOMALG_MATRICES.ZZ, NrCols( m ) * HOMALG_MATRICES.ZZ );
        epi := ByASmallerPresentation( CokernelEpi( map ) );
        weights := EntriesOfHomalgMatrixAsListList( MatrixOfMap( epi ) );
        
        # and variables names
        vars := JoinStringsWithSeparator( List( [ 1 .. NrCols( m ) ], i -> Concatenation( "x", String( i-1 ) ) ), "," );
        
        # then construct the variety
        return ToricVariety( rays, max_cones, weights, vars );
        
end );


InstallMethod( Kbar3OfQSM,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSM( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return data.Kbar3;
        fi;
        
end );

InstallMethod( Kbar3OfQSMByPolytope,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSMByPolytope( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return data.Kbar3;
        fi;
        
end );



##############################################################################################
##
##  All curve components
##
##############################################################################################

InstallMethod( GeneraOfCurvesInQSM,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSM( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return EvalString( String( data.GenusVxiAndKbar ) );
        fi;
        
end );

InstallMethod( GeneraOfCurvesInQSMByPolytope,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSMByPolytope( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return EvalString( String( data.GenusVxiAndKbar ) );
        fi;
        
end );


InstallMethod( DegreeOfKbarOnCurvesInQSM,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSM( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return EvalString( String( data.DegreeOfKbarOnVxiAndKbar ) );
        fi;
        
end );

InstallMethod( DegreeOfKbarOnCurvesInQSMByPolytope,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSMByPolytope( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return EvalString( String( data.DegreeOfKbarOnVxiAndKbar ) );
        fi;
        
end );


InstallMethod( IntersectionNumbersOfCurvesInQSM,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSM( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return EvalString( String( data.IntersectionAmongVxiAndKbarWithVxjAndKbar ) );
        fi;
        
end );

InstallMethod( IntersectionNumbersOfCurvesInQSMByPolytope,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSMByPolytope( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return EvalString( String( data.IntersectionAmongVxiAndKbarWithVxjAndKbar ) );
        fi;
        
end );


InstallMethod( IndicesOfTrivialCurvesInQSM,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSM( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return EvalString( String( data.IndexFacetInteriorDivisors ) );
        fi;
        
end );

InstallMethod( IndicesOfTrivialCurvesInQSMByPolytope,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSMByPolytope( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return EvalString( String( data.IndexFacetInteriorDivisors ) );
        fi;
        
end );


##############################################################################################
##
##  Properties of the dual graph
##
##############################################################################################


InstallMethod( ComponentsOfDualGraphOfQSM,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSM( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return EvalString( ReplacedString( String( data.ComponentsOfDualGraph ), "\'", "\"" ) );
        fi;
        
end );

InstallMethod( ComponentsOfDualGraphOfQSMByPolytope,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSMByPolytope( index );

        # check if the data is meaningful
        if ( data <> fail ) then
            return EvalString( ReplacedString( String( data.ComponentsOfDualGraph ), "\'", "\"" ) );
        fi;
        
end );


InstallMethod( GenusOfComponentsOfDualGraphOfQSM,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSM( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return EvalString( String( data.GenusOfComponentsOfDualGraph ) );
        fi;
        
end );

InstallMethod( GenusOfComponentsOfDualGraphOfQSMByPolytope,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSMByPolytope( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return EvalString( String( data.GenusOfComponentsOfDualGraph ) );
        fi;
        
end );


InstallMethod( DegreeOfKbarOnComponentsOfDualGraphOfQSM,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSM( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return EvalString( String( data.DegreeOfKbarOnComponentsOfDualGraph ) );
        fi;
        
end );

InstallMethod( DegreeOfKbarOnComponentsOfDualGraphOfQSMByPolytope,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSMByPolytope( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return EvalString( String( data.DegreeOfKbarOnComponentsOfDualGraph ) );
        fi;
        
end );


InstallMethod( IntersectionNumberOfComponentsOfDualGraphOfQSM,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSM( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return EvalString( String( data.IntersectionNumberOfComponentsOfDualGraph ) );
        fi;
        
end );

InstallMethod( IntersectionNumberOfComponentsOfDualGraphOfQSMByPolytope,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSMByPolytope( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return EvalString( String( data.IntersectionNumberOfComponentsOfDualGraph ) );
        fi;
        
end );


##############################################################################################
##
##  Plotting the dual graph
##
##############################################################################################


InstallMethod( DualGraphOfQSM,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSM( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return PlotDualGraph( data );
        fi;
        
end );

InstallMethod( DualGraphOfQSMByPolytope,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSMByPolytope( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return PlotDualGraph( data );
        fi;
        
end );


InstallMethod( PlotDualGraph, [ IsRecord ],
    function( data )
        local genera, names, int, num_comp, edges, i, j, script, options, output_string, output, input_string, input;
        
        # read-out the genera
        genera := String( data.GenusOfComponentsOfDualGraph );
        RemoveCharacters( genera, " " );
        
        # read-out the names of the curves
        names := ReplacedString( String( data.ComponentsOfDualGraph ), "\'", "" );
        RemoveCharacters( names, " " );
        # Convenience method - add the degree of Kbar to the right power?
        # Add dual graph of nodal Higgs curve eventually?
        
        # compute edge-list
        int := EvalString( String( data.IntersectionNumberOfComponentsOfDualGraph ) );
        num_comp := Length( EvalString( String( data.GenusOfComponentsOfDualGraph ) ) );
        edges := [];
        for i in [ 1 .. num_comp ] do
            for j in [ i + 1 .. num_comp ] do
                if ( int[ i ][ j ] <> 0 ) then
                    Append( edges, [[ i-1, j-1 ]] );
                fi;
            od;
        od;
        edges := String( edges );
        RemoveCharacters( edges, " " );
        
        # find the python script and transmit data by the options
        script := FindDualGraphScript();
        options := Concatenation( String( genera ), " ", String( edges ), " ", String( names ) );
        
        # execute this script
        output_string := "";
        output := OutputTextString( output_string, true );
        input_string := "";
        input := InputTextString( input_string );
        Process( DirectoryCurrent(), script, input, output, [ options ] );
        
        # return success
        return true;
        
end );


##############################################################################################
##
##  Properties of the simplified dual graph
##
##############################################################################################


InstallMethod( ComponentsOfSimplifiedDualGraphOfQSM,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSM( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return EvalString( ReplacedString( String( data.ComponentsOfSimplifiedDualGraph ), "\'", "\"" ) );
        fi;
        
end );

InstallMethod( ComponentsOfSimplifiedDualGraphOfQSMByPolytope,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSMByPolytope( index );

        # check if the data is meaningful
        if ( data <> fail ) then
            return EvalString( ReplacedString( String( data.ComponentsOfSimplifiedDualGraph ), "\'", "\"" ) );
        fi;
        
end );


InstallMethod( GenusOfComponentsOfSimplifiedDualGraphOfQSM,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSM( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return EvalString( String( data.CiGenus ) );
        fi;
        
end );

InstallMethod( GenusOfComponentsOfSimplifiedDualGraphOfQSMByPolytope,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSMByPolytope( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return EvalString( String( data.CiGenus ) );
        fi;
        
end );


InstallMethod( DegreeOfKbarOnComponentsOfSimplifiedDualGraphOfQSM,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSM( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return EvalString( String( data.CiDegreeKbar ) );
        fi;
        
end );

InstallMethod( DegreeOfKbarOnComponentsOfSimplifiedDualGraphOfQSMByPolytope,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSMByPolytope( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return EvalString( String( data.CiDegreeKbar ) );
        fi;
        
end );


InstallMethod( EdgeListOfSimplifiedDualGraphOfQSM,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSM( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return EvalString( String( data.EdgeList ) );
        fi;
        
end );

InstallMethod( EdgeListOfSimplifiedDualGraphOfQSMByPolytope,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSMByPolytope( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return EvalString( String( data.EdgeList ) );
        fi;
        
end );


##############################################################################################
##
##  Plotting the simplified dual graph
##
##############################################################################################


InstallMethod( SimplifiedDualGraphOfQSM,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSM( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return PlotSimplifiedDualGraph( data );
        fi;
        
end );

InstallMethod( SimplifiedDualGraphOfQSMByPolytope,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSMByPolytope( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return PlotSimplifiedDualGraph( data );
        fi;
        
end );


InstallMethod( PlotSimplifiedDualGraph, [ IsRecord ],
    function( data )
        local genera, edges, names, script, options, output_string, output, input_string, input;
        
        # extract genera
        genera := String( data.CiGenus );
        RemoveCharacters( genera, " " );
        
        # extract the edges
        edges := String( data.EdgeList );
        RemoveCharacters( edges, " " );
        
        # read-out the names
        names := ReplacedString( String( data.ComponentsOfSimplifiedDualGraph ), "\'", "" );
        RemoveCharacters( names, " " );
        
        # find the python script and transmit data by the options
        script := FindDualGraphScript();
        options := Concatenation( String( genera ), " ", String( edges ), " ", String( names ) );
        
        # execute this script
        output_string := "";
        output := OutputTextString( output_string, true );
        input_string := "";
        input := InputTextString( input_string );
        Process( DirectoryCurrent(), script, input, output, [ options ] );
        
        # return success
        return true;
        
end );


InstallMethod( SimplifiedDualGraphWithExternalLegsOfQSM,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSM( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return PlotSimplifiedDualGraphWithExternalLegs( data );
        fi;
        
end );

InstallMethod( SimplifiedDualGraphWithExternalLegsOfQSMByPolytope,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSMByPolytope( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return PlotSimplifiedDualGraphWithExternalLegs( data );
        fi;
        
end );

InstallMethod( PlotSimplifiedDualGraphWithExternalLegs, [ IsRecord ],
    function( data )
        local genera, edges, names, external_legs, count, i, j, script, options, output_string, output, input_string, input;
        
        # extract genera
        genera := EvalString( String( data.CiGenus ) );
        
        # extract the edges
        edges := EvalString( String( data.EdgeList ) );

        # read-out the names
        names := ReplacedString( String( data.ComponentsOfSimplifiedDualGraph ), "\'", "" );
        RemoveCharacters( names, " " );
        RemoveCharacters( names, "[" );
        RemoveCharacters( names, "]" );
        names := SplitString( names, "," );
        
        # append external legs
        external_legs := 2 * EvalString( String( data.CiDegreeKbar ) );
        count := Length( genera );
        for i in [ 1 .. Length( external_legs ) ] do
            for j in [ 1 .. external_legs[ i ] ] do
                Append( names, [ Concatenation( "E", String( count ) ) ] );
                edges := Concatenation( edges, [[ i-1, count ]] );
                Append( genera, [ -100 ] );
                count := count + 1;
            od;
        od;
        
        # convert to strings
        names := ReplacedString( String( names ), "\"", "" );
        RemoveCharacters( names, " " );
        edges := String( edges );
        RemoveCharacters( edges, " " );
        genera := String( genera );
        RemoveCharacters( genera, " " );
        
        # find the python script and transmit data by the options
        script := FindDualGraphScript();
        options := Concatenation( String( genera ), " ", String( edges ), " ", String( names ) );
        
        # execute this script
        output_string := "";
        output := OutputTextString( output_string, true );
        input_string := "";
        input := InputTextString( input_string );
        Process( DirectoryCurrent(), script, input, output, [ options ] );
        
        # return success
        return true;
        
end );



##############################################################################################
##
##  Toric ambient space 5-fold
##
##############################################################################################


InstallMethod( PF11, [ ],
    function( )
        local rays, max_cones, weights, names;
        
        rays := [[0,-1],[-1,-1],[-1,0],[-1,1],[-1,2],[0,1],[1,0]];
        max_cones := [[1, 2], [1, 7], [2, 3], [3, 4], [4, 5], [5, 6], [6, 7]];
        weights := [ [1,0,-1,-1,0], [0,0,0,1,0], [0,0,1,-1,0], [1,-1,-1,0,-1], [0,0,0,0,1], [0,1,0,0,-1], [1,-1,0,0,0] ];
        names := "v,e3,e2,u,e4,e1,w";
        
        return ToricVariety( rays, max_cones, weights, names );
        
end );


InstallMethod( ToricAmbientSpaceOfQSM,
               "an integer",
               [ IsInt ],
    function( index )
        
        return ConstructX5( BaseSpaceOfQSM( index ) );
        
end );

InstallMethod( ToricAmbientSpaceOfQSMByPolytope,
               "an integer",
               [ IsInt ],
    function( index )
        
        return ConstructX5( BaseSpaceOfQSMByPolytope( index ) );
        
end );

InstallMethod( ConstructX5,
               [ IsToricVariety ],
    function( B3 )
        local varsB3, raysB3, fibre, varsFibre, raysFibre, T, rays, max_cones, weights, names, i, test_ray, pos;
        
        # identify the rays and variables of the base
        varsB3 := List( IndeterminatesOfPolynomialRing( CoxRing( B3 ) ), i -> String( i ) );
        raysB3 := RayGenerators( FanOfVariety( B3 ) );
        
        # repeat for the fibre
        fibre := PF11();
        varsFibre := List( IndeterminatesOfPolynomialRing( CoxRing( fibre ) ), i -> String( i ) );
        raysFibre := RayGenerators( FanOfVariety( fibre ) );
        
        # compute direct product of the varieties
        T := B3 * fibre;
        rays := RayGenerators( FanOfVariety( T ) );
        max_cones := List( RaysInMaximalCones( FanOfVariety( T ) ), i -> Positions( i, 1 ) );
        weights := List( WeightsOfIndeterminates( CoxRing( T ) ), i -> UnderlyingListOfRingElements( i ) );
        
        # assign the variables names to match those of B3 and fibre
        names := List( [ 1 .. Length( varsB3 ) + Length( varsFibre ) ], i -> "" );
        
        # identify the variables of the base
        for i in [ 1 .. Length( varsB3 ) ] do
            
            test_ray := Concatenation( raysB3[ i ], [ 0,0 ] );
            pos := Position( rays, test_ray );
            names[ pos ] := varsB3[ i ];
            
        od;
        
        # identify the variables of the fibre
        for i in [ 1 .. Length( varsFibre ) ] do
            
            test_ray := Concatenation( [ 0,0,0 ], raysFibre[ i ] );
            pos := Position( rays, test_ray );
            names[ pos ] := varsFibre[ i ];
            
        od;
        
        # return the result
        return ToricVariety( rays, max_cones, weights, JoinStringsWithSeparator( names, "," ) );
        
end );


##############################################################################################
##
##  The Picard lattice of the K3
##
##############################################################################################


InstallMethod( IsK3OfQSMElliptic,
               "an integer",
               [ IsInt ],
    function( index )
        local int, self_int, i;
        
        # read the data
        int := IntersectionNumberOfComponentsOfDualGraphOfQSM( index );
        self_int := List( [ 1 .. Length( int ) ], i -> int[ i ][ i ] );
        
        # check if we detect that this K3 is elliptic
        if Position( self_int, 0 ) <> fail then
            return true;
        fi;
        
        # test failed, so return false
        return false;
        
end );

InstallMethod( IsK3OfQSMByPolytopeElliptic,
               "an integer",
               [ IsInt ],
    function( index )
        local int, self_int, i;
        
        # read the data
        int := IntersectionNumberOfComponentsOfDualGraphOfQSMByPolytope( index );
        self_int := List( [ 1 .. Length( int ) ], i -> int[ i ][ i ] );
        
        # check if we detect that this K3 is elliptic
        if Position( self_int, 0 ) <> fail then
            return true;
        fi;
        
        # test failed, so return false
        return false;
        
end );

InstallMethod( RankOfPicardLatticeOfK3OfQSM,
               "an integer",
               [ IsInt ],
    function( index )
        
        return Length( ComponentsOfDualGraphOfQSM( index ) ) - 3;
        
end );

InstallMethod( RankOfPicardLatticeOfK3OfQSMByPolytope,
               "an integer",
               [ IsInt ],
    function( index )
        
        return Length( ComponentsOfDualGraphOfQSMByPolytope( index ) ) - 3;
        
end );


##############################################################################################
##
##  Display information about a QSM
##
##############################################################################################


InstallMethod( FullInformationOfQSM,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSM( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return DisplayFullInformationOfQSM( data, false );
        fi;
        
end );

InstallMethod( FullInformationOfQSM,
               "an integer",
               [ IsInt, IsBool ],
    function( index, details )
        local data;
        
        # read the data
        data := ReadQSM( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return DisplayFullInformationOfQSM( data, details );
        fi;
        
end );

InstallMethod( FullInformationOfQSMByPolytope,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSMByPolytope( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return DisplayFullInformationOfQSM( data, false );
        fi;
        
end );

InstallMethod( FullInformationOfQSMByPolytope,
               "an integer",
               [ IsInt, IsBool ],
    function( index, details )
        local data;
        
        # read the data
        data := ReadQSMByPolytope( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return DisplayFullInformationOfQSM( data, details );
        fi;
        
end );


InstallMethod( DisplayFullInformationOfQSM,
               "a record",
               [ IsRecord, IsBool ],
    function( data, details )
        local int, self_int, m, s;
        
        # print details about this vacuum
        Print( "\n" );
        Print( Concatenation( "The QSM defined by FRSTs of the ", String( data.PolyInx ), "th 3-dimensional polytope in the Kreuzer-Skarke list\n" ) );
        Print( "----------------------------------------------------------------------------------------\n" );
        Print( "\n");
        Print( "Information on the 3-dimensional polytope:\n" );
        Print( Concatenation( "(*) Vertices: ", String( data.PolytopeVertices ), "\n" ) );
        Print( Concatenation( "(*) Maximal number of lattice points in facets: ", String( data.MaxLatticePtsInFacet ), "\n" ) );
        Print( Concatenation( "(*) Estimated number of FRSTs: ", String( data.TriangulationEstimate ), "\n" ) );
        Print( Concatenation( "(*) Can be computed in short time: ", String( data.TriangQuick ), "\n" ) );
        
        Print( "\n");
        Print( "Information of ONE particular 3-fold:\n" );
        Print( Concatenation( "(*) Kbar^3: ", String( data.Kbar3 ), "\n" ) );
        Print( Concatenation( "(*) Number of homogeneous variables: ", String( Length( EvalString( data.RayGeneratorsOfB3 ) ) ), "\n" ) );
        Print( Concatenation( "(*) Picard group: Z^", String( Length( EvalString( data.RayGeneratorsOfB3 ) ) - 3 ), "\n" ) );
        if details then
            Print( Concatenation( "(*) Ray generators: ", String( data.RayGeneratorsOfB3 ), "\n" ) );
            Print( Concatenation( "(*) Max cones: ", String( data.TriangulationOfB3 ), "\n" ) );
        fi;
        
        Print( "\n");
        Print( "Information about elliptic 4-fold:\n" );
        Print( Concatenation( "(*) h11: ", String( data.h11 ), "\n" ) );
        Print( Concatenation( "(*) h12: ", String( data.h12 ), "\n" ) );
        Print( Concatenation( "(*) h13: ", String( data.h13 ), "\n" ) );
        Print( Concatenation( "(*) h22: ", String( data.h22 ), "\n" ) );
        Print( "\n");
        
        Print( "Information about the K3-surface:\n" );
        int := EvalString( String( data.IntersectionNumberOfComponentsOfDualGraph ) );
        self_int := List( [ 1 .. Length( int ) ], i -> int[ i ][ i ] );
        if Position( self_int, 0 ) <> fail then
            Print( "(*) IsElliptic: True\n" );
        else
            Print( "(*) IsElliptic: No\n" );
        fi;
        Print( Concatenation( "(*) Rank of Picard lattice: ", String( Length( int[ 1 ] ) - 3 ), "\n" ) );
        Print( "\n");
        
        Print( "Information on the nodal quark-doublet curve:\n" );
        Print( Concatenation( "(*) Genus: ", String( Int( data.Kbar3/2 + 1 ) ), "\n" ) );
        Print( Concatenation( "(*) Number of components: ", String( Length( EvalString( ReplacedString( String( data.ComponentsOfDualGraph ), "\'", "\"" ) ) ) ), "\n" ) );
        Print( Concatenation( "(*) Components: ", ReplacedString( String( data.ComponentsOfDualGraph ), "\'", "\"" ), "\n" ) );
        Print( Concatenation( "(*) Genera: ", String( data.GenusOfComponentsOfDualGraph ), "\n" ) );
        Print( Concatenation( "(*) Degree of Kbar: ", String( data.DegreeOfKbarOnComponentsOfDualGraph ), "\n" ) );
        if details then
            Print( Concatenation( "(*) Intersection numbers of components: ", String( data.IntersectionNumberOfComponentsOfDualGraph ), "\n" ) );
        fi;
        Print( "\n");
        
        Print( "Information on simplified dual graph:\n" );
        Print( Concatenation( "(*) Number of components: ", String( Length( EvalString( data.CiGenus ) ) ), "\n" ) );
        Print( Concatenation( "(*) Components: ", ReplacedString( String( data.ComponentsOfSimplifiedDualGraph ), "\'", "\"" ), "\n" ) );
        Print( Concatenation( "(*) Genera: ", String( data.CiGenus ), "\n" ) );
        Print( Concatenation( "(*) Edge list of dual graph: ", String( data.EdgeList ), "\n" ) );
        Print( "\n");
        
        Print( "Root bundles:\n" );
        Print( Concatenation( "(*) Looking for ", String( 2 * data.Kbar3 ), "th root of line bundle M\n" ) );
        Print( Concatenation( "(*) Degrees of line bundle M: ", String( ( 6 + data.Kbar3 ) * EvalString( data.CiDegreeKbar ) ), "\n" ) );
        Print( Concatenation( "(*) Total number of root bundles: ", String( ( 2 * data.Kbar3 )^(2 * Int( data.Kbar3/2 + 1 )) ), "\n" ) );
        Print( "\n" );
        
        # return success
        return true;
        
end );


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
            return CountMinimalLimitRoots( data, true );
        fi;
        
end );

InstallMethod( CountMinimalLimitRootsOfQSM, [ IsInt, IsBool ],
    function( index, display_details )
        local data;
        
        data := ReadQSM( index );
        if ( data <> fail ) then
            return CountMinimalLimitRoots( data, display_details );
        fi;
        
end );

InstallMethod( CountMinimalLimitRootsOfQSMByPolytope, [ IsInt ],
    function( index )
        local data;
        
        data := ReadQSMByPolytope( index );
        if ( data <> fail ) then
            return CountMinimalLimitRoots( data, true );
        fi;
    
end );

InstallMethod( CountMinimalLimitRootsOfQSMByPolytope, [ IsInt, IsBool ],
    function( index, display_details )
        local data;
        
        data := ReadQSMByPolytope( index );
        if ( data <> fail ) then
            return CountMinimalLimitRoots( data, display_details );
        fi;
    
end );

InstallMethod( CountMinimalLimitRoots, [ IsRecord, IsBool ],
    function( data, display_details )
        local index, Kbar3, genera, degrees, edges, total_genus, root, min;
        
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
        
        # compute minimal roots
        min := Int( Sum( degrees ) / root - total_genus + 1 );
        return CountDistributionWithExternalLegs( [ genera, degrees, edges, total_genus, root, min, min, [], [] ], display_details );
        
end );


##############################################################################################
##
##  Count distribution of limit roots
##
##############################################################################################

InstallMethod( CountLimitRootDistributionOfQSM, [ IsInt, IsInt, IsInt ],
    function( index, h0Min, h0Max )
        local data;
        
        data := ReadQSM( index );
        if ( data <> fail ) then
            return CountLimitRootDistribution( data, h0Min, h0Max, true );
        fi;
        
end );

InstallMethod( CountLimitRootDistributionOfQSM, [ IsInt, IsInt, IsInt, IsBool ],
    function( index, h0Min, h0Max, display_details )
        local data;
        
        data := ReadQSM( index );
        if ( data <> fail ) then
            return CountLimitRootDistribution( data, h0Min, h0Max, display_details );
        fi;
        
end );

InstallMethod( CountLimitRootDistributionOfQSMByPolytope, [ IsInt, IsInt, IsInt ],
    function( index, h0Min, h0Max )
        local data;
        
        data := ReadQSMByPolytope( index );
        if ( data <> fail ) then
            return CountLimitRootDistribution( data, h0Min, h0Max, true );
        fi;
        
end );

InstallMethod( CountLimitRootDistributionOfQSMByPolytope, [ IsInt, IsInt, IsInt, IsBool ],
    function( index, h0Min, h0Max, display_details )
        local data;
        
        data := ReadQSMByPolytope( index );
        if ( data <> fail ) then
            return CountLimitRootDistribution( data, h0Min, h0Max, display_details );
        fi;
        
end );

InstallMethod( CountLimitRootDistribution, [ IsRecord, IsInt, IsInt, IsBool ],
    function( data, h0Min, h0Max, display_details )
        local index, Kbar3, genera, degrees, edges, total_genus, root, min;
        
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

        # call other function to compute this root distribution
        return CountDistributionWithExternalLegs( [ genera, degrees, edges, total_genus, root, h0Min, h0Max, [], [] ], display_details );
        
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
            return CountPartialBlowupLimitRootDistribution( data, h0Min, h0Max, true );
        fi;
        
end );

InstallMethod( CountPartialBlowupLimitRootDistributionOfQSM, [ IsInt, IsInt, IsInt, IsBool ],
    function( index, h0Min, h0Max, display_details )
        local data;
        
        data := ReadQSM( index );
        if ( data <> fail ) then
            return CountPartialBlowupLimitRootDistribution( data, h0Min, h0Max, display_details );
        fi;
        
end );

InstallMethod( CountPartialBlowupLimitRootDistributionOfQSMByPolytope, [ IsInt, IsInt, IsInt ],
    function( index, h0Min, h0Max )
        local data;
        
        data := ReadQSMByPolytope( index );
        if ( data <> fail ) then
            return CountPartialBlowupLimitRootDistribution( data, h0Min, h0Max, true );
        fi;
        
end );

InstallMethod( CountPartialBlowupLimitRootDistributionOfQSMByPolytope, [ IsInt, IsInt, IsInt, IsBool ],
    function( index, h0Min, h0Max, display_details )
        local data;
        
        data := ReadQSMByPolytope( index );
        if ( data <> fail ) then
            return CountPartialBlowupLimitRootDistribution( data, h0Min, h0Max, display_details );
        fi;
        
end );

InstallMethod( CountPartialBlowupLimitRootDistribution, [ IsRecord, IsInt, IsInt, IsBool ],
    function( data, h0Min, h0Max, display_details )
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
        result := EvalString( ReadAll( input ) );
        CloseStream(input);
        RemoveFile( result_file );
        
        # return result
        return result;        
        
        
        
end );


##############################################################################################
##
##  Count distribution of partial blowup limit roots by tree-like analysis
##
##############################################################################################

InstallMethod( CountPartialBlowupLimitRootDistributionOfQSMFromTreelikeAnalysis, [ IsInt, IsInt, IsInt ],
    function( index, h0Min, h0Max )
        local data;
        
        data := ReadQSM( index );
        if ( data <> fail ) then
            return CountPartialBlowupLimitRootDistributionFromTreelikeAnalysis( data, h0Min, h0Max, true );
        fi;
        
end );

InstallMethod( CountPartialBlowupLimitRootDistributionOfQSMFromTreelikeAnalysis, [ IsInt, IsInt, IsInt, IsBool ],
    function( index, h0Min, h0Max, display_details )
        local data;
        
        data := ReadQSM( index );
        if ( data <> fail ) then
            return CountPartialBlowupLimitRootDistributionFromTreelikeAnalysis( data, h0Min, h0Max, display_details );
        fi;
        
end );

InstallMethod( CountPartialBlowupLimitRootDistributionOfQSMByPolytopeFromTreelikeAnalysis, [ IsInt, IsInt, IsInt ],
    function( index, h0Min, h0Max )
        local data;
        
        data := ReadQSMByPolytope( index );
        if ( data <> fail ) then
            return CountPartialBlowupLimitRootDistributionFromTreelikeAnalysis( data, h0Min, h0Max, true );
        fi;
        
end );

InstallMethod( CountPartialBlowupLimitRootDistributionOfQSMByPolytopeFromTreelikeAnalysis, [ IsInt, IsInt, IsInt, IsBool ],
    function( index, h0Min, h0Max, display_details )
        local data;
        
        data := ReadQSMByPolytope( index );
        if ( data <> fail ) then
            return CountPartialBlowupLimitRootDistributionFromTreelikeAnalysis( data, h0Min, h0Max, display_details );
        fi;
        
end );

InstallMethod( CountPartialBlowupLimitRootDistributionFromTreelikeAnalysis, [ IsRecord, IsInt, IsInt, IsBool ],
    function( data, h0Min, h0Max, display_details )
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
            if genera[ i ] <> 0 then
                Error( "The genera must all be zero for this method to apply." );
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
        dir := FindPartialBlowupRootCounterFromTreelikeAnalysisDirectory();
        bin := Filename( dir, "./partialBlowupsAllTrees" );
        if not IsExistingFile( bin ) then
            Error( "./partialBlowupsAllTrees is not available in designed folder" );
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
