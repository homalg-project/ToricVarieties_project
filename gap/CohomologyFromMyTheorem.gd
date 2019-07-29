##########################################################################################
##
##  CohomologyFromMyTheorem.gd         SheafCohomologyOnToricVarieties package
##
##  Copyright 2019                     Martin Bies,       ULB Brussels
##
#! @Chapter Sheaf cohomology via my cohomology theorem
##
#########################################################################################


#############################################################
##
#! @Section Truncations of InternalHoms of FpGradedModules
##
#############################################################

# FIXME: IMPLEMENT THE FOLLOWING METHODS
# FIXME: RIGHT NOW NOT ALL ARE IMPLEMENTED
# FIXME: ALSO - CONTINUE TO WORK OVER THIS FILE AFTER GRADED_EXT
#!
DeclareOperation( "TruncateInternalHom",
                [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsList, IsBool ] );

#!
DeclareOperation( "TruncateInternalHomToZero",
                [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsBool ] );

#!
DeclareOperation( "TruncateInternalHomInParallel",
                [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsList, IsBool ] );

#!
DeclareOperation( "TruncateInternalHomToZeroInParallel",
                [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsBool ] );

#!
DeclareOperation( "TruncateInternalHomEmbedding",
                [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsList, IsBool ] );

#!
DeclareOperation( "TruncateInternalHomEmbeddingToZero",
                [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsBool ] );

#!
DeclareOperation( "TruncateInternalHomEmbeddingInParallel",
                [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsList, IsBool ] );

#!
DeclareOperation( "TruncateInternalHomEmbeddingToZeroInParallel",
                [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsBool ] );

#!
DeclareOperation( "TruncateInternalHom",
                [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsFpGradedLeftOrRightModulesMorphism, IsList, IsBool ] );

#!
DeclareOperation( "TruncateInternalHomToZero",
                [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsFpGradedLeftOrRightModulesMorphism, IsBool ] );

#!
DeclareOperation( "TruncateInternalHomEmbeddingInParallel",
                [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsFpGradedLeftOrRightModulesMorphism, IsList, IsBool ] );

#!
DeclareOperation( "TruncateInternalHomEmbeddingToZero InParallel",
                [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsFpGradedLeftOrRightModulesMorphism, IsBool ] );


#############################################################
##
## Section Truncations of GradedExt of FpGradedModules
##
#############################################################

#!
DeclareOperation( "TruncateGradedExt",
                [ IsInt, IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsList, IsBool ] );

#!
DeclareOperation( "TruncateGradedExtToZero",
                [ IsInt, IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsBool ] );

#!
DeclareOperation( "TruncateGradedExtInParallel",
                [ IsInt, IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsList, IsBool ] );

#!
DeclareOperation( "TruncateGradedExtToZeroInParallel",
                [ IsInt, IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsBool ] );


#############################################################
##
#! @Section Computation of H0 by my theorem
##
#############################################################

#! @Description
#! Computation of sheaf cohomology from my own theorem
#! @Returns a list consisting of an integer and a vector space
#! @Arguments vari, M
DeclareOperation( "H0",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool, IsBool, IsBool ] );
DeclareOperation( "H0",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool, IsBool ] );
DeclareOperation( "H0",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool ] );
DeclareOperation( "H0",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ] );

#! @Description
#! Computation of sheaf cohomology from my own theorem, but in parallel (by forking).
#! @Returns a list consisting of an integer and a vector space
#! @Arguments vari, M
DeclareOperation( "H0Parallel",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool, IsBool, IsBool ] );
DeclareOperation( "H0Parallel",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool, IsBool ] );
DeclareOperation( "H0Parallel",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool ] );
DeclareOperation( "H0Parallel",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ] );


#############################################################
##
#! @Section Computation of Hi by my theorem
##
#############################################################

#! @Description
#! Computation of sheaf cohomology from my own theorem
#! @Returns a list consisting of an integer and a vector space
#! @Arguments vari, M, i
DeclareOperation( "Hi",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsBool, IsBool, IsBool ] );
DeclareOperation( "Hi",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsBool, IsBool ] );
DeclareOperation( "Hi",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsBool ] );
DeclareOperation( "Hi",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt ] );

#! @Description
#! Computation of sheaf cohomology from my own theorem, but in parallel (by forking).
#! @Returns a list consisting of an integer and a vector space
#! @Arguments vari, M
DeclareOperation( "HiParallel",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsBool, IsBool, IsBool ] );
DeclareOperation( "HiParallel",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsBool, IsBool ] );
DeclareOperation( "HiParallel",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsBool ] );
DeclareOperation( "HiParallel",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt ] );


###################################################################################
##
#! @Section Computation of all sheaf cohomologies from my own theorem
##
###################################################################################

#! @Description
#! Computation of all sheaf cohomology classes from my theorem
#! @Returns a list of lists, which in turn consist each of an integer and a vector space
#! @Arguments vari, M
DeclareOperation( "AllHi",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool, IsBool ] );
DeclareOperation( "AllHi",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool ] );
DeclareOperation( "AllHi",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ] );

#! @Description
#! Computation of all sheaf cohomology classes from my theorem, but by use of parallelisation.
#! @Returns a list of lists, which in turn consist each of an integer and a vector space
#! @Arguments vari, M
DeclareOperation( "AllHiParallel",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool, IsBool ] );
DeclareOperation( "AllHiParallel",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool ] );
DeclareOperation( "AllHiParallel",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ] );


#######################################################################
##
#! @Section Write matrices to be used for H0 computation via GS to files
##
#######################################################################

#!
DeclareOperation( "H0ByGSWritingMatricesUsedByFastInternalHomToFilesForCAP",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool ] );

DeclareOperation( "H0ByGSWritingMatricesUsedByFastInternalHomToFilesForCAP",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ] );
