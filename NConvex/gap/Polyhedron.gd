# SPDX-License-Identifier: GPL-2.0-or-later
# NConvex: A Gap package to perform polyhedral computations
#
# Declarations
#


DeclareCategory( "IsPolyhedron",
                 IsConvexObject );

#####################################
##
## Constructors
##
#####################################

#! @Chapter Polyhedrons
#! @Section Creating polyhedron

#! @Arguments L
#! @Returns a <C>Polyhedron</C> Object
#! @Description  
#! The function takes a list of lists <C>L</C>$:=[L_1, L_2, ...]$ where each $L_j$ represents 
#! an inequality and returns the polyhedron defined by them. 
#! For example the $j$'th entry $L_j = [c_j,a_{j1},a_{j2},...,a_{jn}]$ corresponds to the inequality
#! $c_j+\sum_{i=1}^n a_{ji}x_i \geq 0$.
DeclareOperation( "PolyhedronByInequalities",
                  [ IsList ] );

#! @Arguments P, C
#! @Returns a <C>Polyhedron</C> Object
#! @Description
#! The input is a polytope <C>P</C> and a cone <C>C</C>. The output is the polyhedron defined by the Minkowski sum <C>P+C</C>.
DeclareOperation( "Polyhedron",
                  [ IsPolytope, IsCone ] );
#! @Arguments L, C
#! @Returns a <C>Polyhedron</C> Object
#! @Description  
#! The input is a list <C>L</C> and a cone <C>C</C>. The output is the polyhedron defined by the Minkowski sum 
#! <C>P+C</C> where <C>P</C> is the polytope, i.e., the convex hull, defined by the points <C>L</C>.
DeclareOperation( "Polyhedron",
                  [ IsList, IsCone ] );
#! @Arguments P, L
#! @Returns a <C>Polyhedron</C> Object
#! @Description
#! The input is a polytope <C>P</C> and a list <C>L</C>. The output is the polyhedron defined by the Minkowski sum 
#! <C>P+C</C> where <C>C</C> is the cone defined by the rays <C>L</C>.
DeclareOperation( "Polyhedron",
                  [ IsPolytope, IsList ] );

#! @Arguments P, C
#! @Returns a <C>Polyhedron</C> Object
#! @Description
#! The input is a list <C>P</C> and a list <C>C</C>. The output is the polyhedron defined by the Minkowski sum 
#! of the polytope defined by <C>P</C> and the cone defined by <C>C</C>.
DeclareOperation( "Polyhedron",
                  [ IsList, IsList ] );

                 
#####################################
##
## Structural Elements
##
#####################################

#! @Section Attributes

#! @Arguments P
#! @Returns cdd Object
#! @Description  
#! Converts the polyhedron to a cdd object. The operations of CddInterface can then be applied
#! on this convex object.
DeclareAttribute( "ExternalCddPolyhedron",
                   IsPolyhedron );
#! @Arguments P
#! @Returns normaliz Object
#! @Description  
#! Converts the polyhedron to an normaliz object. The operations of NormalizInterface can then be applied
#! on this convex object.
DeclareAttribute( "ExternalNmzPolyhedron",
                   IsPolyhedron );
                   
#! @Arguments P
#! @Returns a list
#! @Description  
#! Returns the Defining inequalities of the given polyhedron.
DeclareAttribute( "DefiningInequalities",
                   IsPolyhedron );

#! @Arguments P
#! @Returns a <C>Polytope</C> Object
#! @Description  
#! Returns the main rational polytope of the polyhedron.
DeclareAttribute( "MainRatPolytope",
                  IsPolyhedron );

#! @Arguments P
#! @Returns a <C>Polytope</C> Object
#! @Description  
#! Returns the main integral polytope of the given polyhedron.
DeclareAttribute( "MainPolytope",
                  IsPolyhedron );

#! @Arguments P
#! @Returns a list
#! @Description  
#! Returns the vertices of the main rational polytope of the polyhedron.
DeclareAttribute( "VerticesOfMainRatPolytope",
                  IsPolyhedron );

#! @Arguments P
#! @Returns a list
#! @Description  
#! Returns the vertices of the main integral polytope of the given polyhedron.
DeclareAttribute( "VerticesOfMainPolytope",
                  IsPolyhedron );

#! @Arguments P
#! @Returns a <C>Cone</C> Object
#! @Description  
#! Returns the tail cone of the polyhedron.
DeclareAttribute( "TailCone",
                  IsPolyhedron );

#! @Arguments P
#! @Returns a list
#! @Description  
#! Returns the Ray Generators of the tail cone.
DeclareAttribute( "RayGeneratorsOfTailCone",
                  IsPolyhedron );

DeclareAttribute( "HomogeneousPointsOfPolyhedron",
                  IsPolyhedron );
#! @Arguments P
#! @Returns a list
#! @Description  
#! Returns the integral lattice generators of the polyhedron. The output is a list $L$ of length $3$. Any integral point in
#! polyhedron can be written as $a+mb+nc$, where $a\in L[1],b\in L[2],c\in L[3], m\geq 0$.
DeclareAttribute( "LatticePointsGenerators",
                  IsPolyhedron );

#! @Arguments P
#! @Returns a list
#! @Description  
#! Returns a basis to the lineality space of the polyhedron. I.e., a basis to the vector space that is contained in <C>P</C>.
DeclareAttribute( "BasisOfLinealitySpace",
                  IsPolyhedron );
#! @Arguments P
#! @Returns a list
#! @Description  
#! Returns a list whose $i$'th entry is the number of faces of dimension $i-1$.
DeclareAttribute( "FVector", IsPolyhedron );

#####################################
##
## Properties
##
#####################################

#! @Section Properties

#! @Arguments P
#! @Returns true or false
#! @Description  
#! The input is a polyhedron P and the output is whether it is bounded or not.
DeclareProperty( "IsBounded",
                 IsPolyhedron );

DeclareProperty( "IsNotEmpty",
                 IsPolyhedron );

#! @Arguments P
#! @Returns true or false
#! @Description  
#! The input is a polyhedron P and the output is whether its tail cone is pointed or not.
DeclareProperty( "IsPointed",
                 IsPolyhedron );

#DeclareGlobalFunction( "Draw" );

#! @InsertChunk example3

#! @Section Solving Linear programs
#! The problem of solving linear programs can be solved in the gap package
#! <C>CddInterface</C>, which is required by <C>NConvex</C>.

#! @Arguments P, max_or_min, target_func
#! @Returns a list or fail
#! @Description  
#! The input is a polyhedron <C>P</C>, a string <C>max_or_min</C> $\in$ {"max", "min"} and an objective function 
#! <C>target_func</C>, which we want to maximize or minimize. If the linear program has an optimal solution,
#! the operation returns a list of two entries, the solution vector and the optimal value of the objective function,
#! otherwise it returns fail.
DeclareOperation( "SolveLinearProgram", [ IsPolyhedron, IsString, IsList ] );

#! @Arguments P, max_or_min, target_func
#! @Returns a list or fail
#! @Description  
#! The input is a polytope <C>P</C>, a string <C>max_or_min</C> $\in$ {"max","min"} and an objective function 
#! <C>target_func</C>, which we want to maximize or minimize. If the linear program has an optimal solution,
#! the operation returns a list of two entries, the solution vector and the optimal value of the objective function,
#! otherwise it returns fail.
DeclareOperation( "SolveLinearProgram", [ IsPolytope, IsString, IsList ] );

#! @InsertChunk linear_program
