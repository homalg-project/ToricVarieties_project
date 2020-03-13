#! @Chapter Localized truncations of FPGradedModules

#! @Section Examples

LoadPackage( "TruncationsOfFPGradedModules" );

#! We can perform localized truncations of fp graded modules:

#! @Example
Q := HomalgFieldOfRationalsInSingular();;
S := GradedRing( Q * "x_1, x_2, x_3, x_4" );;
SetWeightsOfIndeterminates( S, [[1,0],[1,0],[0,1],[0,1]] );;
vars := IndeterminatesOfPolynomialRing( S );;
ideal := LeftIdealForCAP( [ vars[ 1 ] * vars[ 3 ], vars[ 1 ] * vars[ 4 ],
                            vars[ 2 ] * vars[ 3 ], vars[ 2 ] * vars[ 4 ] ], S );;
IsWellDefined( ideal );
#! true
new_ideal := LocalizedDegreeZero( ideal, [ 1,3 ] );;
IsWellDefined( new_ideal );
#! true
#! @EndExample

#! We can also compute localized truncations of fp graded module morphisms:

#! @Example
pr := WeakCokernelProjection( RelationMorphism( ideal ) );;
range := AsFreydCategoryObject( Range( pr ) );;
mor := FreydCategoryMorphism( ideal, pr, range );;
new_mor := LocalizedDegreeZero( mor, [ 1,3 ] );;
IsWellDefined( new_mor );
#! true
#! @EndExample

LoadPackage( "ToricSheaves" );
