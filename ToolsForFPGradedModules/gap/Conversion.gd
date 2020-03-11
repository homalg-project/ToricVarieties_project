################################################################################################
##
##  Conversion.gd               ToolsForFPGradedModules package
##
##  Copyright 2020              Martin Bies,       University of Oxford
##
#! @Chapter Conversion among f.p. graded modules
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


##############################################################################################
##
#! @Section Turn left into right modules and vice versa
##
##############################################################################################

#! @Description
#! The argument is a graded row R. This method turns it into the corresponding graded column.
#! @Returns graded column
#! @Arguments R
DeclareOperation( "TurnIntoGradedColumn",
                  [ IsGradedRow ] );

#! @Description
#! The argument is a graded column C. This method turns it into the corresponding graded row.
#! @Returns graded row
#! @Arguments C
DeclareOperation( "TurnIntoGradedRow",
                  [ IsGradedColumn ] );

#! @Description
#! The argument is a graded row morphism m. This method turns it into the corresponding
#! morphism of graded columns.
#! @Returns graded columns morphism
#! @Arguments C
DeclareOperation( "TurnIntoGradedColumnMorphism",
                  [ IsGradedRowMorphism ] );

#! @Description
#! The argument is a graded column morphism m. This method turns it into the corresponding
#! morphism of graded rows.
#! @Returns graded row morphism
#! @Arguments C
DeclareOperation( "TurnIntoGradedRowMorphism",
                  [ IsGradedColumnMorphism ] );

#! @Description
#! The argument is an f.p. graded left module M. This method turns it into the corresponding right module.
#! @Returns f.p. graded right module
#! @Arguments M
DeclareOperation( "TurnIntoFpGradedRightModule",
                  [ IsFpGradedLeftModulesObject ] );

#! @Description
#! The argument is an f.p. graded right module M. This method turns it into the corresponding left module.
#! @Returns f.p. graded left module
#! @Arguments M
DeclareOperation( "TurnIntoFpGradedLeftModule",
                  [ IsFpGradedRightModulesObject ] );

#! @Description
#! The argument is an f.p. graded left module morphism M. This method turns it into the corresponding 
#! right module morphism.
#! @Returns f.p. graded right module morphism
#! @Arguments M
DeclareOperation( "TurnIntoFpGradedRightModuleMorphism",
                  [ IsFpGradedLeftModulesMorphism ] );

#! @Description
#! The argument is an f.p. graded right module morphism M. This method turns it into the corresponding 
#! left module morphism.
#! @Returns f.p. graded left module morphism
#! @Arguments M
DeclareOperation( "TurnIntoFpGradedLeftModuleMorphism",
                  [ IsFpGradedRightModulesMorphism ] );
