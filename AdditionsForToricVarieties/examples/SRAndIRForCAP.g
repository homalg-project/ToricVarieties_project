#! @Chapter Additional methods and properties for toric varieties

#! @Section Example: Stanley-Reisner ideal for CAP

LoadPackage( "AdditionsForToricVarieties" );

#! @Example
P2 := ProjectiveSpace( 2 );
#! <A projective toric variety of dimension 2>
SR1 := SRLeftIdealForCAP( P2 );;
IsWellDefined( SR1 );
#! true
SR2 := SRRightIdealForCAP( P2 );;
IsWellDefined( SR2 );
#! true
#! @EndExample


#! @Section Example: Irrelevant ideal for CAP

#! @Example
P2 := ProjectiveSpace( 2 );
#! <A projective toric variety of dimension 2>
IR1 := IrrelevantLeftIdealForCAP( P2 );;
IsWellDefined( IR1 );
#! true
IR2 := IrrelevantRightIdealForCAP( P2 );;
IsWellDefined( IR2 );
#! true
#! @EndExample

#! @Section Example: Monomials of given degree

#! @Example
P1 := ProjectiveSpace( 1 );
#! <A projective toric variety of dimension 1>
var := P1*P1;
#! <A projective toric variety of dimension 2
#! which is a product of 2 toric varieties>
Exponents( var, [ 1,1 ] );
#! [ [ 1, 1, 0, 0 ], [ 1, 0, 1, 0 ],
#! [ 0, 1, 0, 1 ], [ 0, 0, 1, 1 ] ]
MonomsOfCoxRingOfDegreeByNormaliz( var, [1,2] );
#! [ x_1^2*x_2, x_1^2*x_3, x_1*x_2*x_4,
#! x_1*x_3*x_4, x_2*x_4^2, x_3*x_4^2 ]
MonomsOfCoxRingOfDegreeByNormaliz( var, [-1,-1] );
#! []
l := MonomsOfCoxRingOfDegreeByNormalizAsColumnMatrices
     ( var, [1,2], 2, 3 );;
Display( l[ 1 ] );
#! 0,
#! x_1^2*x_2,
#! 0
#! (over a graded ring)
#! @EndExample
