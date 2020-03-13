################################################################################################
##
##  LocalizedTruncationsFunctor.gd     TruncationsOfFPGradedModules
##
##  Copyright 2020                     Martin Bies,       University of Oxford
##
#!  @Chapter Functor for localized truncations to degree 0
##
################################################################################################

#######################################################################################
##
#! @Section Localized truncation functor for graded rows and columns
##
#######################################################################################

#! @Description
#! The arguments are a graded ring $S$ and a list $L$ of variables.
#! This function then computes the localized truncation functor at
#! the variables $L$ to degree 0 for graded rows.
#! @Returns a functor
#! @Arguments S, L
DeclareOperation( "LocalizedTruncationFunctorForGradedRows",
                  [ IsHomalgGradedRing, IsList ] );

#! @Description
#! The arguments are a graded ring $S$ and a list $L$ of variables.
#! This function then computes the localized truncation functor at
#! the variables $L$ to degree 0 for graded columns.
#! @Returns a functor
#! @Arguments S, L
DeclareOperation( "LocalizedTruncationFunctorForGradedColumns",
                  [ IsHomalgGradedRing, IsList ] );

DeclareOperation( "LocalizedTruncationFunctorForGradedRowsAndColumns",
                  [ IsHomalgGradedRing, IsList, IsBool ] );


#######################################################################################
##
#! @Section Localized truncation functor for f.p. graded modules
##
#######################################################################################

#! @Description
#! The arguments are a graded ring $S$ and a list $L$ of variables.
#! This function then computes the localized truncation functor at 
#! the variables $L$ to degree 0 for fp graded left modules.
#! @Returns a functor
#! @Arguments S, L
DeclareOperation( "LocalizedTruncationFunctorForFPGradedLeftModules",
                  [ IsHomalgGradedRing, IsList ] );

#! @Description
#! The arguments are a graded ring $S$ and a list $L$ of variables.
#! This function then computes the localized truncation functor at 
#! the variables $L$ to degree 0 for fp graded right modules.
#! @Returns a functor
#! @Arguments S, L
DeclareOperation( "LocalizedTruncationFunctorForFPGradedRightModules",
                  [ IsHomalgGradedRing, IsList ] );

DeclareOperation( "LocalizedTruncationFunctorForFPGradedModules",
                  [ IsHomalgGradedRing, IsList, IsBool ] );
