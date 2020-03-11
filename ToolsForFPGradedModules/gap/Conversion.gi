################################################################################################
##
##  Conversion.gi               ToolsForFPGradedModules package
##
##  Copyright 2020              Martin Bies,       University of Oxford
##
##  Conversion among FPGradedModules and 'old' graded modules and saving them to files
##
################################################################################################



##############################################################################################
##
## Section Turn CAP Graded Modules into old graded modules and vice versa
##
##############################################################################################

# compute the maps in a minimal free resolution of a f.p. graded module presentation
InstallMethod( TurnIntoOldGradedModule,
               "a f.p. graded S-module",
               [ IsFpGradedLeftOrRightModulesObject ],
  function( module )
    local ring, gens, old_gens, i, matrix, old_graded_module;

    # extract the underlying ring
    ring := UnderlyingHomalgGradedRing( RelationMorphism( module ) );

    # then the degrees of the generators
    gens := DegreeList( Range( RelationMorphism( module ) ) );
    old_gens := [];
    for i in [ 1 .. Length( gens ) ] do
      Append( old_gens, ListWithIdenticalEntries( gens[ i ][ 2 ], UnderlyingListOfRingElements( gens[ i ][ 1 ] ) ) );
    od;

    # and the underlying matrix
    matrix := UnderlyingHomalgMatrix( RelationMorphism( module ) );

    # and create the graded module
    if IsFpGradedLeftModulesObject( module ) then
      old_graded_module := LeftPresentationWithDegrees( matrix, old_gens );
    else
      old_graded_module := RightPresentationWithDegrees( matrix, old_gens );
    fi;

    # and return it
    return old_graded_module;

end );

InstallMethod( TurnIntoCAPGradedModule,
               " a f.p. graded S-module",
               [ IsGradedModuleOrGradedSubmoduleRep ],
  function( module )
    local ring, mor, generators_degrees, generators, matrix;

    # then extract the underlying ring
    if HasLeftActingDomain( module ) then
      ring := LeftActingDomain( module );
    else
      ring := RightActingDomain( module );
    fi;

    # extract presentation morphism of module
    mor := PresentationMorphism( module );

    # set up the generators
    generators_degrees := List( DegreesOfGenerators( Range( mor ) ), k -> [ k, 1 ] );
    generators := GradedRow( generators_degrees, ring );

    # extract the underlying matrix
    matrix := MatrixOfMap( mor );
    if not HasLeftActingDomain( module ) then
      matrix := Involution( matrix );
    fi;

    # form the CAP_module
    return FreydCategoryObject( DeduceMapFromMatrixAndRangeForGradedRows( matrix, generators ) );

end );



##############################################################################################
##
## Section Save CAP f.p. graded module to file
##
##############################################################################################

