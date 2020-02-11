#! @Chapter Sheaf cohomology with Spasm

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

#! We provide more convenient methods calls. Namely, H0ParallelBySpasmAndCheckOverIntegers( P1xP1, irP1xP1 ); is short for
#! H0ParallelBySpasm( P1xP1, irP1xP1, 42013, true, true ). The fourth argument being true, this will always
#! display information on the status of the computation. Since the fifth argument is true, this method will perform checks
#! on the rank of the involved matrices over the integers. Recall that Spasm only operates over a finite field.

#! We also provide the method H0ParallelBySpasm( P1xP1, irP1xP1 ). It calls
#! H0ParallelBySpasm( P1xP1, irP1xP1, 42013, true, true ). Consequently, this method operates similar to the previous one.
#! However, in contrast, it will not perform checks over the integers.
