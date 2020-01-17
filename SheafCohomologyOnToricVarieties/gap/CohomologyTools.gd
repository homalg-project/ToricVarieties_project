################################################################################################
##
##  CohomologyTools.gd          SheafCohomologyOnToricVarieties package
##
##  Copyright 2020              Martin Bies,       University of Oxford
##
#! @Chapter Tools for cohomology computations
##
################################################################################################



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

DeclareOperation( "ApproxH0",
                  [ IsToricVariety, IsInt, IsFpGradedLeftOrRightModulesObject, IsBool ] );

#! @Description
#! The argument is a toric variety V, a non-negative integer e and a graded CAP module M. 
#! The method computes the degree zero layer of Hom( B(e), M ) by use of parallelisation and 
#! returns its vector space dimension.
#! @Returns a non-negative integer
#! @Arguments V, e, M
DeclareOperation( "ApproxH0Parallel",
                  [ IsToricVariety, IsInt, IsFpGradedLeftOrRightModulesObject ] );

DeclareOperation( "ApproxH0Parallel",
                  [ IsToricVariety, IsInt, IsFpGradedLeftOrRightModulesObject, IsBool ] );

#! @Description
#! The argument is a toric variety V, non-negative integers i, e and a graded CAP module M.
#! The method computes the degree zero layer of Ext^i( B(e), M ) and returns its vector
#! space dimension.
#! @Returns a non-negative integer
#! @Arguments V, i, e, M
DeclareOperation( "ApproxHi",
                  [ IsToricVariety, IsInt, IsInt, IsFpGradedLeftOrRightModulesObject ] );

DeclareOperation( "ApproxHi",
                  [ IsToricVariety, IsInt, IsInt, IsFpGradedLeftOrRightModulesObject, IsBool ] );

#! @Description
#! The argument is a toric variety V, non-negative integer i, e and a graded CAP module M.
#! The method computes the degree zero layer of Ext^i( B(e), M ) by use of parallelisation and
#! returns its vector space dimension.
#! @Returns a non-negative integer
#! @Arguments V, i, e, M
DeclareOperation( "ApproxHiParallel",
                  [ IsToricVariety, IsInt, IsInt, IsFpGradedLeftOrRightModulesObject ] );

DeclareOperation( "ApproxHiParallel",
                  [ IsToricVariety, IsInt, IsInt, IsFpGradedLeftOrRightModulesObject, IsBool ] );
