##########################################################################################
##
##  DegreeXLayer.gd                    SheafCohomologyOnToricVarieties package
##
##  Copyright 2016                     Martin Bies,       ITP Heidelberg
##
#! @Chapter Truncations of Sfpgrmod to single degrees
##
#########################################################################################



##########################################################
##
#! @Section DegreeXLayers of the Cox ring
##
##########################################################

#! @Description
#! Given a smooth and complete toric variety and a list of integers (= degree) corresponding to an element of 
#! the class group of the variety, this method return a list of integer valued lists. These lists correspond 
#! to the exponents of the monomials of degree in the Cox ring of this toric variety.
#! @Returns a list of lists of integers
#! @Arguments vari, degree
DeclareOperation( "Exponents",
               [ IsToricVariety, IsList ] );

#! @Description
#! Given a smooth and complete toric variety and a list of integers (= degree) corresponding to an element
#! of the class group of the variety, this method returns the list of all monomials in the Cox ring of the
#! given degree. This method uses NormalizInterface. 
#! @Returns a list
#! @Arguments vari, degree
DeclareOperation( "MonomsOfCoxRingOfDegreeByNormaliz",
               [ IsToricVariety, IsList ] );

#! @Description
#! Given a smooth and complete toric variety and a list of integers (= degree) corresponding to an element
#! of the class group of the variety, this method returns the list of all monomials in the Cox ring of the
#! given degree. This method uses NormalizInterface. 
#! @Returns a list
#! @Arguments vari, degree
DeclareOperation( "DegreeXLayer",
                 [ IsToricVariety, IsList ] );

#! @Description
#! Given a smooth and complete toric variety, a list of integers (= degree) corresponding to an element
#! of the class group of the variety and two non-negative integers i and l, this method returns a list
#! of column matrices. The columns are of length l and have at position i the monoms of the Coxring of degree 'degree'.
#! @Returns a list of matrices
#! @Arguments vari, degree, i, l
DeclareOperation( "DegreeXLayerVectorsAsColumnMatrices",
                 [ IsToricVariety, IsList, IsPosInt, IsPosInt ] );





##############################################################################################
##
#! @Section GAP category of DegreeXLayerVectorSpaces(Morphisms)
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
#! @Section Constructors for DegreeXLayerVectorSpaces(Morphisms)
##
##############################################################################################

#! @Description
#! The arguments are a list of monomials $L$, a homalg graded ring $S$ (the Coxring of the 
#! variety in question)), a vector space $V$ and a non-negative integer $n$. $V$ is to be 
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
#! @Section Attributes for DegreeXLayerVectorSpaces(Morphisms)
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



################################################################################################################
##
#! @Section Convenient methods to display all information about vector space presentations and morphisms thereof
##
################################################################################################################

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



##############################################################################################
##
#! @Section Truncations of projective graded modules (as defined in CAP) to a single degree
##
##############################################################################################

#! @Description
#! The arguments are a toric variety $V$, a projective graded $S$-module $M$ ($S$ being the Cox ring of $V$)
#! and a <A>degree_list</A> specifying an element of the degree group of the toric variety $V$. The latter can either 
#! be specified by a list of integers or a HomalgModuleElement. Based on this input, the method computes the 
#! truncation of $M$ to the specified degree.
#! We expect that $V$ is smooth and compact. Under these circumstances the truncation is a finite dimensional
#! vector space and we return the corresponding DegreeXLayerVectorSpace.
#! @Returns a DegreeXLayerVectorSpace
#! @Arguments V, M, degree_list
DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModule",
                  [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsList, IsHomalgRing ] );

DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModule",
                  [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsHomalgModuleElement, IsHomalgRing ] );

DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModule",
                  [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsList ] );

DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModule",
                  [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsHomalgModuleElement ] );

#! @Description
#! The arguments are as before, but will format the DegreeXLayer a bit more.
#! @Returns a formated DegreeXLayerVectorSpace
#! @Arguments V, M, degree_list
DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListOfColumnMatrices",
                  [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsList ] );

DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListOfColumnMatrices",
                  [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsHomalgModuleElement ] );

DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListsOfRecords",
                  [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsList ] );

DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListsOfRecords",
                  [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsHomalgModuleElement ] );

DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsUnionOfColumnMatrices",
                  [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsList ] );

DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsUnionOfColumnMatrices",
                  [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsHomalgModuleElement ] );

