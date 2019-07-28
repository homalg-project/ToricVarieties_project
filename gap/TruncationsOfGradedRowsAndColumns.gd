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

DeclareOperation( "InputTest",
                  [ IsToricVariety, IsGradedRowOrColumn, IsList ] );

DeclareOperation( "InputTest",
                  [ IsToricVariety, IsGradedRowOrColumnMorphism, IsList ] );

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

#! @Description
#! The arguments are a variety V, a graded row or column M and a list l,
#! specifying a degree in the class group of the Cox ring of $V$.
#! We then compute the truncation of M to the specified degree and identify
#! its generators. We format each generator as list [ n, g ], where g denotes
#! a generator of the n-th direct summand of M. We return the list of all
#! these lists [ n, g ].
#! @Returns a list
#! @Arguments V, M, l
DeclareOperation( "GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListList",
                  [ IsToricVariety, IsGradedRowOrColumn, IsList ] );

#! @Description
#! The arguments are a variety V, a graded row or column M and a HomalgModuleElement
#! m, specifying a degree in the class group of the Cox ring of $V$.
#! We then compute the truncation of M to the specified degree and identify
#! its generators. We format each generator as list [ n, g ], where g denotes
#! a generator of the n-th direct summand of M. We return the list of all
#! these lists [ n, g ].
#! @Returns a list
#! @Arguments V, M, m
DeclareOperation( "GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListList",
                  [ IsToricVariety, IsGradedRowOrColumn, IsHomalgModuleElement ] );


##############################################################################################
##
#! @Section Truncations of graded row and column morphisms
##
##############################################################################################

DeclareOperation( "FindVarsAndCoefficients",
                  [ IsString, IsChar, IsFieldForHomalg ] );

DeclareOperation( "NonTrivialMorphismTruncation",
                  [ IsList, IsGradedRowOrColumnMorphism, IsFieldForHomalg, IsBool ] );

#! @Description
#! The arguments are a toric variety $V$, a morphism $a$ of graded rows or columns,
#! a list $d$ specifying a degree in the class group of $V$, a field $F$ for homalg and a boolean $B$.
#! We then truncate $m$ to the specified degree $d$. We express this result as morphism
#! of vector spaces over the field $F$. We return this vector space morphism.
#! If the boolean $B$ is true, we display additional output during the computation, otherwise this
#! output is surpressed.
#! @Returns a vector space morphism
#! @Arguments V, a, d, F, B
DeclareOperation( "TruncateGradedRowOrColumnMorphism",
                  [ IsToricVariety, IsGradedRowOrColumnMorphism, IsList, IsFieldForHomalg, IsBool ] );

#! @Description
#! The arguments are a toric variety $V$, a morphism $a$ of graded rows or columns,
#! and a HomalgModuleElement $m$ specifying a degree in the class group of $V$,
#! a field $F$ for homalg and a boolean $B$.
#! We then truncate $m$ to the specified degree $d$. We express this result as morphism
#! of vector spaces over the field $F$. We return this vector space morphism.
#! If the boolean $B$ is true, we display additional output during the computation, 
#! otherwise this output is surpressed.
#! @Returns a vector space morphism
#! @Arguments V, a, m, F, B
DeclareOperation( "TruncateGradedRowOrColumnMorphism",
                 [ IsToricVariety, IsGradedRowOrColumnMorphism, IsHomalgModuleElement, IsHomalgRing, IsBool ] );

#! @Description
#! This method operates just as 'TruncateGradedRowOrColumnMorphism' above.
#! However, here the field F is taken as the field of coefficients of
#! the Cox ring of the variety $V$.
#! @Returns a vector space morphism
#! @Arguments V, a, d, B
DeclareOperation( "TruncateGradedRowOrColumnMorphism",
                  [ IsToricVariety, IsGradedRowOrColumnMorphism, IsList, IsBool ] );

#! @Description
#! This method operates just as 'TruncateGradedRowOrColumnMorphism' above.
#! However, here the field F is taken as the field of coefficients of
#! the Cox ring of the variety $V$.
#! @Returns a vector space morphism
#! @Arguments V, a, m, B
DeclareOperation( "TruncateGradedRowOrColumnMorphism",
                  [ IsToricVariety, IsGradedRowOrColumnMorphism, IsHomalgModuleElement, IsBool ] );

#! @Description
#! This method operates just as 'TruncateGradedRowOrColumnMorphism' above.
#! However, here the field F is taken as the field of coefficients of
#! the Cox ring of the variety $V$. Also, B is set to false, i.e. no
#! additional information is being displayed.
#! @Returns a vector space morphism
#! @Arguments V, a, d
DeclareOperation( "TruncateGradedRowOrColumnMorphism",
                  [ IsToricVariety, IsGradedRowOrColumnMorphism, IsList ] );

#! @Description
#! This method operates just as 'TruncateGradedRowOrColumnMorphism' above.
#! However, here the field F is taken as the field of coefficients of
#! the Cox ring of the variety $V$. Also, B is set to false, i.e. no
#! additional information is being displayed.
#! @Returns a vector space morphism
#! @Arguments V, a, m
DeclareOperation( "TruncateGradedRowOrColumnMorphism",
                  [ IsToricVariety, IsGradedRowOrColumnMorphism, IsHomalgModuleElement ] );

