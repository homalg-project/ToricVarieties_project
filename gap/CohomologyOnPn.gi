###################################################################################
##
##  CohomologyOnPn.gi         ToricVarieties package
##
##  Copyright 2015- 2016, Sebastian Gutsche, TU Kaiserslautern
##                        Martin Bies,       ITP Heidelberg
##
##  Chapter Sheaf cohomology computations on (direct products of) projective spaces
##
###################################################################################



########################################################
##
## Methods specialised to cohomology computations on P^N
##
########################################################

# compute H0 of a given bundle via linear regularity
InstallMethod( H0OnProjectiveSpaceViaLinearRegularity,
               " for a toric variety and graded left module",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep ],
  function( variety, module )
    local m, deltaMd, mPower, H0Func;

    # check if the input is valid
    if not IsProjectiveSpace( variety ) then

      Error( "The variety has to be a projective space to allow for the application of linear regularity" );
      return;

    fi;

    #compute the maximal ideal
    m := IrrelevantIdeal( variety );

    #determine deltaMd according to lemma 4.2 in 1409.6100 - this is the critical line
    deltaMd := Maximum( 0, LinearRegularity( module ) + 1 );

    #compute the linRegIndex'th Frobenius power of m
    mPower := GradedLeftSubmodule( List( EntriesOfHomalgMatrix( MatrixOfSubobjectGenerators( m ) ), a -> a^(deltaMd) ) );	
	
    #compute H0-function
    H0Func := HilbertFunction( ByASmallerPresentation( GradedHom( mPower, module ) ) );

    # return only H^0 of the bundle asked by the user, however we know H^0 also for the positive twists of that bundle
    return H0Func( 0 );
 
end );


# compute H0 of bundle and all its positive twists via linear regularity
InstallMethod( H0OnProjectiveSpaceForAllPositiveTwistsViaLinearRegularity,
               " for a toric variety and graded left module",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep ],
  function( variety, module )
    local m, deltaMd, mPower, H0Func;

    # check if the input is valid
    if not IsProjectiveSpace( variety ) then
    
      Error( "The variety has to be a projective space to allow for the application of linear regularity" );
      return;
    
    fi;

    #compute the maximal ideal
    m := IrrelevantIdeal( variety );

    #determine deltaMd according to lemma 4.2 - this is the critical line
    deltaMd := Maximum( 0, LinearRegularity( module ) + 1 );

    #compute the linRegIndex'th Frobenius power of m
    mPower := GradedLeftSubmodule( List( EntriesOfHomalgMatrix( MatrixOfSubobjectGenerators( m ) ), a -> a^(deltaMd) ) );	
	
    #compute H0
    H0Func := HilbertFunction( ByASmallerPresentation( GradedHom( mPower, module ) ) );

    # return only H^0 of the bundle asked by the user, however we know H^0 also for the positive twists of that bundle
    return H0Func;
 
end );


# compute H0 of bundle and all positive twists in a certain range via linear regularity
InstallMethod( H0OnProjectiveSpaceInRangeViaLinearRegularity,
               " for a toric variety and graded left module",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsList ],
  function( variety, module, range )
    local m, deltaMd, mPower, H0Func;

    # check if the input is valid
    if not IsProjectiveSpace( variety ) then

      Error( "The variety has to be a projective space to allow for the application of linear regularity" );
      return;

    fi;

    #compute the maximal ideal
    m := IrrelevantIdeal( variety );

    #determine deltaMd according to lemma 4.2 - this is the critical line
    deltaMd := Maximum( 0, LinearRegularity( module ) + 1 );

    #compute the linRegIndex'th Frobenius power of m
    mPower := GradedLeftSubmodule( List( EntriesOfHomalgMatrix( MatrixOfSubobjectGenerators( m ) ), a -> a^(deltaMd) ) );	
	
    #compute H0
    H0Func := HilbertFunction( ByASmallerPresentation( GradedHom( mPower, module ) ) );

    # return only H^0 of the bundle asked by the user, however we know H^0 also for the positive twists of that bundle
    return List( range, x -> [ x, H0Func( x ) ] );
 
