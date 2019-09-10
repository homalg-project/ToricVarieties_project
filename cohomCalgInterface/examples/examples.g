#! @Chapter Functions supported by cohomCalg

#! @Section Examples

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

#! We also support the use of a monomial_file. Namely, cohomCalg computes combinatorial data on
#! monomials in the Cox ring at each program run, unless this data is stored in a corresponding file.
#! To use such a file, set the attribute "MonomialFile" to the desired name of this monomial file.
#! Suppose for example, that we want to use the monomial file "Test.dat" for the space P3 above. Then
#! we can use

#! @Example
SetMonomialFile( P3, "Test.dat" );
#! @EndExample

#! This file will be stored in the folder "cohomCalg" of this package.
