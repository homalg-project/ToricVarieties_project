##########################################################################################
##
##  DegreeXLayerVectorSpace.gd         TruncationsOfFPGradedModules package
##
##  Copyright 2020                     Martin Bies,    University of Oxford
##
#! @Chapter DegreeXLayerVectorSpaceMorphisms
##
#########################################################################################


##############################################################################################
##
#! @Section GAP category of DegreeXLayerVectorSpaces
##
##############################################################################################

#! @Description
#! The GAP category for vector spaces that represent a degree layer of a f.p. graded module
#! @Returns true or false
#! @Arguments object
DeclareCategory( "IsDegreeXLayerVectorSpace",
                 IsObject );

#! @Description
#! The GAP category for morphisms between vector spaces that represent a degree layer of a f.p. graded module
#! @Returns true or false
#! @Arguments object
DeclareCategory( "IsDegreeXLayerVectorSpaceMorphism",
                 IsObject );

#! @Description
#! The GAP category for (left) presentations of vector spaces that represent a degree layer of a f.p. graded module
#! @Returns true or false
#! @Arguments object
DeclareCategory( "IsDegreeXLayerVectorSpacePresentation",
                 IsObject );

#! @Description
#! The GAP category for (left) presentation morphisms of vector spaces that represent a degree layer of a 
#! f.p. graded module
#! @Returns true or false
#! @Arguments object
DeclareCategory( "IsDegreeXLayerVectorSpacePresentationMorphism",
                 IsObject );



##############################################################################################
##
#! @Section Constructors for DegreeXLayerVectorSpaces
##
##############################################################################################

#! @Description
#! The arguments are a list of monomials $L$, a homalg graded ring $S$ (the Coxring of the 
#! variety in question), a vector space $V$ and a non-negative integer $n$. $V$ is to be
#! given as a vector space defined in the package 'LinearAlgebraForCAP'.
#! This method then returns the corresponding DegreeXLayerVectorSpace.
#! @Returns a CAPCategoryObject
#! @Arguments L, S, V, n
DeclareOperation( "DegreeXLayerVectorSpace",
                  [ IsList, IsHomalgGradedRing, IsVectorSpaceObject, IsInt ] );

#! @Description
#! The arguments are a DegreeXLayerVectorSpace <A>source</A>, a vector space morphism $\varphi$ (as defined in
#! 'LinearAlgebraForCAP') and a DegreeXLayerVectorSpace <A>range</A>. If $\varphi$ is a vector space
#! morphism between the underlying vector spaces of <A>source</A> and <A>range</A> this method returns
#! the corresponding DegreeXLayerVectorSpaceMorphism.
#! @Returns a DegreeXLayerVectorSpaceMorphism
#! @Arguments L, S, V
DeclareOperation( "DegreeXLayerVectorSpaceMorphism",
                  [ IsDegreeXLayerVectorSpace, IsVectorSpaceMorphism, IsDegreeXLayerVectorSpace ] );

#! @Description
#! The arguments is a DegreeXLayerVectorSpaceMorphism <A>a</A>. This method treats this morphism as a
#! presentation, i.e. we are interested in the cokernel of the underlying morphism of vector spaces. The corresponding
#! DegreeXLayerVectorSpacePresentation is returned.
#! @Returns a DegreeXLayerVectorSpaceMorphism
#! @Arguments a
DeclareOperation( "DegreeXLayerVectorSpacePresentation",
                  [ IsDegreeXLayerVectorSpaceMorphism ] );

#! @Description
#! The arguments is a DegreeXLayerVectorSpacePresentation <A>source</A>, a vector space morphism $\varphi$ and a
#! DegreeXLayerVectorSpacePresentation <A>range</A>. The corresponding DegreeXLayerVectorSpacePresentationMorphism
#! is returned.
#! @Returns a DegreeXLayerVectorSpacePresentationMorphism
#! @Arguments source, \varphi, range
DeclareOperation( "DegreeXLayerVectorSpacePresentationMorphism",
                  [ IsDegreeXLayerVectorSpacePresentation, IsVectorSpaceMorphism, IsDegreeXLayerVectorSpacePresentation ] );



##############################################################################################
##
#! @Section Attributes for DegreeXLayerVectorSpaces
##
##############################################################################################

#! @Description
#! The argument is a DegreeXLayerVectorSpace $V$. The output is the Coxring, in which this
#! vector space is embedded via the generators (specified when installing $V$).
#! @Returns a homalg graded ring
#! @Arguments V
DeclareAttribute( "UnderlyingHomalgGradedRing",
                  IsDegreeXLayerVectorSpace );

#! @Description
#! The argument is a DegreeXLayerVectorSpace $V$. The output is the list of generators, that
#! embed $V$ into the Coxring in question.
#! @Returns a list
#! @Arguments V
DeclareAttribute( "Generators",
                  IsDegreeXLayerVectorSpace );

#! @Description
#! The argument is a DegreeXLayerVectorSpace $V$. The output is the underlying vectorspace object
#! (as defined in 'LinearAlgebraForCAP').
#! @Returns a VectorSpaceObject
#! @Arguments V
DeclareAttribute( "UnderlyingVectorSpaceObject",
                  IsDegreeXLayerVectorSpace );

#! @Description
#! The argument is a DegreeXLayerVectorSpace $V$. For $S$ its 'UnderlyingHomalgGradedRing' this vector space
#! is embedded (via its generators) into $S^n$. The integer $n$ is the embedding dimension.
#! @Returns a VectorSpaceObject
#! @Arguments V
DeclareAttribute( "EmbeddingDimension",
                  IsDegreeXLayerVectorSpace );


