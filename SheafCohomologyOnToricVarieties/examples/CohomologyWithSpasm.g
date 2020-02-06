#! @Chapter Sheaf cohomology with Spasm and Linbox

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
h0 := H0ParallelBySpasmAndLinbox( P1xP1, irP1xP1, 42013, false, true )[ 3 ];
#! 1
irP1xP1 := IrrelevantRightIdealForCAP( P1xP1 );
#! <An object in Category of f.p. graded right
#! modules over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 0, 1 ], [ 1, 0 ], [ 1, 0 ], [ 0, 1 ] ])>
h0 := H0ParallelBySpasmAndLinbox( P1xP1, irP1xP1, 42013, false, true )[ 3 ];
#! 1
#! @EndExample

#! We provide more convenient methods calls. Namely, H0ParallelBySpasmAndLinboxCheck( P1xP1, irP1xP1 ); is short for
#! H0ParallelBySpasmAndLinbox( P1xP1, irP1xP1, 42013, true, true ). The fourth argument being true, this will always
#! display information on the status of the computation. Since the fifth argument is true, this method will check
#! ranks with Linbox.

#! We also provide the method H0ParallelBySpasm( P1xP1, irP1xP1 ). It calls H0ParallelBySpasmAndLinbox( P1xP1, irP1xP1, 42013, true, true ).
#! Consequently, this method operates similar to the previous shorthand. However, in contrast, it will not perform checks with Linbox.
