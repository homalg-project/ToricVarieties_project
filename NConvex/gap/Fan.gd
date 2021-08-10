# SPDX-License-Identifier: GPL-2.0-or-later
# NConvex: A Gap package to perform polyhedral computations
#
# Declarations
#


#! @Chapter Fans
#! @Section Constructors
#! 

##
DeclareCategory( "IsFan",
                 IsConvexObject );

#! @Arguments F
#! @Returns a fan object
#! @Description
#! If the input <A>F</A> is fan then return <A>F</A>.
DeclareOperation( "Fan",
                 [ IsFan ] );

#! @Arguments C
#! @Returns a fan object
#! @Description
#! The input is a list of list $C$. the output is the fan defined by the cones 
#! $\{\mathrm{Cone}_i(C_i )\}_{C_i\in C}$.
DeclareOperation( "Fan",
                 [ IsList ] );

#! @Arguments R, C
#! @Returns a fan object
#! @Description
#! The input is two lists, $R$ that indicates the rays and $C$
#! that indicates the cones. The output is the fan defined by the cones
#! $\{\mathrm{Cone}_i(\{ R_j, j\in C_i\} )\}_{C_i\in C}$.
DeclareOperation( "Fan",
                 [ IsList, IsList ] );
#! @InsertChunk fan1
#! @InsertChunk fan2


DeclareOperation( "FanWithFixedRays",
                 [ IsList, IsList ] );

DeclareOperation( "DeriveFansFromTriangulation",
                 [ IsList, IsBool ] );

#! @Arguments R
#! @Returns a list of fans
#! @Description
#! The input is a list of ray generators $R$. Provided that the package
#! TopcomInterface is available, this function computes the list of all
#! fine and regular triangulations of these ray generators. It then returns
#! the list of the associated fans of these triangulations.
DeclareOperation( "FansFromTriangulation",
                 [ IsList ] );

#! @Arguments R
#! @Returns a fan
#! @Description
#! The input is a list of ray generators $R$. Provided that the package
#! TopcomInterface is available, this function computes a
#! fine and regular triangulation of these ray generators and returns
#! the associated fan.
DeclareOperation( "FanFromTriangulation",
                 [ IsList ] );

#! @InsertChunk fan3

##################################
##
##  Attributes
##
##################################

#! @Chapter Fans
#! @Section Attributes
#! 

#! @Arguments F
#! @Returns a list
#! @Description
#! The input is a fan <A>F</A>. The output is the set of all ray generators of the maximal cones in the fan.
DeclareAttribute( "RayGenerators",
                    IsFan );

#! @Arguments F
#! @Returns a list
#! @Description
#! The input is a fan <A>F</A>. The output is the given or defining set of ray generators of the maximal cones in the fan.
DeclareAttribute( "GivenRayGenerators",
                    IsFan );                    

#! @Arguments F
#! @Returns a list
#! @Description
#! The input is a fan <A>F</A>. The output is a list of lists.
#! which represent an incidence matrix for the correspondence of the rays and the maximal cones of the fan <A>F</A>.
#! The i'th list in the result represents the i'th maximal cone of <A>F</A>.
#! In such a list, the j'th entry is $1$ if the j'th ray is in the cone, 0 otherwise.
DeclareAttribute( "RaysInMaximalCones",
                  IsFan );

#! @Arguments F
#! @Returns a list
#! @Description
#! The input is a fan <A>F</A>. The output is a list of the maximal cones of <A>F</A>.
DeclareAttribute( "MaximalCones",
                  IsFan );

#! @Arguments F
#! @Returns a list
#! @Description
#! Description
DeclareAttribute( "FVector",
                  IsFan );
 
DeclareAttribute( "RaysInAllCones", 
                  IsFan );

DeclareAttribute( "RaysInTheGivenMaximalCones",
                  IsFan );

DeclareAttribute( "GivenMaximalCones",
                  IsFan );

DeclareAttribute( "AllCones",
                  IsFan );

DeclareAttribute( "Rays",
                  IsFan );

DeclareAttribute( "PrimitiveCollections",
                  IsFan );

#################################
##
##  Properties
##
#################################
#! @Chapter Fans
#! @Section Properties
#! 

#! @Arguments F
#! @Returns a true or false
#! @Description
#! It checks whether the constructed fan is well defined or not.
DeclareProperty( "IsWellDefinedFan",
                  IsFan );

#! @Arguments F
#! @Returns a true or false
#! @Description
#! Checks whether the fan is complete, i.e. if its support is the whole space.
DeclareProperty( "IsComplete",
                   IsFan );

#! @Arguments F
#! @Returns a true or false
#! @Description
#! Checks whether the fan is pointed, i.e., that every cone it contains is pointed.
DeclareProperty( "IsPointed",
                 IsFan );

#! @Arguments F
#! @Returns a true or false
#! @Description
#! Checks if the fan is smooth, i.e. if every cone in the fan is smooth.
DeclareProperty( "IsSmooth",
                 IsFan );

#! @Arguments F
#! @Returns a true or false
#! @Description
#! Checks if the fan is simplicial, i.e. if every cone in the fan is simplicial.
DeclareProperty( "IsSimplicial",
                 IsFan );

#! @Arguments F
#! @Returns a true or false
#! @Description
#! Checks if the fan is normal as described in (Theorem 4.7, Combinatorial convexity and algebraic geometry, Ewald, Guenter).
DeclareProperty( "IsNormalFan",
                 IsFan );

#! @Arguments F
#! @Returns a true or false
#! @Description
#! Synonyme to <C>IsNormalFan</C>
DeclareProperty( "IsRegularFan",
                 IsFan );

#! @Arguments F
#! @Returns a true or false
#! @Description
#! Checks whether the fan is a fano fan.
DeclareProperty( "IsFanoFan",
                 IsFan );

#################################
##
##    Operations on fans
##
#################################

#! @Chapter Fans
#! @Section Operations on fans
#! 

DeclareOperation( "\*",
                 [ IsFan, IsFan ] );

DeclareOperation( "ToricStarFan",
                  [ IsFan, IsFan ] );

DeclareOperation( "CanonicalizeFan",
                  [ IsFan ] );
                  
DeclareOperation( "MaximalCones",
                  [ IsFan, IsInt ] );

#! @InsertChunk fan4

#################################
##
## some extra operations
##
################################

DeclareOperation( "FirstLessTheSecond",
                   [ IsList, IsList] );
                   

DeclareOperation( "OneMaximalConeInList",
                   [ IsList] );
                   
DeclareOperation( "ListOfMaximalConesInList",
                   [ IsList] );
