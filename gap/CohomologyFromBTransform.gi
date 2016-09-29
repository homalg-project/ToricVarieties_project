#############################################################################
##
##  CohomologyFromBTransform.gi         ToricVarieties package
##
##  Copyright 2015- 2016, Sebastian Gutsche, TU Kaiserslautern
##                        Martin Bies,       ITP Heidelberg
##
##  Cohomology via B-transform
##
#############################################################################



####################################################################################
##
#! @Section The ideal and B-transform
##
####################################################################################

# computing the ideal transform of a left presentation with respect to a graded left ideal
InstallMethod( IdealTransform,
               " for a CAP presentation category object and a graded left ideal",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsGradedLeftOrRightIdealForCAP, IsBool, IsBool ],
  function( variety, module, ideal, frobenius_powers_wished, display_messages )
    local cox_ring, left, iota, buffer_mapping, power;

    # collect basic information
    cox_ring := CoxRing( variety );

    # check the rest of the input for validity
    left := IsGradedLeftIdealForCAP( ideal );
    if not IsIdenticalObj( UnderlyingHomalgGradedRing( UnderlyingMorphism( module ) ), cox_ring ) then

      Error( "The module has to be defined over the Cox ring of the variety" );
      return;

    elif not IsIdenticalObj( HomalgGradedRing( ideal ), cox_ring ) then

      Error( "The ideal has to be defined in the Cox ring of the variety" );
      return;

    elif left <> IsCAPCategoryOfProjectiveGradedLeftModulesMorphism( UnderlyingMorphism( module ) ) then

      Error( "The ideal and the presentation must both be left or both be right" );
      return;

    elif not IsSmooth( variety ) then

      Error( "Currently, the computation of DegreeXLayers is only supported on smooth and complete varieties" );
      return;

    elif not IsComplete( variety ) then

      Error( "Currently, the computation of DegreeXLayers is only supported on smooth and complete varieties" );
      return;

    fi;

    # COMMENT:
    # We look at the following:
    # 0 -> GradedHom( S, M ) -> GradedHom( I, M ) -> GradedHom( I^2, M ) -> ...
    # Here we intent do find a non-negative integer k such that GradedHom( I^k, M ) -> GradedHom( B^{I+1}, M ) is an iso.
    # Once such an integer is found, Hom( B^k, M ) will give us H^0( Sheafify( M ) ) and is therefore returned.
    #
    # Note that it is not sufficient to compute a non-negative integer k such that Hom( B^k, M ) -> Hom( B^{k+1}, M ) is an iso.
    # It may for example happen that the sequence Hom( B^*, M ) looks as
    # 0 -> 0 -> 0 -> 0 -> 115...
    # Then 0 -> 0 is an iso, but H0( M ) \neq 0!

    # COMMENT2:
    # This approach should be equivalent to Saturation of the module. Thus it makes no sense to first saturate the module and
    # then go through this computation.

    # initialise iota
    iota := EmbeddingInSuperObjectForCAP( ideal );

    # initialise the buffer_mapping: Hom( S, module ) -> Hom( I, module )
    buffer_mapping := InternalHomOnMorphisms( iota, IdentityMorphism( module ) );
    buffer_mapping := ByASmallerPresentation( buffer_mapping );

    # set the current ideal power
    power := 1;

    while not IsIsomorphism( buffer_mapping ) do

      # compute the ideal embedding
      if frobenius_powers_wished then

        iota := Lift( EmbeddingInSuperObjectForCAP( FrobeniusPower( ideal, power+1 ) ),
                      EmbeddingInSuperObjectForCAP( FrobeniusPower( ideal, power ) ) 
                     );

      else

        iota := Lift( EmbeddingInSuperObjectForCAP( ideal^( power+1 ) ),
                      EmbeddingInSuperObjectForCAP( ideal^power ) 
                     );

      fi;

      # increase the power
      power := power + 1;

      # compute the new buffer_mapping
      buffer_mapping := InternalHomOnMorphisms( iota, IdentityMorphism( module ) );
      buffer_mapping := ByASmallerPresentation( buffer_mapping );

    od;

    # now compute the degree 0 layer of buffer_mapping
    buffer_mapping := DegreeXLayer( variety, buffer_mapping, TheZeroElement( DegreeGroup( cox_ring ) ), display_messages );

    # and then return the cokernel object of its source
    return CokernelObject( UnderlyingMorphism( Source( buffer_mapping ) ) );