InstallMethod( SaveToFileAsOldGradedModule,
               "a f.p. graded S-module",
               [ IsString, IsFpGradedLeftOrRightModulesObject ],
  function( filename, module )
    local name, output, ring, vars, weights, degree_group, generator_degrees, new_gens, s, matrix_entries, i, help_list;

    # set up the filename
    # by default we save the file in the folder of the package SheafCohomologyOnToricVarieties
    name := Filename( DirectoriesPackageLibrary( "SheafCohomologyOnToricVarieties", "" )[ 1 ], 
                                                                 Concatenation( filename, ".gi" ) );

    # check if the file exists
    if IsExistingFile( name ) then

      # if it does, try to remove it
      if RemoveFile( name ) = fail then
        Error( "the file already exists and cannot be deleted before the write process" );
        return;
      fi;

    fi;

    # create an output stream, append input
    output := OutputTextFile( name, true );;

    # check if that stream works
    if output = fail then
      Error( "failed to set up file-stream" );
      return;
    fi;

    # ensure that we load GradedModules
    AppendTo( output, "LoadPackage( \"GradedModules\" ); \n" );

    # write the non-graded ring to the file
    ring := UnderlyingHomalgGradedRing( UnderlyingMorphism( module ) );
    vars := IndeterminatesOfPolynomialRing( ring );
    s := "ring := HomalgFieldOfRationalsInSingular() * \"";
    for i in [ 1 .. Length( vars ) - 1 ] do
      s := Concatenation( s, String( vars[ i ] ), "," );
    od;
    s := Concatenation( s, String( vars[ Length( vars ) ] ), "\"; \n" );
    AppendTo( output, s );
    AppendTo( output, "ring := GradedRing( ring ); \n" );

    # now also save the grading
    degree_group := DegreeGroup( ring );
    AppendTo( output, Concatenation( "A := ", String( Rank( degree_group ) ), " * HOMALG_MATRICES.ZZ; \n" ) );
    weights := WeightsOfIndeterminates( ring );
    weights := List( [ 1 .. Length( weights ) ], k -> UnderlyingListOfRingElements( weights[ k ] ) );
    AppendTo( output, Concatenation( "weights := ", String( weights ), "; \n" ) );
    AppendTo( output, "weights := List( weights, i -> HomalgModuleElement( i, A ) ); \n" );
    AppendTo( output, "SetWeightsOfIndeterminates( ring, weights ); \n" );

    # write the generator_degrees to the file
    generator_degrees := DegreeList( Range( UnderlyingMorphism( module ) ) );
    new_gens := [];
    for i in [ 1 .. Length( generator_degrees ) ] do
      Append( new_gens, ListWithIdenticalEntries( generator_degrees[ i ][ 2 ], 
                                                  UnderlyingListOfRingElements( generator_degrees[ i ][ 1 ] ) ) );
    od;
    s := Concatenation( "generators_degrees :=", String( new_gens ), "; \n");
    AppendTo( output, s );

    # write the matrix to the file
    matrix_entries := EntriesOfHomalgMatrixAsListList( UnderlyingHomalgMatrix( UnderlyingMorphism( module ) ) );
    for i in [ 1 .. Length( matrix_entries ) ] do
      help_list := List( matrix_entries[ i ], k -> String( k ) );
      matrix_entries[ i ] := help_list;
    od;
    s := Concatenation( "matrix := HomalgMatrix( ", String( matrix_entries ), ", ring ); \n" );
    AppendTo( output, s );

    # write lines, that form the graded module (in old GradedModules-Package) from this input
    s := Concatenation( s, filename, ":= LeftPresentationWithDegrees( matrix, generators_degrees ); \n" );
    AppendTo( output, s );

    # close the stream
    CloseStream(output);

    # and return true in case we were successful
    return true;

end );

InstallMethod( SaveToFileAsCAPGradedModule,
               "a f.p. graded S-module",
               [ IsString, IsFpGradedLeftOrRightModulesObject ],
  function( filename, module )
    local name, output, generator_degrees, s, relations_degrees, matrix_entries, i, help_list;

    # set up the filename
    name := Filename( DirectoriesPackageLibrary( "SheafCohomologyOnToricVarieties", "" )[ 1 ], 
                                                                         Concatenation( filename, ".gi" ) );;

    # check if the file exists
    if IsExistingFile( name ) then

      # if it does, try to remove it
      if RemoveFile( name ) = fail then
        Error( "the file already exists and cannot be deleted before the write process" );
        return;
      fi;

    fi;

    # create an output stream, append input
    output := OutputTextFile( name, true );;

    # check if that stream works
    if output = fail then
      Error( "failed to set up file-stream" );
      return;
    fi;

    # write the generator_degrees to the file
    generator_degrees := DegreeList( Range( UnderlyingMorphism( module ) ) );
    generator_degrees := List( generator_degrees, k -> [ UnderlyingListOfRingElements( k[ 1 ] ), k[ 2 ] ] );
    s := Concatenation( "generators_degrees :=",
                        String( generator_degrees ),
                        "; \n");
    AppendTo( output, s );
    s := Concatenation( "generators := CAPCategoryOfProjectiveGradedLeftModulesObject( generators_degrees, ",
                        "CoxRing( ambient_space ) ); \n" );
    AppendTo( output, s );

    # write the relations_degrees to the file
    relations_degrees := DegreeList( Source( UnderlyingMorphism( module ) ) );
    relations_degrees := List( relations_degrees, k -> [ UnderlyingListOfRingElements( k[ 1 ] ), k[ 2 ] ] );
    s := Concatenation( "relations_degrees :=",
                        String( relations_degrees ),
                        "; \n");
    AppendTo( output, s );
    s := Concatenation( "relations := CAPCategoryOfProjectiveGradedLeftModulesObject( relations_degrees, ",
                        "CoxRing( ambient_space ) ); \n" );
    AppendTo( output, s );

    # write the matrix to the file
    matrix_entries := EntriesOfHomalgMatrixAsListList( UnderlyingHomalgMatrix( UnderlyingMorphism( module ) ) );
    for i in [ 1 .. Length( matrix_entries ) ] do
      help_list := List( matrix_entries[ i ], k -> String( k ) );
      matrix_entries[ i ] := help_list;
    od;
    s := Concatenation( "matrix := HomalgMatrix( ",
                        String( matrix_entries ),
                        ", CoxRing( ambient_space ) ); \n" );
    AppendTo( output, s );

    # write lines, that form the module from this input, hence one only has to read this file to gap to create the module
    s := Concatenation( "mor := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( ",
                        "relations, matrix, generators ); \n" );
    s := Concatenation( s, filename, ":= CAPPresentationCategoryObject( mor ); \n" );
    AppendTo( output, s );

    # close the stream
    CloseStream(output);

    # and return true in case we were successful
    return true;

end );



