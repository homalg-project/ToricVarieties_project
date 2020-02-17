#! @Chapter Coherent sheaves on toric varieties

#! @Section Examples

LoadPackage( "CoherentSheavesOnToricVarieties" );
LoadPackage( "SheafCohomologyOnToricVarieties" );

#! We construct a coherent sheaf associated to the irrelevant ideal of the projective space P2 as follows:

#! @Example
P2 := ProjectiveSpace( 2 );;
ir := IrrelevantLeftIdealForCAP( P2 );;
sheaf := CoherentSheafOnToricVariety( P2, ir );
#! <A coherent sheaf on a projective toric variety of dimension 2>
AmbientToricVariety( sheaf );;
DefiningModule( sheaf );;
#! @EndExample

#! We can also compute tensor products and powers of a sheaf.

#! @Example
p1 := sheaf * sheaf;;
p2 := sheaf^2;;
DefiningModule( p1 ) = DefiningModule( p2 );
#! true
#! @EndExample
