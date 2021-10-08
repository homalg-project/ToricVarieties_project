#! @Chapter Computation of minimal roots and their distribution for arbitrary nodal curves with external legs.

LoadPackage( "QSMExplorer" );

#! @Section Examples

#! You can also specify external legs and counts the roots on a nodal curve subject to these external legs. The following code executes this computation for a simple example:
#! @Example
CountDistributionWithExternalLegs( [ [ 0,0,0 ], [ 16, 16, 16 ], [ [0,1], [1,2], [2,0] ], 1, 8, 0, 8, [ 0, 0, 1 ], [ 2, 2, 4 ] ], false );;
#! @EndExample

# The 2nd but last argument tells us that there is an external leg attached to the vertex $0$, another external leg is also attached to the vertex $0$ and there is one external leg attached to vertex $1$. The last argument lists the weights along these legs. Let us modify this example slightly:

#! @Example
n := CountDistributionWithExternalLegs( [ [ 0,0,0,1 ], [ 16, 16, 16, 16 ], [ [0,1], [1,2], [2,0], [0,3], [1,3], [0,4], [4,2] ], 5, 8, 0, 8, [ 0, 0, 3 ], [ 2, 2, 4 ] ], false );;
n;
#! [ 0, 0, 0, 0, 13652, 64, 0, 0, 0 ]
#! @EndExample
