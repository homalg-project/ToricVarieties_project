#! @Chunk Hirzebruch5

#! @Example
H5 := Fan( [[-1,5],[0,1],[1,0],[0,-1]],[[1,2],[2,3],[3,4],[4,1]] );
#! <A fan in |R^2>
H5 := ToricVariety( H5 );
#! <A toric variety of dimension 2>
IsComplete( H5 );
#! true
IsSimplicial( H5 );
#! true
IsAffine( H5 );
#! false
IsOrbifold( H5 );
#! true
IsProjective( H5 );
#! true
ithBettiNumber( H5, 0 );
#! 1
DimensionOfTorusfactor( H5 );
#! 0
Length( AffineOpenCovering( H5 ) );
#! 4
MorphismFromCoxVariety( H5 );
#! <A "homomorphism" of right objects>
CartierTorusInvariantDivisorGroup( H5 );
#! <A free left submodule given by 8 generators>
TorusInvariantPrimeDivisors( H5 );
#! [ <A prime divisor of a toric variety with coordinates ( 1, 0, 0, 0 )>,
#!   <A prime divisor of a toric variety with coordinates ( 0, 1, 0, 0 )>,
#!   <A prime divisor of a toric variety with coordinates ( 0, 0, 1, 0 )>,
#!   <A prime divisor of a toric variety with coordinates ( 0, 0, 0, 1 )> ]
P := TorusInvariantPrimeDivisors( H5 );
#! [ <A prime divisor of a toric variety with coordinates ( 1, 0, 0, 0 )>,
#!   <A prime divisor of a toric variety with coordinates ( 0, 1, 0, 0 )>,
#!   <A prime divisor of a toric variety with coordinates ( 0, 0, 1, 0 )>,
#!   <A prime divisor of a toric variety with coordinates ( 0, 0, 0, 1 )> ]
A := P[ 1 ] - P[ 2 ] + 4*P[ 3 ];
#! <A divisor of a toric variety with coordinates ( 1, -1, 4, 0 )>
A;
#! <A divisor of a toric variety with coordinates ( 1, -1, 4, 0 )>
IsAmple( A );
#! false
WeilDivisorsOfVariety( H5 );;
CoordinateRingOfTorus( H5 );
#! Q[x1,x1_,x2,x2_]/( x1*x1_-1, x2*x2_-1 )
CoordinateRingOfTorus( H5,"x" );
#! Q[x1,x1_,x2,x2_]/( x1*x1_-1, x2*x2_-1 )
D:=CreateDivisor( [ 0,0,0,0 ],H5 );
#! <A divisor of a toric variety with coordinates 0>
BasisOfGlobalSections( D );
#! [ |[ 1 ]| ]
D:=Sum( P );
#! <A divisor of a toric variety with coordinates ( 1, 1, 1, 1 )>
BasisOfGlobalSections(D);
#! [ |[ x1_ ]|, |[ x1_*x2 ]|, |[ 1 ]|, |[ x2 ]|,
#!   |[ x1 ]|, |[ x1*x2 ]|, |[ x1^2*x2 ]|, 
#!   |[ x1^3*x2 ]|, |[ x1^4*x2 ]|, |[ x1^5*x2 ]|, 
#!   |[ x1^6*x2 ]| ]
divi := DivisorOfCharacter( [ 1,2 ],H5 );
#! <A principal divisor of a toric variety with coordinates ( 9, -2, 2, 1 )>
BasisOfGlobalSections( divi );
#! [ |[ x1_*x2_^2 ]| ]
ZariskiCotangentSheafViaPoincareResidueMap( H5 );;
ZariskiCotangentSheafViaEulerSequence( H5 );;
EQ( H5, ProjectiveSpace( 2 ) );
#! false
H5B1 := BlowUpOnIthMinimalTorusOrbit( H5, 1 );
#! <A toric variety of dimension 2>
H5_version2 := DeriveToricVarietiesFromGrading( [[0,1,1,0],[1,0,-5,1]], false );
#! [ <A toric variety of dimension 2> ]
H5_version3 := ToricVarietyFromGrading( [[0,1,1,0],[1,0,-5,1]] );
#! <A toric variety of dimension 2>
NameOfVariety( H5 );
#! "H_5"
Display( H5 );
#! A projective normal toric variety of dimension 2.
#! The torus of the variety is RingWithOne( ... ).
#! The class group is <object> and the Cox ring is RingWithOne( ... ).
#! @EndExample

#! Another example

#! @Example
P2 := ProjectiveSpace( 2 );
#! <A projective toric variety of dimension 2>
IsNormalVariety( P2 );
#! true
AffineCone( P2 );
#! <An affine normal toric variety of dimension 3>
PolytopeOfVariety( P2 );
#! <A polytope in |R^2 with 3 vertices>
IsIsomorphicToProjectiveSpace( P2 );
#! true
IsIsomorphicToProjectiveSpace( H5 );
#! false
Length( MonomsOfCoxRingOfDegree( P2, [1,2,3] ) );
#! 28
IsDirectProductOfPNs( P2 * P2 );
#! true
IsDirectProductOfPNs( P2 * H5 );
#! false
#! @EndExample

#! @Chunk nonprojective

#! @Example
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
#! @EndExample
