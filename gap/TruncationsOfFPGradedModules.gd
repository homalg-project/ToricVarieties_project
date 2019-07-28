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
#! @Section Truncations of fp graded modules
##
##############################################################################################

#! @Description
#! The arguments are a toric variety $V$, an f.p. graded module $M$, a list
#! $d$ (specifying a element of the class group of $V$) and a boolean $B$.
#! We then compute the truncation of $M$ to the degree $d$ and return the
#! corresponding vector space presentation as a FreydCategoryObject.
#! If $B$ is true, we display additional information during the computation.
#! This can be useful for longer computations.
#! @Returns a FreydCategoryObject
#! @Arguments V, M, d, B
DeclareOperation( "TruncateFPGradedModule",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsList ] );

DeclareOperation( "TruncateFPGradedModule",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsHomalgModuleElement ] );

DeclareOperation( "TruncateFPGradedModule",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsList, IsBool ] );

DeclareOperation( "TruncateFPGradedModule",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsHomalgModuleElement, IsBool ] );

DeclareOperation( "TruncateFPGradedModule",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsList, IsBool, IsFieldForHomalg ] );

DeclareOperation( "TruncateFPGradedModule",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsHomalgModuleElement, IsBool, IsFieldForHomalg ] );


##############################################################################################
##
#! @Section Truncations of fp graded modules in parallel
##
##############################################################################################

#! @Description
#! The arguments are a toric variety $V$, an f.p. graded module $M$, a list
#! $d$ (specifying a element of the class group of $V$), an integer $N$ and a
#! boolean $B$. We then compute the truncation of $M$ to the degree $d$ and
#! return the corresponding vector space presentation encoded as a
#! FreydCategoryObject. This is performed in $N$ child processes in parallel.
#! If $B$ is true, we display additional information during the computation.
#! The latter can be useful for longer computations.
#! @Returns a FreydCategoryObject
#! @Arguments V, M, d, N, B
DeclareOperation( "TruncateFPGradedModuleInParallel",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsList, IsInt ] );

DeclareOperation( "TruncateFPGradedModuleInParallel",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsHomalgModuleElement, IsInt ] );

DeclareOperation( "TruncateFPGradedModuleInParallel",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsList, IsInt, IsBool ] );

DeclareOperation( "TruncateFPGradedModuleInParallel",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsHomalgModuleElement, IsInt, IsBool ] );

DeclareOperation( "TruncateFPGradedModuleInParallel",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsList, IsInt, IsBool, IsFieldForHomalg ] );

DeclareOperation( "TruncateFPGradedModuleInParallel",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsHomalgModuleElement, IsInt, IsBool, IsFieldForHomalg ] );


##############################################################################################
##
#! @Section Truncations of fp graded modules morphisms
##
##############################################################################################

#! @Description
#! The arguments are a toric variety $V$, an f.p. graded module $M$, a list
#! $d$ (specifying a element of the class group of $V$) and a boolean $B$.
#! We then compute the truncation of $M$ to the degree $d$ and return the
#! corresponding vector space presentation encoded as a FreydCategoryObject.
#! If $B$ is true, we display additional information during the computation.
#! This can be useful for longer computations.
#! @Returns a FreydCategoryObject
#! @Arguments V, M, d, B
DeclareOperation( "TruncateFPGradedModuleMorphism",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsList ] );

DeclareOperation( "TruncateFPGradedModuleMorphism",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsHomalgModuleElement ] );

DeclareOperation( "TruncateFPGradedModuleMorphism",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsList, IsBool ] );

DeclareOperation( "TruncateFPGradedModuleMorphism",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsHomalgModuleElement, IsBool ] );

DeclareOperation( "TruncateFPGradedModuleMorphism",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsList, IsBool, IsFieldForHomalg ] );

DeclareOperation( "TruncateFPGradedModuleMorphism",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsHomalgModuleElement, IsBool, IsFieldForHomalg ] );


if false then

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

fi;
