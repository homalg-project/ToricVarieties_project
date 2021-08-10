# SPDX-License-Identifier: GPL-2.0-or-later
# NConvex: A Gap package to perform polyhedral computations
#
# Implementations
#


################################
##
## Attributes
##
################################

##
InstallMethod( ContainingGrid,
               " for convex objects",
               [ IsConvexObject ],
               
  function( convobj )
    
    return AmbientSpaceDimension( convobj ) * HOMALG_MATRICES.ZZ;
    
end );
