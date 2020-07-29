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
CoordinateRing( v );;
Os := StructureSheaf( v );;
IsWellDefined( Os );
#! true
CoordinateRing( v2 );;
Os2 := StructureSheaf( v2 );;
IsWellDefined( Os2 );
#! true
#! @EndExample

#! We can also construct ideal sheaves.

#! @Example
ideal_sheaf := IdealSheafOnSubvariety( v, [ vars[ 1 ], vars[ 2 ] ] );;
IsWellDefined( ideal_sheaf );
#! true
#! @EndExample

#! In this case, V( x1, x2 ) defines a divisor of the subvariety v = V( x1 ). Therefore, it also makes sense to consider the inverse of this ideal sheaf.
#! This is the line bundle associated to the divisor V( x1, x2 ).

#! @Example
inverse_of_ideal_sheaf := InverseOfIdealSheafOnSubvariety( v, [ vars[ 1 ], vars[ 2 ] ] );;
IsWellDefined( inverse_of_ideal_sheaf );
#! true
#! @EndExample

#! Of course, it makes a difference if we consider the ideal sheaf of V( x1, x2 ) inside V( x1 ) (where it is dual to a line bundle) or on P2, where V( x1, x2 ) is inverse to a skyscraper sheaf.

#! @Example
inverse_of_skyscraper := IdealSheafOnSubvariety( v2, [ vars[ 1 ], vars[ 2 ] ] );;
IsWellDefined( inverse_of_skyscraper );
#! true
DefiningModule( inverse_of_skyscraper ) = DefiningModule( inverse_of_ideal_sheaf );
#! false
#! @EndExample

#! Note that the above functions to not perform a test to tell whether or not a vanishing locus forms a divisor of a given subvariety.
#! For convenience, also a toric variety (instead of a ToricSubvariety) can be directly handed over to the above methods.
