################################################################################################
##
##  CohomologyTools.gi          SheafCohomologyOnToricVarieties package
##
##  Copyright 2020              Martin Bies,       University of Oxford
##
#! @Chapter Tools for cohomology computations
##
################################################################################################



##############################################################################################
##
##  Section Approximation Of Sheaf Cohomologies
##
##############################################################################################

InstallMethod( BPowerLeft,
               "a toric variety, a non-negative integer",
               [ IsToricVariety, IsInt ],
  function( variety, power )
    local generators, generators_power;

    # check input
    if power < 0 then
      Error( "The power must not be negative" );
      return;
    fi;

    # compute the power-th Frobenius power of the irrelevant left ideal
    generators := GeneratorsOfIrrelevantIdeal( variety );
    generators_power := List( [ 1 .. Length( generators ) ], i -> generators[ i ]^power );
    return LeftIdealForCAP( generators_power, CoxRing( variety ) );

end );

InstallMethod( BPowerRight,
               "a toric variety, a non-negative integer",
               [ IsToricVariety, IsInt ],
  function( variety, power )
    local generators, generators_power;

    # check input
    if power < 0 then
      Error( "The power must not be negative" );
      return;
    fi;

    # compute the power-th Frobenius power of the irrelevant left ideal
    generators := GeneratorsOfIrrelevantIdeal( variety );
    generators_power := List( [ 1 .. Length( generators ) ], i -> generators[ i ]^power );
    return RightIdealForCAP( generators_power, CoxRing( variety ) );

end );

InstallMethod( ApproxH0,
               "a toric variety, a non-negative integer",
               [ IsToricVariety, IsInt, IsFpGradedLeftOrRightModulesObject, IsBool ],
  function( variety, e, module, display_messages )
    local left, vec_space_morphism;

    # check if we are computing for a left-module
    left := IsFpGradedLeftModulesObject( module );

    # compute vec_space_morphism
    if left then
      vec_space_morphism := TruncateInternalHomToZero( variety, BPowerLeft( variety, e ), module, display_messages, 
                                                         SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_FIELD );
    else
      vec_space_morphism := TruncateInternalHomToZero( variety, BPowerRight( variety, e ), module, display_messages, 
                                                         SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_FIELD );
    fi;

    # return the cokernel object
    return CokernelObject( RelationMorphism( vec_space_morphism ) );

end );

InstallMethod( ApproxH0,
               "a toric variety, a non-negative integer",
               [ IsToricVariety, IsInt, IsFpGradedLeftOrRightModulesObject ],
  function( variety, e, module )

    return ApproxH0( variety, e, module, false );
end );

InstallMethod( ApproxH0Parallel,
               "a toric variety, a non-negative integer",
               [ IsToricVariety, IsInt, IsFpGradedLeftOrRightModulesObject, IsBool ],
  function( variety, e, module, display_messages )
    local left, vec_space_morphism;

    # check if we are computing for a left-module
    left := IsFpGradedLeftModulesObject( module );

    # compute vec_space_morphism
    if left then
      vec_space_morphism := TruncateInternalHomToZeroInParallel( variety, BPowerLeft( variety, e ), module, display_messages,
      SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_FIELD );
    else
      vec_space_morphism := TruncateInternalHomToZeroInParallel( variety, BPowerRight( variety, e ), module, display_messages, SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_FIELD );
    fi;

    # return the cokernel object
    return CokernelObject( RelationMorphism( vec_space_morphism ) );

end );

InstallMethod( ApproxH0Parallel,
               "a toric variety, a non-negative integer",
               [ IsToricVariety, IsInt, IsFpGradedLeftOrRightModulesObject ],
  function( variety, e, module )

    return ApproxH0Parallel( variety, e, module, false );
end );


InstallMethod( ApproxHi,
               "a toric variety, a non-negative integer",
               [ IsToricVariety, IsInt, IsInt, IsFpGradedLeftOrRightModulesObject, IsBool ],
  function( variety, index, e, module, display_messages )
    local left, vec_space_morphism;

    # check if the index is in the correct range
    if index < 0 then
      Error( "The cohomology index must not be negative" );
      return;
    elif index > Dimension( variety ) then
      Error( "The cohomology index must not be larger than the dimension of the variety" );
      return;
    fi;

    # check if we are computing for a left-module
    left := IsFpGradedLeftModulesObject( module );

    # compute vec_space_morphism
    if left then
      vec_space_morphism := TruncateGradedExtToZero( index, variety, BPowerLeft( variety, e ), module, display_messages, SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_FIELD );
    else
      vec_space_morphism := TruncateGradedExtToZero( index, variety, BPowerRight( variety, e ), module, display_messages, SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_FIELD );
    fi;

    # return the cokernel object
    return CokernelObject( RelationMorphism( vec_space_morphism ) );

end );

InstallMethod( ApproxHi,
               "a toric variety, a non-negative integer",
               [ IsToricVariety, IsInt, IsInt, IsFpGradedLeftOrRightModulesObject ],
  function( variety, index, e, module )

    return ApproxHi( variety, index, e, module, false );

end );

InstallMethod( ApproxHiParallel,
               "a toric variety, a non-negative integer",
               [ IsToricVariety, IsInt, IsInt, IsFpGradedLeftOrRightModulesObject, IsBool ],
  function( variety, index, e, module, display_messages )
    local left, vec_space_morphism;

    # check if the index is in the correct range
    if index < 0 then
      Error( "The cohomology index must not be negative" );
      return;
    elif index > Dimension( variety ) then
      Error( "The cohomology index must not be larger than the dimension of the variety" );
      return;
    fi;

    # check if we are computing for a left-module
    left := IsFpGradedLeftModulesObject( module );

    # compute vec_space_morphism
    if left then
      vec_space_morphism := TruncateGradedExtToZeroInParallel( index, variety, BPowerLeft( variety, e ), module, display_messages, SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_FIELD );
    else
      vec_space_morphism := TruncateGradedExtToZeroInParallel( index, variety, BPowerRight( variety, e ), module, display_messages, SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_FIELD );
    fi;

    # return the cokernel object
    return CokernelObject( RelationMorphism( vec_space_morphism ) );

end );

InstallMethod( ApproxHiParallel,
               "a toric variety, a non-negative integer",
               [ IsToricVariety, IsInt, IsInt, IsFpGradedLeftOrRightModulesObject ],
  function( variety, index, e, module )

    return ApproxHiParallel( variety, index, e, module, false );

end );