##############################################################################################
##
#! @Section Attributes for DegreeXLayerVectorSpaceMorphisms
##
##############################################################################################

#! @Description
#! The argument is a DegreeXLayerVectorSpaceMorphism $a$. The output is its source.
#! @Returns a DegreeXLayerVectorSpace
#! @Arguments a
DeclareAttribute( "Source",
                  IsDegreeXLayerVectorSpaceMorphism );

#! @Description
#! The argument is a DegreeXLayerVectorSpaceMorphism $a$. The output is its range.
#! @Returns a DegreeXLayerVectorSpace
#! @Arguments a
DeclareAttribute( "Range",
                  IsDegreeXLayerVectorSpaceMorphism );

#! @Description
#! The argument is a DegreeXLayerVectorSpaceMorphism $a$. The output is its range.
#! @Returns a DegreeXLayerVectorSpace
#! @Arguments a
DeclareAttribute( "UnderlyingVectorSpaceMorphism",
                  IsDegreeXLayerVectorSpaceMorphism );

#! @Description
#! The argument is a DegreeXLayerVectorSpaceMorphism $a$. The output is the Coxring, in which the source and range of this
#! is morphism are embedded.
#! @Returns a homalg graded ring
#! @Arguments a
DeclareAttribute( "UnderlyingHomalgGradedRing",
                  IsDegreeXLayerVectorSpaceMorphism );


##############################################################################################
##
#! @Section Attributes for DegreeXLayerVectorSpacePresentations
##
##############################################################################################

#! @Description
#! The argument is a DegreeXLayerVectorSpacePresentation $a$. The output is the underlying
#! DegreeXLayerVectorSpaceMorphism
#! @Returns a DegreeXLayerVectorSpaceMorphism
#! @Arguments a
DeclareAttribute( "UnderlyingDegreeXLayerVectorSpaceMorphism",
                  IsDegreeXLayerVectorSpacePresentation );

#! @Description
#! The argument is a DegreeXLayerVectorSpacePresentation $a$. The output is the vector space object
#! which is the cokernel of the underlying vector space morphism.
#! @Returns a VectorSpaceObject
#! @Arguments a
DeclareAttribute( "UnderlyingVectorSpaceObject",
                  IsDegreeXLayerVectorSpacePresentation );

#! @Description
#! The argument is a DegreeXLayerVectorSpacePresentation $a$. The output is the vector space morphism
#! which defines the underlying morphism of DegreeXLayerVectorSpaces.
#! @Returns a VectorSpaceMorphism
#! @Arguments a
DeclareAttribute( "UnderlyingVectorSpaceMorphism",
                  IsDegreeXLayerVectorSpacePresentation );

#! @Description
#! The argument is a DegreeXLayerVectorSpacePresentation $a$. The output is the Coxring, 
#! in which the source and range of the underlying morphism of DegreeXLayerVectorSpaces are embedded.
#! @Returns a homalg graded ring
#! @Arguments a
DeclareAttribute( "UnderlyingHomalgGradedRing",
                  IsDegreeXLayerVectorSpacePresentation );

#! @Description
#! The argument is a DegreeXLayerVectorSpacePresentation $a$. The output is the underlying
#! vector space presentation.
#! @Returns a CAP presentation category object
#! @Arguments a
DeclareAttribute( "UnderlyingVectorSpacePresentation",
                  IsDegreeXLayerVectorSpacePresentation );


##############################################################################################
##
#! @Section Attributes for DegreeXLayerVectorSpacePresentationMorphisms
##
##############################################################################################

#! @Description
#! The argument is a DegreeXLayerVectorSpacePresentationMorphism $a$. The output is its source.
#! @Returns a DegreeXLayerVectorSpacePresentation
#! @Arguments a
DeclareAttribute( "Source",
                  IsDegreeXLayerVectorSpacePresentationMorphism );

#! @Description
#! The argument is a DegreeXLayerVectorSpacePresentationMorphism $a$. The output is its range.
#! @Returns a DegreeXLayerVectorSpacePresentation
#! @Arguments a
DeclareAttribute( "Range",
                  IsDegreeXLayerVectorSpacePresentationMorphism );

#! @Description
#! The argument is a DegreeXLayerVectorSpacePresentationMorphism $a$. The output is the underlying graded ring of its
#! source.
#! @Returns a homalg graded ring
#! @Arguments a
DeclareAttribute( "UnderlyingHomalgGradedRing",
                  IsDegreeXLayerVectorSpacePresentationMorphism );

#! @Description
#! The argument is a DegreeXLayerVectorSpacePresentationMorphism $a$. The output is the underlying vector space 
#! presentation morphism.
#! @Returns a CAP presentation category morphism
#! @Arguments a
DeclareAttribute( "UnderlyingVectorSpacePresentationMorphism",
                  IsDegreeXLayerVectorSpacePresentationMorphism );



###############################
##
#! @Section Convenience methods
##
###############################

#! @Description
#! The argument is a DegreeXLayerVectorSpacePresentation $p$. This method displays $p$ in great detail.
#! @Returns detailed information about p
#! @Arguments p
DeclareOperation( "FullInformation",
                 [ IsDegreeXLayerVectorSpacePresentation ] );

#! @Description
#! The argument is a DegreeXLayerVectorSpacePresentationMorphism $p$. This method displays $p$ in great detail.
#! @Returns detailed information about p
#! @Arguments p
DeclareOperation( "FullInformation",
                 [ IsDegreeXLayerVectorSpacePresentationMorphism ] );
