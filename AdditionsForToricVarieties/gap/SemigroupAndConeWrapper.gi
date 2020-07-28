####################################################################################
##
##  SemigroupAndConeWrapper.gd   AdditionsForToricVarieties package
##
##  Copyright 2020               Martin Bies,       University of Oxford
##
##  Wrapper for generators of semigroups and hyperplane constraints of cones
##
####################################################################################


############################################
##
##  Section GAP Categories
##
############################################

##
DeclareRepresentation( "IsSemigroupForPresentationsByProjectiveGradedModulesRep",
                       IsSemigroupForPresentationsByProjectiveGradedModules and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfSemigroupsForPresentationsByProjectiveGradedModules",
        NewFamily( "TheFamilyOfSemigroupsForPresentationsByProjectiveGradedModules" ) );

BindGlobal( "TheTypeOfSemigroupForPresentationsByProjectiveGradedModules",
        NewType( TheFamilyOfSemigroupsForPresentationsByProjectiveGradedModules,
                IsSemigroupForPresentationsByProjectiveGradedModulesRep ) );


##
DeclareRepresentation( "IsAffineSemigroupForPresentationsByProjectiveGradedModulesRep",
                       IsAffineSemigroupForPresentationsByProjectiveGradedModules and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfAffineSemigroupsForPresentationsByProjectiveGradedModules",
        NewFamily( "TheFamilyOfAffineSemigroupsForPresentationsByProjectiveGradedModules" ) );

BindGlobal( "TheTypeOfAffineSemigroupsForPresentationsByProjectiveGradedModules",
        NewType( TheFamilyOfAffineSemigroupsForPresentationsByProjectiveGradedModules,
                IsAffineSemigroupForPresentationsByProjectiveGradedModulesRep ) );



############################################
##
## Section Constructors
##
############################################

InstallMethod( SemigroupForPresentationsByProjectiveGradedModules,
               [ IsList, IsInt ],
  function( list_of_generators, embedding_dimension )
    local helper_list, i, j, cone, hpres, sg;

    if embedding_dimension < 0 then
      Error( "the embedding dimension cannot be negative" );
      return;
    fi;

    # we have to check that 
    # (1) all entries of the list_of_generators are of the same length 'embedding_dimension'
    # (2) all entries are integers

    # @ (1)
    helper_list := DuplicateFreeList( 
                           List( [ 1 .. Length( list_of_generators ) ], i -> Length( list_of_generators[ i ] ) ) );
    if Length( helper_list ) > 1 then
      Error( "all generators have to be of the same length");
      return;
    elif helper_list[ 1 ] <> embedding_dimension then
      Error( Concatenation( "the generators must be of the length", String( embedding_dimension ) ) );
      return;
    fi;

    # @ (2)
    for i in [ 1 .. Length( list_of_generators ) ] do

      for j in [ 1 .. Length( list_of_generators[ i ] ) ] do

        if not IsInt( list_of_generators[ i ][ j ] ) then
          Error( "the entries of all generators must be integers" );
          return;
        fi;

      od;

    od;

    # cone-semigroup?
    if DecideIfIsConeSemigroupGeneratorList( list_of_generators ) then

      # now try to compute the ConeHPresentation list associated to the associated cone
      cone := NmzCone( [ "integral_closure", list_of_generators ] );

      # check if the cone is full-dimensional, so that normaliz can compute an H-presentation
      NmzCompute( cone );
      if NmzRank( cone ) <> NmzEmbeddingDimension( cone ) then
        hpres := fail;
      else
        hpres := NmzSupportHyperplanes( cone );
      fi;

      # now objectify with these presentations
      sg := rec();
      ObjectifyWithAttributes( sg, TheTypeOfSemigroupForPresentationsByProjectiveGradedModules,
                               GeneratorList, DuplicateFreeList( list_of_generators ),
                               EmbeddingDimension, embedding_dimension,
                               ConeHPresentationList, hpres
                            );

      # set AffineConeSemigroup property
      SetIsSemigroupOfCone( sg, true );

    else

      # now objectify with these presentations
      sg := rec();
      ObjectifyWithAttributes( sg, TheTypeOfSemigroupForPresentationsByProjectiveGradedModules,
                               GeneratorList, DuplicateFreeList( list_of_generators ),
                               EmbeddingDimension, embedding_dimension
                            );

      # set AffineConeSemigroup property
      SetIsSemigroupOfCone( sg, false );

    fi;

    # decide if the semigroup is empty
    if Length( GeneratorList( sg ) ) = 0 then
      SetIsTrivial( sg, true );
    else
      SetIsTrivial( sg, false );
    fi;

    # and return the resulting object
    return sg;

end );

