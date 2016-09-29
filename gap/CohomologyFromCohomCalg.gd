###############################################################################################
##
##  CohomologyFromCohomCalg.gd         ToricVarieties package
##
##  Copyright 2015- 2016, Sebastian Gutsche, TU Kaiserslautern
##                        Martin Bies,       ITP Heidelberg
##
#! @Chapter Cohomology of vector bundles on (smooth and compact) toric varieties from cohomCalg
##
###############################################################################################



####################################################################################
##
#! @Section All sheaf cohomologies of vector bundles from cohomCalg
##
####################################################################################

#! @Description
#! The arguments are a toric variety <A>V</A> with Coxring <A>S</A> and a f.p. graded S-module <A>M</A>. Given that <A>M</A> is
#! free, i.e. <A>\tilde{M}</A> is a vector bundle on <A>V</A>, then this method computes all cohomology classes of this vector
#! bundle. A boolean <A>B</A> can be specified as third argument. If <A>B</A> equals true, then a list of vector spaces is
#! produced, otherwise only the dimensions of these vector spaces are returned. The default value is false.
#! @Returns a list of vector spaces
#! @Arguments V, M, B
DeclareOperation( "AllCohomologiesFromCohomCalg",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool ] );

DeclareOperation( "AllCohomologiesFromCohomCalg",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ] );

DeclareOperation( "AllCohomologiesFromCohomCalg",
                  [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsBool ] );

DeclareOperation( "AllCohomologiesFromCohomCalg",
                  [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject ] );