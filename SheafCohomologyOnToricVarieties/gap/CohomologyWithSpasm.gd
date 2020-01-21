##########################################################################################
##
##  CohomologyWithSpasm.gd             SheafCohomologyOnToricVarieties package
##
##  Copyright 2020                     Martin Bies,       University of Oxford
##
#! @Chapter Sheaf cohomology computations (https://arxiv.org/abs/1802.08860) with Spasm
##
#########################################################################################

DeclareOperation( "H0ParallelBySpasm",
                  [ IsToricVariety, IsFpGradedLeftModulesObject ] );

DeclareOperation( "TruncateIntHomToZeroInParallelBySpasm",
                  [ IsToricVariety, IsFpGradedLeftModulesObject, IsFpGradedLeftModulesObject ] );

DeclareOperation( "TruncateFPGradedModuleMorphismToZeroInParallelBySpasm",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism ] );
