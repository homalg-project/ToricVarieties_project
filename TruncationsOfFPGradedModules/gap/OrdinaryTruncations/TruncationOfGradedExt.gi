##########################################################################################
##
##  TruncationOfGradedExt.gi           TruncationsOfFPGradedModules package
##
##  Copyright 2020                     Martin Bies,    University of Oxford
##
##  Truncations of GradedExt for f.p. graded modules
##
#########################################################################################


##########################################################
##
#! @Section Truncations of InternalHoms of FpGradedModules
##
##########################################################

InstallMethod( TruncateInternalHom,
               " for a toric variety, an f.p. graded module, an f.p. graded module, a bool ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsList, IsBool, IsFieldForHomalg ],
  function( variety, a, b, degree, display_messages, rationals )
      local range, source, map, mor;

      # inform about status
      if display_messages then
        Print( "Compute FpGradedModuleMorphism whose kernel is the InternalHom...\n" );
      fi;

      # determine morphism whose kernel is the InternalHom in question
      source := InternalHomOnMorphisms( IdentityMorphism( Range( RelationMorphism( a ) ) ), RelationMorphism( b ) );
      source := FreydCategoryObject( source );
      range := InternalHomOnMorphisms( IdentityMorphism( Source( RelationMorphism( a ) ) ), RelationMorphism( b ) );
      range := FreydCategoryObject( range );
      map := InternalHomOnMorphisms( RelationMorphism( a ), IdentityMorphism( Range( RelationMorphism( b ) ) ) );
      mor := FreydCategoryMorphism( source, map, range );

      # inform about status again
      if display_messages then
        Print( "Truncate it now... \n\n" );
      fi;

      # and return the truncation
      return KernelObject( TruncateFPGradedModuleMorphism( variety, mor, degree, display_messages, rationals ) );

end );

InstallMethod( TruncateInternalHomEmbedding,
               " for a toric variety, an f.p. graded module, an f.p. graded module, a bool ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsList, IsBool, IsFieldForHomalg ],
  function( variety, a, b, degree, display_messages, rationals )
      local range, source, map, mor;

      # inform about status
      if display_messages then
        Print( "Compute FpGradedModuleMorphism whose kernel is the InternalHom...\n" );
      fi;

      # determine morphism whose kernel is the InternalHom in question
      source := InternalHomOnMorphisms( IdentityMorphism( Range( RelationMorphism( a ) ) ), RelationMorphism( b ) );
      source:= FreydCategoryObject( source );
      range := InternalHomOnMorphisms( IdentityMorphism( Source( RelationMorphism( a ) ) ), RelationMorphism( b ) );
      range := FreydCategoryObject( range );
      map := InternalHomOnMorphisms( RelationMorphism( a ), IdentityMorphism( Range( RelationMorphism( b ) ) ) );
      mor := FreydCategoryMorphism( source, map, range );

      # inform about status again
      if display_messages then
        Print( "Truncate it now... \n\n" );
      fi;

      # and return the truncation
      return KernelEmbedding( TruncateFPGradedModuleMorphism( variety, mor, degree, display_messages, rationals ) );

end );

InstallMethod( TruncateInternalHom,
               " for a toric variety, a f.p. graded left S-module, a f.p. graded left S-module",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsFpGradedLeftOrRightModulesMorphism, IsList, IsBool, IsFieldForHomalg ],
  function( variety, mor1, mor2, degree, display_messages, rationals )
      local ker1, ker2, map, bridge;

      # mor1: A -> A'
      # mor2: B -> B'

      # compute kernel embedding IntHom( A', B );
      if display_messages then
        Print( "Compute FpGradedModuleMorphism whose kernel is InternalHom( A', B )...\n" );
      fi;
      ker1 := TruncateInternalHomEmbedding( variety, Range( mor1 ), Source( mor2 ), degree, display_messages, rationals );

      # compute kernel embedding IntHom( A, B' );
      if display_messages then
        Print( "Compute FpGradedModuleMorphism whose kernel is InternalHom( A, B' )...\n" );
      fi;
      ker2 := TruncateInternalHomEmbedding( variety, Source( mor1 ), Range( mor2 ), degree, display_messages, rationals );

      # check for degenerate cases first
      if Dimension( Range( RelationMorphism( Range( ker1 ) ) ) ) = 0 then
        map := ZeroMorphism( VectorSpaceObject( 0, rationals ),
                             Range( RelationMorphism( Range( ker2 ) ) ) );
      elif Dimension( Range( RelationMorphism( Range( ker2 ) ) ) ) = 0 then
        map  := ZeroMorphism( Range( RelationMorphism( Range( ker1 ) ) ),
                              VectorSpaceObject( 0, rationals ) );
      else
        # and only truncate by brute force if necessary
        map := TensorProductOnMorphisms( DualOnMorphisms( MorphismDatum( mor1 ) ), MorphismDatum( mor2 ) );
        map := TruncateGradedRowOrColumnMorphism( variety, map, degree, display_messages, rationals );
      fi;
      bridge := FreydCategoryMorphism( Range( ker1 ), map, Range( ker2 ) );

      if display_messages then
        Print( "Compute lift...\n" );
      fi;
      return Lift( PreCompose( ker1, bridge ), ker2 );

