#! @Chapter Check speciality of line bundles

#! @Section Examples

LoadPackage( "QSMExplorer" );

#! A line bundle $L$ on a tree-like, rational, nodal curve $C$ is special iff its cohomologies jump under deformation of $C$. This algorithm, invented by Prof. Dr. Ron Donagi (University of Pennsylvania) decides if $(L,C)$ is special. Here are examples.

#! @Example
s1 := Speciality( [ 1, 1, 1, -1, -1, -1, -1 ], [ [0,1], [1,2], [0,3], [0,4], [1,5], [1,6] ], false );;
s1;
#! true
degrees := [ 1,1,1,1,2,-1,-1,-1,-1,-1,-1 ];;
edges := [ [0,1],[1,2],[2,3],[3,4],[0,5],[1,6],[1,7],[2,8],[3,9],[3,10] ];;
s2 := Speciality( degrees, edges, false );;
s2;
#! true
s3 := Speciality( [ 0, -5 ], [ [0,1] ], false );;
s3;
#! false
s4 := Speciality( [ 1, -5 ], [ [0,1] ], false );;
s4;
#! true
edges := [ [0,1], [1,2], [3,0], [4,0], [5,1], [6,1] ];;
degrees := [ 1, 1, 1, -1, -1, -1, -1 ];;
s5 := Speciality( degrees, edges, false );;
s5;
#! true
edges := [ [0,1], [1,2], [3,0], [4,0], [5,1], [6,1] ];;
degrees := [2,1,1,-1,-1,-1,-1];;
s6 := Speciality( degrees, edges, false );;
s6;
#! false
edges := [ [0,1], [1,2], [3,0], [4,0], [5,1], [6,1] ];;
degrees := [ 1, 1, 0, -1, -1, -1, -1 ];;
s7 := Speciality( degrees, edges, false );;
s7;
#! false
edges := [ [0,1], [1,2], [3,0], [4,0], [5,1], [6,1] ];;
degrees := [ 1, 1, -1, -1, -1, -1, -1 ];;
s8 := Speciality( degrees, edges, false );;
s8;
#! false
#! @EndExample