# convenience method which deduces the embedding dimension (if possible) from a given list of generators
InstallMethod( SemigroupForPresentationsByProjectiveGradedModules,
               [ IsList ],
  function( list_of_generators )

    if Length( list_of_generators ) = 0 then
      Error( "the embedding dimension cannot be deduced uniquely from the given list of semigroup generators" );
      return;
    else
      return SemigroupForPresentationsByProjectiveGradedModules( list_of_generators, Length( list_of_generators[ 1 ] ) );
    fi;

end );

# constructor for affine semigroup
InstallMethod( AffineSemigroupForPresentationsByProjectiveGradedModules,
               [ IsSemigroupForPresentationsByProjectiveGradedModules, IsList ],
  function( semigroup_for_CAP, offset_point )
    local conversion, i, affine_semigroup;

    # check input
    if not Length( offset_point ) = EmbeddingDimension( semigroup_for_CAP ) then
      Error( "The offset_point and the semigroup are not embedded into isomorphic lattices" );
      return;
    fi;
    for i in [ 1 .. Length( offset_point ) ] do
      if not IsInt( offset_point[ i ] ) then
        Error( "The offset_point must be given as a list of integers" );
        return;
      fi;
    od;

    # we have found that the input is valid, so collect the information that we need about the cone
    affine_semigroup := rec();
    ObjectifyWithAttributes( affine_semigroup, TheTypeOfAffineSemigroupsForPresentationsByProjectiveGradedModules,
                             UnderlyingSemigroup, semigroup_for_CAP,
                             Offset, offset_point,
                             EmbeddingDimension, Length( offset_point )
                            );

    # check if this affine_semigroup is trivial
    if IsTrivial( semigroup_for_CAP ) then
      SetIsTrivial( affine_semigroup, true );
    else
      SetIsTrivial( affine_semigroup, false );
    fi;

    # decide if this is an AffineConeSemigroup
    if IsSemigroupOfCone( semigroup_for_CAP ) then
      SetIsAffineSemigroupOfCone( affine_semigroup, true );
    else
      SetIsAffineSemigroupOfCone( affine_semigroup, false );
    fi;

    # and return this object
    return affine_semigroup;

end );

# convenience-constructor I
InstallMethod( AffineSemigroupForPresentationsByProjectiveGradedModules,
               [ IsList, IsList ],
  function( semigroup_generators, offset_point )

    return AffineSemigroupForPresentationsByProjectiveGradedModules( 
                   SemigroupForPresentationsByProjectiveGradedModules( semigroup_generators ),
                   offset_point );

end );

# convenience-constructor II
InstallMethod( AffineSemigroupForPresentationsByProjectiveGradedModules,
               [ IsList, IsInt, IsList ],
  function( semigroup_generators, embedding_dimension, offset_point )

    return AffineSemigroupForPresentationsByProjectiveGradedModules( 
                   SemigroupForPresentationsByProjectiveGradedModules( semigroup_generators, embedding_dimension ),
                   offset_point );

end );



####################################
##
## String
##
####################################

InstallMethod( String,
              [ IsSemigroupForPresentationsByProjectiveGradedModules ],
  function( semigroup_for_CAP )

    # if empty
    if IsTrivial( semigroup_for_CAP ) then
      return Concatenation( "A trivial semigroup in of Z^",
                             String( EmbeddingDimension( semigroup_for_CAP ) ) 
                           );
    # otherwise
    else
      if Length( GeneratorList( semigroup_for_CAP ) ) = 1 then

        if IsSemigroupOfCone( semigroup_for_CAP ) = true then
          return Concatenation( "A cone-semigroup in Z^",
                                String( EmbeddingDimension( semigroup_for_CAP ) ),
                                " formed as the span of 1 generator"
                               );
        elif IsSemigroupOfCone( semigroup_for_CAP ) = false then
          return Concatenation( "A non-cone semigroup in Z^",
                                String( EmbeddingDimension( semigroup_for_CAP ) ),
                                " formed as the span of 1 generator"
                               );
        else
          return Concatenation( "A semigroup in Z^",
                                String( EmbeddingDimension( semigroup_for_CAP ) ),
                                " formed as the span of 1 generator"
                               );
        fi;

      else

        if IsSemigroupOfCone( semigroup_for_CAP ) = true then
          return Concatenation( "A cone-semigroup in Z^",
                                String( EmbeddingDimension( semigroup_for_CAP ) ),
                                " formed as the span of ",
                                String( Length( GeneratorList( semigroup_for_CAP ) ) ),
                                " generators"
                               );
        elif IsSemigroupOfCone( semigroup_for_CAP ) = false then
          return Concatenation( "A non-cone semigroup in Z^",
                                String( EmbeddingDimension( semigroup_for_CAP ) ),
                                " formed as the span of ",
                                String( Length( GeneratorList( semigroup_for_CAP ) ) ),
                                " generators"
                               );
        else
          return Concatenation( "A semigroup in Z^",
                                String( EmbeddingDimension( semigroup_for_CAP ) ),
                                " formed as the span of ",
                                String( Length( GeneratorList( semigroup_for_CAP ) ) ),
                                " generators"
                               );
        fi;

      fi;

    fi;

end );

