#! @Chapter Truncations of f.p. graded modules

LoadPackage( "TruncationsOfFPGradedModules" );

#! @Section Examples

#! @Section Truncations of f.p. graded modules

#! @Example
P2 := ProjectiveSpace( 2 );
#! <A projective toric variety of dimension 2>
cox_ring := CoxRing( P2 );
#! Q[x_1,x_2,x_3]
#! (weights: [ 1, 1, 1 ])
source := GradedRow( [[[-1],1]], cox_ring );
#! <A graded row of rank 1>
range := GradedRow( [[[0],1]], cox_ring );
#! <A graded row of rank 1>
vars := IndeterminatesOfPolynomialRing( cox_ring );;
matrix := HomalgMatrix( [[ vars[ 1 ] ]], cox_ring );
#! <A 1 x 1 matrix over a graded ring>
obj1 := FreydCategoryObject(
         GradedRowOrColumnMorphism( source, matrix, range ) );
#! <An object in Category of f.p. graded
#! left modules over Q[x_1,x_2,x_3]
#! (with weights [ 1, 1, 1 ])>
IsWellDefined( obj1 );
#! true
trunc_obj1 := TruncateFPGradedModule( P2, obj1, [ 2 ] );
#! <An object in Freyd( Category of matrices
#! over Q (with weights [ 1 ]) )>
IsWellDefined( trunc_obj1 );
#! true
Display( UnderlyingMatrix( RelationMorphism( trunc_obj1 ) ) );
#! 1,0,0,0,0,0,
#! 0,1,0,0,0,0,
#! 0,0,0,1,0,0
#! (over a graded ring)
trunc_obj2 := TruncateFPGradedModuleInParallel( P2, obj1, [ 2 ], 2 );
#! <An object in Freyd( Category of matrices
#! over Q (with weights [ 1 ]) )>
IsWellDefined( trunc_obj2 );
#! true
Display( UnderlyingMatrix( RelationMorphism( trunc_obj2 ) ) );
#! 1,0,0,0,0,0,
#! 0,1,0,0,0,0,
#! 0,0,0,1,0,0
#! (over a graded ring)
#! @EndExample


#! @Section Truncations of f.p. graded module morphisms

#! @Example
source := GradedRow( [[[-1],1]], cox_ring );
#! <A graded row of rank 1>
range := GradedRow( [[[1],2]], cox_ring );
#! <A graded row of rank 2>
matrix := HomalgMatrix( [[ vars[ 1 ] * vars[ 2 ],
                           vars[ 1 ] * vars[ 3 ] ]], cox_ring );
#! <A 1 x 2 matrix over a graded ring>
obj2 := FreydCategoryObject(
         GradedRowOrColumnMorphism( source, matrix, range ) );
#! <An object in Category of f.p. graded
#! left modules over Q[x_1,x_2,x_3]
#! (with weights [ 1, 1, 1 ])>
source := GradedRow( [[[0],1]], cox_ring );
#! <A graded row of rank 1>
range := GradedRow( [[[1],2]], cox_ring );
#! <A graded row of rank 2>
matrix := HomalgMatrix( [[ vars[ 2 ], vars[ 3 ] ]], cox_ring );
#! <A 1 x 2 matrix over a graded ring>
mor := GradedRowOrColumnMorphism( source, matrix, range );
#! <A morphism in Category of graded rows
#! over Q[x_1,x_2,x_3] (with weights [ 1, 1, 1 ])>
pres_mor := FreydCategoryMorphism( obj1, mor, obj2 );
#! <A morphism in Category of f.p. graded
#! left modules over Q[x_1,x_2,x_3]
#! (with weights [ 1, 1, 1 ])>
IsWellDefined( pres_mor );
#! true
trunc_pres_mor1 := TruncateFPGradedModuleMorphism( P2, pres_mor, [ 2 ] );
#! <A morphism in Freyd( Category of
#! matrices over Q (with weights [ 1 ]) )>
IsWellDefined( trunc_pres_mor1 );
#! true
trunc_pres_mor2 := TruncateFPGradedModuleMorphismInParallel
                            ( P2, pres_mor, [ 2 ], [ 2, 2, 2 ] );
#! <A morphism in Freyd( Category of
#! matrices over Q (with weights [ 1 ]))>
IsWellDefined( trunc_pres_mor2 );
#! true
#! @EndExample