end );



##################################################################
##
## Experimental methods for computations on direct products on Pns
##
##################################################################


# compute H0 on a direct product on projective spaces without use of "GradedModules"
InstallMethod( H0OnDirectProductsOfProjectiveSpaces,
               " for toric varieties and a module presentation",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool, IsBool ],
  function( variety, module, saturation_wished, display_messages )
    local left, GS_cone, constituents, cox_ring, var, irrelIdeals, counter, i, idealGenerators, mSat, powers, 
         truncation_functor, l, iota, buffer_mapping, hom_nesting, degree_X_layer_functor, vec_space_presentation;

    # (0): check if the input is valid and if we are dealing with a left or right presentation
    if not IsDirectProductOfPNs( variety ) then

      Error( Concatenation( "The variety has to be a direct product of projective spaces ",
                                   " to allow for application of 'H0OnDirectProductsOfProjectiveSpaces'" ) );
      return;

    fi;


    # (1) collect basic information
    left := IsCAPCategoryOfProjectiveGradedLeftModulesMorphism( UnderlyingMorphism( module ) );
    GS_cone := GSCone( variety );
    constituents := IsProductOf( variety );
    cox_ring := CoxRing( variety );
    var := ListOfVariablesOfCoxRing( variety );


    # (2) compute the irrelevant ideals of the projective spaces, whose direct product is variety
    irrelIdeals := [];
    counter := 0;
    for i in [ 1.. Length( constituents ) ] do

      # create irrelevant ideal of i-th constituent
      idealGenerators := List( [ 1 .. Dimension( constituents[ i ] ) + 1 ], k -> var[ k + counter ] );

      # and add the corresponding ideal
      if left then
        Add( irrelIdeals, GradedLeftSubmoduleForCAP( TransposedMat( [ idealGenerators ] ), cox_ring ) );
      else
        Add( irrelIdeals, GradedRightSubmoduleForCAP( [ idealGenerators ], cox_ring ) );
      fi;

      # and increase counter
      counter := counter + Dimension( constituents[ i ] ) + 1;

    od;


    # (3) Saturate the module
    if saturation_wished then
      if left then
        mSat := Saturate( module, IrrelevantLeftIdealForCAP( variety ) );
      else
        mSat := Saturate( module, IrrelevantRightIdealForCAP( variety ) );
      fi;
    else
      mSat := module;
    fi;


    # (4) compute 'cohomology' with respect to the various constituents
    powers := List( [ 1.. Length( irrelIdeals ) ], x -> 0 );

    for i in [ 1 .. Length( irrelIdeals ) ] do

      # initialise the counters
      l := 0;
      iota := EmbeddingInSuperObjectForCAP( irrelIdeals[ i ] );

      # first: compute Hom( Range( iota ), mSat ) -> Hom( Source( iota ), mSat )
      # second: truncate this map to the GS-cone
      buffer_mapping := InternalHomOnMorphisms( iota, IdentityMorphism( mSat ) );
      buffer_mapping := ByASmallerPresentation( Truncation( buffer_mapping, GS_cone ) );

      # compute the correct l to determine H^0( module )
      while not IsIsomorphism( buffer_mapping ) do

        l := l + 1;
        iota := Lift( EmbeddingInSuperObjectForCAP( irrelIdeals[ i ]^(l+1) ),
                      EmbeddingInSuperObjectForCAP( irrelIdeals[ i ]^l ) 
                     );
        buffer_mapping := InternalHomOnMorphisms( iota, IdentityMorphism( mSat ) );
        buffer_mapping := ByASmallerPresentation( Truncation( buffer_mapping, GS_cone ) );

      od;

      # save the computed power
      powers[ i ] := l;

    od;


    # (5) sort the powers in decreasing order
    powers := List( [ 1 .. Length( powers ) ], i -> [ powers[ i ], PresentationForCAP( irrelIdeals[ i ] ) ] );
    Sort( powers, function( a,b ) return a[ 1 ] > b[ 1 ]; end ); 


    # (6) compute Hom-Nesting
    hom_nesting := InternalHomOnObjects( FrobeniusPower( powers[ 1 ][ 2 ], powers[ 1 ][ 1 ] ), mSat );
    for i in [ 2 .. Length( powers ) ] do

      hom_nesting := ByASmallerPresentation(
                         InternalHomOnObjects( FrobeniusPower( powers[ i ][ 2 ], powers[ i ][ 1 ] ), hom_nesting ) );

    od;


    # (7) truncate to degree zero
    vec_space_presentation := DegreeXLayer( variety, hom_nesting, TheZeroElement( DegreeGroup( cox_ring ) ) );

    # (8) return the cokernel object
    return CokernelObject( UnderlyingMorphism( vec_space_presentation ) );

