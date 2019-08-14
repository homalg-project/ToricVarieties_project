################################################################################################
##
##  CohomologyTools.gd          SheafCohomologyOnToricVarieties package
##
##  Copyright 2019              Martin Bies,       ULB Brussels
##
#! @Chapter Tools for cohomology computations
##
################################################################################################



##############################################################################################
##
#! @Section Turn CAP Graded Modules into old graded modules and vice versa
##
##############################################################################################

#! @Description
#! The argument is a graded left or right module presentation M for CAP
#! @Returns the corresponding graded modules in terms of the 'old' packages GradedModules
#! @Arguments M
DeclareOperation( "TurnIntoOldGradedModule",
                  [ IsFpGradedLeftOrRightModulesObject ] );

DeclareOperation( "TurnIntoCAPGradedModule",
                  [ IsGradedModuleOrGradedSubmoduleRep ] );


##############################################################################################
##
#! @Section Save CAP f.p. graded module to file
##
##############################################################################################

#! @Description
#! The argument is a graded left or right module presentation M for CAP and saves this module 
#! to file as 'old' graded module presentation. By default, the files are saved in the main 
#! directory of the package 'SheafCohomologyOnToricVarieties'.
#! @Returns true (in case of success) or raises error in case the file could not be written
#! @Arguments M
DeclareOperation( "SaveToFileAsOldGradedModule",
                  [ IsString, IsFpGradedLeftOrRightModulesObject ] );

#! @Description
#! The argument is a graded left or right module presentation M for CAP and saves this module 
#! to file as CAP graded module presentation. By default, the files are saved in the main 
#! directory of the package 'SheafCohomologyOnToricVarieties'.
#! @Returns true (in case of success) or raises error in case the file could not be written
#! @Arguments M
DeclareOperation( "SaveToFileAsCAPGradedModule",
                  [ IsString, IsFpGradedLeftOrRightModulesObject ] );


##############################################################################################
##
#! @Section Approximation Of Sheaf Cohomologies
##
##############################################################################################

#! @Description
#! The argument is a toric variety V and a non-negative integer e. The method computes the e-th
#! Frobenius power of the irrelevant left ideal of V.
#! @Returns a CAP graded left module
#! @Arguments V, e
DeclareOperation( "BPowerLeft",
                  [ IsToricVariety, IsInt ] );

#! @Description
#! The argument is a toric variety V and a non-negative integer e. The method computes the e-th
#! Frobenius power of the irrelevant right ideal of V.
#! @Returns a CAP graded right module
#! @Arguments V, e
DeclareOperation( "BPowerRight",
                  [ IsToricVariety, IsInt ] );

#! @Description
#! The argument is a toric variety V, a non-negative integer e and a graded CAP module M. 
#! The method computes the degree zero layer of Hom( B(e), M ) and returns its vector 
#! space dimension.
#! @Returns a non-negative integer
#! @Arguments V, e, M
DeclareOperation( "ApproxH0",
                  [ IsToricVariety, IsInt, IsFpGradedLeftOrRightModulesObject ] );

#! @Description
#! The argument is a toric variety V, a non-negative integer e and a graded CAP module M. 
#! The method computes the degree zero layer of Hom( B(e), M ) by use of parallelisation and 
#! returns its vector space dimension.
#! @Returns a non-negative integer
#! @Arguments V, e, M
DeclareOperation( "ApproxH0Parallel",
                  [ IsToricVariety, IsInt, IsFpGradedLeftOrRightModulesObject ] );

#! @Description
#! The argument is a toric variety V, non-negative integers i, e and a graded CAP module M.
#! The method computes the degree zero layer of Ext^i( B(e), M ) and returns its vector
#! space dimension.
#! @Returns a non-negative integer
#! @Arguments V, e, M
DeclareOperation( "ApproxHi",
                  [ IsToricVariety, IsInt, IsInt, IsFpGradedLeftOrRightModulesObject ] );

#! @Description
#! The argument is a toric variety V, non-negative integer i, e and a graded CAP module M.
#! The method computes the degree zero layer of Ext^i( B(e), M ) by use of parallelisation and
#! returns its vector space dimension.
#! @Returns a non-negative integer
#! @Arguments V, e, M
DeclareOperation( "ApproxHiParallel",
                  [ IsToricVariety, IsInt, IsInt, IsFpGradedLeftOrRightModulesObject ] );
