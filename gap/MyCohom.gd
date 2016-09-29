########################################################################################
##
##  MyCohom.gd            ToricVarieties package
##
##  Copyright 2015- 2016, Sebastian Gutsche, TU Kaiserslautern
##                        Martin Bies,       ITP Heidelberg
##
#! @Chapter Methods to implement my improved cohomology theorems
##
########################################################################################

##########################################################################################################################
##
#! @Section My improved methods (maybe)
##
##########################################################################################################################

#! @Description
#! Given a smooth and complete toric variety $X$ with Cox ring $S$, a f.p. graded $S$-module $M$, and integer $m$ and a list of integers
#! which defines a point $p \in \text{Cl} \left( X_\Sigma \right)$, this method checks if 
#! $H^m \left( X_\Sigma, \mathcal{M} \left( p \right) \right) = 0$. If so the method returns true and otherwise false.
#! @Returns true or false
#! @Arguments vari, module, integer m, integer list p
DeclareOperation( "CriterionForVanishingSheafCohomologyClass",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsList ] );

DeclareOperation( "CriterionForVanishingLocalCohomologyClass",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsList ] );

DeclareOperation( "Criterion",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsGradedLeftOrRightModulePresentationForCAP, IsInt ] );


# experimental methods
DeclareOperation( "MyHiForCAP",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsBool, IsBool, IsBool ] );

DeclareOperation( "MyHiForCAP",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsBool, IsBool ] );

DeclareOperation( "MyHiForCAP",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsBool ] );

DeclareOperation( "MyHiForCAP",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt ] );

# yet more experimental methods

DeclareOperation( "PrintE1SheetToTerminal", 
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ] );
DeclareOperation( "MyHiForCAPFromKoszul",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt ] );