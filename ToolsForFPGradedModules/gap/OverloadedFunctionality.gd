################################################################################################
##
##  OverloadedFunctionality.gd   ToolsForFPGradedModules package
##
##  Copyright 2020               Martin Bies,       University of Oxford
##
#! @Chapter Overload functions/methods for old graded modules
##
################################################################################################


#! @Description
#! The argument is an FPGradedMOdule. We then compute an equivalent yet simpler presentation for this module.
#! @Arguments M
DeclareOperation( "ByASmallerPresentation",
                  [ IsFpGradedLeftOrRightModulesObject ] );
