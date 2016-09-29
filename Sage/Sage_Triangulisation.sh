#!/usr/bin/env sage

import sys
from sage.all import *

#if len(sys.argv) != 2:
#    print "Usage: %s <n>"%sys.argv[0]
#    print "Outputs the prime factorization of n."
#    sys.exit(1)

# (step 1) compute the ray generators from the charges
PointConfiguration.set_engine( 'internal' )
charges = matrix( sage_eval(sys.argv[ 1 ] ) )
rays = kernel( charges ).basis_matrix()

# (step2) create a list of points for use in triangulation
dim_fan = rays.nrows()
zero = [ 0 for i in range( 0, dim_fan ) ]
points = PointConfiguration( rays.augment( vector( zero ) ).transpose() )
points = points.restrict_to_star_triangulations( zero )
points = points.restrict_to_fine_triangulations()

# (step3) triangulate
tria = points.triangulations_list()
triangl = [[i[:-1] for i in j ] for j in tria ]

# (step4) pick the first triangulation, under the assumption that it is good
# not that unfortunately I cannot check for regularity, since I cannot install TOPCOM (yet)
fan = Fan( triangl[ 0 ], points )

# (step5) make minor consistency checks
if not fan.is_smooth() :
     print "Fan not smooth"
     sys.exit( 1 )

if not fan.is_complete():
     print "Fan not complete"
     sys.exit( 1 )

# (step6) translate the fan into information that GAP understands
max_cones = fan.cones()[ dim_fan ]
rays = fan.rays()
generators_of_max_cones = [ [ rays.index( j ) + 1 for j in max_cones[ i ] ] for i in range( 0, len( max_cones ) ) ]
rays = rays.matrix()
ray_generators = [ rays.row(u).list() for u in range( 0, rays.nrows() ) ]
res = [ ray_generators, generators_of_max_cones ]

print res