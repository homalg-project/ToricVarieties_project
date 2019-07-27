##########################################################################################
##
##  TruncationsOfGradedRowsAndColumns.gd   SheafCohomologyOnToricVarieties package
##
##  Copyright 2019                         Martin Bies,       ULB Brussels
##
#! @Chapter Truncations of graded rows and columns
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
