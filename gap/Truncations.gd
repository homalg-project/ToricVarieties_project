##########################################################################################
##
##  DegreeXLayer.gd                    SheafCohomologyOnToricVarieties package
##
##  Copyright 2019                     Martin Bies,       ULB Brussels
##
#! @Chapter Truncations of Sfpgrmod to single degrees
##
#########################################################################################


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

DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListList",
                  [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsList ] );

DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListList",
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

DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphismMinimal",
                  [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism, IsList, IsList, IsHomalgRing, IsBool ] );


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
DeclareOperation( "ComputeDegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphismMinimally",
               [ IsList, IsBool ] );

DeclareOperation( "ComputeDegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphismMinimally",
               [ IsList, IsBool, IsInt, IsInt ] );

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
