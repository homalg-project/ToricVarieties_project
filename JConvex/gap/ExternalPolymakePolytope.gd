#############################################################################
##
##  ExternalPolymakePolytope.gd  JConvex package
##                               Martin Bies
##
##  Copyright 2021               University of Pennsylvania
##
##  A Gap package to do convex geometry by Polymake
##
#! @Chapter External PolymakePolytopes
##
#############################################################################


##############################################################################################
##
#! @Section GAP category of PolymakePolytopes
##
##############################################################################################

#! @Description
#! The GAP category for polytopes residing in Polymake
#! @Returns true or false
#! @Arguments object
DeclareCategory( "IsPolymakePolytope",
                 IsObject );

##############################################################################################
##
#! @Section Constructors for PolymakePolytopes
##
##############################################################################################

#! @Arguments genes[, linearities_list ]
#! @Returns a PolymakePolytope
#! @Description
#! The function takes a list in which every entry represents a vertex in the ambient vector space.
#! In case we want some vertices to be free (the vertex and its negative belong to the PolymakePolytope) we should refer
#! in a second list to their indices.
DeclareGlobalFunction( "Polymake_PolytopeByGenerators" );

#! @Arguments ineq [, linearities_list ]
#! @Returns a PolymakePolytope
#! @Description
#! The function takes a list in which every entry represents an inequality (or equality).
#! In case we want some entries to represent equalities we should refer in a second list to their indices.
DeclareGlobalFunction( "Polymake_PolytopeFromInequalities" );


##############################################################################################
##
#! @Section Attributes of PolymakePolytopes
##
##############################################################################################

#! @Arguments P
#! @Returns a PolymakeCone
#! @Description
#! The function takes a PolymakePolytope and returns its canonical V-rep.
DeclareAttribute( "Polymake_CanonicalPolytopeByGenerators",  IsPolymakePolytope  );

#! @Arguments P
#! @Returns a PolymakeCone
#! @Description
#! The function takes a PolymakePolytope and returns its canonical H-rep.
DeclareAttribute( "Polymake_CanonicalPolytopeFromInequalities",  IsPolymakePolytope  );

#! @Arguments P
#! @Returns a PolymakePolytope
#! @Description
#! The function takes a PolymakePolytope and returns its reduced $V$-representation.
DeclareAttribute( "Polymake_V_Rep",  IsPolymakePolytope  );

#! @Arguments P
#! @Returns a PolymakePolytope
#! @Description 
#! The function takes a PolymakePolytope and returns its reduced $H$-representation. 
DeclareAttribute( "Polymake_H_Rep",  IsPolymakePolytope  );
#! @InsertChunk Example4

#! @Arguments P
#! @Returns The dimension of the ambient space of the PolymakePolytope(i.e., the space that contains $P$).
DeclareAttribute( "Polymake_AmbientSpaceDimension", IsPolymakePolytope );

#! @Arguments P
#! @Returns The dimension of the PolymakePolytope, where the dimension, $\mathrm{dim}(P)$, of a PolymakePolytope $P$
#! is the maximum number of affinely independent points in $P$ minus 1.
DeclareAttribute( "Polymake_Dimension", IsPolymakePolytope );

#! @Arguments P
#! @Returns The vertices of the PolymakePolytope.
DeclareAttribute( "Polymake_Vertices", IsPolymakePolytope );

#! @Arguments P
#! @Returns The linealities of the PolymakePolytope.
DeclareAttribute( "Polymake_Linealities", IsPolymakePolytope );

#! @Arguments P
#! @Returns a list
#! @Description
#! The output is the equalities of the PolymakePolytope.
DeclareAttribute( "Polymake_Equalities", IsPolymakePolytope );

#! @Arguments P
#! @Description
#! The output is the inequalities of the PolymakePolytope.
DeclareAttribute( "Polymake_Inequalities", IsPolymakePolytope );

#! @Arguments P
#! @Description
#! The output are the lattice points of the given polytope.
DeclareAttribute( "Polymake_LatticePoints", IsPolymakePolytope );


##############################################################################################
##
#! @Section Properties of PolymakePolytopes
##
##############################################################################################

#! @Arguments P
#! @Returns true or false
#! @Description
#! The output is <C>true</C> if the PolymakePolytope is empty and <C>false</C> otherwise
DeclareProperty( "Polymake_IsEmpty", IsPolymakePolytope );

#! @Arguments P
#! @Returns true or false
#! @Description
#! The output is <C>true</C> if the PolymakePolytope is pointed and <C>false</C> otherwise
DeclareProperty( "Polymake_IsPointed", IsPolymakePolytope );
#! @InsertChunk demo

#! @Arguments P
#! @Returns true or false
#! @Description
#! Returns if the polytope is bounded or not.
DeclareProperty( "Polymake_IsBounded", IsPolymakePolytope );


##############################################################################################
##
#! @Section Intersection of two polytopes
##
##############################################################################################

#! @Arguments P1, P2
#! @Description
#! The output is the intersection of P1 and P2.
DeclareOperation( "Polymake_Intersection", [ IsPolymakePolytope, IsPolymakePolytope ] );
