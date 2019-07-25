################################################################################################
##
##  ToricVarietiesAdditionalPropertiesForCAP.gi        SheafCohomologyOnToricVarieties package
##
##  Copyright 2019                                     Martin Bies,       ULB Brussels
##
#! @Chapter Additional methods/properties for toric varieties
##
################################################################################################


###################################################################################
##
##  Define Global variables
##
###################################################################################

SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_INTERNAL_LAZY := true;


######################
##
#! @Section Properties
##
######################

InstallMethod( IsValidInputForCohomologyComputations,
               " for a toric variety",
               [ IsToricVariety ],

  function( variety )
    local result;

    # initialise value
    result := true;
    
    # check that the variety matches our general requirements
    if SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_INTERNAL_LAZY then

      if not ( ( IsSmooth( variety ) and IsComplete( variety ) ) or 
               ( IsSimplicial( FanOfVariety( variety ) ) and IsProjective( variety ) ) ) then

        result := false;

      fi;

    else

      if not ( IsSmooth( variety ) and IsComplete( variety ) ) then
      
        result := false;

      fi;

    fi;

    # and return result
    return result;

end );


######################
##
#! @Section Attributes
##
######################

InstallMethod( IrrelevantLeftIdealForCAP,
               " for toric varieties",
               [ IsFanRep ],
  function( variety )
    local cox_ring, maximal_cones, indeterminates, irrelevant_ideal, i, j, matrix, range, alpha;
    
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
    
    # construct the ideal with generators encoded in 'irrelevant_ideal'
    matrix := HomalgMatrix( TransposedMat( [ irrelevant_ideal ] ), cox_ring );
    range := GradedRow( [ [ TheZeroElement( DegreeGroup( cox_ring ) ), NrColumns( matrix ) ] ], cox_ring );
    alpha := DeduceMapFromMatrixAndRangeForGradedRows( matrix, range );

    if not IsWellDefined( alpha ) then
      Error( "Cannot deduce underlying morphism of graded rows from the given input." );
      return;
    fi;

    return FreydCategoryObject( KernelEmbedding( alpha ) );

end );

InstallMethod( IrrelevantRightIdealForCAP,
               " for toric varieties",
               [ IsFanRep ],
  function( variety )
    local cox_ring, maximal_cones, indeterminates, irrelevant_ideal, i, j, matrix, range, alpha;
    
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
    
    # construct the ideal with generators encoded in 'irrelevant_ideal'
    matrix := HomalgMatrix( [ irrelevant_ideal ], cox_ring );
    range := GradedColumn( [ [ TheZeroElement( DegreeGroup( cox_ring ) ), NrColumns( matrix ) ] ], cox_ring );
    alpha := DeduceMapFromMatrixAndRangeForGradedCols( matrix, range );

    if not IsWellDefined( alpha ) then
      Error( "Cannot deduce underlying morphism of graded rows from the given input." );
      return;
    fi;

    return FreydCategoryObject( KernelEmbedding( alpha ) );

end );

InstallMethod( SRLeftIdealForCAP,
               " for toric varieties",
               [ IsToricVariety ],
  function( variety )
    local cox_ring, primitive_collections, SR_generators, I, k, buffer, SR_ideal, matrix, range, alpha;

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

    # construct the ideal with generators encoded in 'irrelevant_ideal'
    matrix := HomalgMatrix( TransposedMat( [ SR_generators ] ), cox_ring );
    range := GradedRow( [ [ TheZeroElement( DegreeGroup( cox_ring ) ), NrColumns( matrix ) ] ], cox_ring );
    alpha := DeduceMapFromMatrixAndRangeForGradedRows( matrix, range );

    if not IsWellDefined( alpha ) then
      Error( "Cannot deduce underlying morphism of graded rows from the given input." );
      return;
    fi;

    return FreydCategoryObject( KernelEmbedding( alpha ) );

end );

InstallMethod( SRRightIdealForCAP,
               " for toric varieties",
               [ IsToricVariety ],
  function( variety )
    local cox_ring, primitive_collections, SR_generators, I, k, buffer, SR_ideal, matrix, range, alpha;

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

    # construct the ideal with generators encoded in 'irrelevant_ideal'
    matrix := HomalgMatrix( [ SR_generators ], cox_ring );
    range := GradedColumn( [ [ TheZeroElement( DegreeGroup( cox_ring ) ), NrColumns( matrix ) ] ], cox_ring );
    alpha := DeduceMapFromMatrixAndRangeForGradedCols( matrix, range );

    if not IsWellDefined( alpha ) then
      Error( "Cannot deduce underlying morphism of graded rows from the given input." );
      return;
    fi;

    return FreydCategoryObject( KernelEmbedding( alpha ) );

end );

# f.p. graded left S-modules category
InstallMethod( SfpgrmodLeft,
               " for toric varieties",
               [ IsToricVariety ],
  function( variety )

    return FpGradedLeftModules( CoxRing( variety ) );

end );

# f.p. graded right S-modules category
InstallMethod( SfpgrmodRight,
               " for toric varieties",
               [ IsToricVariety ],
  function( variety )

    return FpGradedRightModules( CoxRing( variety ) );

end );
