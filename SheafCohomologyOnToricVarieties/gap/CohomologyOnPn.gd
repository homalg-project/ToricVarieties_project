##########################################################################################
##
##  CohomologyOnPn.gd                  SheafCohomologyOnToricVarieties package
##
##  Copyright 2020                     Martin Bies,       University of Oxford
##
#! @Chapter Sheaf cohomology computations on (direct products of) projective spaces
##
#########################################################################################



####################################################
##
#! @Section Specialised methods on CPn
##
####################################################

#! @Description
#! Given that variety is a complex projective space with Coxring <M>S</M> and <M>M</M> a f. p. graded S-module, this method computes the 
#! dimension of the vector space <M>H^0 \left( X_\Sigma, \widetilde{M} \right)</M> and returns this integer. To achieve this an 
#! integer <M>e</M> is computed such that <M>H^0 \left( \tilde{M} \right) \cong H_S^0 \left( \mathfrak{m}^e , \tilde{M} \right)_0</M>. 
#! This integer <M>e</M> in turn is computed by use of linear regularity of the module <M>M</M>.
#! @Returns an integer
#! @Arguments vari, M
DeclareOperation( "H0OnProjectiveSpaceViaLinearRegularity",
                  [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep ] );

#! @Description
#! Given that variety is a complex projective space with Coxring <M>S</M> and <M>M</M> a f. p. graded S-module, this method computes a
#! function <M>f \colon \mathbb{N}_{\geq 0} \to \mathbb{N}_{\geq 0}</M> such that <M>f \left( n \right) = 
#! dim \left( H^0 \left( X_\Sigma, \widetilde{M} \left( n \right) \right) \right)</M>. This function is returned.
#! @Returns a function
#! @Arguments vari, M
DeclareOperation( "H0OnProjectiveSpaceForAllPositiveTwistsViaLinearRegularity",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep ] );

#! @Description
#! Given that variety is a complex projective space with Coxring <M>S</M> and <M>M</M> a f. p. graded S-module, this method uses 
#! the function <M>f \colon \mathbb{N}_{\geq 0} \to \mathbb{N}_{\geq 0}</M> computed by 
#! H0OnCPNForAllTwistsViaLinReg and evaluates it for all integers in range. The resulting list of non-negative 
#! integers is returned.
#! @Returns a list of non-negative integers
#! @Arguments vari, M, range
DeclareOperation( "H0OnProjectiveSpaceInRangeViaLinearRegularity",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsList ] );



#####################################################################################################################
##
#! @Section Experimental methods for computations on direct products on Pns implemented for the GradedModules Package
##
#####################################################################################################################

#! @Description
#! Given that variety <A>vari</A>is a direct product of complex projective spaces with Coxring <M>S</M> and that
#! <M>M</M> a f. p. graded S-module, this is an experimental method to compute sheaf cohomology. Note that all
#! coherent sheaves on direct products of projective spaces have finite dimensional vector spaces as their
#! cohomology groups. Thus this method returns such a vector space.
#! A boolean $b$ can be specified as third argument. If $b = true$ we saturate the module before the core procedure is applied.
#! The default value is 'false', i.e. do not saturate the module.
#! @Returns a vector space
#! @Arguments vari, M, b
#!
DeclareOperation( "H0OnDirectProductsOfProjectiveSpaces",
                  [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsBool ] );

DeclareOperation( "H0OnDirectProductsOfProjectiveSpaces",
                  [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep ] );
