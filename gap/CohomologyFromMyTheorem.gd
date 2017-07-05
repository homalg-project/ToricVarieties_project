##########################################################################################
##
##  CohomologyFromMyTheorem.gd         SheafCohomologyOnToricVarieties package
##
##  Copyright 2016                     Martin Bies,       ITP Heidelberg
##
#! @Chapter Sheaf cohomology via my cohomology theorem
##
#########################################################################################


#############################################################
##
#! @Section Specialised InternalHomOnObjects methods
##
#############################################################

#!
DeclareOperation( "InternalHomDegreeZeroOnObjects",
                [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, 
                                  IsGradedLeftOrRightModulePresentationForCAP, IsBool ] );

#!
DeclareOperation( "ComputeInput",
               [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism, IsList ] );

#!
DeclareOperation( "InternalHomDegreeZeroOnObjectsParallel",
                [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, 
                                  IsGradedLeftOrRightModulePresentationForCAP, IsBool ] );

#!
DeclareOperation( "InternalHomEmbeddingDegreeZeroOnObjectsParallel",
                [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, 
                                  IsGradedLeftOrRightModulePresentationForCAP, IsBool, IsHomalgRing ] );


#############################################################
##
#! @Section Specialised InternalHomOnMorphisms methods
##
#############################################################

#!
DeclareOperation( "InternalHomDegreeZeroOnMorphisms",
                [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, 
                                  IsGradedLeftOrRightModulePresentationMorphismForCAP, IsBool ] );

#!
DeclareOperation( "InternalHomDegreeZeroOnMorphismsParallel",
                [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, 
                                  IsGradedLeftOrRightModulePresentationMorphismForCAP, IsBool, IsHomalgRing ] );


#############################################################
##
## Section Specialised GradedExt methods
##
#############################################################

#!
DeclareOperation( "GradedExtDegreeZeroOnObjects",
                [ IsInt, IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, 
                                         IsGradedLeftOrRightModulePresentationForCAP, IsBool ] );

#!
DeclareOperation( "GradedExtDegreeZeroOnObjectsParallel",
                [ IsInt, IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, 
                                         IsGradedLeftOrRightModulePresentationForCAP, IsBool ] );


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