end );

# compute H0 on a direct product on projective spaces without use of "GradedModules"
InstallMethod( H0OnDirectProductsOfProjectiveSpaces,
               " for toric varieties and a submodule for CAP ",
               [ IsToricVariety, IsGradedLeftOrRightSubmoduleForCAP, IsBool, IsBool ],
  function( variety, submodule, saturation_wished, display_messages )

    return H0OnDirectProductsOfProjectiveSpaces( variety, PresentationForCAP( submodule ), saturation_wished, display_messages );

end );

# compute H0 on a direct product on projective spaces without use of "GradedModules"
InstallMethod( H0OnDirectProductsOfProjectiveSpaces,
               " for toric varieties and a submodule for CAP ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool ],
  function( variety, submodule, saturation_wished )

    return H0OnDirectProductsOfProjectiveSpaces( variety, PresentationForCAP( submodule ), saturation_wished, false );

end );

# compute H0 on a direct product on projective spaces without use of "GradedModules"
InstallMethod( H0OnDirectProductsOfProjectiveSpaces,
               " for toric varieties and a submodule for CAP ",
               [ IsToricVariety, IsGradedLeftOrRightSubmoduleForCAP, IsBool ],
  function( variety, submodule, saturation_wished )

    return H0OnDirectProductsOfProjectiveSpaces( variety, PresentationForCAP( submodule ), saturation_wished, false );

end );

# compute H0 on a direct product on projective spaces without use of "GradedModules"
InstallMethod( H0OnDirectProductsOfProjectiveSpaces,
               " for toric varieties and a module presentation",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ],
  function( variety, module )

    return H0OnDirectProductsOfProjectiveSpaces( variety, module, false, false );

end );

# compute H0 on a direct product on projective spaces without use of "GradedModules"
InstallMethod( H0OnDirectProductsOfProjectiveSpaces,
               " for toric varieties and a submodule for CAP ",
               [ IsToricVariety, IsGradedLeftOrRightSubmoduleForCAP ],
  function( variety, submodule )

    return H0OnDirectProductsOfProjectiveSpaces( variety, PresentationForCAP( submodule ), false, false );

end );



############################################################################################################
##
## Experimental methods for computations on direct products on Pns implemented for the GradedModules Package
##
############################################################################################################


