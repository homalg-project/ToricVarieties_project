##########################################################################################
##
##  TruncationsOfFPGradedModules.gi        SheafCohomologyOnToricVarieties package
##
##  Copyright 2019                         Martin Bies,       ULB Brussels
##
#! @Chapter Truncations of f.p. graded modules
##
#########################################################################################


##############################################################################################
##
#! @Section Truncations of fp graded modules
##
##############################################################################################

InstallMethod( TruncateFPGradedModule,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsList ],
  function( variety, graded_module, degree )

      return FreydCategoryObject(
                TruncateGradedRowOrColumnMorphism( variety, RelationMorphism( graded_module ), degree ) );

end );

InstallMethod( TruncateFPGradedModule,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsHomalgModuleElement ],
  function( variety, graded_module, degree )

      return FreydCategoryObject(
                TruncateGradedRowOrColumnMorphism( variety, RelationMorphism( graded_module ), degree ) );

end );

InstallMethod( TruncateFPGradedModule,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsList, IsBool ],
  function( variety, graded_module, degree, display_messages )

      return FreydCategoryObject(
                TruncateGradedRowOrColumnMorphism( variety, RelationMorphism( graded_module ), degree, display_messages ) );

end );

InstallMethod( TruncateFPGradedModule,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsHomalgModuleElement, IsBool ],
  function( variety, graded_module, degree, display_messages )

      return FreydCategoryObject(
                TruncateGradedRowOrColumnMorphism( variety, RelationMorphism( graded_module ), degree, display_messages ) );

end );

InstallMethod( TruncateFPGradedModule,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsList, IsBool, IsFieldForHomalg ],
  function( variety, graded_module, degree, display_messages, rationals )

      return FreydCategoryObject(
                TruncateGradedRowOrColumnMorphism(
                                          variety, RelationMorphism( graded_module ), degree, display_messages, rationals ) );

end );

InstallMethod( TruncateFPGradedModule,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsHomalgModuleElement, IsBool, IsFieldForHomalg ],
  function( variety, graded_module, degree, display_messages, rationals )

      return FreydCategoryObject(
                TruncateGradedRowOrColumnMorphism(
                                          variety, RelationMorphism( graded_module ), degree, display_messages, rationals ) );

end );



##############################################################################################
##
#! @Section Truncations of fp graded modules in parallel
##
##############################################################################################

InstallMethod( TruncateFPGradedModuleInParallel,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsList, IsPosInt ],
  function( variety, graded_module, degree, NrJobs )

      return FreydCategoryObject(
                TruncateGradedRowOrColumnMorphismInParallel( variety, RelationMorphism( graded_module ), degree, NrJobs ) );

end );

InstallMethod( TruncateFPGradedModuleInParallel,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsHomalgModuleElement, IsPosInt ],
  function( variety, graded_module, degree, NrJobs )

      return FreydCategoryObject(
                TruncateGradedRowOrColumnMorphismInParallel( variety, RelationMorphism( graded_module ), degree, NrJobs ) );

end );

InstallMethod( TruncateFPGradedModuleInParallel,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsList, IsPosInt, IsBool ],
  function( variety, graded_module, degree, NrJobs, display_messages )

      return FreydCategoryObject(
                TruncateGradedRowOrColumnMorphismInParallel(
                                              variety, RelationMorphism( graded_module ), degree, NrJobs, display_messages ) );

end );

InstallMethod( TruncateFPGradedModuleInParallel,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsHomalgModuleElement, IsPosInt, IsBool ],
  function( variety, graded_module, degree, NrJobs, display_messages )

      return FreydCategoryObject(
                TruncateGradedRowOrColumnMorphismInParallel(
                                             variety, RelationMorphism( graded_module ), degree, NrJobs, display_messages ) );

end );

InstallMethod( TruncateFPGradedModuleInParallel,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsList, IsPosInt, IsBool, IsFieldForHomalg ],
  function( variety, graded_module, degree, NrJobs, display_messages, rationals )

      return FreydCategoryObject(
                TruncateGradedRowOrColumnMorphismInParallel(
                                   variety, RelationMorphism( graded_module ), degree, NrJobs, display_messages, rationals ) );

end );

InstallMethod( TruncateFPGradedModuleInParallel,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsHomalgModuleElement, IsPosInt, IsBool, IsFieldForHomalg ],
  function( variety, graded_module, degree, NrJobs, display_messages, rationals )

      return FreydCategoryObject(
                TruncateGradedRowOrColumnMorphismInParallel(
                                  variety, RelationMorphism( graded_module ), degree, NrJobs, display_messages, rationals ) );

