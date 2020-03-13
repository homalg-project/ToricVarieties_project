#! @Chapter Localized truncations of graded rows or columns

#! @Section Examples

LoadPackage( "TruncationsOfFPGradedModules" );

#! We can perform localized truncations of graded rows:
if false then
#! @Example
Q := HomalgFieldOfRationalsInSingular();;
S := GradedRing( Q * "x_1, x_2, x_3, x_4" );;
SetWeightsOfIndeterminates( S, [[1,0],[1,0],[0,1],[0,1]] );;
vars := IndeterminatesOfPolynomialRing( S );;
row := GradedRow( [ [[1,1],2] ], S );;
new_row := LocalizedDegreeZero( row, [ 1,3 ] );;
IsWellDefined( new_row );
#! true
#! @EndExample

#! Similarly, we can compute localized truncations of graded row morphisms:

#! @Example
ideal := LeftIdealForCAP( [ vars[ 1 ] * vars[ 3 ], vars[ 1 ] * vars[ 4 ],
                            vars[ 2 ] * vars[ 3 ], vars[ 2 ] * vars[ 4 ] ], S );;
IsWellDefined( ideal );
#! true
mor := RelationMorphism( ideal );;
new_mor := LocalizedDegreeZero( mor, [ 1,3 ] );;
IsWellDefined( new_mor );
#! true
#! @EndExample

#! Here is another example, where we compute the localized truncation of a morphism of graded rows:

#! @Example
Q := HomalgFieldOfRationalsInSingular();;
S := GradedRing( Q * "x_1, x_2, x_3, x_4" );;
SetWeightsOfIndeterminates( S, [[1,-7],[0,1],[1,0],[0,1]] );;
S2 := Localized_degree_zero_ring_and_generators( S, [ 1,2 ] );;
M := HomalgMatrix( "[ x_1*x_2^7, x_3, x_1*x_4^8, 0 ]", 2,2, S );;
range := GradedRow( [ [[0,0],2] ], S );;
mor := DeduceSomeMapFromMatrixAndRangeForGradedRows( M, range );;
new_mor := LocalizedDegreeZero( mor, [ 1, 2 ] );;
IsWellDefined( new_mor );
#! true
#! @EndExample


#! Here is another example which should be placed in the graded rows and columns
fi;
#! @Example
S := HomalgFieldOfRationalsInSingular() * "x1..3";;
S := GradedRing( S );;
SetWeightsOfIndeterminates( S, [1,1,2] );;
vars := IndeterminatesOfPolynomialRing( S );;
mons := Localized_degree_zero_monomials( S, [3] );;
Length( mons );
#! 3
source := GradedRow( [ [[ 0 ], 2 ] ], S );;
IsWellDefined( LocalizedDegreeZero( source, [ 3 ] ) );
#! true
range := GradedRow( [ [[ 1 ], 1 ] ], S );;
IsWellDefined( LocalizedDegreeZero( range, [ 3 ] ) );
#! true
matrix := HomalgMatrix( [ [ vars[ 1 ] ], [ vars[ 2 ] ] ], S );;
mor := GradedRowOrColumnMorphism( source, matrix, range );;
IsWellDefined( mor );
#! true
mor2 := LocalizedDegreeZero( mor, [ 3 ] );;
IsWellDefined( mor2 );
#! true
#! @EndExample
