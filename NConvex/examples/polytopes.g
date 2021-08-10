LoadPackage( "NC" );

#! @Chunk example2
#! @Example

P:= Polytope( [ [ 0, 0, 0 ], [ 1, 0, 0 ], [ 0, 1, 0 ], [ 1, 1, 2 ] ] );
#! <A polytope in |R^3>
IsNormalPolytope( P );
#! false
IsVeryAmple( P );
#! false
Q:= Polytope( [ [ 0, 0, 0 ], [ 1, 0, 0 ], [ 0, 1, 0 ], [ 1, 1, 1 ] ] );
#! <A polytope in |R^3>
IsNormalPolytope( Q );
#! true
IsVeryAmple( Q );
#! true
Q;
#! <A normal very ample polytope in |R^3 with 4 vertices>
T:= Polytope( [ [ 0, 0, 0 ], [ 1, 0, 0 ], [ 0, 1, 0 ], [ 1, 1, 4 ] ] ); 
#! <A polytope in |R^3>
I:= Polytope( [ [ 0, 0, 0 ], [ 0, 0, 1 ] ] );
#! <A polytope in |R^3>
J:= T + I; 
#! <A polytope in |R^3>
IsVeryAmple( J );
#! true
IsNormalPolytope( J );
#! false
J;
#! <A very ample polytope in |R^3 with 8 vertices>
# Example 2.2.20 Cox, Toric Varieties
A:= [ [1,1,1,0,0,0], [1,1,0,1,0,0], [1,0,1,0,1,0], [ 1,0,0,1,0,1], 
[ 1,0,0,0,1,1], [ 0,1,1,0,0,1], [0,1,0,1,1,0], [0,1,0,0,1,1], 
[0,0,1,1,1,0], [0,0,1,1,0,1] ];
#! [ [ 1, 1, 1, 0, 0, 0 ], [ 1, 1, 0, 1, 0, 0 ], [ 1, 0, 1, 0, 1, 0 ],
#! [ 1, 0, 0, 1, 0, 1 ], [ 1, 0, 0, 0, 1, 1 ], [ 0, 1, 1, 0, 0, 1 ], 
#!  [ 0, 1, 0, 1, 1, 0 ], [ 0, 1, 0, 0, 1, 1 ], [ 0, 0, 1, 1, 1, 0 ], 
#! [ 0, 0, 1, 1, 0, 1 ] ]
H:= Polytope( A );
#! <A polytope in |R^6>
IsVeryAmple( H );   
#! true
IsNormalPolytope( H );
#! false
H;
#! <A very ample polytope in |R^6 with 10 vertices>
l:= [ [ 0, 0, 1 ], [ 0, 0, 0 ], [ 1, 0, 0 ], [ 1, 0, 1 ], [ 0, 1, 0 ], 
[ 0, 1, 1 ], [ 1, 1, 4 ], [ 1, 1, 5 ] ];;
P:= Polytope( l );
#! <A polytope in |R^3>
IsNormalPolytope( P );
#! false
lattic_points:= LatticePoints( P );
#! [ [ 0, 0, 0 ], [ 0, 0, 1 ], [ 0, 1, 0 ], [ 0, 1, 1 ], [ 1, 0, 0 ], [ 1, 0, 1 ], 
#! [ 1, 1, 4 ], [ 1, 1, 5 ] ]
u:= Cartesian( lattic_points, lattic_points );;
k:= Set( List( u, u-> u[1]+u[2] ) );
#! [ [ 0, 0, 0 ], [ 0, 0, 1 ], [ 0, 0, 2 ], [ 0, 1, 0 ], [ 0, 1, 1 ], [ 0, 1, 2 ],
#! [ 0, 2, 0 ], [ 0, 2, 1 ], [ 0, 2, 2 ], [ 1, 0, 0 ], [ 1, 0, 1 ], [ 1, 0, 2 ], 
#! [ 1, 1, 0 ], [ 1, 1, 1 ], [ 1, 1, 2 ], [ 1, 1, 4 ], [ 1, 1, 5 ], [ 1, 1, 6 ], 
#! [ 1, 2, 4 ], [ 1, 2, 5 ], [ 1, 2, 6 ], [ 2, 0, 0 ], [ 2, 0, 1 ], [ 2, 0, 2 ], 
#! [ 2, 1, 4 ], [ 2, 1, 5 ], [ 2, 1, 6 ], [ 2, 2, 8 ], [ 2, 2, 9 ], [ 2, 2, 10 ] ]
Q:= 2*P;
#! <A polytope in |R^3 with 8 vertices>
LatticePoints( Q );
#! [ [ 0, 0, 0 ], [ 0, 0, 1 ], [ 0, 0, 2 ], [ 0, 1, 0 ], [ 0, 1, 1 ], [ 0, 1, 2 ],
#! [ 0, 2, 0 ], [ 0, 2, 1 ], [ 0, 2, 2 ], [ 1, 0, 0 ], 
#!   [ 1, 0, 1 ], [ 1, 0, 2 ], [ 1, 1, 0 ], [ 1, 1, 1 ], [ 1, 1, 2 ], [ 1, 1, 3 ], 
#! [ 1, 1, 4 ], [ 1, 1, 5 ], [ 1, 1, 6 ], [ 1, 2, 4 ], [ 1, 2, 5 ], [ 1, 2, 6 ], 
#! [ 2, 0, 0 ], [ 2, 0, 1 ], [ 2, 0, 2 ], [ 2, 1, 4 ], 
#!   [ 2, 1, 5 ], [ 2, 1, 6 ], [ 2, 2, 8 ], [ 2, 2, 9 ], [ 2, 2, 10 ] ]
P:= Polytope( [ [ 1, 1 ], [ 1, -1 ], [ -1, 1 ], [ -1, -1 ] ] );
#! <A polytope in |R^2>
Q:= PolarPolytope( P );
#! <A polytope in |R^2>
Vertices( Q );
#! [ [ -1, 0 ], [ 0, -1 ], [ 0, 1 ], [ 1, 0 ] ]
T := PolarPolytope( Q );
#! <A polytope in |R^2>
Vertices( T );
#! [ [ -1, -1 ], [ -1, 1 ], [ 1, -1 ], [ 1, 1 ] ]
P:= Polytope( [ [ 0, 0 ], [ 1, -1], [ -1, 1 ], [ -1, -1 ] ] );
#! <A polytope in |R^2>
# PolarPolytope( P );;
#! @EndExample
#! @BeginLatexOnly
#! Let us now find out if the vertices of the polytope defined by the following inequalities:
#! $$x_2\geq 0,1-x_1-x_2\geq 0,1+x_1-x_2\geq 0.$$
#! @EndLatexOnly
#! @Example
P := PolytopeByInequalities( [ [ 0, 0, 1 ], [ 1, -1, -1 ], [ 1, 1, -1 ] ] );
#! <A polytope in |R^2>
Vertices( P );
#! [ [ -1, 0 ], [ 0, 1 ], [ 1, 0 ] ]
#! @EndExample
#! @EndChunk