end );

# computing the ideal transform of a left presentation with respect to a graded left ideal
InstallMethod( IdealTransform,
               " for a CAP presentation category object and a graded left ideal",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsGradedLeftOrRightIdealForCAP, IsBool ],
  function( variety, module, ideal, frobenius_powers_wished )

    return IdealTransform( variety, module, ideal, frobenius_powers_wished, false );

end );

# computing the ideal transform of a left presentation with respect to a graded left ideal
InstallMethod( IdealTransform,
               " for a CAP presentation category object and a graded left ideal",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsGradedLeftOrRightIdealForCAP ],
  function( variety, module, ideal )

    return IdealTransform( variety, module, ideal, true, false );

end );

# compute H^0 from the B-transform
InstallMethod( H0FromBTransform,
               " for toric varieties, a graded module presentation and a boolean ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool, IsBool ],
  function( variety, module_presentation, frobenius_powers_wished, display_messages )
  local cox_ring, left;

    # check that the input is valid to work with
    cox_ring := CoxRing( variety );
    if not IsSmooth( variety ) then

      Error( "This method is currently only supported for smooth and complete varieties" );
      return;

    elif not IsComplete( variety ) then

      Error( "This method is currently only supported for smooth and complete varieties" );
      return;

    elif not IsIdenticalObj( cox_ring, UnderlyingHomalgGradedRing( UnderlyingMorphism( module_presentation ) ) ) then

      Error( "The module presentation must be defined over the Cox ring of the variety in question" );
      return;

    fi;

    # determine if we are dealing with a left or right_presentation
    left := IsCAPCategoryOfProjectiveGradedLeftModulesMorphism( UnderlyingMorphism( module_presentation ) );

    # now compute the corresponding ideal transform
    if left then

       return IdealTransform(
                     variety, module_presentation, IrrelevantLeftIdealForCAP( variety ), frobenius_powers_wished, display_messages );

    else

       return IdealTransform( 
                     variety, module_presentation, IrrelevantRightIdealForCAP( variety ), frobenius_powers_wished, display_messages );

    fi;

end );

InstallMethod( H0FromBTransform, 
               " for toric varieties, a graded ideal and a boolean ",
               [ IsToricVariety, IsGradedLeftOrRightSubmoduleForCAP, IsBool, IsBool ],
  function( variety, submodule, frobenius_powers_wished, display_messages )

    return H0FromBTransform( variety, PresentationForCAP( submodule ), frobenius_powers_wished, display_messages );

end );

InstallMethod( H0FromBTransform,
               " for toric varieties, a graded module presentation and a boolean ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool ],
  function( variety, module, frobenius_powers_wished )

    return H0FromBTransform( variety, module, frobenius_powers_wished, false );

end );

InstallMethod( H0FromBTransform, 
               " for toric varieties, a graded ideal and a boolean ",
               [ IsToricVariety, IsGradedLeftOrRightSubmoduleForCAP, IsBool ],
  function( variety, submodule, frobenius_powers_wished )

    return H0FromBTransform( variety, PresentationForCAP( submodule ), frobenius_powers_wished, false );

end );


InstallMethod( H0FromBTransform,
               " for toric varieties, a graded module presentation and a boolean ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ],
  function( variety, module )

    return H0FromBTransform( variety, module, true, false );

end );

InstallMethod( H0FromBTransform, 
               " for toric varieties, a graded ideal and a boolean ",
               [ IsToricVariety, IsGradedLeftOrRightSubmoduleForCAP ],
  function( variety, submodule )

    return H0FromBTransform( variety, PresentationForCAP( submodule ), true, false );

end );



########################################################################################
##
#! @Section Computation of B-transform for the GradedModules package
##
########################################################################################

