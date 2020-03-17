#! @Chapter Stuff

#! @Section Examples

LoadPackage( "CoherentSheavesOnToricVarieties" );

#! We form the category of coherent sheaves on P2:

#! @Example
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
