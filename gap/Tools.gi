################################################################################################
##
##  Tools.gi          SheafCohomologyOnToricVarieties package
##
##  Copyright 2017                     Martin Bies,       ITP Heidelberg
##
#! @Chapter Tools
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
               [ IsGradedLeftOrRightModulePresentationForCAP ],
  function( module )
    local ring, gens, old_gens, i, matrix, old_graded_module;

    # extract the underlying ring
    ring := UnderlyingHomalgGradedRing( UnderlyingMorphism( module ) );

    # then the degrees of the generators
    gens := DegreeList( Range( UnderlyingMorphism( module ) ) );
    old_gens := [];
    for i in [ 1 .. Length( gens ) ] do
      Append( old_gens, ListWithIdenticalEntries( gens[ i ][ 2 ], UnderlyingListOfRingElements( gens[ i ][ 1 ] ) ) );
    od;

    # and the underlying matrix
    matrix := UnderlyingHomalgMatrix( UnderlyingMorphism( module ) );

    # and create the graded module
    if IsGradedLeftModulePresentationForCAP( module ) then
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
    local left, ring, mor, generators_degrees, generators, relations_degrees, relations, matrix, CAP_mor, CAP_module;

    # check if this is a left or right module
    left := HasLeftActingDomain( module );

    # then extract the underlying ring
    if left then
      ring := LeftActingDomain( module );
    else
      ring := RightActingDomain( module );
    fi;

    # extract presentation morphism of module
    mor := PresentationMorphism( module );

    # set up the generators
    generators_degrees := List( DegreesOfGenerators( Range( mor ) ), k -> [ k, 1 ] );
    generators := CAPCategoryOfProjectiveGradedLeftModulesObject( generators_degrees, ring );

    # set up the relations
    relations_degrees := List( DegreesOfGenerators( Source( mor ) ), k -> [ k, 1 ] );
    relations := CAPCategoryOfProjectiveGradedLeftModulesObject( relations_degrees, ring );

    # extract the underlying matrix
    matrix := MatrixOfMap( mor );
    if not left then
      matrix := Involution( matrix );
    fi;

    # form the CAP_module
    CAP_mor := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( relations, matrix, generators );
    CAP_module := CAPPresentationCategoryObject( CAP_mor );

    # and return the module
    return CAP_module;

end );



##############################################################################################
##
## Section Save CAP f.p. graded module to file
##
##############################################################################################

InstallMethod( SaveToFileAsOldGradedModule,
               "a f.p. graded S-module",
               [ IsString, IsGradedLeftOrRightModulePresentationForCAP ],
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
               [ IsString, IsGradedLeftOrRightModulePresentationForCAP ],
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
