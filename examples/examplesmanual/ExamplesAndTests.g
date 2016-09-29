#! @Chapter Examples and tests

#! @Section Hirzebruch surface of index 5

LoadPackage( "ToricVarieties" );
#HomalgFieldOfRationalsInSingular();;

#! @Example

H5 := Fan( [[-1,5],[0,1],[1,0],[0,-1]],[[1,2],[2,3],[3,4],[4,1]] );
#! <A fan in |R^2>
H5 := ToricVariety( H5 );
#! <A toric variety of dimension 2>
IsComplete( H5 );
#! true
IsAffine( H5 );
#! false
IsOrbifold( H5 );
#! true
IsProjective( H5 );
#! true
P := TorusInvariantPrimeDivisors( H5 );
#! [ <A prime divisor of a toric variety with coordinates ( 1, 0, 0, 0 )>,
#!   <A prime divisor of a toric variety with coordinates ( 0, 1, 0, 0 )>,
#!   <A prime divisor of a toric variety with coordinates ( 0, 0, 1, 0 )>,
#!   <A prime divisor of a toric variety with coordinates ( 0, 0, 0, 1 )> ]
A := P[ 1 ] - P[ 2 ] + 4*P[ 3 ];
#! <A divisor of a toric variety with coordinates ( 1, -1, 4, 0 )>
IsAmple( A );
#! false
CoordinateRingOfTorus( H5 );
#! Q[x1,x1_,x2,x2_]/( x1*x1_-1, x2*x2_-1 )
D:=CreateDivisor( [0,0,0,0], H5 );
#! <A divisor of a toric variety with coordinates 0>
BasisOfGlobalSections( D );
#! [ |[ 1 ]| ]
D:=Sum( P );
#! <A divisor of a toric variety with coordinates ( 1, 1, 1, 1 )>
BasisOfGlobalSections( D );
#! [ |[ x1_ ]|, |[ x1_*x2 ]|, |[ 1 ]|, |[ x2 ]|,
#!   |[ x1 ]|, |[ x1*x2 ]|, |[ x1^2*x2 ]|, 
#!   |[ x1^3*x2 ]|, |[ x1^4*x2 ]|, |[ x1^5*x2 ]|, 
#!   |[ x1^6*x2 ]| ]
D2 := DivisorOfCharacter( [1,2], H5 );
#! <A principal divisor of a toric variety with coordinates ( 9, 2, 1, -2 )>
BasisOfGlobalSections( D2 );
#! [ |[ x1_*x2_^2 ]| ]


#! @EndExample




#! @Section Affine space from a cone

#! @Example

C:=Cone( [[1,0,0],[0,1,0],[0,0,1]] );
#! <A cone in |R^3>
C3:=ToricVariety( C );
#! <An affine normal toric variety of dimension 3>
Dimension( C3 );
#! 3
IsOrbifold( C3 );
#! true
IsSmooth( C3 );
#! true
CoordinateRingOfTorus( C3 );
#! Q[x1,x1_,x2,x2_,x3,x3_]/( x1*x1_-1, x2*x2_-1, x3*x3_-1 )

#! @EndExample







#! @Section Product of projective spaces from a polytope

#! @Example

P1P1 := Polytope( [[1,1],[1,-1],[-1,-1],[-1,1]] );
#! <A polytope in |R^2>
P1P1 := ToricVariety( P1P1 );
#! <A projective toric variety of dimension 2>
IsProjective( P1P1 );
#! true
IsComplete( P1P1 );
#! true 
CoordinateRingOfTorus( P1P1 );
#! Q[x1,x1_,x2,x2_]/( x1*x1_-1, x2*x2_-1 )
IsVeryAmple( Polytope( P1P1 ) );
#! true
ProjectiveEmbedding( P1P1 );
#! [ |[ x1_*x2_ ]|, |[ x1_ ]|, |[ x1_*x2 ]|, |[ x2_ ]|,
#! |[ 1 ]|, |[ x2 ]|, |[ x1*x2_ ]|, |[ x1 ]|, |[ x1*x2 ]| ]
Length( last );
#! 9

#! @EndExample





#! @Section Morphism between toric varieties and their class groups

#! @Example