InstallMethod( String,
              [ IsAffineSemigroupForPresentationsByProjectiveGradedModules ],
  function( affine_semigroup_for_CAP )

    if IsTrivial( affine_semigroup_for_CAP ) then
      return Concatenation( "A trivial affine semigroup in Z^",
                             String( EmbeddingDimension( affine_semigroup_for_CAP ) ) );
    else
      if IsAffineSemigroupOfCone( affine_semigroup_for_CAP ) = true then
        return Concatenation( "A non-trivial affine cone-semigroup in Z^",
                              String( EmbeddingDimension( affine_semigroup_for_CAP ) ) );
      elif IsAffineSemigroupOfCone( affine_semigroup_for_CAP ) = false then
        return Concatenation( "A non-trivial affine non-cone semigroup in Z^",
                              String( EmbeddingDimension( affine_semigroup_for_CAP ) ) );
      else
        return Concatenation( "A non-trivial affine semigroup in Z^",
                              String( EmbeddingDimension( affine_semigroup_for_CAP ) ) );
      fi;
    fi;

end );



####################################
##
## Display
##
####################################

InstallMethod( Display,
               [ IsSemigroupForPresentationsByProjectiveGradedModules ],
  function( semigroup_for_CAP )

    if IsTrivial( semigroup_for_CAP ) then
      Print( Concatenation( String( semigroup_for_CAP ), "\n" ) );
    else
      if IsSemigroupOfCone( semigroup_for_CAP ) = true then
        Print( Concatenation( String( semigroup_for_CAP ), " - Hilbert basis is as follows: \n" ) );
        Display( GeneratorList( semigroup_for_CAP ) );
        Print( "\n" );
      else
        Print( Concatenation( String( semigroup_for_CAP ), " - generators are as follows: \n" ) );
        Display( GeneratorList( semigroup_for_CAP ) );
        Print( "\n" );
      fi;
    fi;

end );

InstallMethod( Display,
              [ IsAffineSemigroupForPresentationsByProjectiveGradedModules ],
  function( affine_semigroup_for_CAP )

    if IsTrivial( affine_semigroup_for_CAP ) then
      Print( Concatenation( String( affine_semigroup_for_CAP ), "\n" ) );
      Print( Concatenation( "Offset: ", String( Offset( affine_semigroup_for_CAP ) ), "\n" ) );
    else
      if IsAffineSemigroupOfCone( affine_semigroup_for_CAP ) = true then
        Print( Concatenation( String( affine_semigroup_for_CAP ), "\n" ) );
        Print( Concatenation( "Offset: ", String( Offset( affine_semigroup_for_CAP ) ), "\n" ) );
        Print( Concatenation( "Hilbert basis: ",
               String( GeneratorList( UnderlyingSemigroup( affine_semigroup_for_CAP ) ) ) ) );
        Print( "\n" );
      else
        Print( Concatenation( String( affine_semigroup_for_CAP ), "\n" ) );
        Print( Concatenation( "Offset: ", String( Offset( affine_semigroup_for_CAP ) ), "\n" ) );
        Print( Concatenation( "Semigroup generators: ",
               String( GeneratorList( UnderlyingSemigroup( affine_semigroup_for_CAP ) ) ) ) );
        Print( "\n" );
      fi;
    fi;

end );



####################################
##
## ViewObj
##
####################################

InstallMethod( ViewObj,
               [ IsSemigroupForPresentationsByProjectiveGradedModules ],
  function( semigroup_for_CAP )

    Print( Concatenation( "<", String( semigroup_for_CAP ), ">" ) );

end );

