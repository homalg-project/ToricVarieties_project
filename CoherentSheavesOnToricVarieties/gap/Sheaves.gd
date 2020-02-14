################################################################################################
##
##  Sheaves.gd                         CoherentSheavesOnToricVarieties package
##
##  Copyright 2020                     Martin Bies,       University of Oxford
##
#! @Chapter Coherent sheaves on toric varieties
##
################################################################################################


##############################################################################################
##
#! @Section GAP category for coherent sheaves
##
##############################################################################################

#! @Description
#! The GAP category for coherent sheaves on toric varieties
#! @Returns true or false
#! @Arguments object
DeclareCategory( "IsCoherentSheafOnToricVariety",
                 IsObject );
DeclareOperation( "ToricVarietyString",
                  [ IsToricVariety, IsBool ] );


##############################################################################################
##
#! @Section Constructors for coherent sheaves of toric varieties
##
##############################################################################################

#! @Description
#! The arguments are a toric variety tor and an fp-graded left or right module.
#! @Returns a subvariety of a toric variety
#! @Arguments tor, L
DeclareOperation( "CoherentSheafOnToricVariety",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject ] );


##############################################################################################
##
#! @Section Attributes for coherent sheaves
##
##############################################################################################

#! @Description
#! The argument is a coherent sheaf F on a toric variety.
#! The output is the ambient toric variety.
#! @Returns a toric variety
#! @Arguments F
DeclareAttribute( "AmbientToricVariety",
                  IsCoherentSheafOnToricVariety );

#! @Description
#! The argument is a coherent sheaf F on a toric varieties.
#! The output is the defining module of this sheaf.
#! @Returns an fp graded S-module
#! @Arguments F
DeclareAttribute( "DefiningModule",
                  IsCoherentSheafOnToricVariety );
