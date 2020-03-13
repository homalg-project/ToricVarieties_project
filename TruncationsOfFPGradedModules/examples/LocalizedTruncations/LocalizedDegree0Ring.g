#! @Chapter Localized degree-0 rings

#! @Section Examples

LoadPackage( "TruncationsOfFPGradedModules" );

#! We can localize a graded ring and then truncate it to a given degree. Here is an example:

#! @Example
Q := HomalgFieldOfRationalsInSingular();;
S := GradedRing( Q * "x_1, x_2, x_3, x_4" );;
SetWeightsOfIndeterminates( S, [[1,0],[1,0],[0,1],[0,1]] );;
Length( Localized_degree_zero_monomials( S, [ 1,3 ] ) );
#! 2
Localized_degree_zero_ring( S, [ 1,3 ] );
#! Q[t1,t2]
#! @EndExample
