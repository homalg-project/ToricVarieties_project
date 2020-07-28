#! @Chapter Irreducible, complete, torus-invariant curves and proper 1-cycles in a toric variety

#! @Section Examples in projective space

LoadPackage( "AdditionsForToricVarieties" );

#! @Example
HOMALG_IO.show_banners := false;;
HOMALG_IO.suppress_PID := true;;
P2 := ProjectiveSpace( 2 );
#! <A projective toric variety of dimension 2>
ICTCurves( P2 );
#! [ <An irreducible, complete, torus-invariant curve in a toric variety
#!    given as V( [ x_3 ] )>,
#!   <An irreducible, complete, torus-invariant curve in a toric variety
#!    given as V( [ x_2 ] )>,
#!   <An irreducible, complete, torus-invariant curve in a toric variety
#!    given as V( [ x_1 ] )> ]
C1 := ICTCurves( P2 )[ 1 ];
#! <An irreducible, complete, torus-invariant curve in a toric variety
#!  given as V( [ x_3 ] )>
IntersectionForm( P2 );
#! [ [ 1 ] ]
IntersectionProduct( C1, DivisorOfGivenClass( P2, [ 1 ] ) );
#! 1
IntersectionProduct( DivisorOfGivenClass( P2, [ 5 ] ), C1 );
#! 5
#! @EndExample

#! @Example
P3 := ProjectiveSpace( 3 );
#! <A projective toric variety of dimension 3>
C1 := ICTCurves( P3 )[ 1 ];
#! <An irreducible, complete, torus-invariant curve in a toric variety
#!  given as V( [ x_3, x_4 ] )>
vars := DefiningVariables( C1 );
#! [ x_3, x_4 ]
structureSheaf1 := LeftStructureSheaf( C1 );;
IsWellDefined( structureSheaf1 );
#! true
structureSheaf2 := RightStructureSheaf( C1 );;
IsWellDefined( structureSheaf2 );
#! true
#! @EndExample
