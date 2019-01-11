###############################################################################################
##
##  CohomologyFromCohomCalg.gi               SheafCohomologyOnToricVarieties package
##
##  Copyright 2019, Martin Bies,             ULB Brussels
##
##  Chapter Cohomology of vector bundles on (smooth and compact) toric varieties from cohomCalg
##
###############################################################################################



####################################################################################
##
##  Section All sheaf cohomologies of vector bundles from cohomCalg
##
####################################################################################

InstallMethod( AllCohomologiesFromCohomCalg,
               "for a toric variety and a projective f.p. graded S-module",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool ],
  function( variety, module, vector_spaces_wished )
    local cohomCalgDirectory, cohomCalg, degree_list, stdin, stdout, outputs, i, buffer, 
         position, command_string, dimensions, Q;

    # check if the variety gives us a valid input
    if not ( ( IsComplete( variety) and IsSmooth( variety ) ) or
             ( IsSimplicial( Fan( variety ) ) and IsProjective( variety ) ) ) then 

      Error( "The variety has to be smooth, complete or simplicial, projective" );
      return;

    fi;

    # check if the module is projective
    if not IsZeroForObjects( Source( UnderlyingMorphism( module ) ) ) then

      Error( "The given f.p. graded S-module is not projective" );
      return;

    elif not IsIdenticalObj( UnderlyingHomalgGradedRing( UnderlyingMorphism( module ) ), CoxRing( variety ) ) then

      Error( "The module is not defined over the Cox ring of the given variety" );
      return;

    fi;

    # identify the location of cohomcalg
    cohomCalg := cohomCalgBinary( );

    # extract the degree_list of the module
    degree_list := DegreeList( Range( UnderlyingMorphism( module ) ) );

    # set up communication channels
    stdin := InputTextUser();
    outputs := List( [ 1 .. Length( degree_list ) ] );

    # iterate over all degree layers
    for i in [ 1 .. Length( degree_list ) ] do

      buffer := "";
      stdout := OutputTextString( buffer, true );

      # this the string that we need to address cohomCalg
      # not that the degrees used by CAP describe the degree of the generators of the module
      # this is related by (-1) to the degree of the corresponding bundle, as used by cohomCalg
      # -> therefore an additional (-1) is used in the following command
      command_string := SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_INTERNAL_COHOMCALG_COMMAND_STRING(
                                    variety, (-1) * UnderlyingListOfRingElements( degree_list[ i ][ 1 ] ) );

      # execute cohomCalg with the 'input file' described by the command_string
      # we use the integrated mode, so that only the necessary output is generated
      Process( cohomCalg[1], cohomCalg[2], stdin, stdout, ["--integrated", command_string ] );

      # make a number of adjustments to this string
      buffer := ReplacedString( buffer, "{", "[" );
      buffer := ReplacedString( buffer, "}", "]" );

      # check if something went wrong during the computation
      if buffer[ 2 ] = 'F' then

        Error( Concatenation( "cohomCalg experienced an error while computing the cohomologies of the bundle ",
                              String( degree_list[ i ][ 1 ] ) ) );
        return;

      else

        buffer[ 2 ] := 't';

      fi;

      # cut off the information, which specifies which rationoms contribute to which cohomology classes
      position := Positions( buffer, '[' )[ 4 ];
      buffer := List( [ 1 .. position-2 ], j -> buffer[ j ] );
      Add( buffer, ']' );
      Add( buffer, ']' );

      # now evaluate the string buffer
      buffer := EvalString( buffer );

      # and assign this new value
      outputs[ i ] := degree_list[ i ][ 2 ] * buffer[ 2 ][ 1 ];

    od;

    # now process the outputs and format them as wished by the user
    dimensions :=  Sum( outputs );
    if not vector_spaces_wished then
      return dimensions;
    else
      Q := HomalgFieldOfRationals();
      return List( [ 1 .. Length( dimensions ) ], i -> VectorSpaceObject( dimensions[ i ], Q ) );
    fi;

end );

InstallMethod( AllCohomologiesFromCohomCalg,
               "for a toric variety and a projective f.p. graded S-module",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ],
  function( variety, module )

    return AllCohomologiesFromCohomCalg( variety, module, false );

end );

InstallMethod( AllCohomologiesFromCohomCalg,
               "for a toric variety and a projective f.p. graded S-module",
               [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsBool ],
  function( variety, module, vector_spaces_wished )

    return AllCohomologiesFromCohomCalg( variety,
                                         ApplyFunctor( EmbeddingOfProjCategory( CapCategory( module ) ), module ),
                                         vector_spaces_wished
                                        );

end );

InstallMethod( AllCohomologiesFromCohomCalg,
               "for a toric variety and a projective f.p. graded S-module",
               [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject ],
  function( variety, module )

    return AllCohomologiesFromCohomCalg( variety,
                                         ApplyFunctor( EmbeddingOfProjCategory( CapCategory( module ) ), module ),
                                         false
                                        );

end );