InstallMethod( ViewObj,
              [ IsAffineSemigroupForPresentationsByProjectiveGradedModules ],
  function( affine_semigroup_for_CAP )

    Print( Concatenation( "<", String( affine_semigroup_for_CAP ), ">" ) );

end );



############################################
##
##  Section Operations
##
############################################

InstallMethod( DecideIfIsConeSemigroupGeneratorList,
               "for semigroup_generator_lists",
               [ IsList ],
  function( list_of_original_generators )
    local list_of_generators, cone, hilbert_basis, i, pos;

    # extract the necessary data
    list_of_generators := DuplicateFreeList( list_of_original_generators );
    cone := NmzCone( [ "integral_closure", list_of_generators ] );
    NmzCompute( cone );

    # check if Normaliz can compute a Hilbert basis
    if not NmzHasConeProperty( cone, "HilbertBasis" ) then

      return fail;

    fi;

    # then extract the Hilbet basis
    hilbert_basis := NmzHilbertBasis( cone );

    # now compare list_of_generators and hilbert_basis modulo potential permutations
    if Length( hilbert_basis ) > Length( list_of_generators ) then
      return false;
    fi;

    # scan over list_of_generators
    # for each generator see if find a counterpart in hilbert_basis
    # then delete this counter_part
    for i in [ 1 .. Length( list_of_generators ) ] do

      pos := Position( hilbert_basis, list_of_generators[ i ] );
      if pos <> fail then
        Remove( hilbert_basis, pos );
      fi;

    od;

    # and give the final answer
    return Length( hilbert_basis ) = 0;

end );



#############################################################################
##
##  Section Check if point is contained in cone or an affine (cone) semigroup
##
#############################################################################

# check if a point lies in a subsemigroup
InstallMethod( PointContainedInSemigroup,
               " for a subsemigroup for CAP and a list of integers ",
               [ IsSemigroupForPresentationsByProjectiveGradedModules, IsList ],
  function( semigroup_for_CAP, point )
    local res, cone_h_presentation_list, i, constraint;

    # check if the point lies in the same lattice as the affine_cone_semigroup
    if Length( point ) <> EmbeddingDimension( semigroup_for_CAP ) then
      Error( "The point and the semigroup are not embedded into the same lattice" );
      return;
    fi;

    # check if semigroup is trivial
    # if so, then the point lies in the semigroup iff point = [ 0,...,0 ]
    if IsTrivial( semigroup_for_CAP ) then
      if point = List( [ 1 .. Length( point ) ], k -> 0 ) then
        return true;
      fi;
    fi;

    # next check if we have an H-presentation
    if IsSemigroupOfCone( semigroup_for_CAP ) and HasConeHPresentationList( semigroup_for_CAP ) then

      # isolate the h-constraints
      cone_h_presentation_list := ConeHPresentationList( semigroup_for_CAP );

      # next compute the hyperplane constraints
      for i in [ 1..Length( cone_h_presentation_list ) ] do

        # compute constraint
        constraint := Sum( List( [ 1..Length( cone_h_presentation_list[ i ] ) ], 
                                             x -> cone_h_presentation_list[ i ][ x ] * point[ x ] ) );

        # if non-negative, the point satisfies this constraint
        if constraint < 0 then
	  return false;
        fi;

      od;

      # all tests passed, so return true
      return true;

    else

      # we have to work with 4ti2 to decide membership

      # Recall that subsemigroup_generators are given as = [ gen1, gens2, ..., genN ].
      # For use by 4ti2Interface, we need to transpose this list, i.e. the generators are written in the columns
      res := 4ti2Interface_zsolve_equalities_and_inequalities_in_positive_orthant(
                                           TransposedMat( GeneratorList( semigroup_for_CAP ) ), point, [], [] );

      # the first entry of the returned list expresses the point in terms of the generators (if such a solution exists)
      # so the first entry has length 0 precisely if the point is NOT contained in the subsemigroup
      if Length( res[ 1 ] ) = 0 then
        return false;
      else
        return true;
      fi;

    fi;

end );

# check if a point satisfies hyperplane constraints for a cone, thereby determining if the point lies in the cone
InstallMethod( PointContainedInAffineSemigroup,
               " for an affine semigroup and a list specifying a point ",
               [ IsAffineSemigroupForPresentationsByProjectiveGradedModules, IsList ],
  function( affine_semigroup_for_CAP, point )

   return PointContainedInSemigroup( UnderlyingSemigroup( affine_semigroup_for_CAP ), 
                                     point - Offset( affine_semigroup_for_CAP ) 
                                    );

end );
