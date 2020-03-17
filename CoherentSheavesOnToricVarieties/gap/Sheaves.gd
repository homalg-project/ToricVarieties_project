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
DeclareOperation( "ToricVarietyString",
                  [ IsToricVariety ] );


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

#! @Description
#! The argument is a coherent sheaf F on a toric varieties.
#! The output is the corresponding object in the Serre quotient category.
#! @Arguments F
DeclareAttribute( "DefiningSerreQuotientObject",
                  IsCoherentSheafOnToricVariety );

##############################################################################################
##
#! @Section Properties of coherent sheaves
##
##############################################################################################

#! @Description
#! Check if a coherent sheaf F is well defined.
#! @Returns true or false
#! @Arguments F
DeclareProperty( "IsWellDefined",
                  IsCoherentSheafOnToricVariety );


##############################################################################################
##
#! @Section Operations for coherent sheaves
##
##############################################################################################

#! @Description
#! Computes tensor product of two coherent sheaves F1, F2.
#! @Returns coherent sheaf
#! @Arguments F1, F2
DeclareOperation( "TensorProductOnObjects",
                  [ IsCoherentSheafOnToricVariety, IsCoherentSheafOnToricVariety ] );

#! @Description
#! Computes tensor product of two coherent sheaves F1, F2.
#! @Returns coherent sheaf
#! @Arguments F1, F2
DeclareOperation( "\*",
               [ IsCoherentSheafOnToricVariety, IsCoherentSheafOnToricVariety ] );

#! @Description
#! Computes n-th power of a coherent sheaf F.
#! @Returns coherent sheaf
#! @Arguments F, n
DeclareOperation( "\^",
               [ IsCoherentSheafOnToricVariety, IsInt ] );
