##########################################################################################
##
##  CohomologyFromResolution.gd        SheafCohomologyOnToricVarieties package
##
##  Copyright 2019                     Martin Bies,       ULB Brussels
##
#! @Chapter Cohomology of coherent sheaves from resolution
##
#########################################################################################



###################################################################################
##
#! @Section Mapping between the cohomology classes computed by the theorem of GS
##
###################################################################################

#! @Description
#! Given a smooth and projective toric variety <M>vari</M> with Coxring <M>S</M> and a f. p.
#! graded S-modules <M>M</M>, this method computes a minimal free resolution of <M>M</M> and then the dimension of the cohomology
#! classes of the projective modules in this minimal free resolution.
#! @Returns a list of lists of integers
#! @Arguments vari, M
DeclareOperation( "CohomologiesList",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ] );



#############################################################################################################
##
#! @Section Deductions On Sheaf Cohomology From Cohomology Of projective modules in a minimal free resolution
##
#############################################################################################################

#! @Description
#! Given a smooth and projective toric variety <M>vari</M> with Coxring <M>S</M> and a f. p.
#! graded S-modules <M>M</M>, this method computes a minimal free resolution of <M>M</M> and then the dimension of the cohomology
#! classes of the projective modules in this minimal free resolution. From this information we draw conclusions on the sheaf
#! cohomologies of the sheaf <M>\tilde{M}</M>.
#! @Returns a list
#! @Arguments vari, M
DeclareOperation( "DeductionOfSheafCohomologyFromResolution",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool ] );

DeclareOperation( "DeductionOfSheafCohomologyFromResolution",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ] );

DeclareOperation( "AnalyseShortExactSequence",
                  [ IsList ] );
