####################################################################################
##
##  SemigroupAndConeWrapper.gd   AdditionsForToricVarieties package
##
##  Copyright 2020               Martin Bies,       University of Oxford
##
#! @Chapter Wrapper for generators of semigroups and hyperplane constraints of cones
##
####################################################################################

############################################
##
#! @Section GAP Categories
##
############################################

#! @Description
#! The GAP category of lists of integer-valued lists, which encode the generators of subsemigroups of $Z^n$.
#! @Arguments object
DeclareCategory( "IsSemigroupForPresentationsByProjectiveGradedModules",
                 IsObject );

#! @Description
#! The GAP category of affine semigroups $H$ in $\mathbb{Z}^n$. That means that there is a semigroup 
#! $G \subseteq \mathbb{Z}^n$ and $p \in \mathbb{Z}^n$ such that $H = p + G$.
#! @Arguments object
DeclareCategory( "IsAffineSemigroupForPresentationsByProjectiveGradedModules",
                 IsObject );



############################################
##
#! @Section Constructors
##
############################################

#! @Description
#! The argument is a list $L$ and a non-negative integer $d$. We then check if this list could be the list of generators
#! of a subsemigroup of $Z^d$. If so, we create the corresponding SemigroupGeneratorList.
#! @Returns a SemigroupGeneratorList
#! @Arguments L
DeclareOperation( "SemigroupForPresentationsByProjectiveGradedModules",
                  [ IsList, IsInt ] );
DeclareOperation( "SemigroupForPresentationsByProjectiveGradedModules",
                  [ IsList ] );

#! @Description
#! The argument is a SemigroupForPresentationsByProjectiveGradedModules $S$ and a point $p \in \mathbb{Z}^n$ encoded as list
#! of integers. We then compute the affine semigroup $p + S$. Alternatively to $S$ we allow the use of either a list of
#! generators (or a list of generators together with the embedding dimension).
#! @Returns an AffineSemigroup
#! @Arguments L, p
DeclareOperation( "AffineSemigroupForPresentationsByProjectiveGradedModules",
                  [ IsSemigroupForPresentationsByProjectiveGradedModules, IsList ] );
DeclareOperation( "AffineSemigroupForPresentationsByProjectiveGradedModules",
                  [ IsList, IsList ] );
DeclareOperation( "AffineSemigroupForPresentationsByProjectiveGradedModules",
                  [ IsList, IsInt, IsList ] );



############################################
##
#! @Section Attributes
##
############################################

#! @Description
#! The argument is a SemigroupForPresentationsByProjectiveGradedModules $L$. We then return the list of its generators.
#! @Returns a list
#! @Arguments L
DeclareAttribute( "GeneratorList",
                  IsSemigroupForPresentationsByProjectiveGradedModules );

#! @Description
#! The argument is a SemigroupForPresentationsByProjectiveGradedModules $L$. We then return the embedding dimension of this semigroup.
#! @Returns a non-negative integer
#! @Arguments L
DeclareAttribute( "EmbeddingDimension",
                  IsSemigroupForPresentationsByProjectiveGradedModules );

#! @Description
#! The argument is a SemigroupForPresentationsByProjectiveGradedModules $L$. If the associated semigroup is a cone semigroup, 
#! then (during construction) an H-presentation of that cone was computed. We return the list of the corresponding
#! H-constraints. This conversion uses Normaliz and can fail if the cone if not full-dimensional. In case that
#! such a conversion error occured, the attribute is set to the value 'fail'.
#! @Returns a list or fail
#! @Arguments L
DeclareAttribute( "ConeHPresentationList",
                  IsSemigroupForPresentationsByProjectiveGradedModules );

#! @Description
#! The argument is an AffineSemigroupForPresentationsByProjectiveGradedModules $S$. This one is given as $S = p + H$ for a 
#! point $p \in \mathbb{Z}^n$ and a semigroup $H \subseteq \mathbb{Z}^n$. We then return the offset $p$.
#! @Returns a list of integers
#! @Arguments S
DeclareAttribute( "Offset",
                  IsAffineSemigroupForPresentationsByProjectiveGradedModules );