end );


#########################################################################
##
#! @Section Truncations of InternalHoms of FpGradedModules to degree zero
##
#########################################################################

InstallMethod( TruncateInternalHomToZero,
               " for a toric variety, an f.p. graded module, an f.p. graded module, a bool ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsBool, IsFieldForHomalg ],
  function( variety, a, b, display_messages, rationals )

    return TruncateInternalHom( variety, a, b,
                                UnderlyingListOfRingElements( TheZeroElement( DegreeGroup( CoxRing( variety ) ) ) ),
                                display_messages, rationals );

end );

InstallMethod( TruncateInternalHomEmbeddingToZero,
               " for a toric variety, an f.p. graded module, an f.p. graded module, a bool ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsBool, IsFieldForHomalg ],
  function( variety, a, b, display_messages, rationals )

    return TruncateInternalHomEmbedding( variety, a, b,
                                         UnderlyingListOfRingElements( TheZeroElement( DegreeGroup( CoxRing( variety ) ) ) ),
                                         display_messages, rationals );

end );

InstallMethod( TruncateInternalHomToZero,
               " for a toric variety, a f.p. graded left S-module, a f.p. graded left S-module",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsFpGradedLeftOrRightModulesMorphism, IsBool, IsFieldForHomalg ],
  function( variety, mor1, mor2, display_messages, rationals )

    return TruncateInternalHom( variety, mor1, mor2,
                                UnderlyingListOfRingElements( TheZeroElement( DegreeGroup( CoxRing( variety ) ) ) ), 
                                display_messages, rationals );

end );


######################################################################
##
#! @Section Truncations of InternalHoms of FpGradedModules in parallel
##
######################################################################

InstallMethod( TruncateInternalHomInParallel,
               " for a toric variety, an f.p. graded module, an f.p. graded module, a bool ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsList, IsBool, IsFieldForHomalg ],
  function( variety, a, b, degree, display_messages, rationals )
      local range, source, map, mor;

      # inform about status
      if display_messages then
        Print( "Compute FpGradedModuleMorphism whose kernel is the InternalHom...\n" );
      fi;

      # determine morphism whose kernel is the InternalHom in question
      source := InternalHomOnMorphisms( IdentityMorphism( Range( RelationMorphism( a ) ) ), RelationMorphism( b ) );
      source:= FreydCategoryObject( source );
      range := InternalHomOnMorphisms( IdentityMorphism( Source( RelationMorphism( a ) ) ), RelationMorphism( b ) );
      range := FreydCategoryObject( range );
      map := InternalHomOnMorphisms( RelationMorphism( a ), IdentityMorphism( Range( RelationMorphism( b ) ) ) );
      mor := FreydCategoryMorphism( source, map, range );

      # inform about status again
      if display_messages then
        Print( "Truncate it now... \n\n" );
      fi;

      # and return the truncation
      return KernelObject( TruncateFPGradedModuleMorphismInParallel( variety, mor, degree, [ 2, 2, 3 ], display_messages, rationals ) );

end );

InstallMethod( TruncateInternalHomEmbeddingInParallel,
               " for a toric variety, an f.p. graded module, an f.p. graded module, a bool ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsList, IsBool, IsFieldForHomalg ],
  function( variety, a, b, degree, display_messages, rationals )
      local range, source, map, mor;

      # inform about status
      if display_messages then
        Print( "Compute FpGradedModuleMorphism whose kernel is the InternalHom...\n" );
      fi;

      # determine morphism whose kernel is the InternalHom in question
      source := InternalHomOnMorphisms( IdentityMorphism( Range( RelationMorphism( a ) ) ), RelationMorphism( b ) );
      source:= FreydCategoryObject( source );
      range := InternalHomOnMorphisms( IdentityMorphism( Source( RelationMorphism( a ) ) ), RelationMorphism( b ) );
      range := FreydCategoryObject( range );
      map := InternalHomOnMorphisms( RelationMorphism( a ), IdentityMorphism( Range( RelationMorphism( b ) ) ) );
      mor := FreydCategoryMorphism( source, map, range );

      # inform about status again
      if display_messages then
        Print( "Truncate it now... \n\n" );
      fi;

      # and return the truncation
      return KernelEmbedding( TruncateFPGradedModuleMorphismInParallel( variety, mor, degree, [ 2, 2, 3 ], display_messages, rationals ) );

end );


