################################################################################################
##
##  Conversion.gd               ToolsForFPGradedModules package
##
##  Copyright 2020              Martin Bies,       University of Oxford
##
#! @Chapter Conversion among FPGradedModules and 'old' graded modules and saving them to files
##
################################################################################################



##############################################################################################
##
#! @Section Turn CAP Graded Modules into old graded modules and vice versa
##
##############################################################################################

#! @Description
#! The argument is a graded left or right module presentation M for CAP
#! @Returns the corresponding graded modules in terms of the 'old' packages GradedModules
#! @Arguments M
DeclareOperation( "TurnIntoOldGradedModule",
                  [ IsFpGradedLeftOrRightModulesObject ] );

DeclareOperation( "TurnIntoCAPGradedModule",
                  [ IsGradedModuleOrGradedSubmoduleRep ] );


##############################################################################################
##
#! @Section Save CAP f.p. graded module to file
##
##############################################################################################

#! @Description
#! The argument is a graded left or right module presentation M for CAP and saves this module 
#! to file as 'old' graded module presentation. By default, the files are saved in the main 
#! directory of the package 'SheafCohomologyOnToricVarieties'.
#! @Returns true (in case of success) or raises error in case the file could not be written
#! @Arguments M
DeclareOperation( "SaveToFileAsOldGradedModule",
                  [ IsString, IsFpGradedLeftOrRightModulesObject ] );

#! @Description
#! The argument is a graded left or right module presentation M for CAP and saves this module 
#! to file as CAP graded module presentation. By default, the files are saved in the main 
#! directory of the package 'SheafCohomologyOnToricVarieties'.
#! @Returns true (in case of success) or raises error in case the file could not be written
#! @Arguments M
DeclareOperation( "SaveToFileAsCAPGradedModule",
                  [ IsString, IsFpGradedLeftOrRightModulesObject ] );


