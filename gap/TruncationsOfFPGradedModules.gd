##########################################################################################
##
##  TruncationsOfFPGradedModules.gd        SheafCohomologyOnToricVarieties package
##
##  Copyright 2019                         Martin Bies,       ULB Brussels
##
#! @Chapter Truncations of f.p. graded modules
##
#########################################################################################


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
