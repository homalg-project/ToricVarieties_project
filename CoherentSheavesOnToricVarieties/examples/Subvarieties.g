#! @Chapter Subvarieties of toric varieties

#! @Section Examples

LoadPackage( "CoherentSheavesOnToricVarieties" );
LoadPackage( "SheafCohomologyOnToricVarieties" );

#! We construct a subvariety by naming its ambient toric variety and its defining equations.

#! @Example
P2 := ProjectiveSpace( 2 );;
vars := IndeterminatesOfPolynomialRing( CoxRing( P2 ) );;
v := SubvarietyOfToricVariety( P2, [ vars[ 1 ] ] );
#! <A subvariety of a projective toric variety
#! of dimension 2 defined by one equation>
#! @EndExample

#! We can then access this defining data:

#! @Example
AmbientToricVariety( v );;
Length( DefiningEquations( v ) );
#! 1
#! @EndExample

#! Note that the toric variety itself can be constructed as a subvariety:
#! @Example
v2 := SubvarietyOfToricVariety( P2, [ ] );
#! <A subvariety of a projective toric variety
#! of dimension 2 defined by one equation>
#! @EndExample

#! From the defining data we derive the coordinate ring and structure sheaf of a subvariety from this data:

#! @Example
LeftCoordinateRing( v );;
RightCoordinateRing( v );;
ls := LeftStructureSheaf( v );;
IsWellDefined( ls );
#! true
rs := RightStructureSheaf( v );;
IsWellDefined( rs );
#! true
LeftCoordinateRing( v2 );;
RightCoordinateRing( v2 );;
ls2 := LeftStructureSheaf( v2 );;
IsWellDefined( ls2 );
#! true
rs2 := RightStructureSheaf( v2 );;
IsWellDefined( rs2 );
#! true
#! @EndExample

#! We can also construct ideal sheaves.

#! @Example
left_ideal_sheaf := LeftIdealSheafOnSubvariety( v, [ vars[ 1 ], vars[ 2 ] ] );;
IsWellDefined( left_ideal_sheaf );
#! true
right_ideal_sheaf := RightIdealSheafOnSubvariety( v, [ vars[ 1 ], vars[ 2 ] ] );;
IsWellDefined( right_ideal_sheaf );
#! true
#! @EndExample

#! In this case, V( x1, x2 ) defines a divisor of the subvariety v = V( x1 ). Therefore, it also makes sense to consider the inverse of this ideal sheaf.
#! This is the line bundle associated to the divisor V( x1, x2 ).

#! @Example
inverse_of_left_ideal_sheaf := InverseOfLeftIdealSheafOnSubvariety( v, [ vars[ 1 ], vars[ 2 ] ] );;
IsWellDefined( inverse_of_left_ideal_sheaf );
#! true
inverse_of_right_ideal_sheaf := InverseOfRightIdealSheafOnSubvariety( v, [ vars[ 1 ], vars[ 2 ] ] );;
IsWellDefined( inverse_of_right_ideal_sheaf );
#! true
#! @EndExample

#! Of course, it makes a difference if we consider the ideal sheaf of V( x1, x2 ) inside V( x1 ) (where it is dual to a line bundle) or on P2, where V( x1, x2 ) is inverse to a skyscraper sheaf.

#! @Example
inverse_of_left_skyscraper := LeftIdealSheafOnSubvariety( v2, [ vars[ 1 ], vars[ 2 ] ] );;
IsWellDefined( inverse_of_left_skyscraper );
#! true
inverse_of_right_skyscraper := RightIdealSheafOnSubvariety( v2, [ vars[ 1 ], vars[ 2 ] ] );;
IsWellDefined( inverse_of_right_skyscraper );
#! true
DefiningModule( inverse_of_left_skyscraper ) = DefiningModule( inverse_of_left_ideal_sheaf );
#! false
DefiningModule( inverse_of_right_skyscraper ) = DefiningModule( inverse_of_right_ideal_sheaf );
#! false
#! @EndExample

#! Note that the above functions to not perform a test to tell whether or not a vanishing locus forms a divisor of a given subvariety.
#! For convenience, also a toric variety (instead of a ToricSubvariety) can be directly handed over to the above methods.
