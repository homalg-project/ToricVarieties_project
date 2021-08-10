gap> F := Fan( [ [ 1, 0 ], [ 1, 1 ], [ 0, 1 ] ], [ [ 1, 2 ], [ 2, 3 ] ] );;
gap> IsWellDefinedFan( F );
true
gap> F := Fan( [ [ 1, 0 ], [ 1, 2 ], [ 2, 1 ], [ 0, 1 ] ], [ [ 1, 2 ], [ 3, 4 ] ] );;
gap> IsWellDefinedFan( F );
false
