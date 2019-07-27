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

DeclareOperation( "ExtendedDegreeList",
                  [ IsToricVariety, IsGradedRowOrColumn, IsList ] );

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
#! @Arguments V, M, degree_list, field
DeclareOperation( "DegreeXLayerOfGradedRowOrColumn",
                  [ IsToricVariety, IsGradedRowOrColumn, IsList, IsFieldForHomalg ] );

#! @Description
#! As above, but with a HomalgModuleElement m specifying the degree.
#! @Returns DegreeXLayerVectorSpace
#! @Arguments V, M, m, field
DeclareOperation( "DegreeXLayerOfGradedRowOrColumn",
                  [ IsToricVariety, IsGradedRowOrColumn, IsHomalgModuleElement, IsFieldForHomalg ] );

#! @Description
#! As above, but the coefficient ring of the Cox ring will be used as field
#! @Returns DegreeXLayerVectorSpace
#! @Arguments V, M, degree
DeclareOperation( "DegreeXLayerOfGradedRowOrColumn",
                  [ IsToricVariety, IsGradedRowOrColumn, IsList ] );

#! @Description
#! As above, but a HomalgModuleElement m specifies the degree
#! and we use the coefficient ring of the Cox ring as field.
#! @Returns DegreeXLayerVectorSpace
#! @Arguments V, M, m
DeclareOperation( "DegreeXLayerOfGradedRowOrColumn",
                  [ IsToricVariety, IsGradedRowOrColumn, IsHomalgModuleElement ] );


##############################################################################################
##
#! @Section Formats for generators of truncations of graded rows and columns
##
##############################################################################################

#! @Description
#! The arguments are a variety V, a graded row or column M and a list l,
#! specifying a degree in the class group of the Cox ring of $V$.
#! We then compute the truncation of M to the specified degree and return its
#! generators as list of column matrices.
#! @Returns a list
#! @Arguments V, M, l
DeclareOperation( "GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListOfColumnMatrices",
                  [ IsToricVariety, IsGradedRowOrColumn, IsList ] );

#! @Description
#! The arguments are a variety V, a graded row or column M and a
#! HomalgModuleElement m, specifying a degree in the class group of the Cox ring of $V$.
#! We then compute the truncation of M to the specified degree and return its
#! generators as list of column matrices.
#! @Returns a list
#! @Arguments V, M, m
DeclareOperation( "GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListOfColumnMatrices",
                  [ IsToricVariety, IsGradedRowOrColumn, IsHomalgModuleElement ] );

#! @Description
#! The arguments are a variety V, a graded row or column M and a list l,
#! specifying a degree in the class group of the Cox ring of $V$.
#! We then compute the truncation of M to the specified degree and its
#! generators as column matrices. The matrix formed from the union of these
#! column matrices is returned.
#! @Returns a list
#! @Arguments V, M, m
DeclareOperation( "GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsUnionOfColumnMatrices",
                  [ IsToricVariety, IsGradedRowOrColumn, IsList ] );

#! @Description
#! The arguments are a variety V, a graded row or column M and a
#! HomalgModuleElement m, specifying a degree in the class group of the Cox ring of $V$.
#! We then compute the truncation of M to the specified degree and its
#! generators as column matrices. The matrix formed from the union of these column
#! matrices is returned.
#! @Returns a list
#! @Arguments V, M, m
DeclareOperation( "GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsUnionOfColumnMatrices",
                  [ IsToricVariety, IsGradedRowOrColumn, IsHomalgModuleElement ] );

#! @Description
#! The arguments are a variety V, a graded row or column M and a list l,
#! specifying a degree in the class group of the Cox ring of $V$.
#! We then compute the truncation of M to the specified degree and return its
#! generators as list [ n, rec_list ]. n specifies the number of generators.
#! rec_list is a list of record. The i-th record contains the generators of the
#! i-th direct summand of M.
#! @Returns a list
#! @Arguments V, M, l
DeclareOperation( "GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListsOfRecords",
                  [ IsToricVariety, IsGradedRowOrColumn, IsList ] );

#! The arguments are a variety V, a graded row or column M and a
#! HomalgModuleElement m, specifying a degree in the class group of the Cox ring of $V$.
#! We then compute the truncation of M to the specified degree and return its
#! generators as list [ n, rec_list ]. n specifies the number of generators.
#! rec_list is a list of record. The i-th record contains the generators of the
#! i-th direct summand of M.
#! @Returns a list
#! @Arguments V, M, m
DeclareOperation( "GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListsOfRecords",
                  [ IsToricVariety, IsGradedRowOrColumn, IsHomalgModuleElement ] );

#!
DeclareOperation( "GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListList",
                  [ IsToricVariety, IsGradedRowOrColumn, IsList ] );

#!
DeclareOperation( "GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListList",
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