P1 := Polytope([[0],[1]]);
#! <A polytope in |R^1>
P2 := Polytope([[0,0],[0,1],[1,0]]);
#! <A polytope in |R^2>
P1 := ToricVariety( P1 );
#! <A projective toric variety of dimension 1>
P2 := ToricVariety( P2 );
#! <A projective toric variety of dimension 2>
P1P2 := P1*P2;
#! <A projective toric variety of dimension 3
#!  which is a product of 2 toric varieties>
cl := ClassGroup( P1 );
#! <A non-torsion left module presented by 1 relation for 2 generators>
Display( ByASmallerPresentation( cl ) );
#! Z^(1 x 1) 
cl2 := ClassGroup( P2 );
#! <A non-torsion left module presented by 2 relations for 3 generators>
Display( ByASmallerPresentation( cl2 ) );
#! Z^(1 x 1)
cl12 := ClassGroup( P1P2 );
#! <A free left module of rank 2 on free generators>
Display( cl12 );
#! Z^(1 x 2)
PicardGroup( P1P2 );
#! <A free left module of rank 2 on free generators>
P2P1:=P2*P1;
#! <A projective toric variety of dimension 3 
#!  which is a product of 2 toric varieties>
M := [[0,0,1],[1,0,0],[0,1,0]];
#! [ [ 0, 0, 1 ], [ 1, 0, 0 ], [ 0, 1, 0 ] ]
M := ToricMorphism(P1P2,M,P2P1);
#! <A "homomorphism" of right objects>
IsMorphism( M );
#! true
ClassGroup( M );
#! <A homomorphism of left modules>
Display( ClassGroup( M ) );
#! [ [  0,  1 ],
#!   [  1,  0 ] ]
#! 
#! the map is currently represented by the above 2 x 2 matrix
smaller_class_group := ByASmallerPresentation( ClassGroup( M ) );
#! <A non-zero homomorphism of left modules>
Display( smaller_class_group );
#! [ [  0,  1 ],
#!   [  1,  0 ] ]
#! 
#! the map is currently represented by the above 2 x 2 matrix

#! @EndExample





#! @Section Divisor on a toric variety

#! @Example

H7 := Fan( [[0,1],[1,0],[0,-1],[-1,7]],[[1,2],[2,3],[3,4],[4,1]] );
#! <A fan in |R^2>
H7 := ToricVariety( H7 );
#! <A toric variety of dimension 2>
P := TorusInvariantPrimeDivisors( H7 );
#! [ <A prime divisor of a toric variety with coordinates ( 1, 0, 0, 0 )>,
#!   <A prime divisor of a toric variety with coordinates ( 0, 1, 0, 0 )>,
#!   <A prime divisor of a toric variety with coordinates ( 0, 0, 1, 0 )>,
#!   <A prime divisor of a toric variety with coordinates ( 0, 0, 0, 1 )> ]
D := P[3]+P[4];
#! <A divisor of a toric variety with coordinates ( 0, 0, 1, 1 )>
IsBasepointFree( D );
#! true
IsAmple( D );
#! true
CoordinateRingOfTorus(H7,"x");
#! Q[x1,x1_,x2,x2_]/( x1*x1_-1, x2*x2_-1 )
Polytope( D );
#! <A polytope in |R^2>
CharactersForClosedEmbedding( D );
#! [ |[ 1 ]|, |[ x2 ]|, |[ x1 ]|, |[ x1*x2 ]|, |[ x1^2*x2 ]|, 
#!   |[ x1^3*x2 ]|, |[ x1^4*x2 ]|, |[ x1^5*x2 ]|, 
#!   |[ x1^6*x2 ]|, |[ x1^7*x2 ]|, |[ x1^8*x2 ]| ]
CoxRingOfTargetOfDivisorMorphism( D );
#! Q[x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8,x_9,x_10,x_11]
#! (weights: [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ])
RingMorphismOfDivisor( D );
#! <A "homomorphism" of rings>
Display( last );
#! Q[x_1,x_2,x_3,x_4]
#! (weights: [ ( 0, 0, 1, -7 ), ( 0, 0, 0, 1 ), ( 0, 0, 1, 0 ), ( 0, 0, 0, 1 ) ])
#!   ^
#!   |
#! [ x_3*x_4, x_1*x_4^8, x_2*x_3, x_1*x_2*x_4^7, x_1*x_2^2*x_4^6,
#!   x_1*x_2^3*x_4^5, x_1*x_2^4*x_4^4, x_1*x_2^5*x_4^3, 
#!   x_1*x_2^6*x_4^2, x_1*x_2^7*x_4, x_1*x_2^8 ]
#!   |
#!   |
#! Q[x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8,x_9,x_10,x_11]
#! (weights: [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ])
ByASmallerPresentation( ClassGroup( H7 ) );
#! <A free left module of rank 2 on free generators>
Display(RingMorphismOfDivisor( D ) );
#! Q[x_1,x_2,x_3,x_4]
#! (weights: [ ( 1, -7 ), ( 0, 1 ), ( 1, 0 ), ( 0, 1 ) ])
#!   ^
#!   |
#! [ x_3*x_4, x_1*x_4^8, x_2*x_3, x_1*x_2*x_4^7, x_1*x_2^2*x_4^6, 
#!   x_1*x_2^3*x_4^5, x_1*x_2^4*x_4^4, x_1*x_2^5*x_4^3, 
#!   x_1*x_2^6*x_4^2, x_1*x_2^7*x_4, x_1*x_2^8 ]
#!   |
#!   |
#! Q[x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8,x_9,x_10,x_11]
#! (weights: [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ])
MonomsOfCoxRingOfDegree( D );
#! [ x_3*x_4, x_1*x_4^8, x_2*x_3, x_1*x_2*x_4^7, x_1*x_2^2*x_4^6, 
#!   x_1*x_2^3*x_4^5, x_1*x_2^4*x_4^4, x_1*x_2^5*x_4^3, 
#!   x_1*x_2^6*x_4^2, x_1*x_2^7*x_4, x_1*x_2^8 ]
D2:=D-2*P[ 2 ];
#! <A divisor of a toric variety with coordinates ( 0, -2, 1, 1 )>
IsBasepointFree( D2 );
#! false
IsAmple( D2 );
#! false