#! @Description
#! The arguments are a toric variety $V$, a projective graded $S$-module morphism $\varphi$ 
#! ($S$ being the Cox ring of $V$) and a <A>degree_list</A> specifying an element of the degree group of the 
#! toric variety $V$. The latter can either be a list of integers or a HomalgModuleElement. Based on this input, 
#! the method returns the truncation of $\varphi$ to the specified degree.
#! We expect that $V$ is smooth and compact. Under these circumstances the truncation is a morphism of finite dimensional
#! vector spaces. We return the corresponding DegreeXLayerVectorSpaceMorphism.
#! @Returns a DegreeXLayerVectorSpaceMorphism
#! @Arguments V, \varphi, degree_list
DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism",
                  [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism, IsList, IsHomalgRing, IsBool ] );

DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism",
                 [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism, IsHomalgModuleElement,
                   IsHomalgRing, IsBool ] );

DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism",
                  [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism, IsList, IsBool ] );

DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism",
                  [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism, IsHomalgModuleElement, IsBool ] );

DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism",
                  [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism, IsList ] );

DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism",
                  [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism, IsHomalgModuleElement ] );



####################################################################
##
#! @Section DegreeXLayer of projective module morphism saved in file
##
####################################################################

#! @Description
#! The arguments are a toric variety $V$, a projective graded $S$-module morphism $\varphi$ 
#! ($S$ being the Cox ring of $V$) and a <A>degree_list</A> specifying an element of the degree group of the 
#! toric variety $V$ and string 'file_name'. This method then computes the matrix encoding the DegreeXLayer of the 
#! given morphism of projective modules and saves it to the file 'file_name'. This file is prepared to be used with 
#! gap.
#! @Returns true or false
#! @Arguments V, \varphi, degree_list, file_name
DeclareOperation( "WriteDegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphismToFileForGAPMinimal",
               [ IsList, IsString, IsBool ] );

#!
DeclareOperation( "WriteDegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphismToFileForGAPMinimal",
               [ IsString, IsString, IsBool ] );

#!
DeclareOperation( "WriteDegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphismToFileForGAP",
               [ IsList, IsString, IsBool ] );

#!
DeclareOperation( "WriteDegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphismToFileForGAP",
               [ IsString, IsList, IsString, IsBool ] );

#!
DeclareOperation( "WriteDegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphismToFileForGAP",
               [ IsString, IsHomalgModuleElement, IsString, IsBool ] );


##################################################################################################
##
#! @Section Truncation functor of projective graded modules (as defined in CAP) to a single degree
##
##################################################################################################

# a function that computes the truncation functor to single degrees for both projective left and right modules
DeclareGlobalFunction( "DegreeXLayerOfProjectiveGradedModulesFunctor" );

#! @Description
#! The arguments are a toric variety $V$ and <A>degree_list</A> specifying an element of the degree group of the 
#! toric variety $V$. The latter can either be a list of integers or a HomalgModuleElement. 
#! Based on this input, the method returns the functor for the truncation of projective graded left-$S$-modules
#! to <A>degree_list</A>.
#! @Returns a functor
#! @Arguments V, degree_list
DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftModulesFunctor",
                  [ IsToricVariety, IsList ] );

DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftModulesFunctor",
                  [ IsToricVariety, IsHomalgModuleElement ] );

#! @Description
#! The arguments are a toric variety $V$ and <A>degree_list</A> specifying an element of the degree group of the 
#! toric variety $V$. The latter can either be a list of integers or a HomalgModuleElement. 
#! Based on this input, the method returns the functor for the truncation of projective graded right-$S$-modules 
#! to <A>degree_list</A>.
#! @Returns a functor
#! @Arguments V, degree_list
DeclareOperation( "DegreeXLayerOfProjectiveGradedRightModulesFunctor",
                  [ IsToricVariety, IsList ] );

DeclareOperation( "DegreeXLayerOfProjectiveGradedRightModulesFunctor",
                  [ IsToricVariety, IsHomalgModuleElement ] );



##############################################################################################
##
#! @Section Truncations of graded module presentations (as defined in CAP) to a single degree
##
##############################################################################################

