################################################################################################
##
##  SRAndIRForCAP.gd.gi        SheafCohomologyOnToricVarieties package
##
##  Copyright 2020             Martin Bies,       University of Oxford
##
##  Stanley Reisner and irrelevant ideal as FPGradedModules
##
################################################################################################


####################################################################
##
## Section Irrelevant ideal via FPGradedModules
##
####################################################################

InstallMethod( GeneratorsOfIrrelevantIdeal,
               " for toric varieties",
               [ IsFanRep ],
  function( variety )
    local cox_ring, maximal_cones, indeterminates, irrelevant_ideal, i, j;
    
    # extract the necessary information
    cox_ring := CoxRing( variety );
    maximal_cones := RaysInMaximalCones( FanOfVariety( variety ) );
    indeterminates := Indeterminates( cox_ring );
    
    # initialise the list of generators of the irrelvant ideal
    irrelevant_ideal := [ 1 .. Length( maximal_cones ) ];
    
    # and now compute these generators
    for i in [ 1 .. Length( maximal_cones ) ] do
        
        irrelevant_ideal[ i ] := 1;
        
        for j in [ 1 .. Length( maximal_cones[ i ] ) ] do
            
            irrelevant_ideal[ i ] := irrelevant_ideal[ i ] * indeterminates[ j ]^( 1 - maximal_cones[ i ][ j ] );
            
        od;
        
    od;
    
    return irrelevant_ideal;

end );

InstallMethod( IrrelevantLeftIdealForCAP,
               " for toric varieties",
               [ IsFanRep ],
  function( variety )

    return LeftIdealForCAP( GeneratorsOfIrrelevantIdeal( variety ), CoxRing( variety ) );

end );

InstallMethod( IrrelevantRightIdealForCAP,
               " for toric varieties",
               [ IsFanRep ],
  function( variety )

    return RightIdealForCAP( GeneratorsOfIrrelevantIdeal( variety ), CoxRing( variety ) );

end );


####################################################################
##
## Section Stanley-Reisner ideal via FPGradedModules
##
####################################################################

InstallMethod( GeneratorsOfSRIdeal,
               " for toric varieties",
               [ IsToricVariety ],
  function( variety )
    local cox_ring, primitive_collections, SR_generators, I, k, buffer;

    # identify the Cox ring
    cox_ring := CoxRing( variety );

    # compute primitive collections of the fan
    primitive_collections := PrimitiveCollections( FanOfVariety( variety ) );

    # form monomial from the primivite collections
    SR_generators := [];
    for I in primitive_collections do
        buffer := Indeterminates( CoxRing( variety ) )[ I[ 1 ] ];
        for k in [ 2 .. Length( I ) ] do
           buffer := buffer * Indeterminates( CoxRing( variety ) )[ I[ k ] ];
        od;
        Add( SR_generators, buffer );
    od;

    return SR_generators;

end );

InstallMethod( SRLeftIdealForCAP,
               " for toric varieties",
               [ IsToricVariety ],
  function( variety )

    return LeftIdealForCAP( GeneratorsOfSRIdeal( variety ), CoxRing( variety ) );

end );

InstallMethod( SRRightIdealForCAP,
               " for toric varieties",
               [ IsToricVariety ],
  function( variety )

    return RightIdealForCAP( GeneratorsOfSRIdeal( variety ), CoxRing( variety ) );

end );


####################################################################
##
## Section FPGraded left and right modules over the Cox ring
##
####################################################################

# f.p. graded left S-modules category
InstallMethod( FpGradedLeftModules,
               " for toric varieties",
               [ IsToricVariety ],
  function( variety )

    return FpGradedLeftModules( CoxRing( variety ) );

end );

# f.p. graded right S-modules category
InstallMethod( FpGradedRightModules,
               " for toric varieties",
               [ IsToricVariety ],
  function( variety )

    return FpGradedRightModules( CoxRing( variety ) );

end );
