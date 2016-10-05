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