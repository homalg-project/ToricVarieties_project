#! @Chapter Coherent sheaves on toric varieties

#! @Section Examples

LoadPackage( "CoherentSheavesOnToricVarieties" );

#! We construct a coherent sheaf associated to the irrelevant ideal of the projective space P2 as follows:

#! @Example
P2 := ProjectiveSpace( 2 );;
ir := IrrelevantLeftIdealForCAP( P2 );;
sheaf := CoherentSheafOnToricVariety( P2, ir );;
AmbientToricVariety( sheaf );;
IsWellDefined( DefiningModule( sheaf ) );;
IsWellDefined( DefiningSerreQuotientObject( sheaf ) );;
#! @EndExample

#! We can also construct a sheaf from a right module. But internally, it will always be converted into a left module:

#! @Example
ir2 := IrrelevantRightIdealForCAP( P2 );;
sheaf2 := CoherentSheafOnToricVariety( P2, ir2 );;
IsFpGradedRightModulesObject( DefiningModule( sheaf2 ) );
#! false
IsEqualForObjects( DefiningModule( sheaf ), DefiningModule( sheaf2 ) );
#! true
#! @EndExample

#! We also compute tensor products of sheaves as follows:

#! @Example
p1 := sheaf * sheaf;;
p2 := sheaf^2;;
DefiningModule( p1 ) = DefiningModule( p2 );
#! true
#! @EndExample

#! We can of course repeat all of this for a Hirzebruch surface as well:

#! @Example
rays := [ [1,0], [0,1], [-1,1], [0,-1] ];;
max_cones := [ [1,2],[2,3],[3,4],[4,1] ];;
tor := ToricVariety( Fan( rays, max_cones ) );;
ir := IrrelevantLeftIdealForCAP( tor );;
sheaf := CoherentSheafOnToricVariety( tor, ir );;
AmbientToricVariety( sheaf );;
IsWellDefined( DefiningModule( sheaf ) );;
IsWellDefined( DefiningSerreQuotientObject( sheaf ) );;
ir2 := IrrelevantRightIdealForCAP( tor );;
sheaf2 := CoherentSheafOnToricVariety( tor, ir2 );;
IsFpGradedRightModulesObject( DefiningModule( sheaf2 ) );
#! false
IsEqualForObjects( DefiningModule( sheaf ), DefiningModule( sheaf2 ) );
#! true
p1 := sheaf * sheaf;;
p2 := sheaf^2;;
DefiningModule( p1 ) = DefiningModule( p2 );
#! true
#! @EndExample
