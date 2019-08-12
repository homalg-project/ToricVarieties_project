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
m1 := TruncateInternalHom( P2, obj1, obj2, [ 4 ], false, Q );
#! <An object in Freyd( Category of matrices over Q )>
IsWellDefined( m1 );
#! true
m2 := TruncateInternalHomEmbedding( P2, obj1, obj2, [ 4 ], false, Q );
#! <A monomorphism in Freyd( Category of matrices over Q )>
IsWellDefined( m2 );
#! true
m3 := TruncateInternalHom( P2, pres_mor, IdentityMorphism( obj2 ), [ 4 ], false, Q );
#! <A morphism in Freyd( Category of matrices over Q )>
IsWellDefined( m3 );
#! true
#! @EndExample


#! @Subsection Truncation of IntHom to degree zero

#! @Example
m4 := TruncateInternalHomToZero( P2, obj1, obj2, false, Q );
#! <An object in Freyd( Category of matrices over Q )>
IsWellDefined( m4 );
#! true
m5 := TruncateInternalHomEmbeddingToZero( P2, obj1, obj2, false, Q );
#! <A monomorphism in Freyd( Category of matrices over Q )>
IsWellDefined( m5 );
#! true
m6 := TruncateInternalHomToZero( P2, pres_mor, IdentityMorphism( obj2 ), false, Q );
#! <A morphism in Freyd( Category of matrices over Q )>
IsWellDefined( m6 );
#! true
#! @EndExample


#! @Subsection Truncation of IntHom in parallel

#! @Example
m7 := TruncateInternalHomInParallel( P2, obj1, obj2, [ 4 ], false, Q );
#! <An object in Freyd( Category of matrices over Q )>
m1 = m7;
#! true
m8 := TruncateInternalHomEmbeddingInParallel( P2, obj1, obj2, [ 4 ], false, Q );
#! <A monomorphism in Freyd( Category of matrices over Q )>
m8 = m2;
#! true
m9 := TruncateInternalHomInParallel( P2, pres_mor, IdentityMorphism( obj2 ), [ 4 ], false, Q );
#! <A morphism in Freyd( Category of matrices over Q )>
m9 = m3;
#! true
#! @EndExample


#! @Subsection Truncation of IntHom to degree zero in parallel

#! @Example
m10 := TruncateInternalHomToZeroInParallel( P2, obj1, obj2, false, Q );
#! <An object in Freyd( Category of matrices over Q )>
m10 = m4;
#! true
m11 := TruncateInternalHomEmbeddingToZeroInParallel( P2, obj1, obj2, false, Q );
#! <A monomorphism in Freyd( Category of matrices over Q )>
m11 = m5;
#! true
m12 := TruncateInternalHomToZeroInParallel( P2, pres_mor, IdentityMorphism( obj2 ), false, Q );
#! <A morphism in Freyd( Category of matrices over Q )>
m12 = m6;
#! true
#! @EndExample

#! @Subsection Truncation of GradedExt

#! @Example
v1 := TruncateGradedExt( 1, P2, obj1, obj2, [ 4 ], [ false, Q ] );
#! <An object in Freyd( Category of matrices over Q )>
IsWellDefined( v1 );
#! true
v2 := TruncateGradedExt( 1, P2, obj1, obj2, [ 0 ], [ false, Q ] );
#! <An object in Freyd( Category of matrices over Q )>
IsWellDefined( v2 );
#! true
v3 := TruncateGradedExtToZero( 1, P2, obj1, obj2, false, Q );
#! <An object in Freyd( Category of matrices over Q )>
v3 = v2;
#! true
v4 := TruncateGradedExtInParallel( 1, P2, obj1, obj2, [ 4 ], [ false, Q ] );
#! <An object in Freyd( Category of matrices over Q )>
IsWellDefined( v4 );
#! true
v5 := TruncateGradedExtInParallel( 1, P2, obj1, obj2, [ 0 ], [ false, Q ] );
#! <An object in Freyd( Category of matrices over Q )>
IsWellDefined( v5 );
#! true
v6 := TruncateGradedExtToZeroInParallel( 1, P2, obj1, obj2, false, Q );
#! <An object in Freyd( Category of matrices over Q )>
v6 = v5;
#! true
#! @EndExample
