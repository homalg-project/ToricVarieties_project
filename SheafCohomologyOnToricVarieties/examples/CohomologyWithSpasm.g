#! @Chapter Sheaf cohomology computations (https://arxiv.org/abs/1802.08860) with Spasm

#! @Section Examples

LoadPackage( "SheafCohomologyOnToricVarieties" );

#! @Example
F1 := Fan( [[1],[-1]],[[1],[2]] );
#! <A fan in |R^1>
P1 := ToricVariety( F1 );
#! <A toric variety of dimension 1>
P1xP1 := P1 * P1;
#! <A toric variety of dimension 2 which is a product of 2 toric varieties>
irP1xP1 := IrrelevantLeftIdealForCAP( P1xP1 );
#! <An object in Category of f.p. graded left
#! modules over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 0, 1 ], [ 1, 0 ], [ 1, 0 ], [ 0, 1 ] ])>
h0 := H0ParallelBySpasm( P1xP1, irP1xP1, 42013, false, true )[ 3 ];
#! 1
irP1xP1 := IrrelevantRightIdealForCAP( P1xP1 );
#! <An object in Category of f.p. graded right
#! modules over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 0, 1 ], [ 1, 0 ], [ 1, 0 ], [ 0, 1 ] ])>
h0 := H0ParallelBySpasm( P1xP1, irP1xP1, 42013, false, true )[ 3 ];
#! 1
#! @EndExample