#! @Description
#! The arguments are a toric variety $V$, a graded module presentation $\alpha$
#! and <A>degree_list</A> specifying an element of the degree group of the toric variety $V$. 
#! The latter can either be a list of integers or a HomalgModuleElement.
#! Based on this input, the method returns the truncation of $\alpha$ to the specified degree.
#! We expect that $V$ is smooth and compact. Under these circumstances the truncation is a finite dimensional
#! vector space presentation. We return the corresponding DegreeXLayerVectorSpacePresentation.
#! Optionally, a boolean $b$ can be provided as fourth argument. It will display/suppress information on the status of the computation.
#! $b = true$ will print information on the status of the computation, which might be useful in case the calculation takes several hours
#! and the user wants to stay informed on the status of the computation. $b = false$ will suppress this output. The defaul value is false.
#! @Returns a DegreeXLayerVectorSpacePresentation
#! @Arguments V, alpha, degree_list
DeclareOperation( "DegreeXLayerOfGradedLeftOrRightModulePresentation",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsList, IsBool ] );

DeclareOperation( "DegreeXLayerOfGradedLeftOrRightModulePresentation",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsHomalgModuleElement, IsBool ] );

DeclareOperation( "DegreeXLayerOfGradedLeftOrRightModulePresentation",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsList ] );

DeclareOperation( "DegreeXLayerOfGradedLeftOrRightModulePresentation",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsHomalgModuleElement ] );

#! @Description
#! The same as DegreeXLayerOfGradedLeftOrRightModulePresentation, but immediately returns the 
#! underlying vector space presentation.
#! @Returns a CAPPresentationCategoryObject
#! @Arguments V, alpha, degree_list
DeclareOperation( "DegreeXLayer",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsList, IsBool ] );

DeclareOperation( "DegreeXLayer",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsList ] );


DeclareOperation( "DegreeXLayer",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsHomalgModuleElement, IsBool ] );

DeclareOperation( "DegreeXLayer",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsHomalgModuleElement ] );

#! @Description
#! The arguments are a toric variety $V$, a graded module presentation morphism $\alpha$
#! and <A>degree_list</A> specifying an element of the degree group of the toric variety $V$.
#! The latter can either be a list of integers or a HomalgModuleElement.
#! Based on this input, the method returns the truncation of $\alpha$ to the specified degree.
#! We expect that $V$ is smooth and compact. Under these circumstances the truncation is a morphism of 
#! finite dimensional vector space presentations. We return the corresponding DegreeXLayerVectorSpacePresentationMorphism.
#! Optionally, a boolean $b$ can be provided as fourth argument. It will display/suppress information on the status of the computation.
#! $b = true$ will print information on the status of the computation, which might be useful in case the calculation takes several hours
#! and the user wants to stay informed on the status of the computation. $b = false$ will suppress this output. The defaul value is false.
#! @Returns a DegreeXLayerVectorSpacePresentationMorphism
#! @Arguments V, alpha, degree_list
DeclareOperation( "DegreeXLayerOfGradedLeftOrRightModulePresentationMorphism",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsList, IsBool ] );

DeclareOperation( "DegreeXLayerOfGradedLeftOrRightModulePresentationMorphism",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsList ] );

DeclareOperation( "DegreeXLayerOfGradedLeftOrRightModulePresentationMorphism",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsHomalgModuleElement, IsBool ] );

DeclareOperation( "DegreeXLayerOfGradedLeftOrRightModulePresentationMorphism",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsHomalgModuleElement ] );

#! @Description
#! As 'DegreeXLayerOfGradedLeftOrRightModulePresentationMorphism', but takes the truncations of source and range as input.
#! @Returns a DegreeXLayerVectorSpacePresentationMorphism
#! @Arguments V, alpha, degree_list, truncated_source, truncated_range
DeclareOperation( "DegreeXLayerOfGradedLeftOrRightModulePresentationMorphismWithGivenSourceAndRange",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsList, 
                    IsCAPPresentationCategoryObject, IsCAPPresentationCategoryObject, IsBool ] );

DeclareOperation( "DegreeXLayerOfGradedLeftOrRightModulePresentationMorphismWithGivenSourceAndRange",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsList, 
                    IsCAPPresentationCategoryObject, IsCAPPresentationCategoryObject ] );

DeclareOperation( "DegreeXLayerOfGradedLeftOrRightModulePresentationMorphismWithGivenSourceAndRange",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsHomalgModuleElement,
                    IsCAPPresentationCategoryObject, IsCAPPresentationCategoryObject, IsBool ] );

DeclareOperation( "DegreeXLayerOfGradedLeftOrRightModulePresentationMorphismWithGivenSourceAndRange",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsHomalgModuleElement,
                    IsCAPPresentationCategoryObject, IsCAPPresentationCategoryObject ] );

#! @Description
#! The same as DegreeXLayerOfGradedLeftOrRightModulePresentationMorphism, but immediately returns the 
#! underlying vector space presentation morphism.
#! @Returns a CAPPresentationCategoryMorphism
#! @Arguments V, alpha, degree_list
DeclareOperation( "DegreeXLayer",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsList, IsBool ] );