#! @EndExample





#! @Section Examples with Nef cones, Mori cones and intersection numbers

#! @Example
F1 := Fan( [[1],[-1]], [[1],[2]] );
#! <A fan in |R^1>
P1 := ToricVariety( F1 );
#! <A toric variety of dimension 1>
P1xP1 := P1*P1;
#! <A toric variety of dimension 2 which is a product of 2 toric varieties>
NefConeInClassGroup( P1xP1 );
#! [ [ 0, 1 ], [ 1, 0 ] ]
MoriCone( P1xP1 );
#! [ [ 1, 1 ], [ -1, 0 ] ]
IntersectionForm( P1xP1 );
#! [ [ -1, 1 ], [ 0, 1 ] ]
D := DivisorOfGivenClass( P1xP1, [2,2] );
#! <A Cartier divisor of a toric variety with coordinates ( 0, 2, 2, 0 )>
IsNef( D );
#! true
IsAmple( D );
#! true
IsAmpleViaNefCone( D );
#! true
ClassOfSmallestAmpleDivisor( P1xP1 );
#! [ 1, 1 ]
D2 := DivisorOfGivenClass( P1xP1, [-1,0] );
#! <A Cartier divisor of a toric variety with coordinates ( -1, 0, 0, 0 )>
IsAmple( D2 );
#! false
IsAmpleViaNefCone( D2 );
#! false
IsNef( D2 );
#! false
IntersectionProduct( 1,2, D );
#! 2
IntersectionProduct( 1,2, D2 );
#! 0

#! @EndExample



#! @Section Cohomology example

#! @Example

F1 := Fan( [[1],[-1]], [[1],[2]] );
#! <A fan in |R^1>
P1 := ToricVariety( F1 );
#! <A toric variety of dimension 1>
B := GradedLeftSubmodule( "x_1, x_2", CoxRing( P1 ) );
#! <A graded torsion-free (left) ideal given by 2 generators>
ByASmallerPresentation( ClassGroup( P1 ) );
#! <A free left module of rank 1 on a free generator>
H0FromBTransformInInterval( P1, B, 0, 5 );
#! [ ( Q^0 ), ( Q^1 ), ( Q^1 ), ( Q^1 ), ( Q^1 ), ( Q^1 ) ]
H0ByGS( P1, B );
#! Found integer: 1
#! [ 1, ( Q^1 ) ]

#! @EndExample