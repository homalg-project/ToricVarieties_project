#! @Chunk AffineSpace

LoadPackage( "ToricVarieties" );

#! @Example
C:=Cone( [[1,0,0],[0,1,0],[0,0,1]] );
#! <A cone in |R^3>
C3:=ToricVariety(C);
#! <An affine normal toric variety of dimension 3>
Dimension(C3);
#! 3
IsSimplicial( C3 );
#! true
IsOrbifold(C3);
#! true
IsSmooth(C3);
#! true
IsProjective( C3 );
#! false
DimensionOfTorusfactor( C3 );
#! 0
CoordinateRingOfTorus(C3,"x");
#! Q[x1,x1_,x2,x2_,x3,x3_]/( x1*x1_-1, x2*x2_-1, x3*x3_-1 )
CoordinateRing(C3,"x");
#! Q[x_1,x_2,x_3]
MorphismFromCoordinateRingToCoordinateRingOfTorus( C3 );
#! <A monomorphism of rings>
C3;
#! <An affine normal smooth toric variety of dimension 3>
StructureDescription( C3 );
#! "|A^3"
IsAffine( ProjectiveSpace( 1 ) );
#! false
IrrelevantIdeal( C3 );;
#! @EndExample

#! Another example:

#! @Example
v:=Cone( [[1,0,0],[0,1,0]] );
#! <A cone in |R^3>
v:=ToricVariety(v);
#! <An affine normal toric variety of dimension 3>
DimensionOfTorusfactor( v );
#! 1
v2:=Cone( [[1,1],[-1,1]] );
#! <A cone in |R^2>
v2:=ToricVariety(v2);
#! <An affine normal toric variety of dimension 2>
IsSmooth( v2 );
#! false
Display( v2 );
#! An affine normal non smooth toric variety of dimension 2.
#! @EndExample
