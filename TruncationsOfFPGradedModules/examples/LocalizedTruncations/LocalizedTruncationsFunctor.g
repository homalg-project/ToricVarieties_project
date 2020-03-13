#! @Chapter Functors for localized truncations to degree 0

#! @Section Examples

LoadPackage( "TruncationsOfFPGradedModules" );

#! We can compute the truncation functors for graded rows, graded columns and f.p. graded modules:

#! @Example
Q := HomalgFieldOfRationalsInSingular();;
S := GradedRing( Q * "x_1, x_2, x_3, x_4" );;
SetWeightsOfIndeterminates( S, [[1,0],[1,0],[0,1],[0,1]] );;
f1 := LocalizedTruncationFunctorForGradedRows( S, [ 1 ] );;
f2 := LocalizedTruncationFunctorForGradedColumns( S, [ 1 ] );;
f3 := LocalizedTruncationFunctorForFPGradedLeftModules( S, [ 1 ] );;
f4 := LocalizedTruncationFunctorForFPGradedRightModules( S, [ 1 ] );;
#! @EndExample
