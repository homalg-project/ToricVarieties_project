#! @Chapter Conversion among f.p. graded modules

#! @Section Examples

#! @Subsection Conversion of modules

LoadPackage( "ToolsForFPGradedModules" );

#! We can turn the modules provided by the legendary GradedModules package into the ones provided by FreydCategories:
#! @Example
Q := HomalgFieldOfRationalsInSingular();;
S := GradedRing( Q * "x_1, x_2, x_3, x_4" );;
SetWeightsOfIndeterminates( S, [[1,0],[1,0],[0,1],[0,1]] );;
vars := IndeterminatesOfPolynomialRing( S );;
irP1xP1 := LeftIdealForCAP( [ vars[ 1 ] * vars[ 3 ], vars[ 1 ] * vars[ 4 ],
                              vars[ 2 ] * vars[ 3 ], vars[ 2 ] * vars[ 4 ] ], S );;
IsWellDefined( irP1xP1 );
#! true
module2 := TurnIntoOldGradedModule( irP1xP1 );
#! <A graded left module presented by 4 relations for 4 generators>
module3 := TurnIntoCAPGradedModule( module2 );
#! <An object in Category of f.p. graded left
#! modules over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
module3 = irP1xP1;
#! true
#! @EndExample

#! We can also turn left into right modules:

#! @Example
graded_row := GradedRow( [ [[1,1],2],[[-1,0],1] ], S );;
graded_col := TurnIntoGradedColumn( graded_row );;
graded_row2 := TurnIntoGradedRow( graded_col );;
IsEqualForObjects( graded_row, graded_row2 );
#! true
irP1xP1_right := TurnIntoFpGradedRightModule( irP1xP1 );;
irP1xP1_2 := TurnIntoFpGradedLeftModule( irP1xP1_right );;
IsEqualForObjects( irP1xP1, irP1xP1_2 );
#! true
#! @EndExample

#! Likewise, we can turn morphisms of left modules into morphisms of right modules and vice versa:

#! @Example
mor := RelationMorphism( irP1xP1 );;
mor_right := TurnIntoGradedColumnMorphism( mor );;
mor2 := TurnIntoGradedRowMorphism( mor_right );;
IsEqualForMorphisms( mor, mor2 );
#! true
k := WeakCokernelProjection( RelationMorphism( irP1xP1 ) );;
range := AsFreydCategoryObject( Range( k ) );;
fp_mor := FreydCategoryMorphism( irP1xP1, k, range );;
fp_mor_right := TurnIntoFpGradedRightModuleMorphism( fp_mor );;
fp_mor2 := TurnIntoFpGradedLeftModuleMorphism( fp_mor_right );;
IsEqualForMorphisms( fp_mor, fp_mor2 );
#! true
#! @EndExample