end );



##############################################################################################
##
#! @Section Truncations of fp graded module morphisms
##
##############################################################################################

InstallMethod( TruncateFPGradedModuleMorphism,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsList, IsBool, IsFieldForHomalg ] );
  function( variety, graded_module_morphism, degree, display_messages, rationals )
    local source, map, range;

    # truncate source, map and range
    source := FreydCategoryObject(
                TruncateGradedRowOrColumnMorphism(
                     variety, RelationMorphism( Source( graded_module_morphism ) ), degree, display_message, rationals ) );
    map := TruncateGradedRowOrColumnMorphism( 
                     variety, MorphismDatum( graded_module_morphism ), degree, display_message, rationals );
    range := FreydCategoryObject(
                TruncateGradedRowOrColumnMorphism(
                     variety, RelationMorphism( Range( graded_module_morphism ) ), degree, display_message, rationals ) );

    # and return the result
    return FreydCategoryMorphism( source, map, range );

end );

InstallMethod( TruncateFPGradedModuleMorphism,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsHomalgModuleElement, IsBool, IsFieldForHomalg ] );
  function( variety, graded_module_morphism, degree, display_messages, rationals )

      return TruncateFPGradedModuleMorphism( variety,
                                             graded_module_morphism,
                                             UnderlyingListOfRingElements( degree ),
                                             display_messages,
                                             rationals );

end );

InstallMethod( TruncateFPGradedModuleMorphism,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsList, IsBool ] );
  function( variety, graded_module_morphism, degree, display_messages )

      return TruncateFPGradedModuleMorphism( variety,
                                             graded_module_morphism,
                                             degree,
                                             display_messages,
                                             CoefficientsRing( CoxRing( variety ) ) );

end );

InstallMethod( TruncateFPGradedModuleMorphism,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsHomalgModuleElement, IsBool ] );
  function( variety, graded_module_morphism, degree, display_messages )

      return TruncateFPGradedModuleMorphism( variety,
                                             graded_module_morphism,
                                             UnderlylingListOfRingElements( degree ),
                                             display_messages,
                                             CoefficientsRing( CoxRing( variety ) ) );

end );

InstallMethod( TruncateFPGradedModuleMorphism,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsList ] );
  function( variety, graded_module_morphism, degree, display_messages )

      return TruncateFPGradedModuleMorphism( variety,
                                             graded_module_morphism,
                                             degree,
                                             false,
                                             CoefficientsRing( CoxRing( variety ) ) );

end );

InstallMethod( TruncateFPGradedModuleMorphism,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsHomalgModuleElement ],
  function( variety, graded_module_morphism, degree )

    return TruncateFPGradedModuleMorphism( variety,
                                           graded_module_morphism,
                                           UnderlyingListOfRingElements( degree ),
                                           false,
                                           CoefficientsRing( CoxRing( variety ) ) );

end );


##############################################################################################
##
#! @Section Truncations of fp graded module morphisms in parallel
##
##############################################################################################

InstallMethod( TruncateFPGradedModuleMorphismInParallel,
               " a toric variety, an f.p. graded module, a list specifying a degree ",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsList, IsList, IsBool, IsFieldForHomalg ] );
  function( variety, graded_module_morphism, degree, NrJobs, display_messages, rationals )
    local source, map, range;

    # first check that the user specified meaningful NrJobs
    if not Length( NrJobs ) = 3 then
      Error( "NrJobs must be a list of 3 positive integers" );
      return;
    fi;

    if not ForAll( NrJobs, IsPosInt ) then
      Error( "NrJobs must be a list of 3 positive integers" );
      return;
    fi;

    # now truncate in parallel

    # truncate source, map and range
    source := FreydCategoryObject(
                TruncateGradedRowOrColumnMorphism(
                     variety, RelationMorphism( Source( graded_module_morphism ) ), degree, display_message, rationals ) );
    map := TruncateGradedRowOrColumnMorphism( 
                     variety, MorphismDatum( graded_module_morphism ), degree, display_message, rationals );
    range := FreydCategoryObject(
                TruncateGradedRowOrColumnMorphism(
                     variety, RelationMorphism( Range( graded_module_morphism ) ), degree, display_message, rationals ) );

    # and return the result
    return FreydCategoryMorphism( source, map, range );

end );
