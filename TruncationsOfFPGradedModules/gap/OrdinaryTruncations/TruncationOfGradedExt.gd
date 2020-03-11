##########################################################################################
##
##  TruncationOfGradedExt.gd           TruncationsOfFPGradedModules package
##
##  Copyright 2020                     Martin Bies,    University of Oxford
##
#! @Chapter Truncations of GradedExt for f.p. graded modules
##
#########################################################################################


#############################################################
##
#! @Section Truncations of InternalHoms of FpGradedModules
##
#############################################################

#!
DeclareOperation( "TruncateInternalHom",
                [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsList, IsBool, IsFieldForHomalg ] );

#!
DeclareOperation( "TruncateInternalHomEmbedding",
                [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsList, IsBool, IsFieldForHomalg ] );

#!
DeclareOperation( "TruncateInternalHom",
                [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsFpGradedLeftOrRightModulesMorphism, IsList, IsBool, IsFieldForHomalg ] );


#########################################################################
##
#! @Section Truncations of InternalHoms of FpGradedModules to degree zero
##
#########################################################################

#!
DeclareOperation( "TruncateInternalHomToZero",
                [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsBool, IsFieldForHomalg ] );

#!
DeclareOperation( "TruncateInternalHomEmbeddingToZero",
                [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsBool, IsFieldForHomalg ] );

#!
DeclareOperation( "TruncateInternalHomToZero",
                [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsFpGradedLeftOrRightModulesMorphism, IsBool, IsFieldForHomalg ] );


######################################################################
##
#! @Section Truncations of InternalHoms of FpGradedModules in parallel
##
######################################################################

#!
DeclareOperation( "TruncateInternalHomInParallel",
                [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsList, IsBool, IsFieldForHomalg ] );

#!
DeclareOperation( "TruncateInternalHomEmbeddingInParallel",
                [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsList, IsBool, IsFieldForHomalg ] );

#!
DeclareOperation( "TruncateInternalHomInParallel",
                [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsFpGradedLeftOrRightModulesMorphism, IsList, IsBool, IsFieldForHomalg ] );


#####################################################################################
##
#! @Section Truncations of InternalHoms of FpGradedModules to degree zero in parallel
##
#####################################################################################

#!
DeclareOperation( "TruncateInternalHomToZeroInParallel",
                [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsBool, IsFieldForHomalg ] );
#!
DeclareOperation( "TruncateInternalHomEmbeddingToZeroInParallel",
                [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsBool, IsFieldForHomalg ] );

#!
DeclareOperation( "TruncateInternalHomToZeroInParallel",
                [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsFpGradedLeftOrRightModulesMorphism, IsBool, IsFieldForHomalg ] );



#############################################################
##
## Section Truncations of GradedExt of FpGradedModules
##
#############################################################

#!
DeclareOperation( "TruncateGradedExt",
                [ IsInt, IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsList, IsList ] );

#!
DeclareOperation( "TruncateGradedExtToZero",
                [ IsInt, IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsBool, IsFieldForHomalg ] );

#!
DeclareOperation( "TruncateGradedExtInParallel",
                [ IsInt, IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsList, IsList ] );

#!
DeclareOperation( "TruncateGradedExtToZeroInParallel",
                [ IsInt, IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsBool, IsFieldForHomalg ] );