#! @Description
#! The arguments are a toric variety $V$, a morphism $a$ of graded rows or columns,
#! a list $d$ specifying a degree in the class group of $V$, a field $F$ for homalg and a boolean $B$.
#! We then truncate $m$ to the specified degree $d$. We express this result as morphism
#! of vector spaces over the field $F$. We return the corresponding DegreeXLayerVectorSpaceMorphism.
#! If the boolean $B$ is true, we display additional output during the computation, otherwise this
#! output is surpressed.
#! @Returns a DegreeXLayerVectorSpaceMorphism
#! @Arguments V, a, d, F, B
DeclareOperation( "DegreeXLayerOfGradedRowOrColumnMorphism",
                  [ IsToricVariety, IsGradedRowOrColumnMorphism, IsList, IsFieldForHomalg, IsBool ] );

#! @Description
#! The arguments are a toric variety $V$, a morphism $a$ of graded rows or columns,
#! a HomalgModuleElement $m$ specifying a degree in the class group of $V$,
#! a field $F$ for homalg and a boolean $B$. We then truncate $m$ to the specified
#! degree $d$. We express this result as morphism of vector spaces over the field
#! $F$. We return the corresponding DegreeXLayerVectorSpaceMorphism.
#! If the boolean $B$ is true, we display additional output during the computation,
#! otherwise this output is surpressed.
#! @Returns a DegreeXLayerVectorSpaceMorphism
#! @Arguments V, a, m, F, B
DeclareOperation( "DegreeXLayerOfGradedRowOrColumnMorphism",
                 [ IsToricVariety, IsGradedRowOrColumnMorphism, IsHomalgModuleElement, IsHomalgRing, IsBool ] );

#! @Description
#! This method operates just as 'DegreeXLayerOfGradedRowOrColumnMorphism'
#! above. However, here the field F is taken as the field of coefficients
#! of the Cox ring of the variety $V$.
#! @Returns a vector space morphism
#! @Arguments V, a, d, B
DeclareOperation( "DegreeXLayerOfGradedRowOrColumnMorphism",
                  [ IsToricVariety, IsGradedRowOrColumnMorphism, IsList, IsBool ] );

#! @Description
#! This method operates just as 'DegreeXLayerOfGradedRowOrColumnMorphism'
#! above. However, here the field F is taken as the field of coefficients
#! of the Cox ring of the variety $V$.
#! @Returns a vector space morphism
#! @Arguments V, a, m, B
DeclareOperation( "DegreeXLayerOfGradedRowOrColumnMorphism",
                  [ IsToricVariety, IsGradedRowOrColumnMorphism, IsHomalgModuleElement, IsBool ] );

#! @Description
#! This method operates just as 'DegreeXLayerOfGradedRowOrColumnMorphism'
#! above. However, here the field F is taken as the field of coefficients
#! of the Cox ring of the variety $V$. Also, B is set to false, i.e. no
#! additional information is being displayed.
#! @Returns a vector space morphism
#! @Arguments V, a, d
DeclareOperation( "DegreeXLayerOfGradedRowOrColumnMorphism",
                  [ IsToricVariety, IsGradedRowOrColumnMorphism, IsList ] );

#! @Description
#! This method operates just as 'DegreeXLayerOfGradedRowOrColumnMorphism'
#! above. However, here the field F is taken as the field of coefficients
#! of the Cox ring of the variety $V$. Also, B is set to false, i.e. no
#! additional information is being displayed.
#! @Returns a vector space morphism
#! @Arguments V, a, m
DeclareOperation( "DegreeXLayerOfGradedRowOrColumnMorphism",
                  [ IsToricVariety, IsGradedRowOrColumnMorphism, IsHomalgModuleElement ] );


#############################################################################
##
#! @Section Saving the truncation of graded row and column morphism to a file
##
#############################################################################

DeclareOperation( "FindVarsAndCoefficientsWithoutEvaluation",
                  [ IsString, IsChar ] );

#! @Description
#! The arguments are a toric variety $V$, a projective graded $S$-module morphism $\varphi$ 
#! ($S$ being the Cox ring of $V$) and a <A>degree_list</A> specifying an element of the degree group of the 
#! toric variety $V$ and string 'file_name'. This method then computes the matrix encoding the DegreeXLayer of the 
#! given morphism of projective modules and saves it to the file 'file_name'. This file is prepared to be used with 
#! gap.
#! @Returns true or false
#! @Arguments V, \varphi, degree_list, file_name
DeclareOperation( "EntriesOfTruncatedMatrix",
               [ IsList, IsBool ] );

DeclareOperation( "EntriesOfTruncatedMatrixInRange",
               [ IsList, IsBool, IsInt, IsInt ] );

DeclareOperation( "TruncateGradedRowOrColumnMorphismInParallel",
                  [ IsToricVariety, IsGradedRowOrColumnMorphism, IsList, IsFieldForHomalg, IsBool, IsInt ] );