# compute H0 on a direct product on projective spaces
InstallMethod( H0OnDirectProductsOfProjectiveSpaces,
               " for toric varieties and a free graded S-module ",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsBool ],
  function( variety, module, saturation_wished )
    local constituents, i, irrelIdeals, coxRing, counter, var, idealGenerators, irrelIdeal, iota, mSat, Powers, l, 
         helpIdeal, gradedHomConcatenation, zero; 

    # check if it is a direct product of PNs
    if not IsDirectProductOfPNs( variety ) then

      Error( "The variety has to be a direct product of PN's. \n" );
      return false;

    fi;

    # we first need to check that the toric variety is really a product of Pn's, so
    constituents := IsProductOf( variety );

    # compute the Coxring of that variety - typical names for the variables are x_i with i ranging over certain integers
    coxRing := CoxRing( variety );
    var := ListOfVariablesOfCoxRing( variety );

    # now compute the irrelevant ideals of the constituents as embedded into coxRing
    irrelIdeals := [];
    counter := 0;
    for i in [ 1.. Length( constituents ) ] do

      # create irrelevant ideal of i-th constituent
      idealGenerators := List( [ 1 .. Dimension( constituents[ i ] ) + 1 ], k -> var[ k + counter ] );
      Add( irrelIdeals, GradedLeftSubmodule( idealGenerators, coxRing ) );

      # and increase counter
      counter := counter + Dimension( constituents[ i ] ) + 1;

    od;

    # now saturate the module with respect to the irrelevant ideal
    if saturation_wished then
      irrelIdeal := IrrelevantIdeal( variety );
      iota := EmbeddingInSuperObject( irrelIdeal );
      SetIsMorphism( iota, true );
      mSat := GradedHom( CoxRing( variety ), GradedHom( irrelIdeal, module ) );
      while not IsIsomorphism( GradedHom( iota, mSat ) ) do
        mSat := GradedHom( CoxRing( variety ), GradedHom( irrelIdeal, mSat ) );
      od;
    else
      mSat := module;
    fi;

    # now we compute 'cohomology' with respect to the various constituents    
    Powers := List( [ 1.. Length( irrelIdeals ) ] );

    for i in [ 1 .. Length( irrelIdeals ) ] do

      # initialise the counters
      l := 0;
      iota := EmbeddingInSuperObject( irrelIdeals[ i ] );
      SetIsMorphism( iota, true );

      # compute the correct l to determine H^0( module )
      while not IsIsomorphism( 
                        TruncationOfGradedModuleMorphismOnDirectProductsOfProjectiveSpaces( variety, GradedHom( iota, mSat ) ) ) do

        l := l + 1;
        iota := PostDivide( EmbeddingInSuperObject( irrelIdeals[ i ]^(l+1) ), EmbeddingInSuperObject( irrelIdeals[ i ]^l ) );
        SetIsMonomorphism( iota, true );

      od;

      Powers[ i ] := l;

    od;

    # sort the computed powers in decreasing order, keeping track of the associated 'irrelevant' ideal at the same time
    Powers := List( [ 1 .. Length( Powers ) ], i -> [ Powers[ i ], irrelIdeals[ i ] ] );
    Sort( Powers, function( a,b ) return a[ 1 ] > b[ 1 ]; end ); 

    # then compute GradedHom nesting
    helpIdeal := GradedLeftSubmodule( 
                 List( EntriesOfHomalgMatrix( MatrixOfSubobjectGenerators( Powers[ 1 ][ 2 ] ) ), a -> a^(Powers[ 1 ][ 1 ]) ) );    
    gradedHomConcatenation := GradedHom( helpIdeal, mSat );
    for i in [ 2 .. Length( Powers ) ] do

      # compute the next ideal power (it may happen that gradedHomConcatenation is a left or right module, so I have to compute
      # the ideal power correspondingly as left or right module)
      if IsHomalgLeftObjectOrMorphismOfLeftObjects( gradedHomConcatenation ) then

        helpIdeal := GradedLeftSubmodule( 
                 List( EntriesOfHomalgMatrix( MatrixOfSubobjectGenerators( Powers[ 1 ][ 2 ] ) ), a -> a^(Powers[ 1 ][ 1 ]) ) );    

      else

        helpIdeal := GradedRightSubmodule( 
                 List( EntriesOfHomalgMatrix( MatrixOfSubobjectGenerators( Powers[ 1 ][ 2 ] ) ), a -> a^(Powers[ 1 ][ 1 ]) ) );    

      fi;

      # and recompute gradedHomConcatenation
      gradedHomConcatenation := GradedHom( helpIdeal, gradedHomConcatenation );

    od;

    # after this nested computation is complete, finally compute its degree 0 part and thereby the zeroth cohomology class 
    zero := List( [ 1.. Rank( ClassGroup( variety ) ) ], k -> 0 );
    return [ DegreeXLayerOfFPGradedModuleForGradedModules( variety, gradedHomConcatenation, zero ), Powers ];    

end );

# compute H0 on a direct product on projective spaces
InstallMethod( H0OnDirectProductsOfProjectiveSpaces,
               " for toric varieties and a free graded S-module ",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep ],
  function( variety, module )

    return H0OnDirectProductsOfProjectiveSpaces( variety, module, false );

end );