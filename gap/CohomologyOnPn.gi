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