##############################################################################################
##
##  Turn left into right modules and vice versa
##
##############################################################################################

InstallMethod( TurnIntoGradedColumn,
               [ IsGradedRow ],
  function( graded_row )
    local degrees;
    
    degrees := List( DegreeList( graded_row ), i -> [ UnderlyingListOfRingElements( i[ 1 ] ), i[ 2 ] ] );
    return GradedColumn( degrees, UnderlyingHomalgGradedRing( graded_row ) );
    
end );

InstallMethod( TurnIntoGradedRow,
               [ IsGradedColumn ],
  function( graded_column )
    local degrees;
    
    degrees := List( DegreeList( graded_column ), i -> [ UnderlyingListOfRingElements( i[ 1 ] ), i[ 2 ] ] );
    return GradedRow( degrees, UnderlyingHomalgGradedRing( graded_column ) );
    
end );

InstallMethod( TurnIntoGradedColumnMorphism,
               [ IsGradedRowMorphism ],
  function( graded_row_morphism )
    local source, range, matrix;
    
    source := TurnIntoGradedColumn( Source( graded_row_morphism ) );
    range := TurnIntoGradedColumn( Range( graded_row_morphism ) );
    matrix := Involution( UnderlyingHomalgMatrix( graded_row_morphism ) );
    return GradedRowOrColumnMorphism( source, matrix, range );
    
end );

InstallMethod( TurnIntoGradedRowMorphism,
               [ IsGradedColumnMorphism ],
  function( graded_column_morphism )
    local source, range, matrix;
    
    source := TurnIntoGradedRow( Source( graded_column_morphism ) );
    range := TurnIntoGradedRow( Range( graded_column_morphism ) );
    matrix := Involution( UnderlyingHomalgMatrix( graded_column_morphism ) );
    return GradedRowOrColumnMorphism( source, matrix, range );
    
end );

InstallMethod( TurnIntoFpGradedRightModule,
               [ IsFpGradedLeftModulesObject ],
  function( module )
    
    return FreydCategoryObject( TurnIntoGradedColumnMorphism( RelationMorphism( module ) ) );
    
end );

InstallMethod( TurnIntoFpGradedLeftModule,
               [ IsFpGradedRightModulesObject ],
  function( module )
    
    return FreydCategoryObject( TurnIntoGradedRowMorphism( RelationMorphism( module ) ) );
    
end );

InstallMethod( TurnIntoFpGradedRightModuleMorphism,
               [ IsFpGradedLeftModulesMorphism ],
  function( morphism )
    local new_source, new_range, new_mor_datum;
    
    new_source := TurnIntoFpGradedRightModule( Source( morphism ) );
    new_range := TurnIntoFpGradedRightModule( Range( morphism ) );
    new_mor_datum := TurnIntoGradedColumnMorphism( MorphismDatum( morphism ) );
    return FreydCategoryMorphism( new_source, new_mor_datum, new_range );
    
end );

InstallMethod( TurnIntoFpGradedLeftModuleMorphism,
               [ IsFpGradedRightModulesMorphism ],
  function( morphism )
    local new_source, new_range, new_mor_datum;
    
    new_source := TurnIntoFpGradedLeftModule( Source( morphism ) );
    new_range := TurnIntoFpGradedLeftModule( Range( morphism ) );
    new_mor_datum := TurnIntoGradedRowMorphism( MorphismDatum( morphism ) );
    return FreydCategoryMorphism( new_source, new_mor_datum, new_range );
    
end );
