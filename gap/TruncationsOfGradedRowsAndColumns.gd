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
#! @Section Truncations of graded rows and columns
##
##############################################################################################

#! @Description
#! The arguments are a toric variety $V$, a graded row or column $M$ over the Cox ring of $V$
#! and a <A>degree_list</A> specifying an element of the degree group of the toric variety $V$.
#! The latter can either be specified by a list of integers or as a HomalgModuleElement.
#! Based on this input, the method computes the truncation of $M$ to the specified degree.
#! This is a finite dimensional vector space. We return the corresponding DegreeXLayerVectorSpace.
#! Optionally, we allow for a field $F$ as fourth input. This field is used to construct
#! the DegreeXLayerVectorSpace. Namely, the wrapper DegreeXLayerVectorSpace contains a
#! representation of the obtained vector space as $F^n$. In case $F$ is specified, we use this
#! particular field. Otherwise, HomalgFieldOfRationals() will be used.
#! @Returns DegreeXLayerVectorSpace
#! @Arguments V, M, degree_list
DeclareOperation( "DegreeXLayerOfGradedRowOrColumn",
                  [ IsToricVariety, IsGradedRowOrColumn, IsList, IsFieldForHomalg ] );

#!
DeclareOperation( "DegreeXLayerOfGradedRowOrColumn",
                  [ IsToricVariety, IsGradedRowOrColumn, IsHomalgModuleElement, IsFieldForHomalg ] );

#!
DeclareOperation( "DegreeXLayerOfGradedRowOrColumn",
                  [ IsToricVariety, IsGradedRowOrColumn, IsList ] );

#!
DeclareOperation( "DegreeXLayerOfGradedRowOrColumn",
                  [ IsToricVariety, IsGradedRowOrColumn, IsHomalgModuleElement ] );


##############################################################################################
##
#! @Section Truncations of graded rows and columns with further formatting
##
##############################################################################################

#! @Description
#! The arguments and functionality are as described above.
#! However, further formatting of the output will be applied.
#! @Returns a formated DegreeXLayerVectorSpace
#! @Arguments V, M, degree_list
DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListOfColumnMatrices",
                  [ IsToricVariety, IsGradedRowOrColumn, IsList ] );

#!
DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListOfColumnMatrices",
                  [ IsToricVariety, IsGradedRowOrColumn, IsHomalgModuleElement ] );

#!
DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListsOfRecords",
                  [ IsToricVariety, IsGradedRowOrColumn, IsList ] );

#!
DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListsOfRecords",
                  [ IsToricVariety, IsGradedRowOrColumn, IsHomalgModuleElement ] );

#!
DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsUnionOfColumnMatrices",
                  [ IsToricVariety, IsGradedRowOrColumn, IsList ] );

#!
DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsUnionOfColumnMatrices",
                  [ IsToricVariety, IsGradedRowOrColumn, IsHomalgModuleElement ] );

#!
DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListList",
                  [ IsToricVariety, IsGradedRowOrColumn, IsList ] );

#!
DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListList",
                  [ IsToricVariety, IsGradedRowOrColumn, IsHomalgModuleElement ] );

if false then
##############################################################################################
##
#! @Section Truncations of graded row and column morphisms
##
##############################################################################################

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
                  [ IsToricVariety, IsGradedRowOrColumn, IsList, IsHomalgRing, IsBool ] );

DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism",
                 [ IsToricVariety, IsGradedRowOrColumn, IsHomalgModuleElement,
                   IsHomalgRing, IsBool ] );

DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism",
                  [ IsToricVariety, IsGradedRowOrColumn, IsList, IsBool ] );

DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism",
                  [ IsToricVariety, IsGradedRowOrColumn, IsHomalgModuleElement, IsBool ] );

DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism",
                  [ IsToricVariety, IsGradedRowOrColumn, IsList ] );

DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism",
                  [ IsToricVariety, IsGradedRowOrColumn, IsHomalgModuleElement ] );

DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphismMinimal",
                  [ IsToricVariety, IsGradedRowOrColumn, IsList, IsList, IsHomalgRing, IsBool ] );


#############################################################################
##
#! @Section Saving the truncation of graded row and column morphism to a file
##
#############################################################################

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

fi;
