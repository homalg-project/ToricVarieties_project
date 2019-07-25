#! @Chapter Functionality of cohomCalg-Interface

#! @Section Functionality of cohomCalg-Interface: Examples

LoadPackage( "cohomCalgInterface" );

#! @Example
P3 := ProjectiveSpace( 3 );
#! <A projective toric variety of dimension 3>
coh1 := AllHiByCohomCalg( P3, [ [[3],1] ] );
#! [ 20, 0, 0, 0 ]
P1 := ProjectiveSpace( 1 );
#! <A projective toric variety of dimension 1>
P1xP1 := P1 * P1;
#! <A projective toric variety of dimension 2 
#! which is a product of 2 toric varieties>
coh2 := AllHiByCohomCalg( P1xP1, [ [[2,1],1] ] );
#! [ 6, 0, 0 ]
coh3 := AllHiByCohomCalg( P1xP1, [ [[2,1],2] ] );
#! [ 12, 0, 0 ]
coh4 := HiByCohomCalg( P1xP1, 0, [ [[2,1],2] ] );
#! 12
coh5 := HiByCohomCalg( P1xP1, 2, [ [[-2,-2],2] ] );
#! 2
#! @EndExample