#! @Description
#! The argument is an IsAffineSemigroupForPresentationsByProjectiveGradedModules $S$. This one is given as $S = p + H$ for a 
#! point $p \in \mathbb{Z}^n$ and a semigroup $H \subseteq \mathbb{Z}^n$. We then return the SemigroupGeneratorList of $H$.
#! @Returns a SemigroupGeneratorList
#! @Arguments S
DeclareAttribute( "UnderlyingSemigroup",
                  IsAffineSemigroupForPresentationsByProjectiveGradedModules );

#! @Description
#! The argument is an IsAffineSemigroupForPresentationsByProjectiveGradedModules $S$. We then return the embedding dimension
#! of this affine semigroup.
#! @Returns a non-negative integer
#! @Arguments S
DeclareAttribute( "EmbeddingDimension",
                  IsAffineSemigroupForPresentationsByProjectiveGradedModules );



############################################
##
#! @Section Property
##
############################################

#! @Description
#! The argument is a SemigroupForPresentationsByProjectiveGradedModules $L$. This property returns 'true' if this semigroup
#! is trivial and 'false' otherwise.
#! @Returns true or false
#! @Arguments L
DeclareProperty( "IsTrivial",
                 IsSemigroupForPresentationsByProjectiveGradedModules );

#! @Description
#! The argument is a SemigroupForPresentationsByProjectiveGradedModules $L$. We return if this is the semigroup of a cone.
#! @Returns true, false
#! @Arguments L
DeclareProperty( "IsSemigroupOfCone",
                  IsSemigroupForPresentationsByProjectiveGradedModules );

#! @Description
#! The argument is an AffineSemigroupForPresentationsByProjectiveGradedModules. This property returns 'true' if the underlying
#! semigroup is trivial and otherwise 'false'.
#! @Returns true or false
#! @Arguments L
DeclareProperty( "IsTrivial",
                 IsAffineSemigroupForPresentationsByProjectiveGradedModules );

#! @Description
#! The argument is an IsAffineSemigroupForPresentationsByProjectiveGradedModules $H$. We return if this is an AffineConeSemigroup. If Normaliz cannot decide this 'fail'
#! is returned.
#! @Returns true, false or fail
#! @Arguments H
DeclareProperty( "IsAffineSemigroupOfCone",
                  IsAffineSemigroupForPresentationsByProjectiveGradedModules );



############################################
##
#! @Section Operations
##
############################################

#! @Description
#! The argument is a list $L$ of generators of a semigroup in $\mathbb{Z}^n$. We then check if this 
#! is the semigroup of a cone. In this case we return 'true', otherwise 'false'. If the operation fails due to 
#! shortcommings in Normaliz we return 'fail'.
#! @Returns true, false or fail
#! @Arguments L
DeclareOperation( "DecideIfIsConeSemigroupGeneratorList",
                  [ IsList ] );



###############################################################################
##
#! @Section Check if point is contained in (affine) cone or (affine ) semigroup
##
###############################################################################

#! @Description
#! The argument is a SemigroupForPresentationsByProjectiveGradedModules $S$ of $\mathbb{Z}^n$, and an integral point $p$ in this
#! lattice. This operation then verifies if the point $p$ is contained in $S$ or not.
#! @Returns true or false
#! @Arguments S, p
DeclareOperation( "PointContainedInSemigroup",
                  [ IsSemigroupForPresentationsByProjectiveGradedModules, IsList ] );

#! @Description
#! The argument is an IsAffineSemigroupForPresentationsByProjectiveGradedModules $H$ and a point $p$. The second argument 
#! This method then checks if $p$ lies in $H$.
#! @Returns true or false
#! @Arguments H, p
DeclareOperation( "PointContainedInAffineSemigroup",
                  [ IsAffineSemigroupForPresentationsByProjectiveGradedModules, IsList ] );
