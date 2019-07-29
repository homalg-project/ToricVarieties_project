#! @Chapter Truncation functors for f.p. graded modules

LoadPackage( "SheafCohomologyOnToricVarieties" );

#! @Section Examples

#! @Example
P2 := ProjectiveSpace( 2 );
#! <A projective toric variety of dimension 2>
P1 := ProjectiveSpace( 1 );
#! <A projective toric variety of dimension 1>
tor := P2 * P1;
#! <A projective toric variety of dimension 3
#! which is a product of 2 toric varieties>
TruncationFunctorForGradedRows( tor, [ 2, 3 ] );
#! Trunction functor for Category of graded rows
#! over Q[x_1,x_2,x_3,x_4,x_5] (with weights
#! [ [ 0, 1 ], [ 1, 0 ], [ 1, 0 ],
#! [ 0, 1 ], [ 0, 1 ] ] ) to the degree [ 2, 3 ]
TruncationFunctorForFpGradedLeftModules( tor, [ 4, 5 ] );
#! Truncation functor for Category of f.p.
#! graded left modules over Q[x_1,x_2,x_3,x_4,x_5]
#! (with weights [ [ 0, 1 ], [ 1, 0 ], [ 1, 0 ],
#! [ 0, 1 ], [ 0, 1 ] ]) to the degree [ 4, 5 ]
#! @EndExample
