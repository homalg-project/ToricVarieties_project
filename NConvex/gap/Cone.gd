# SPDX-License-Identifier: GPL-2.0-or-later
# NConvex: A Gap package to perform polyhedral computations
#
# Declarations
#

CddAvailable := false;
NormalizAvailable := false;

DeclareCategory( "IsCone",
                 IsFan );
                 
                 
##############################
##
##  Constructors
##
##############################

#! @Chapter Cones
#! @Section Creating cones

#! @Arguments L
#! @Returns a <C>Cone</C> Object
#! @Description
#! The function takes a list of lists $[L_1, L_2, ...]$ where each $L_j$ represents 
#! an inequality and returns the cone defined by them. 
#! For example the $j$'th entry $L_j = [a_{j1},a_{j2},...,a_{jn}]$ corresponds to the inequality
#! $\sum_{i=1}^n a_{ji}x_i \geq 0$.
DeclareOperation( "ConeByInequalities",
                  [ IsList ] );

#! @Arguments Eq, Ineq 
#! @Returns a <C>Cone</C> Object
#! @Description  
#! The function takes two lists. The first list is the equalities and the second is 
#! the inequalities and returns the cone defined by them.
DeclareOperation( "ConeByEqualitiesAndInequalities",
                  [ IsList, IsList ] );

DeclareOperation( "ConeByGenerators",
                  [ IsList ] );
#! @Arguments L
#! @Returns a <C>Cone</C> Object
#! @Description  
#! The function takes a list in which every entry represents a ray in the ambient vector space 
#! and returns the cone defined by them.              
DeclareOperation( "Cone",
                  [ IsList ] );

#! @Arguments cdd_cone 
#! @Returns a <C>Cone</C> Object
#! @Description  
#! This function takes a cone defined in **CddInterface** and converts it to a cone in **NConvex**
if CddAvailable then
DeclareOperation( "Cone",
                  [ IsCddPolyhedron ] );
fi;

##############################
##
##  Attributes 
##
##############################

#! @Section Attributes of Cones

# DeclareAttribute( "RayGenerators", 
#                    IsCone );

#! @Arguments C 
#! @Returns a list
#! @Description  
#! Returns the list of the defining inequalities of the cone <C>C</C>.
DeclareAttribute( "DefiningInequalities", 
                   IsCone );
#! @Arguments C 
#! @Returns a list
#! @Description  
#! Returns the list of the equalities in the defining inequalities of the cone <C>C</C>.
DeclareAttribute( "EqualitiesOfCone", 
                   IsCone );

                    
DeclareAttribute( "FactorConeEmbedding",
                   IsCone );
                  

#! @Arguments C 
#! @Returns a cone
#! @Description  
#! Returns the dual cone of the cone <C>C</C>.
DeclareAttribute( "DualCone",
                  IsCone );


DeclareAttribute( "RaysInFacets",
                  IsCone );
                  
DeclareAttribute( "RaysInFaces",
                  IsCone );

# @Arguments cone 
# @Returns a point in the cone
# @Description  
# Returns an interior point of the cone.
#DeclareAttribute( "InteriorPoint", IsCone );

#! @Arguments C 
#! @Returns a list of cones
#! @Description  
#! Returns the list of all faces of the cone <C>C</C>.                  
DeclareAttribute( "FacesOfCone",
                  IsCone );

#! @Arguments C 
#! @Returns a list of cones
#! @Description  
#! Returns the list of all facets of the cone <C>C</C>.
DeclareAttribute( "Facets",
                  IsCone );

if false then
  #! @Arguments C
  #! @Returns a list
  #! @Description
  #! Returns a list whose $i$'th entry is the number of faces of dimension $i$.
  DeclareAttribute( "FVector", IsCone );
fi;

#! @Arguments C 
#! @Returns a list
#! @Description  
#! Returns a relative interior point (or ray) in the cone <C>C</C>.                  
DeclareAttribute( "RelativeInteriorRay", 
                   IsCone );

#! @Arguments C 
#! @Returns a list
#! @Description  
#! Returns the Hilbert basis of the cone <C>C</C>
DeclareAttribute( "HilbertBasis", IsCone );

#! @Arguments C 
#! @Returns a list
#! @Description  
#! Returns the Hilbert basis of the dual cone of the cone <C>C</C>
DeclareAttribute( "HilbertBasisOfDualCone",
                  IsCone );
                  
DeclareAttribute( "LinearSubspaceGenerators", IsCone );

#! @Arguments C 
#! @Returns a list
#! @Description  
#! Returns a basis of the lineality space of the cone <C>C</C>.
DeclareAttribute( "LinealitySpaceGenerators", IsCone );

#! @Arguments C 
#! @Returns a cdd object
#! @Description  
#! Converts the cone to a cdd object. The operations of CddInterface can then be applied
#! on this convex object.
DeclareAttribute( "ExternalCddCone",  IsCone  );

