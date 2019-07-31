#! @Chapter Truncations of GradedExt for f.p. graded modules

LoadPackage( "SheafCohomologyOnToricVarieties" );

#! @Section Examples

#! @Subsection Truncation of IntHom

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
IsWellDefined( obj2 );
#! true
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
Q := HomalgFieldOfRationalsInSingular();
#! Q
TruncateInternalHom( P2, obj1, obj2, degree, [ 4 ], Q );
#!
TruncateInternalHomEmbedding( P2, obj1, obj2, degree, [ 4 ], Q );
#!
TruncateInternalHom( P2, pres_mor, IdentityMorphism( obj2 ), [ 4 ], false, Q );
#!
#! @EndExample


#! @Subsection Truncation of IntHom to degree zero

#! @Example
TruncateInternalHomToZero( P2, obj1, obj2, degree, [ 4 ], Q );
#!
TruncateInternalHomEmbeddingToZero( P2, obj1, obj2, degree, [ 4 ], Q );
#!
TruncateInternalHomToZero( P2, pres_mor, IdentityMorphism( obj2 ), [ 4 ], false, Q );
#!
#! @EndExample


#! @Subsection Truncation of IntHom in parallel

#! @Example
TruncateInternalHomInParallel( P2, obj1, obj2, degree, [ 4 ], Q );
#!
TruncateInternalHomEmbeddingInParallel( P2, obj1, obj2, degree, [ 4 ], Q );
#!
TruncateInternalHomInParallel( P2, pres_mor, IdentityMorphism( obj2 ), [ 4 ], false, Q );
#!
#! @EndExample


#! @Subsection Truncation of IntHom to degree zero in parallel

#! @Example
TruncateInternalHomToZeroInParallel( P2, obj1, obj2, degree, [ 4 ], Q );
#!
TruncateInternalHomEmbeddingToZeroInParallel( P2, obj1, obj2, degree, [ 4 ], Q );
#!
TruncateInternalHomToZeroInParallel( P2, pres_mor, IdentityMorphism( obj2 ), [ 4 ], false, Q );
#!
#! @EndExample
