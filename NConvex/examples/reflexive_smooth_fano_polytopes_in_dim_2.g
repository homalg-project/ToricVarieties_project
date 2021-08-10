LoadPackage( "NConvex" );

# The following list of reflexive 2-polytopes is taken from
# http://magma.maths.usyd.edu.au/~kasprzyk/research/pdf/fano_polytopes.pdf

L := [
     [ [ 1, 0 ], [ 0, 1 ], [ -1, -1 ] ],
     [ [ 1, 0 ], [ -1, 0 ], [ 0, 1 ], [ 0, -1 ] ],
     [ [ 1, 1 ], [ 0, 1 ], [ -1, 0 ], [ 0, -1 ] ],
     [ [ 1, 1 ], [ 0, 1 ], [ -1, 0 ], [ 0, -1 ], [ -1, -1 ] ],
     [ [ 1, 1 ], [ 0, 1 ], [ -1, 0 ], [ 0, -1 ], [ -1, -1 ], [ 1, 0 ] ],
     [ [ 1, 1 ], [ 1, -1 ], [ 0, 1 ], [ 0, -1 ], [-1, 0] ],
     [ [ 1, 1 ], [ 1, -1 ], [ 0, 1 ], [ -1, -1 ], [-1, 0] ],
     [ [ 1, 1 ], [ 1, -1 ], [ -1, 1 ], [ -1, -1 ] ],
     [ [ 1, 0 ], [ 0, 1 ], [ -1, -2 ] ],
     [ [ 1, 1 ], [ 0, 1 ], [ -1, 0 ], [ -1, -2 ] ],
     [ [ 1, 1 ], [ 0, 1 ], [ -1, 0 ], [  1, -2 ] ],
     [ [ 1, 1 ], [ 1, 0 ], [ -1, 0 ], [ -1, -2 ] ],
     [ [ 1, 1 ], [ -1, 1 ], [-1, -2  ], [ 1, 0 ] ],
     [ [ -1, 2  ], [ -1, -1 ], [ 2, -1 ] ],
     [ [ 1, 0 ], [ 0, 1 ], [ -3, -2 ] ],
     [ [ 3, -1 ], [ -1, -1 ], [ -1, 1 ] ] 
     ];

polytopes := List( L, l -> Polytope( l ) );

Display( List( polytopes, IsReflexive ) );
# [ true, true, true, true, true, true, true, true, true, true, true, true, true, true, 
#   true, true ]

Display( List( polytopes, IsSmoothFanoPolytope ) );
# [ true, true, true, true, true, false, false, false, false, false, false, false, false,
#   false, false, false ]


