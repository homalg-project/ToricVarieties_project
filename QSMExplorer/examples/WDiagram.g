#! @Chapter Computation of minimal roots and their distribution for arbitrary nodal curves.

#! @Section Examples

#! You can use the following as a simple check on your installation of the QSM-Explorer.
#! @Example
n := CountSimpleMinimals( );;
n;
#! [ 7 ]
n := CountSimpleDistribution( );;
n;
#! [ 0, 0, 0, 0, 0, 0, 7, 0, 0 ]
#! @EndExample

#! In addition, we can compute the number of minimal weights and their distributions efficiently. Say for example that we have two genus $$g = 0$$ curves joined by two edges. On both curves, the line bundle has degree 4 and we want 2 roots. Then we count the minimal roots as follows:

#! @Example
n := CountMinimals( [ 0, 0 ], [ 4, 4 ], [ [ 0, 1 ], [ 0, 1 ] ], 1, 2 );;
n;
#! [ 1 ]
#! @EndExample

#! Likewise, we can compute the distribution. For this, we need so set also a limit $$L$$, so that we only count limit roots with at most $$L$$ global sections. Hence, we modify the above code as follows to count up to $$h^0 = 20$$:

#! @Example
n := CountDistribution( [ [ 0, 0 ], [ 4, 4 ], [ [ 0, 1 ], [ 0, 1 ] ], 1, 2, 4, 6 ] );;
n;
#! [ 1, 0, 0 ]
#! @EndExample

#! Here are more examples:

#! @Example
n1 := CountDistribution( [ [ 0,0,0 ], [ 16, 16, 16 ], [ [0,1], [0,1], [0,1], [0,1], [0,2], [1,2] ], 4, 8, 3, 8 ] );;
n1;
#! [ 2030, 70, 0, 0, 0, 0 ]
n2 := CountDistribution( [ [ 0,0,0,0 ], [ 16, 16, 16, 16 ], [ [0,1], [0,1], [0,1], [0,1], [0,2], [1,2], [0,3], [1,3] ], 5, 8, 3, 8 ] );;
n2;
#! [ 0, 9331, 5334, 42, 0, 0 ]
n3 := CountDistribution( [ [ 0,0,0 ], [ 36, 8, 36 ], [ [0,1], [0,1], [0,1], [0,1], [0,2], [1,2] ], 4, 16, 1, 8 ] );;
n3;
#! [ 0, 8080, 28631, 7552, 34, 0, 0, 0 ]
n4 := CountDistribution( [ [ 0,0,0 ], [ 34, 8, 38 ], [ [0,1], [0,1], [0,1], [0,1], [0,2] ], 4, 16, 2, 8 ] );;
n4;
#! [ 0, 1547, 1582, 35, 0, 0, 0 ]
#! @EndExample
