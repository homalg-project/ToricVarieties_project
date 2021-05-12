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
    package_directory := DirectoriesPackageLibrary( "QSMExplorer", "bin/RootCounter" );
    if Length( package_directory ) > 1 then
        
        Error( "Found at least two versions of QSMExplorer - unable to determine ./counter" );
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
##  Display information about a QSM
##
##############################################################################################


InstallMethod( DisplayQSM,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSM( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return PrintQSM( data );
        fi;
        
end );

InstallMethod( DisplayQSMByPolytope,
               "an integer",
               [ IsInt ],
    function( index )
        local data;
        
        # read the data
        data := ReadQSMByPolytope( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return PrintQSM( data );
        fi;
        
end );

InstallMethod( PrintQSM,
               "a record",
               [ IsRecord ],
    function( data )
        
        # print details about this vacuum
        Print( "\n" );
        Print( Concatenation( "The QSM defined by FRSTs of the ", String( data.PolyInx ), "th 3-dimensional polytope in the Kreuzer-Skarke list\n" ) );
        Print( "----------------------------------------------------------------------------------------\n" );
        Print( "\n");
        Print( "Information on the 3-fold:\n" );
        Print( Concatenation( "(*) Kbar^3: ", String( data.Kbar3 ), "\n" ) );
        Print( Concatenation( "(*) Estimated number of triangulations: ", String( data.TriangulationEstimation ), "\n" ) );
        Print( "\n");
        Print( "Information on the elliptic 4-fold:\n" );
        Print( Concatenation( "(*) h11: ", String( data.h11 ), "\n" ) );
        Print( Concatenation( "(*) h12: ", String( data.h12 ), "\n" ) );
        Print( Concatenation( "(*) h13: ", String( data.h13 ), "\n" ) );
        Print( Concatenation( "(*) h22: ", String( data.h22 ), "\n" ) );
        Print( "\n");
        Print( "Information on the 3-dimensional polytope:\n" );
        Print( Concatenation( "(*) Vertices: ", String( data.PolytopeVerices ), "\n" ) );
        Print( "\n");
        Print( "Information on the nodal quark-doublet curve:\n" );
        Print( Concatenation( "(*) Genus: ", String( Int( data.Kbar3/2 + 1 ) ), "\n" ) );
        Print( Concatenation( "(*) Looking for ", String( 2 * data.Kbar3 ), "th root of line bundle M \n" ) );
        Print( Concatenation( "(*) Total number of root bundles: ", String( ( 2 * data.Kbar3 )^(2 * Int( data.Kbar3/2 + 1 )) ), "\n" ) );
        Print( "\n" );
        Print( "Information on reduce dual graph of this nodal curve:\n" );
        Print( Concatenation( "(*) Number of components: ", String( Length( EvalString( data.CiGenus ) ) ), "\n" ) );
        Print( Concatenation( "(*) Genera: ", String( data.CiGenus ), "\n" ) );
        Print( Concatenation( "(*) Edge list of dual graph: ", String( data.EdgeList ), "\n" ) );
        Print( Concatenation( "(*) Degrees of line bundle M: ", String( ( 6 + data.Kbar3 ) * EvalString( data.CiDegreeKbar ) ), "\n" ) );
        Print( "\n" );
        
        # return success
        return true;
        
end );


##############################################################################################
##
##  Section Plot dual graph
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
            return PrintDualGraph( data );
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
            return PrintDualGraph( data );
        fi;
        
end );


InstallMethod( PrintDualGraph, [ IsRecord ],
    function( data )
        local script, output_string, output, input_string, input, genera, edges, options;
        
        # find the python script
        script := FindDualGraphScript();
        
        # prepare empty streams
        output_string := "";
        output := OutputTextString( output_string, true );
        input_string := "";
        input := InputTextString( input_string );
        
        # options conveys the necessary information about the graph
        genera := String( data.CiGenus );
        RemoveCharacters( genera, " " );
        edges := String( data.EdgeList );
        RemoveCharacters( edges, " " );
        options := Concatenation( String( genera ), " ", String( edges ) );

        # issue the script
        Process( DirectoryCurrent(), script, input, output, [ options ] );
        
        # return success
        return true;
        
end );

##############################################################################################
##
##  Section Plot dual graph
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
        vars := JoinStringsWithSeparator( List( [ 1 .. NrCols( m ) ], i -> Concatenation( "x", String( i ) ) ), "," );
        
        # then construct the variety
        return ToricVariety( rays, max_cones, weights, vars );
        
end );



##############################################################################################
##
##  Count limit roots
##
##############################################################################################

InstallMethod( CountLimitRootsOfQSM, [ IsInt ],
    function( index )
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
        return CountLimitRootsOfQSM( index, EvalString( str ) );
        
end );

InstallMethod( CountLimitRootsOfQSM, [ IsInt, IsInt ],
    function( index, number_processes )
        local data;
        
        data := ReadQSM( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return CountLimitRoots( data, number_processes );
        fi;
        
end );

InstallMethod( CountLimitRootsOfQSMByPolytope, [ IsInt ],
    function( index )
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
        return CountLimitRootsOfQSMByPolytope( index, EvalString( str ) );
        
end );

InstallMethod( CountLimitRootsOfQSMByPolytope, [ IsInt, IsInt ],
    function( index, number_processes )
        local data;
        
        data := ReadQSMByPolytope( index );
        
        # check if the data is meaningful
        if ( data <> fail ) then
            return CountLimitRoots( data, number_processes );
        fi;
        
end );

InstallMethod( CountLimitRoots, [ IsRecord, IsInt ],
    function( data, number_processes )
        local dir, bin, result_file, output_string, output, input_string, input, index, Kbar3, genera, degrees, edges, total_genus, root, options, i, nr;
        
        # find the counter binary
        dir := FindRootCounterDirectory();
        bin := Filename( dir, "./counter" );
        
        # check if the binary exists
        if not IsExistingFile( bin ) then
            Error( "./counter is not available in designed folder" );
        fi;
        
        # prepare empty streams
        output_string := "";
        output := OutputTextUser();
        input_string := "";
        input := InputTextString( input_string );
        
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
        
        # options conveys the necessary information about the graph
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
        options := Concatenation( options, String( total_genus ), " ", String( root ), " ", String( number_processes ) );
        
        # triggerthe binary
        Process( DirectoryCurrent(), bin, input, output, [ options ] );
        
        # check if the result file exists
        result_file := Filename( dir, "result.txt" );
        if not IsExistingFile( result_file ) then
            Error( "result.txt is not available in designed folder" );
        fi;
        
        # if yes, read the content
        input := InputTextFile(result_file);
        nr := EvalString( ReadAll(input) );
        CloseStream(input);
        RemoveFile( result_file );
        
        # return success
        return nr;
        
end );
