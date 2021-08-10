LoadPackage( "NConvex" );

#! @Chunk zsolve
#! $\newline$
#! To illustrate the using of this function, let us compute the integers solutions of the system:
#!  $\newline3x+5y=8\newline$
#!  $4x-2y\geq 2\newline$
#!  $ 3x+y\geq 3\newline$
#! @Example
SolveEqualitiesAndInequalitiesOverIntergers( [ [ 3, 5 ] ], [ 8 ],
[ [ 4, -2 ], [ 3, 1 ] ], [ 2, 3 ] );
#! [ [ [ 1, 1 ] ], [ [ 5, -3 ] ], [  ] ]
SolveEqualitiesAndInequalitiesOverIntergers( [ [ 3, 5 ] ], [ 8 ],
[ [ 4, -2 ], [ 3, 1 ] ], [ 2, 3 ], [ 1, 1 ] );
#! [ [ [ 1, 1 ] ], [  ], [  ] ]
#! @EndExample
#! So the set of all solutions is given by $\{(1,1)+y*(5,-3),y\geq 0\}$ and it has only one positive solution $(1,1)$.
#! @EndChunk
