# SPDX-License-Identifier: GPL-2.0-or-later
# NConvex: A Gap package to perform polyhedral computations
#
# Declarations
#


DeclareCategory( "IsPolytope",
                 IsConvexObject );

####################################
##
## Constructors
##
####################################

#! @Chapter Polytopes
#! @Section Creating polytopes

#! @Arguments L
#! @Returns a Polytope Object
#! @Description  
#! The operation takes a list $L$ of lists $[L_1, L_2, ...]$ where each $L_j$ represents 
#! an inequality and returns the polytope defined by them (if they define a polytope). 
#! For example the $j$'th entry $L_j = [c_j,a_{j1},a_{j2},...,a_{jn}]$ corresponds to the inequality
#! $c_j+\sum_{i=1}^n a_{ji}x_i \geq 0$.
DeclareOperation( "PolytopeByInequalities",
                  [ IsList ] );

#! @Arguments L
#! @Returns a Polytope Object
#! @Description  
#! The operation takes the list of the vertices and returns the polytope defined by them.
DeclareOperation( "Polytope",
                  [ IsList ] );

                  
####################################
##
## Attributes
##
####################################

#! @Section Attributes

#! @Arguments P 
#! @Returns a CddPolyhedron
#! @Description  
#! Converts the polytope to a CddPolyhedron. The operations of CddInterface can then be applied
#! on this polyhedron.
DeclareAttribute( "ExternalCddPolytope",
                    IsPolytope );

#! @Arguments P 
#! @Returns a List
#! @Description  
#! The operation returns the list of integer points inside the polytope.                    
DeclareAttribute( "LatticePoints",
                    IsPolytope );
  
#! @Arguments P 
#! @Returns a List
#! @Description  
#! The operation returns the interior lattice points inside the polytope.                    
DeclareAttribute( "RelativeInteriorLatticePoints",
                    IsPolytope );
 
DeclareAttribute( "LatticePointsGenerators",
                    IsPolytope );

#! @Arguments P 
#! @Returns a list of lists
#! @Description  
#! The operation returns the vertices of the polytope  
DeclareAttribute( "VerticesOfPolytope",
                    IsPolytope );

#! @Arguments P 
#! @Returns a list of lists
#! @Description  
#! The same output as <C>VerticesOfPolytope</C>.
DeclareOperation( "Vertices",
                  [ IsPolytope ] );
                  
DeclareOperation( "HasVertices",
                  [ IsPolytope ] );

#! @Arguments P 
#! @Returns a list of lists
#! @Description  
#! The operation returns the defining inequalities of the polytope.
#! I.e., a list of lists $[L_1, L_2, ...]$ where each 
#! $L_j=[c_j,a_{j1},a_{j2},...,a_{jn}]$ represents the inequality 
#! $c_j+\sum_{i=1}^n a_{ji}x_i \geq 0$. If $L$ and $-L$ occur in the 
#! output then $L$ is called a defining-equality of the polytope.
DeclareAttribute( "DefiningInequalities",
                    IsPolytope );                    

#! @Arguments P 
#! @Returns a list of lists
#! @Description
#! The operation returns the defining-equalities of the polytope.
DeclareAttribute( "EqualitiesOfPolytope",
                    IsPolytope );

#! @Arguments P 
#! @Returns a list of lists
#! @Description  
#! The operation returns the list of the inequalities of the facets.
#! Each defining inequality that is not defining-equality of the 
#! polytope is a facet inequality.
DeclareAttribute( "FacetInequalities",
                    IsPolytope );

#! @Arguments P 
#! @Returns a list of lists
#! @Description  
#! The operation returns list of lists $L$. The entries of each $L_j$
#! in $L$ consists of $0$'s or $1$'s. For instance, if $L_j=[1,0,0,1,0,1]$, then
#! The polytope has $6$ vertices and the vertices of the $j$'th facet are $\{V_1,V_4,V_6\}$.
DeclareAttribute( "VerticesInFacets",
                    IsPolytope );

#! @Arguments P 
#! @Returns a fan
#! @Description  
#! The operation returns the normal fan of the given polytope.
DeclareAttribute( "NormalFan",
                    IsPolytope );

#! @Arguments P 
#! @Returns a fan
#! @Description
#! The operation returns the face fan of the given polytope. Remember that the face fan of a polytope is isomorphic to the normal fan of its
#! polar polytope.
DeclareAttribute( "FaceFan",
                    IsPolytope );

#! @Arguments P 
#! @Returns a cone
#! @Description  
#! If the ambient space of the polytope is $\mathrm{R}^n$, then the output is a cone in 
#! $\mathrm{R}^{n+1}$. The defining rays of the cone are 
#! ${[a_{j1},a_{j2},...,a_{jn},1]}_j$ such that $V_j=[a_{j1},a_{j2},...,a_{jn}]$ is
#! a vertex in the polytope.
DeclareAttribute( "AffineCone",
                    IsPolytope );

DeclareAttribute( "BabyPolytope",
                    IsPolytope );

#! @Arguments P 
#! @Returns a Polytope
#! @Description  
#! The operation returns the polar polytope of the given polytope.                   
DeclareAttribute( "PolarPolytope",
                    IsPolytope );

#! @Arguments P 
#! @Returns a Polytope
#! @Description  
#! The operation returns the dual polytope of the given polytope.
DeclareAttribute( "DualPolytope",
                    IsPolytope );

