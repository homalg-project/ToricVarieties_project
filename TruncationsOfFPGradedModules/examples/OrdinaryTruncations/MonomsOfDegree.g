#! @Chapter Monoms of Coxring of given degree

#! @Section Example: monoms of Cox ring of degree

LoadPackage( "TruncationsOfFPGradedModules" );

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
