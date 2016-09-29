##########################################################################################
##
##  CohomologyViaGSForGradedModules.gd         ToricVarieties package
##
##  Copyright 2015- 2016, Sebastian Gutsche, TU Kaiserslautern
##                        Martin Bies,       ITP Heidelberg
##
#! @Chapter Sheaf cohomology via the theorem of Greg. Smith for the package GradedModules
##
#########################################################################################



###############################################################################
##
#! @Section Implementation of the theorem of G. Smith for GradedModules package
##
###############################################################################

DeclareOperation( "MultiGradedBettiTable", 
                  [ IsGradedModuleOrGradedSubmoduleRep ] );

#! @Description
#! Given a smooth and projective toric variety with Coxring <M>S</M> and a f. p. graded S-module <M>M</M>, this method uses a 
#! theorem by Greg Smith to try and compute <M>H^0 \left( X_\Sigma, \widetilde{M} \right)</M> on this toric variety. 
#! To this end first the smallest ample bundle is computed (which is in turn achieved by considering the Nef cone). 
#! Suppose the class of this bundle is <M>d</M>, then let <M>C \subseteq S</M> be the degree <M>d</M> layer of the Cox ring. 
#! Then <M>C^\prime := C \cdot S</M> is a f.p. graded <M>S</M>-module. Subsequently the algorithm tries to find an integer 
#! <M> e </M> such that the degree zero layer of <M>\text{Hom} \left( {C^\prime}^{e}, M \right)</M> is isomorphic to 
#! <M>H^0 \left( X_\Sigma, \widetilde{M} \right)</M>. The theorem of G. Smith is used as criterion, when an integer <M> e </M> 
#! satisfies this requirement. In case such an integer <M> e </M> is found, the method returns a list consisting of the 
#! integer <M>e</M> and the dimension of the vector space <M>\text{Hom}_S \left( {C^\prime}^{e}, M \right)_0</M>.
#! Note that the theorem of G. Smith only applies when we compute the e-th power of the ideal <M>C^\prime</M>. 
#! Still experimental evidence indicates that it is favourable to use the e-th Frobenius power instead. Indeed the algorithm
#! uses the Frobenius power in its computation.
#! Finally a boolean $b$ can be given to the method as third argument. If $b = true$, the method will first compute the
#! saturation of the module with respect to $C^\prime$, otherwise it will not. If no value is specified, we use the
#! default value, which is 'false'.
#! @Returns a list consisting of an integer and a vector space
#! @Arguments vari, M, b
DeclareOperation( "H0ByGS",
                  [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsBool ] );

DeclareOperation( "H0ByGS",
                  [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep ] );

DeclareOperation( "H0EstimateByGS",
                  [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsBool ] );

DeclareOperation( "H0EstimateByGS",
                  [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep ] );

#! @Description
#! Given a smooth and projective toric variety with Coxring <M>S</M> and a f. p. graded S-module <M>M</M>, a similar approach
#! is used to try to compute <M>H^i \left( X_\Sigma, \widetilde{M} \right)</M>. Let <M>C^\prime</M> as above, then the theorem
#! of G. Smith is used as criterion when an integer <M> e </M> is such that there is an isomorphism of the degree zero layer of
#! <M>\text{Ext}^i_S \left( {C^\prime}^{e}, M \right)</M> and <M>H^i \left( X_\Sigma, \widetilde{M} \right)</M>. In case 
#! such an integer <M> e </M> is found, the method returns a list consisting of the integer <M>e</M> and the dimension of the 
#! vector space <M>\text{Ext}_S^i \left( {C^\prime}^{e}, M \right)_0</M>.
#! Note that again the e-th Frobenius power of the ideal <M> C^\prime </M> is used for the computation. Also recall that a 
#! boolean $b$ can be provided as third argument to specify if the module should be saturated before the theorem of 
#! G. Smith is applied to it. $b = true$ will trigger the saturation, $b = false$ will prevent it and the default value is
#! $b = false$.
#! @Returns a list consisting of an integer and a vector space
#! @Arguments vari, M, index, b
DeclareOperation( "HiByGS",
                  [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsInt, IsBool ] );

DeclareOperation( "HiByGS",
                  [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsInt ] );

#! @Description
#! Given a smooth and projective toric variety <M> X_\Sigma </M> with Coxring <M>S</M> and a f. p. graded S-module <M>M</M>, 
#! this method tries to compute all cohomology classes of the coherent sheaf <M> \widetilde{M} </M> by applying the method 
#! <M>\text{HiByGS}</M> for all values of <M>i \in \left\{ 0, \dots, \text{dim} X_\Sigma \right\}</M>. In case of success
#! the method returns an integer <M>e</M> such that 
#! <M>\text{Ext}_S^i \left( {C^\prime}^e, M \right)_0 \cong H^i \left( X_\Sigma, \widetilde{M} \right)</M> 
#! and the collection of all degree zero layers represented as vector spaces.
#! Note that again the e-th Frobenius power of the ideal <M> C^\prime </M> is used for the computation. Also recall that a 
#! boolean $b$ can be provided as third argument to specify if the module should be saturated before the theorem of 
#! G. Smith is applied to it. $b = true$ will trigger the saturation, $b = false$ will prevent it and the default value is
#! $b = false$.
#! @Returns a list consisting of an integer and a list of vector spaces
#! @Arguments vari, M
DeclareOperation( "AllCohomologiesByGS",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsBool ] );

DeclareOperation( "AllCohomologiesByGS",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep ] );