InstallMethod( TruncateInternalHomInParallel,
               " for a toric variety, a f.p. graded left S-module, a f.p. graded left S-module",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsFpGradedLeftOrRightModulesMorphism, IsList, IsBool, IsFieldForHomalg ],
  function( variety, mor1, mor2, degree, display_messages, rationals )
      local ker1, ker2, map, bridge;

      # mor1: A -> A'
      # mor2: B -> B'

      # compute kernel embedding IntHom( A', B );
      if display_messages then
        Print( "Compute FpGradedModuleMorphism whose kernel is InternalHom( A', B )...\n" );
      fi;
      ker1 := TruncateInternalHomEmbeddingInParallel( variety, Range( mor1 ), Source( mor2 ), degree, display_messages, rationals );

      # compute kernel embedding IntHom( A, B' );
      if display_messages then
        Print( "Compute FpGradedModuleMorphism whose kernel is InternalHom( A, B' )...\n" );
      fi;
      ker2 := TruncateInternalHomEmbeddingInParallel( variety, Source( mor1 ), Range( mor2 ), degree, display_messages, rationals );

      # compute the bridge map
      if display_messages then
        Print( "Compute bridge map...\n" );
      fi;

      # check for degenerate cases first
      if Dimension( Range( RelationMorphism( Range( ker1 ) ) ) ) = 0 then
        map := ZeroMorphism( VectorSpaceObject( 0, rationals ), Range( RelationMorphism( Range( ker2 ) ) ) );
      elif Dimension( Range( RelationMorphism( Range( ker2 ) ) ) ) = 0 then
        map  := ZeroMorphism( Range( RelationMorphism( Range( ker1 ) ) ), VectorSpaceObject( 0, rationals ) );
      else
        # and only truncate by brute force if necessary
        map := TensorProductOnMorphisms( DualOnMorphisms( MorphismDatum( mor1 ) ), MorphismDatum( mor2 ) );
        map := TruncateGradedRowOrColumnMorphismInParallel( variety, map, degree, 3, display_messages, rationals );
      fi;
      bridge := FreydCategoryMorphism( Range( ker1 ), map, Range( ker2 ) );

      # finally compute the lift
      if display_messages then
        Print( "Compute lift...\n" );
      fi;
      return Lift( PreCompose( ker1, bridge ), ker2 );

end );


#####################################################################################
##
#! @Section Truncations of InternalHoms of FpGradedModules to degree zero in parallel
##
#####################################################################################

InstallMethod( TruncateInternalHomToZeroInParallel,
               " for a toric variety, an f.p. graded module, an f.p. graded module, a bool ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsBool, IsFieldForHomalg ],
  function( variety, a, b, display_messages, rationals )

    return TruncateInternalHomInParallel( variety, a, b,
                                          UnderlyingListOfRingElements( TheZeroElement( DegreeGroup( CoxRing( variety ) ) ) ),
                                          display_messages, rationals );

end );

InstallMethod( TruncateInternalHomEmbeddingToZeroInParallel,
               " for a toric variety, an f.p. graded module, an f.p. graded module, a bool ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsBool, IsFieldForHomalg ],
  function( variety, a, b, display_messages, rationals )

    return TruncateInternalHomEmbeddingInParallel( variety, a, b,
                                                 UnderlyingListOfRingElements( TheZeroElement( DegreeGroup( CoxRing( variety ) ) ) ),
                                                 display_messages, rationals );

end );

InstallMethod( TruncateInternalHomToZeroInParallel,
               " for a toric variety, a f.p. graded left S-module, a f.p. graded left S-module",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsFpGradedLeftOrRightModulesMorphism, IsBool, IsFieldForHomalg ],
  function( variety, mor1, mor2, display_messages, rationals )

    return TruncateInternalHomInParallel( variety, mor1, mor2,
                                          UnderlyingListOfRingElements( TheZeroElement( DegreeGroup( CoxRing( variety ) ) ) ), display_messages, rationals );

end );


#############################################################
##
## Section Specialised GradedExt methods
##
#############################################################

