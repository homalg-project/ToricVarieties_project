LoadPackage( "NConvex" );

#! @Chunk linear_program
#! $\newline$
#! To illustrate the using of this operation, let us solve the linear program:
#! $\\P(x,y)= 1-2x+5y$, with $\newline$
#! $100\leq x \leq 200 \newline$
#! $80\leq y\leq 170 \newline$
#! $y \geq -x+200\newline\newline$
#! We bring the inequalities to the form $b+AX\geq 0$, we get:
#! $\newline -100+x\geq 0 \newline$
#! $200-x \geq 0 \newline$
#! $-80+y \geq 0 \newline$
#! $170 -y \geq 0 \newline$
#! $-200 +x+y \geq 0 \newline$
#! @Example
P := PolyhedronByInequalities( [ [ -100, 1, 0 ], [ 200, -1, 0 ],
[ -80, 0, 1 ], [ 170, 0, -1 ], [ -200, 1, 1 ] ] );;
max := SolveLinearProgram( P, "max", [ 1, -2, 5 ] );
#! [ [ 100, 170 ], 651 ]
min := SolveLinearProgram( P, "min", [ 1, -2, 5 ] );
#! [ [ 200, 80 ], 1 ]
VerticesOfMainRatPolytope( P );
#! [ [ 100, 100 ], [ 100, 170 ], [ 120, 80 ], [ 200, 80 ], [ 200, 170 ] ]
#! @EndExample
#! So the optimal solutions are $(x=100,y=170)$ with maximal value $p=1-2(100)+5(170)=651$ and
#! $(x=200,y=80)$ with minimal value $p=1-2(200)+5(80)=1$.
#! @EndChunk
