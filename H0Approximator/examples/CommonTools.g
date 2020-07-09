#! @Chapter Common functions applied generically to all toric surfaces

#! @Section Examples

LoadPackage( "H0Approximator" );

#! On a genus g curve, a lower bound for the sections of a degree d bundle can be estimated as follows:

#! @Example
sections := Sections( 3, 2 );
#! 0
#! @EndExample
