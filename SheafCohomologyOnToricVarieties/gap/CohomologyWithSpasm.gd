##########################################################################################
##
##  CohomologyWithSpasm.gd             SheafCohomologyOnToricVarieties package
##
##  Copyright 2020                     Martin Bies,       University of Oxford
##
#! @Chapter Sheaf cohomology computations (https://arxiv.org/abs/1802.08860) with Spasm
##
#########################################################################################

#############################################################
##
#! @Section Cohomology from Spasm and Singular
##
#############################################################

#! @Description
#! Given a variety $V$ and an f.p. graded $S$-module $M$ ($S$ being
#! the Cox ring of $V$), this method computes $H^0( V, \tilde{M} )$.
#! It uses a combination of Singular and Spasm to perform this task.
#! @Returns a vector space
#! @Arguments V, M
DeclareOperation( "H0ParallelBySpasm",
                  [ IsToricVariety, IsFpGradedLeftModulesObject ] );

DeclareOperation( "TruncateIntHomToZeroInParallelBySpasm",
                  [ IsToricVariety, IsFpGradedLeftModulesObject, IsFpGradedLeftModulesObject ] );

DeclareOperation( "TruncateFPGradedModuleMorphismToZeroInParallelBySpasm",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism ] );
