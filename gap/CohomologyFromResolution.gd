###############################################################################################
##
##  CohomologyFromResolution.gd         ToricVarieties package
##
##  Copyright 2015- 2016, Sebastian Gutsche, TU Kaiserslautern
##                        Martin Bies,       ITP Heidelberg
##
#! @Chapter Cohomology of coherent sheaves from resolution
##
###############################################################################################


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



###################################################################################
##
#! @Section Mapping between the cohomology classes computed by the theorem of GS
##
###################################################################################

#! @Description
#! Given a smooth and projective toric variety with Coxring <M>S</M> and a morphism <A>f</A> of the f. p.
#! graded S-modules <M>M</M> and <M>N</M>, this method computes the induced morphism between the i-th sheaf cohomology 
#! classes of <M>\tilde{M}</M> and <M>\tilde{N}</M>.
#! @Returns a morphism of vector spaces
#! @Arguments vari, f, i
DeclareOperation( "MapBetweenCohomologyClasses",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsInt ] );



#####################################################################################################
##
#! @Section Mapping between the cohomology classes of the vector bundles in a minimal free resolution
##
#####################################################################################################

#! @Description
#! Given a smooth and projective toric variety with Coxring <M>S</M> and a f. p. 
#! graded S-module <M>M</M>, this method computes a minimal free resolution of <M>M</M>. This resolution consists
#! solemnly of projective graded S-modules <M>M_k</M>. The method then computes the cohomology classes 
#! <M>H^i \left( \tilde{M_k} \right) </M> and the vector space morphisms between them, which are induced from the
#! minimal free resolution.
#! @Returns a complex of vector spaces
#! @Arguments vari, M
DeclareOperation( "MapsBetweenCohomologyClassesOfVectorBundlesInMinimalFreeResolution",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt ] );