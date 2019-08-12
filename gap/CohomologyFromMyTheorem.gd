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
#! @Section Preliminaries
##
#############################################################

#!
DeclareOperation( "ParameterCheck",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsInt ] );

#!
DeclareOperation( "FindIdeal",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsInt ] );



#############################################################
##
#! @Section Computation of H0 by my theorem
##
#############################################################

#! @Description
#! Computation of sheaf cohomology from my theorem
#! @Returns a list consisting of an integer and a vector space
#! @Arguments vari, M
DeclareOperation( "H0",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsBool, IsBool, IsBool ] );
DeclareOperation( "H0",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsBool, IsBool ] );
DeclareOperation( "H0",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsBool ] );
DeclareOperation( "H0",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject ] );

#! @Description
#! Computation of sheaf cohomology from my own theorem, but in parallel (by forking).
#! @Returns a list consisting of an integer and a vector space
#! @Arguments vari, M
DeclareOperation( "H0Parallel",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsBool, IsBool, IsBool ] );
DeclareOperation( "H0Parallel",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsBool, IsBool ] );
DeclareOperation( "H0Parallel",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsBool ] );
DeclareOperation( "H0Parallel",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject ] );


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
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsInt, IsBool, IsBool, IsBool ] );
DeclareOperation( "Hi",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsInt, IsBool, IsBool ] );
DeclareOperation( "Hi",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsInt, IsBool ] );
DeclareOperation( "Hi",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsInt ] );

#! @Description
#! Computation of sheaf cohomology from my own theorem, but in parallel (by forking).
#! @Returns a list consisting of an integer and a vector space
#! @Arguments vari, M
DeclareOperation( "HiParallel",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsInt, IsBool, IsBool, IsBool ] );
DeclareOperation( "HiParallel",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsInt, IsBool, IsBool ] );
DeclareOperation( "HiParallel",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsInt, IsBool ] );
DeclareOperation( "HiParallel",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsInt ] );


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
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsBool, IsBool ] );
DeclareOperation( "AllHi",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsBool ] );
DeclareOperation( "AllHi",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject ] );

#! @Description
#! Computation of all sheaf cohomology classes from my theorem, but by use of parallelisation.
#! @Returns a list of lists, which in turn consist each of an integer and a vector space
#! @Arguments vari, M
DeclareOperation( "AllHiParallel",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsBool, IsBool ] );
DeclareOperation( "AllHiParallel",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsBool ] );
DeclareOperation( "AllHiParallel",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject ] );


#######################################################################
##
#! @Section Write matrices to be used for H0 computation via GS to files
##
#######################################################################

#!
DeclareOperation( "H0ByGSWritingMatricesUsedByFastInternalHomToFilesForCAP",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsBool ] );

DeclareOperation( "H0ByGSWritingMatricesUsedByFastInternalHomToFilesForCAP",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject ] );