#! @Arguments C 
#! @Returns an normaliz object
#! @Description  
#! Converts the cone to a normaliz object. The operations of NormalizInterface can then be applied
#! on this convex object.
DeclareAttribute( "ExternalNmzCone",  IsCone );

if false then
  #! @Arguments C
  #! @Returns an integer
  #! @Description
  #! The dimension of the ambient space of the cone, i.e., the space that contains the cone.
  DeclareAttribute( "AmbientSpaceDimension", IsCone );
fi;

#! @Arguments C
#! @Returns a list
#! @Description
#! See <C>LatticePointsGenerators</C> for polyhedrons. Please note that any cone is a polyhedron.
DeclareAttribute( "LatticePointsGenerators",  IsCone  );

#! @Arguments C
#! @Returns a homalg module
#! @Description
#! Returns the homalg $\mathbb{Z}$-module that is generated by the ray generators of the cone.
DeclareAttribute( "GridGeneratedByCone", IsCone );

#! @Arguments C
#! @Returns a homalg module
#! @Description
#! Returns the homalg $\mathbb{Z}$-module that is presented by the matrix whose raws are the ray generators of the cone.
DeclareAttribute( "FactorGrid",
                  IsCone );

#! @Arguments C
#! @Returns a homalg morphism
#! @Description
#! Returns an epimorphism from a free $\mathbb{Z}$-module to <C>FactorGrid(C)</C>.
DeclareAttribute( "FactorGridMorphism",
                  IsCone );

#! @Arguments C
#! @Returns a homalg module
#! @Description
#! Returns the homalg $\mathbb{Z}$-module that is by generated the ray generators of the orthogonal cone on <C>C</C>.
DeclareAttribute( "GridGeneratedByOrthogonalCone",
                  IsCone );   

##############################
##
##  Properties
##
##############################
#! @Section Properties of Cones

#! @Arguments C 
#! @Returns true or false
#! @Description  
#! Returns if the cone <C>C</C> is regular or not.
DeclareProperty( "IsRegularCone", IsCone );

DeclareProperty( "HasConvexSupport", IsCone );

#! @Arguments C 
#! @Returns true or false
#! @Description  
#! Returns if the cone <C>C</C> is ray or not.
DeclareProperty( "IsRay", IsCone );

#! @Arguments C 
#! @Returns true or false
#! @Description  
#! Returns whether the cone is the zero cone or not.
DeclareProperty( "IsZero", IsCone );

# This method is useless for the user and is designed only for internal use.
# It returns some fan that contains the cone.
DeclareAttribute( "SuperFan", IsCone );

##############################
##
##  Methods
##
##############################
#! @Section Operations on cones

#! @Arguments C, m 
#! @Returns a cone
#! @Description  
#! Returns the projection of the cone on the space (O, $x_1,...,x_{m-1}, x_{m+1},...,x_n$ ).
DeclareOperation( "FourierProjection",
                  [ IsCone, IsInt ] );

#! @Arguments C1, C2
#! @Returns a cone
#! @Description  
#! Returns the intersection.
DeclareOperation( "IntersectionOfCones",
                  [ IsCone, IsCone ] );
#! @Arguments L 
#! @Returns a cone
#! @Description  
#! The input is a list of cones and the output is their intersection.
DeclareOperation( "IntersectionOfCones",
                  [ IsList ] );

#! @Arguments C1, C2 
#! @Returns a true or false
#! @Description  
#! Returns if the cone <C>C1</C> contains the cone <C>C2</C>.
DeclareOperation( "Contains",
                  [ IsCone, IsCone ] );

#! @Arguments L, C
#! @Returns a true or false
#! @Description  
#! Checks whether the input point (or ray) <C>L</C> is in the relative interior of the cone <C>C</C>.
DeclareOperation( "IsRelativeInteriorRay",
                  [ IsList, IsCone ] );
                  
DeclareOperation( "\*",
                [ IsInt, IsCone ] );

#! @InsertChunk example1
                   
DeclareOperation( "\*",
                  [ IsHomalgMatrix, IsCone ] );

#! @Arguments C
#! @Returns a list
#! @Description  
#! It returns a list of inequalities that define the cone.
DeclareOperation( "NonReducedInequalities",
                  [ IsCone ] );

DeclareOperation( "StarSubdivisionOfIthMaximalCone",
                      [ IsFan, IsInt ] );


DeclareOperation( "StarFan", 
                      [ IsCone ] );

DeclareOperation( "StarFan", 
                      [ IsCone, IsFan ] );

DeclareGlobalFunction( "SolutionPostIntMat" ); 
DeclareGlobalFunction( "AddIfPossible" ); 
DeclareGlobalFunction( "IfNotReducedReduceOnce" );
DeclareGlobalFunction( "ReduceTheBase" );