# compute H^0 from the B-transform
InstallMethod( H0FromBTransform, 
               " for toric varieties, a f.p. graded S-module, a non-negative integer",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsInt ],
  function( variety, module, index )
    local B, BPower, GH, zero;

    # check that the input is valid to work with
    if not IsSmooth( variety ) then

      Error( "Variety must be smooth for this method to work." );
      return;

    elif not IsComplete( variety ) then

      Error( "Variety must be complete for this method to work." );
      return;

    elif index < 0 then

      Error( "Index must be a non-negative integer." );
      return;

    fi;

    # generate the necessary information for the computation
    B := IrrelevantIdeal( variety );
    BPower := GradedLeftSubmodule( List( EntriesOfHomalgMatrix( MatrixOfSubobjectGenerators( B ) ), a -> a^(index) ) );	
    GH := ByASmallerPresentation( GradedHom( BPower, module ) );
    zero := List( [ 1..Rank( ClassGroup( variety ) ) ], x -> 0 );

    # compute the degree 0 part of the GradedHom under consideration
    return DegreeXLayerOfFPGradedModuleForGradedModules( variety, GH, zero );

end );

# compute H^0 from the B-transform
InstallMethod( H0FromBTransformInInterval, 
               " for toric varieties, a f.p. graded S-module, a non-negative integer",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsInt, IsInt ],
  function( variety, module, min, max )
    local B, BPower, GH, zero, results, i;

    # check that the input is valid to work with
    if not IsSmooth( variety ) then
        
      Error( "Variety must be smooth for this method to work." );
      return;

    elif not IsComplete( variety ) then
        
      Error( "Variety must be complete for this method to work." );
      return;
    
    elif min < 0 then

      Error( "min must not be negative." );
      return; 

    elif not min <= max then

      Error( "max must not be smaller than min" );
      return;

    fi;

    # generate the necessary information for the computation
    B := IrrelevantIdeal( variety );
    zero := List( [ 1..Rank( ClassGroup( variety ) ) ], x -> 0 );

    # compute the elements of B-transfor for min <= index <= max
    results := [];    
    for i in [ min .. max ] do

      BPower := GradedLeftSubmodule( List( EntriesOfHomalgMatrix( MatrixOfSubobjectGenerators( B ) ), a -> a^( i ) ) );	
      GH := ByASmallerPresentation( GradedHom( BPower, module ) );
      Add( results, DegreeXLayerOfFPGradedModuleForGradedModules( variety, GH, zero ) );

    od;
    
    # return the resulting list 'results'
    return results;

end );

InstallMethod( H0FromBTransform, 
               " for toric varieties, a f.p. graded S-module",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep ],
  function( variety, module )
    local mSat, B, l, BPower, iota_small, iota_big, emb, GH;

    # check that the input is valid to work with
    if not IsSmooth( variety ) then

      Error( "Variety must be smooth for this method to work." );
      return;

    elif not IsComplete( variety ) then

      Error( "Variety must be complete for this method to work." );
      return;

    fi;

    # if the input is a right module, turn it into a left one
    if IsHomalgRightObjectOrMorphismOfRightObjects( module ) then
      module := GradedHom( module, CoxRing( variety ) );
    fi;

    # start the computation of the B-transform
    B := IrrelevantIdeal( variety );
    l := 1;
    BPower := GradedLeftSubmodule( List( EntriesOfHomalgMatrix( MatrixOfSubobjectGenerators( B ) ), a -> a^l ) );	
    emb := EmbeddingInSuperObject( BPower );
    SetIsMorphism( emb, true );
    GH := ByASmallerPresentation( GradedHom( emb, mSat ) );

    # compute the correct l to determine H^0( module )
    while not IsIsomorphism( GH ) do

        # remember the old embedding
        iota_small := EmbeddingInSuperObject( BPower );
        SetIsMorphism( iota_small, true );
        
        # increase power
        l := l + 1;
        
        # compute new embedding
        BPower := GradedLeftSubmodule( List( EntriesOfHomalgMatrix( MatrixOfSubobjectGenerators( B ) ), a -> a^l ) );
        iota_big := EmbeddingInSuperObject( BPower );
        SetIsMorphism( iota_big, true );
        
        # compute the embedding 'oldBPower' -> 'newBPower'
        emb := PostDivide( iota_big, iota_small );
        SetIsMorphism( emb, true );
        
        # and compute the induce map of graded homs
        GH := ByASmallerPresentation( GradedHom( emb, mSat ));
        
    od;

    # finally return the result
    return DegreeXLayerOfFPGradedModuleForGradedModules( 
                                              variety, 
                                              Source( GH ),
                                              UnderlyingListOfRingElements( TheZeroElement( DegreeGroup( CoxRing( variety ) ) ) )
                                              );

end );