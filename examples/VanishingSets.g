#! @Chapter Computation of vanishing sets

#! @Section GS-cone

#! We compute the GS-cone for a number of examples.

LoadPackage( "SheafCohomologyOnToricVarieties" );

#! @Example
F1 := Fan( [[1],[-1]],[[1],[2]] );
#! <A fan in |R^1>
P1 := ToricVariety( F1 );
#! <A toric variety of dimension 1>
v1 := VanishingSets( P1 );
#! rec( 0 := <A non-full vanishing set in Z^1 for cohomological index 0>,
#! 1 := <A non-full vanishing set in Z^1 for cohomological index 1> )
Display( v1.0 );
#! A non-full vanishing set in Z^1 for cohomological index 0 formed from
#! the points NOT contained in the following affine semigroup:
#!
#! A non-trivial affine cone-semigroup in Z^1
#! Offset: [ 0 ]
#! Hilbert basis: [ [ 1 ] ]
Display( v1.1 );
#! A non-full vanishing set in Z^1 for cohomological index 1 formed from
#! the points NOT contained in the following affine semigroup:
#!
#! A non-trivial affine cone-semigroup in Z^1
#! Offset: [ -2 ]
#! Hilbert basis: [ [ -1 ] ]
P1xP1 := P1 * P1;
#! <A smooth toric variety of dimension 2 which is a product of
#! 2 toric varieties>
v2 := VanishingSets( P1xP1 );
#! rec( 0 := <A non-full vanishing set in Z^2 for cohomological index 0>,
#!      1 := <A non-full vanishing set in Z^2 for cohomological index 1>,
#!      2 := <A non-full vanishing set in Z^2 for cohomological index 2> )
Display( v2.0 );
#! A non-full vanishing set in Z^2 for cohomological index 0 formed from
#! the points NOT contained in the following affine semigroup:
#!
#! A non-trivial affine cone-semigroup in Z^2
#! Offset: [ 0, 0 ]
#! Hilbert basis: [ [ 1, 0 ], [ 0, 1 ] ]
Display( v2.1 );
#! A non-full vanishing set in Z^2 for cohomological index 1 formed from
#! the points NOT contained in the following 2 affine semigroups:
#!
#! Affine semigroup 1: 
#! A non-trivial affine cone-semigroup in Z^2
#! Offset: [ 0, -2 ]
#! Hilbert basis: [ [ 1, 0 ], [ 0, -1 ] ]
#!
#! Affine semigroup 2: 
#! A non-trivial affine cone-semigroup in Z^2
#! Offset: [ -2, 0 ]
#! Hilbert basis: [ [ -1, 0 ], [ 0, 1 ] ]
Display( v2.2 );
#! A non-full vanishing set in Z^2 for cohomological index 2 formed from 
#! the points NOT contained in the following affine semigroup: 
#!
#! A non-trivial affine cone-semigroup in Z^2
#! Offset: [ -2, -2 ]
#! Hilbert basis: [ [ -1, 0 ], [ 0, -1 ] ]
P2 := ProjectiveSpace( 2 );
#! <A projective toric variety of dimension 2>
v3 := VanishingSets( P2 );
#! rec( 0 := <A non-full vanishing set in Z^1 for cohomological index 0>,
#!      1 := <A full vanishing set in Z^1 for cohomological index 1>,
#!      2 := <A non-full vanishing set in Z^1 for cohomological index 2> )
P2xP1xP1 := P2*P1*P1;
#! <A smooth toric variety of dimension 4 which is a product 
#! of 3 toric varieties>
v4 := VanishingSets( P2xP1xP1 );
#! rec( 0 := <A non-full vanishing set in Z^3 for cohomological index 0>,
#!      1 := <A non-full vanishing set in Z^3 for cohomological index 1>,
#!      2 := <A non-full vanishing set in Z^3 for cohomological index 2>,
#!      3 := <A non-full vanishing set in Z^3 for cohomological index 3>,
#!      4 := <A non-full vanishing set in Z^3 for cohomological index 4> )
P := Polytope( [[ -2,2],[1,2],[2,1],[2,-2],[-2,-2]] );
#! <A polytope in |R^2>
T := ToricVariety( P );
#! <A projective toric variety of dimension 2>
v5 := VanishingSets( T );
#! rec( 0 := <A non-full vanishing set in Z^3 for cohomological index 0>,
#!      1 := <A non-full vanishing set in Z^3 for cohomological index 1>,
#!      2 := <A non-full vanishing set in Z^3 for cohomological index 2> )
Display( v5.2 );
#! A non-full vanishing set in Z^3 for cohomological index 2 formed from the 
#! points NOT contained in the following affine semigroup:
#!
#! A non-trivial affine non-cone semigroup in Z^3
#! Offset: [ -1, -1, -2 ]
#! Semigroup generators: [ [ 1, -1, -1 ], [ -1, 0, 0 ], [ -1, 1, 0 ], [ 0\
#! , -1, 0 ], [ 0, 0, -1 ] ]
H7 := Fan( [[0,1],[1,0],[0,-1],[-1,7]], [[1,2],[2,3],[3,4],[4,1]] );
#! <A fan in |R^2>
H7 := ToricVariety( H7 );
#! <A toric variety of dimension 2>
v6 := VanishingSets( H7 );
#! rec( 0 := <A non-full vanishing set in Z^2 for cohomological index 0>,
#!      1 := <A non-full vanishing set in Z^2 for cohomological index 1>,
#!      2 := <A non-full vanishing set in Z^2 for cohomological index 2> )
H5 := Fan( [[-1,5],[0,1],[1,0],[0,-1]] ,[[1,2],[2,3],[3,4],[4,1]] );
#! <A fan in |R^2>
H5 := ToricVariety( H5 );
#! <A toric variety of dimension 2>
v7 := VanishingSets( H5 );
#! rec( 0 := <A non-full vanishing set in Z^2 for cohomological index 0>,
#!      1 := <A non-full vanishing set in Z^2 for cohomological index 1>,
#!      2 := <A non-full vanishing set in Z^2 for cohomological index 2> )
PointContainedInVanishingSet( v1.0, [ 1 ] );
#! false
PointContainedInVanishingSet( v1.0, [ 0 ] );
#! false
PointContainedInVanishingSet( v1.0, [ -1 ] );
#! true
PointContainedInVanishingSet( v1.0, [ -2 ] );
#! true
rays := [ [1,0,0], [-1,0,0], [0,1,0], [0,-1,0], [0,0,1], [0,0,-1],
          [2,1,1], [1,2,1], [1,1,2], [1,1,1] ];
