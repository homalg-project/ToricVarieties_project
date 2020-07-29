#! @Chapter Category of coherent sheaves

#! @Section Examples

LoadPackage( "CoherentSheavesOnToricVarieties" );

#! We form the category of coherent sheaves on P2:

#! @Example
HOMALG_IO.show_banners := false;;
HOMALG_IO.suppress_PID := true;;
P2 := ProjectiveSpace( 2 );;
coh := CategoryOfCoherentSheaves( P2 );;
#! @EndExample

#! Likewise, we form the category of coherent sheaves on a Hirzebruch surface:

#! @Example
rays := [ [1,0], [0,1], [-1,1], [0,-1] ];;
max_cones := [ [1,2],[2,3],[3,4],[4,1] ];;
tor := ToricVariety( Fan( rays, max_cones ) );;
coh := CategoryOfCoherentSheaves( tor );;
#! @EndExample

#! Here is another example. Recall that the irrelevant ideal sheafifes to the structure sheaf. The latter is not the sheaf identically zero. Hence, the test of "IsZero" of this sheaf must return false.

#! @Example
F := Fan( [ [ 0, 1 ], [ 1, 0 ], [ -1, -2 ] ], [ [ 1, 2 ], [ 2, 3 ], [ 1, 3 ] ] );;
P112 := ToricVariety( F );;
CohP112 := CategoryOfCoherentSheaves( P112 );;
S := CoxRing( P112 );;
k := IrrelevantLeftIdealForCAP( P112 );;
IsWellDefined( k );
#! true
Sh_K := CoherentSheafOnToricVariety( P112, k );;
ob := DefiningSerreQuotientObject( Sh_K );;
IsZero( ob );
#! false
#! @EndExample
