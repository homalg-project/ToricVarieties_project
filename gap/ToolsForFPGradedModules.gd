##########################################################################################
##
##  ToolsForFPGradedModules.gd        SheafCohomologyOnToricVarieties package
##
##  Copyright 2019                     Martin Bies,       ULB Brussels
##
#! @Chapter Tools for FPGradedModules
##
#########################################################################################


####################################################################################
##
#! @Section Minimal free resolutions
##
####################################################################################

#! @Description
#! The argument is a graded left or right module presentation <A>M</A>.
#! We then compute a minimal free resolution of <A>M</A>.
#! @Returns a complex of projective graded module morphisms
#! @Arguments M
DeclareAttribute( "MinimalFreeResolutionForCAP",
                  IsFpGradedLeftOrRightModulesObject );

## for my convenience a method that displays all information about a (co)complex
DeclareOperation( "FullInformation",
                  [ IsCapComplex ] );

DeclareOperation( "FullInformation",
                  [ IsCapCocomplex ] );



####################################################################################
##
#! @Section Betti tables
##
####################################################################################

#! @Description
#! The argument is a graded left or right module presentation <A>M</A>.
#! We then compute the Betti table of <A>M</A>.
#! @Returns a list of lists
#! @Arguments M
DeclareAttribute( "BettiTableForCAP",
                  IsFpGradedLeftOrRightModulesObject );