#! [ [ 1, 0, 0 ], [ -1, 0, 0 ], [ 0, 1, 0 ], [ 0, -1, 0 ], [ 0, 0, 1 ], [ 0, 0, -1 ], 
#! [ 2, 1, 1 ], [ 1, 2, 1 ], [ 1, 1, 2 ], [ 1, 1, 1 ] ]
cones := [ [1,3,6], [1,4,6], [1,4,5], [2,3,6], [2,4,6], [2,3,5], [2,4,5],
           [1,5,9], [3,5,8], [1,3,7], [1,7,9], [5,8,9], [3,7,8],
           [7,9,10], [8,9,10], [7,8,10] ];
#! [ [ 1, 3, 6 ], [ 1, 4, 6 ], [ 1, 4, 5 ], [ 2, 3, 6 ], [ 2, 4, 6 ], [ 2, 3, 5 ],
#!   [ 2, 4, 5 ], [ 1, 5, 9 ], [ 3, 5, 8 ], [ 1, 3, 7 ], [ 1, 7, 9 ], [ 5, 8, 9 ], 
#!   [ 3, 7, 8 ], [ 7, 9, 10 ], [ 8, 9, 10 ], [ 7, 8, 10 ] ]
F := Fan( rays, cones );
#! <A fan in |R^3>
T := ToricVariety( F );
#! <A toric variety of dimension 3>
[ IsSmooth( T ), IsComplete( T ), IsProjective( T ) ];
#! [ true, true, false ]
SRIdeal( T );
#! <A graded torsion-free (left) ideal given by 23 generators>
v8 := VanishingSets( T );
#! rec( 0 := <A non-full vanishing set in Z^7 for cohomological index 0>,
#!      1 := <A non-full vanishing set in Z^7 for cohomological index 1>,
#!      2 := <A non-full vanishing set in Z^7 for cohomological index 2>,
#!      3 := <A non-full vanishing set in Z^7 for cohomological index 3> )
Display( v8.3 );
#! A non-full vanishing set in Z^7 for cohomological index 3 formed from 
#! the points NOT contained in the following affine semigroup:
#!
#! A non-trivial affine non-cone semigroup in Z^7
#! Offset: [ -2, -2, -2, -1, 1, 0, 0 ]
#! Semigroup generators: [ [ 0, 0, -1, 1, 1, 1, 1 ], [ -1, 0, 0, 1, 2, 0, 1 ],
#! [ 0, -1, 0, -2, -1, 0, -1 ], [ -1, 0, 0, 0, 0, 0, 0 ], [ 0, -1, 0, 0, 0, 0, 0 ],
#! [ 0, 0, -1, 0, 0, 0, 0 ], [ 0, 0, 0, -1, 0, 0, 0 ], [ 0, 0, 0, 0, -1, 0, 0 ], 
#! [ 0, 0, 0, 0, 0, -1, 0 ], [0, 0, 0, 0, 0, 0, -1 ] ]

#! @EndExample
