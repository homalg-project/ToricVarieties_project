#! @Chapter Cohomology of coherent sheaves from resolution

#! @Section Example: Pullback line bundle

LoadPackage( "SheafCohomologyOnToricVarieties" );

#! @Example
var := ProjectiveSpace( 2 );
#! <A projective toric variety of dimension 2>
cox_ring := CoxRing( var );
#! Q[x_1,x_2,x_3]
#! (weights: [ 1, 1, 1 ])
vars := IndeterminatesOfPolynomialRing( cox_ring );
#! [ x_1, x_2, x_3 ]
range := GradedRow( [[[2],1]], cox_ring );
#! <A graded row of rank 1>
source := GradedRow( [[[1],1]], cox_ring );
#! <A graded row of rank 1>
matrix := HomalgMatrix( [[vars[1]] ], cox_ring );
#! <A 1 x 1 matrix over a graded ring>
mor := GradedRowOrColumnMorphism( source, matrix, range );
#! <A morphism in Category of graded rows over
#! Q[x_1,x_2,x_3]
#! (with weights [ 1,1,1 ])>
IsWellDefined( mor );
#! true
pullback_line_bundle := FreydCategoryObject( mor );
#! <An object in Category of f.p. graded left modules over
#! Q[x_1,x_2,x_3] (with weights
#! [ 1, 1, 1 ])>
coh := DeductionOfSheafCohomologyFromResolution( var, pullback_line_bundle );
#! [ 3, 0, 0 ]
#! @EndExample


#! @Example
P1 := ProjectiveSpace( 1 );
#! <A projective toric variety of dimension 1>
P2 := ProjectiveSpace( 2 );
#! <A projective toric variety of dimension 2>
var2 := P1 * P1 * P2;
#! <A projective toric variety of dimension 4 
#! which is a product of 3 toric varieties>
cox_ring2 := CoxRing( var2 );
#! Q[x_1,x_2,x_3,x_4,x_5,x_6,x_7]
#! (weights: [ ( 0, 0, 1 ), ( 0, 1, 0 ), ( 1, 0, 0 ),
#! ( 1, 0, 0 ), ( 1, 0, 0 ), ( 0, 1, 0 ), ( 0, 0, 1 ) ])
vars2 := IndeterminatesOfPolynomialRing( cox_ring2 );
#! [ x_1, x_2, x_3, x_4, x_5, x_6, x_7 ]
range2 := GradedRow( [[[1,1,2],1]], cox_ring2 );
#! <A graded row of rank 1>
source2 := GradedRow( [[[0,1,2],2]], cox_ring2 );
#! <A graded row of rank 2>
matrix2 := HomalgMatrix( [[vars2[3]],[vars2[4]]], cox_ring2 );
#! <A 2 x 1 matrix over a graded ring>
mor2 := GradedRowOrColumnMorphism( source2, matrix2, range2 );
#! <A morphism in Category of graded rows over
#! Q[x_1,x_2,x_3,x_4,x_5,x_6,x_7]
#! (with weights [ [ 0, 0, 1 ], [ 0, 1, 0 ], [ 1, 0, 0 ],
#! [ 1, 0, 0 ], [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ])>
IsWellDefined( mor2 );
#! true
pullback_line_bundle2 := FreydCategoryObject( mor2 );
#! <An object in Category of f.p. graded left modules over
#! Q[x_1,x_2,x_3,x_4,x_5,x_6,x_7] (with weights
#! [ [ 0, 0, 1 ], [ 0, 1, 0 ], [ 1, 0, 0 ], [ 1, 0, 0 ],
#! [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ])>
coh2 := DeductionOfSheafCohomologyFromResolution( var2, pullback_line_bundle2 );
#! [ 6, 0, 0, 0, 0 ]
#! @EndExample


#! @Example
P2 := ProjectiveSpace( 2 );
#! <A projective toric variety of dimension 2>
var3 := P2 * P2;
#! <A projective toric variety of dimension 4 
#! which is a product of 2 toric varieties>
cox_ring3 := CoxRing( var3 );
#! Q[x_1,x_2,x_3,x_4,x_5,x_6]
#! (weights: [ ( 0, 1 ), ( 1, 0 ), ( 1, 0 ), 
#! ( 1, 0 ), ( 0, 1 ), ( 0, 1 ) ])
range3 := GradedRow( [[[1,1],4]], cox_ring3 );
#! <A graded row of rank 4>
source3 := ZeroObject( CapCategory( range3 ) );
#! <A graded row of rank 0>
matrix3 := HomalgZeroMatrix( 0, 4, cox_ring3 );
#! <An unevaluated 0 x 4 zero matrix over a graded ring>
mor3 := GradedRowOrColumnMorphism( source3, matrix3, range3 );
#! <A morphism in Category of graded rows over
#! Q[x_1,x_2,x_3,x_4,x_5,x_6] (with weights
#! [ [ 0, 1 ], [ 1, 0 ], [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
line_bundle3 := FreydCategoryObject( mor3 );
#! <An object in Category of f.p. graded left modules over 
#! Q[x_1,x_2,x_3,x_4,x_5,x_6] (with weights 
#! [ [ 0, 1 ], [ 1, 0 ], [ 1, 0 ], [ 1, 0 ], [0, 1 ], [ 0, 1 ] ])>
IsWellDefined( line_bundle3 );
#! true
coh3 := DeductionOfSheafCohomologyFromResolution( var3, line_bundle3 );
#! [ 36, 0, 0, 0, 0 ]
#! @EndExample