InstallMethod( TruncateGradedExt,
               " for an integer, a toric variety, two f.p. graded modules and a bool ",
               [ IsInt, IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsList, IsList ],
  function( i, variety, module1, module2, degree, options )
    local display_messages, rationals, mu, graded_hom_mapping;

    # extract options
    display_messages := options[ 1 ];
    rationals := options[ 2 ];

    # check input
    if i < 0 then
      Error( "the integer i must be non-negative" );
      return;
    elif IsFpGradedLeftModulesObject( module2 ) <> IsFpGradedLeftModulesObject( module1 ) then
      Error( "the two modules must either both be left or both be right modules" );
      return;
    fi;

    # extract i-th morphism in resolution
    if display_messages then
      Print( "Extract 'i-th' morphism in the resolution of first module...\n" );
    fi;

    if i = 0 then
      mu := ZeroMorphism( module1, ZeroObject( CapCategory( module1 ) ) );
    else
      mu := UnderlyingZFunctorCell( MinimalFreeResolutionForCAP( module1 ) )!.differential_func( -i );
      mu := AsFreydCategoryMorphism( mu );
      mu := KernelEmbedding( CokernelProjection( mu ) );
    fi;

    # compute IntHom( Range( mu ), module2 )_0 -> IntHom( Source( mu ), module2 )_0
    if display_messages then
      Print( "Compute morphism IntHom( Range( mu ), module2 )_0 -> IntHom( Source( mu ), module2 )_0...\n" );
    fi;
    graded_hom_mapping := TruncateInternalHom( variety, mu, IdentityMorphism( module2 ), degree, display_messages, rationals );

    # compute cokernel object of the above morphism
    if display_messages then
      Print( "Compute cokernel object...\n" );
    fi;
    return CokernelObject( graded_hom_mapping );

end );

InstallMethod( TruncateGradedExtToZero,
               " for an integer, a toric variety, two f.p. graded modules and a bool ",
               [ IsInt, IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsBool, IsFieldForHomalg ],
  function( i, variety, module1, module2, display_messages, rationals )

    return TruncateGradedExt( i, variety, module1, module2,
                              UnderlyingListOfRingElements( TheZeroElement( DegreeGroup( CoxRing( variety ) ) ) ), 
                              [ display_messages, rationals ] );
end );

InstallMethod( TruncateGradedExtInParallel,
               " for an integer, a toric variety, two f.p. graded modules and a bool ",
               [ IsInt, IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsList, IsList ],
  function( i, variety, module1, module2, degree, options )
    local display_messages, rationals, mu, graded_hom_mapping;

    # extract options
    display_messages := options[ 1 ];
    rationals := options[ 2 ];

    # check input
    if i < 0 then
      Error( "the integer i must be non-negative" );
      return;
    elif IsFpGradedLeftModulesObject( module2 ) <> IsFpGradedLeftModulesObject( module1 ) then
      Error( "the two modules must either both be left or both be right modules" );
      return;
    fi;

    # extract i-th morphism in resolution
    if display_messages then
      Print( "Extract 'i-th' morphism in the resolution of first module...\n" );
    fi;

    if i = 0 then
      mu := ZeroMorphism( module1, ZeroObject( CapCategory( module1 ) ) );
    else
      mu := UnderlyingZFunctorCell( MinimalFreeResolutionForCAP( module1 ) )!.differential_func( -i );
      mu := AsFreydCategoryMorphism( mu );
      mu := KernelEmbedding( CokernelProjection( mu ) );
    fi;

    # compute IntHom( Range( mu ), module2 )_0 -> IntHom( Source( mu ), module2 )_0
    if display_messages then
      Print( "Compute morphism IntHom( Range( mu ), module2 )_0 -> IntHom( Source( mu ), module2 )_0...\n" );
    fi;
    graded_hom_mapping := TruncateInternalHomInParallel( variety, mu, IdentityMorphism( module2 ), degree, display_messages, rationals );

    # compute cokernel object of the above morphism
    if display_messages then
      Print( "Compute cokernel object...\n" );
    fi;
    return CokernelObject( graded_hom_mapping );

end );

InstallMethod( TruncateGradedExtToZeroInParallel,
               " for an integer, a toric variety, two f.p. graded modules and a bool ",
               [ IsInt, IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsBool, IsFieldForHomalg ],
  function( i, variety, module1, module2, display_messages, rationals )

    return TruncateGradedExtInParallel( i, variety, module1, module2,
                                        UnderlyingListOfRingElements( TheZeroElement( DegreeGroup( CoxRing( variety ) ) ) ), 
                                        [ display_messages, rationals ] );
end );
