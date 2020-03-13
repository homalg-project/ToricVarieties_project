################################################################################################
##
##  LocalizedTruncationsOfFPGradedModules.gd        TruncationsOfFPGradedModules
##
##  Copyright 2020               Martin Bies,       University of Oxford
##
#!  @Chapter Localized truncations of FPGradedModules
##
################################################################################################


#######################################################################################
##
#! @Section Localized degree-0-layer of f.p. graded modules
##
#######################################################################################

#! @Description
#! This method accepts an fp graded module M and a list L of variables.
#! It then localizes M at these variables and computes the degree-0-layer.
#! @Returns an fp graded module
#! @Arguments M, L
DeclareOperation( "LocalizedDegreeZero",
                  [ IsFpGradedLeftOrRightModulesObject, IsList ] );
DeclareOperation( "LocalizedDegreeZero",
                  [ IsFpGradedLeftOrRightModulesObject, IsList, IsHomalgGradedRing, IsList, IsCapCategory ] );

#! @Description
#! This method accepts an fp graded module morphism M and a list L of variables.
#! It then localizes M at these variables and computes the degree-0-layer.
#! @Returns a morphism of fp graded modules
#! @Arguments M, L
DeclareOperation( "LocalizedDegreeZero",
                  [ IsFpGradedLeftOrRightModulesMorphism, IsList ] );