DeclareOperation( "GaleTransform", [ IsHomalgMatrix ] );

DeclareAttribute( "FVector", IsPolytope );

####################################
##
## Properties
##
####################################

#! @Section Properties

#! @Arguments P 
#! @Returns a true or false
#! @Description  
#! Returns whether the polytope empty or not
DeclareProperty( "IsEmpty",
                 IsPolytope );

DeclareProperty( "IsNotEmpty",
                 IsPolytope );

#! @Arguments P 
#! @Returns a true or false
#! @Description  
#! Returns whether the polytope is lattice polytope or not.
DeclareProperty( "IsLatticePolytope",
                 IsPolytope );
#! @Arguments P 
#! @Returns a true or false
#! @Description  
#! Returns whether the polytope is very ample or not.
DeclareProperty( "IsVeryAmple",
                 IsPolytope );

#! @Arguments P 
#! @Returns a true or false
#! @Description  
#! Returns whether the polytope is normal or not.
DeclareProperty( "IsNormalPolytope",
                 IsPolytope );

#! @Arguments P 
#! @Returns a true or false
#! @Description  
#! Returns whether the polytope is simplicial or not.
DeclareProperty( "IsSimplicial",
                 IsPolytope );

#! @Arguments P 
#! @Returns a true or false
#! @Description  
#! Returns whether the polytope is simplex polytope or not.
DeclareProperty( "IsSimplexPolytope",
                 IsPolytope );
                 
#! @Arguments P 
#! @Returns a true or false
#! @Description  
#! Returns whether the polytope is simple or not.
DeclareProperty( "IsSimplePolytope",
                 IsPolytope );
                 
DeclareProperty( "IsBounded",
                 IsPolytope );

#! @Arguments P 
#! @Returns a true or false
#! @Description  
#! Returns whether the polytope is reflexive or not, i.e., if its dual polytope is lattice
#! polytope.
DeclareProperty( "IsReflexive", IsPolytope );

#! @Arguments P 
#! @Returns a true or false
#! @Description  
#! returns whether the polytope is Fano or not. Fano polytope is a full dimensional lattice polytope whose vertices are 
#! primitive elements in the containing lattice, i.e., each vertex is not a positive integer multiple of any other lattice element.
DeclareProperty( "IsFanoPolytope", IsPolytope );

#! @Arguments P 
#! @Returns a true or false
#! @Description  
#! returns whether the polytope is canonical Fano or not. A canonical Fano polytope is a full dimensional lattice polytope whose relative
#! interior contains only one lattice point, namely the origin.
DeclareProperty( "IsCanonicalFanoPolytope", IsPolytope );

#! @Arguments P 
#! @Returns a true or false
#! @Description  
#! returns whether the polytope is terminal Fano or not. A terminal Fano polytope is a full dimensional lattice polytope whose
#! lattice points are its vertices and the origin.
DeclareProperty( "IsTerminalFanoPolytope", IsPolytope );



#! @Arguments P 
#! @Returns a true or false
#! @Description  
#! Returns whether the polytope is smooth fano polytope or not, i.e, if the vertices in each facet form a basis for the containing lattice or not.
#! polytope.
DeclareProperty( "IsSmoothFanoPolytope", IsPolytope );

################################
##
## Methods
##
################################

#! @Section Operations on polytopes

# @Arguments P1, P2
# @Returns a polytope
# @Description
# The output is cartesian product of the input polytopes. The cartesian product of two polytopes 
# $P$ and $Q$ is defined by $\{(M,N),M \in P & N \in Q\}$.
DeclareOperation( "\*",
                  [ IsPolytope, IsPolytope ] );

#! @Arguments P1, P2
#! @Returns a polytope
#! @Description
#! The output is Minkowski sum of the input polytopes.
DeclareOperation( "\+",
                  [ IsPolytope, IsPolytope ] );

#! @Arguments n, P
#! @Returns a polytope
#! @Description
#! The output is Minkowski sum of the input polytope with itself $n$ times.
DeclareOperation( "\*",
                  [ IsInt, IsPolytope ] );

DeclareOperation( "\*",
                  [ IsPolytope, IsInt ] );

# @Arguments P1, P2
# @Returns a polytope
# @Description
# The output The free sum  of the given polytopes. The free sum of two polytopes $P$ and $Q$ is
# defined by $\{(M,0),M\in P\} \cub \{ (0,N),N\in Q\}$.
DeclareOperation( "FreeSumOfPolytopes", [ IsPolytope, IsPolytope ] );

#! @Arguments P1, P2
#! @Returns a polytope
#! @Description
#! The output is the intersection of the input polytopes. 
DeclareOperation( "IntersectionOfPolytopes",
                  [ IsPolytope, IsPolytope ] );
                  
DeclareOperation( "Points", 
                  [ IsList, IsList] );

DeclareOperation( "FourierProjection", 
                  [ IsPolytope, IsInt ] );

#! @Arguments P
#! @Returns a list
#! @Description
#! Returns a random interior point in the polytope.
DeclareOperation( "RandomInteriorPoint", 
                  [ IsPolytope ] );

#! @Arguments M, P
#! @Returns true or false
#! @Description
#! Checks if the given point is interior point of the polytope.
DeclareOperation( "IsInteriorPoint", 
                  [ IsList,IsPolytope ] );

#! @InsertChunk example2
