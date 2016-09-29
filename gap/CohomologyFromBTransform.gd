#############################################################################
##
##  CohomologyFromBTransform.gd         ToricVarieties package
##
##  Copyright 2015- 2016, Sebastian Gutsche, TU Kaiserslautern
##                        Martin Bies,       ITP Heidelberg
##
#! @Chapter Sheaf cohomology via B-transform
##
#############################################################################



####################################################################################
##
#! @Section Ideal and B-transform
##
####################################################################################

#! @Description
#! The arguments are a toric variety <A>V</A>, a  CAPPresentationCategoryObject <A>M</A> and
#! a graded left or right ideal $I$ The ideal and the module have to be defined over the Cox ring of 
#! the variety <A>V</A>. 
#! Optionally a boolean $b$ can be provided as third argument. If $b = true$, we use the Frobenius power of the ideal $I$ and otherwise
#! the standard powers. The default value is 'true', i.e. perform the computations by use of the Frobenius powers.
#! Optionally a boolean $b2$ can be provided as fourth argument. If $b2 = true$, we display messages, which inform about the status of the 
#! computation. The default value is $b2 = false$.
#! @Returns a presentation category object
#! @Arguments V, M, I, b
DeclareOperation( "IdealTransform",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsGradedLeftOrRightSubmoduleForCAP, IsBool, IsBool ] );

DeclareOperation( "IdealTransform",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsGradedLeftOrRightSubmoduleForCAP, IsBool ] );

DeclareOperation( "IdealTransform",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsGradedLeftOrRightSubmoduleForCAP ] );

#! @Description
#! Given a smooth and complete toric variety with Coxring <M>S</M>, a f. p. graded S-module <M>M</M> presented
#! as a GradedModulePresentationForCAP, we compute the B-transform of <A>M</A>. Thereby we determine 
#! $Ĥ^0$ of the sheaf $\tilde{M}$.
#! The computation can be done in two ways. Either by use of Frobenius powers (in this case the third argument has
#! to be set as 'true') or via the ordinary ideal powers (in this case the last argument has to be set as 'false').
#! In any case, the computation will yield a finite dimensional vector space, which is returned as an object in
#! MatrixCategory over the coefficient ring of the Cox ring. The latter is assumed a field.
#! @Returns a VectorSpaceObject
#! @Arguments vari, M, bool
DeclareOperation( "H0FromBTransform",
                 [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool, IsBool ] );

DeclareOperation( "H0FromBTransform",
                 [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool ] );

DeclareOperation( "H0FromBTransform",
                 [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ] );



########################################################################################
##
#! @Section Computation of B-transform for the GradedModules package
##
########################################################################################

DeclareOperation( "H0FromBTransform",
                 [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsInt ] );

#! @Description
#! Given a smooth and complete toric variety with Coxring <M>S</M>, a f. p. graded S-module <M>M</M> and two 
#! non-negative integers <M>a</M> and <M>b</M>, this method computes the degree zero layer of 
#! <M>\text{Hom} \left( B \left( x \right) , M \right)</M> for <M>x \in \left[ a,b \right]</M>. In this 
#! expression <M>B\left(x\right) </M> is the <M>x</M>-th Frobenius power of the irrelevant ideal of the toric
#! variety.
#! @Returns a list of vector spaces
#! @Arguments vari, M, a, b
DeclareOperation( "H0FromBTransformInInterval",
                 [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsInt, IsInt ] );

#! @Description
#! Given a smooth and complete toric variety with Coxring <M>S</M>, a f. p. graded S-module <M>M</M> , this
#! method computes the B-transform and uses a dynamic criterion to stop the computation of this transform.
#! @Returns a vector space
#! @Arguments vari, M
DeclareOperation( "H0FromBTransform",
                 [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep ] );