DeclareOperation( "DegreeXLayer",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsList ] );

DeclareOperation( "DegreeXLayer",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsHomalgModuleElement, IsBool ] );

DeclareOperation( "DegreeXLayer",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsHomalgModuleElement ] );



##################################################################################################
##
#! @Section Truncation functor of projective graded modules (as defined in CAP) to a single degree
##
##################################################################################################

# a function that computes the truncation functor to single degrees for both left and right graded module presentations
DeclareGlobalFunction( "DegreeXLayerOfGradedModulePresentationFunctor" );

#! @Description
#! The arguments are a toric variety $V$ and <A>degree_list</A> specifying an element of the degree group of the 
#! toric variety $V$. 
#! The latter can either be a list of integers or a HomalgModuleElement.
#! Based on this input, the method returns the functor for the truncation of 
#! graded left-$S$-module presentations to <A>degree_list</A>.
#! Optionally, a boolean $b$ can be provided as fourth argument. It will display/suppress information on the status of the computation.
#! $b = true$ will print information on the status of the computation, which might be useful in case the calculation takes several hours
#! and the user wants to stay informed on the status of the computation. $b = false$ will suppress this output. The defaul value is false.
#! @Returns a functor
#! @Arguments V, degree_list
DeclareOperation( "DegreeXLayerOfGradedLeftModulePresentationFunctor",
                  [ IsToricVariety, IsList, IsBool ] );

DeclareOperation( "DegreeXLayerOfGradedLeftModulePresentationFunctor",
                  [ IsToricVariety, IsList ] );

DeclareOperation( "DegreeXLayerOfGradedLeftModulePresentationFunctor",
                  [ IsToricVariety, IsHomalgModuleElement, IsBool ] );

DeclareOperation( "DegreeXLayerOfGradedLeftModulePresentationFunctor",
                  [ IsToricVariety, IsHomalgModuleElement ] );

#! @Description
#! The arguments are a toric variety $V$ and <A>degree_list</A> specifying an element of the degree group of the 
#! toric variety $V$. 
#! The latter can either be a list of integers or a HomalgModuleElement.
#! Based on this input, the method returns the functor for the truncation of 
#! graded right-$S$-module presentations to <A>degree_list</A>.
#! @Returns a functor
#! @Arguments V, degree_list
DeclareOperation( "DegreeXLayerOfGradedRightModulePresentationFunctor",
                  [ IsToricVariety, IsList, IsBool ] );

DeclareOperation( "DegreeXLayerOfGradedRightModulePresentationFunctor",
                  [ IsToricVariety, IsList ] );
                  
DeclareOperation( "DegreeXLayerOfGradedRightModulePresentationFunctor",
                  [ IsToricVariety, IsHomalgModuleElement, IsBool ] );

DeclareOperation( "DegreeXLayerOfGradedRightModulePresentationFunctor",
                  [ IsToricVariety, IsHomalgModuleElement ] );



##################################################################################################
##
#! @Section Truncations of graded module presentations as defined in the package GradedModules
##
##################################################################################################

#! @Description
#! Given a smooth and complete toric variety with Coxring S, a graded free S-module 'module' and list 
#! of integers (=degree) corresponding to an element of the class group of the toric variety, this 
#! method returns a list of generators of the degree layer of the 'module'.
#! @Returns a list of lists
#! @Arguments vari, module, degree
DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListOfColumnMatrices",
                  [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsList ] );

DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListOfColumnMatrices",
                  [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsHomalgModuleElement ] );

DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsUnionOfColumnMatrices",
                  [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsList ] );

DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsUnionOfColumnMatrices",
                  [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsHomalgModuleElement ] );

DeclareOperation( "DegreeXLayerOfGradedFreeModuleForGradedModules",
                 [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsList ] );

#! @Description
#! Given a smooth and complete toric variety with Coxring S, a f. p. graded S-module 'module' and list
#! of integers (=degree) corresponding to an element of the class group of the toric variety, this 
#! method computes the degree 'degree' layer of (a) presentation morphisms of 'module' and returns the 
#! cokernel object of this homomorphism of vector spaces.
#! @Returns a vector space
#! @Arguments vari, module, degree
DeclareOperation( "DegreeXLayerOfFPGradedModuleForGradedModules",
                 [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsList ] );

DeclareOperation( "DegreeXLayerOfFPGradedModuleForGradedModules",
                 [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsHomalgModuleElement ] );