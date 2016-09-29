#############################################################################
##
##  NefMoriAndIntersection.gd         ToricVarieties package
##
##  Copyright 2015- 2016, Sebastian Gutsche, TU Kaiserslautern
##                        Martin Bies,       ITP Heidelberg
##
#! @Chapter The category of f.p. graded S-modules
##
#############################################################################

##########################################################################################################################
##
#! @Section Truncations of f.p. graded S-modules
##
##########################################################################################################################

#!
DeclareOperation( "TruncationOfFreeModuleOnDirectProductsOfProjectiveSpaces",
                  [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep and IsFree ] );

#!
DeclareOperation( "EmbeddingOfTruncationOfFreeModuleOnDirectProductsOfProjectiveSpaces",
                  [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep and IsFree ] );

#!
DeclareOperation( "TruncationOfFPModuleOnDirectProductsOfProjectiveSpaces",
                  [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep ] );

#!
DeclareOperation( "EmbeddingOfTruncationOfFPModuleOnDirectProductsOfProjectiveSpaces",
                  [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep ] );

#!
DeclareOperation( "TruncationOfGradedModuleMorphismOnDirectProductsOfProjectiveSpaces",
                  [ IsToricVariety, IsHomalgGradedMap ] );

##################################################################################################################
##
#! @Section Truncations of f.p. graded S-modules to the GS-cone
##
##################################################################################################################
          
#!
DeclareOperation( "TruncationOfFreeModuleToGSCone",
                  [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep and IsFree ] );

#!
DeclareOperation( "EmbeddingOfTruncationOfFreeModuleToGSCone",
                  [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep and IsFree ] );

#!
DeclareOperation( "TruncationOfFPModuleToGSCone",
                  [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep ] );

#!
DeclareOperation( "EmbeddingOfTruncationOfFPModuleToGSCone",
                  [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep ] );

#!
DeclareOperation( "TruncationOfGradedModuleMorphismToGSCone",
                  [ IsToricVariety, IsHomalgGradedMap ] );

################################################################################################################
##
#! @Section Truncations of f.p. graded S-modules to arbitary subsemigroups of the classgroup
##
################################################################################################################