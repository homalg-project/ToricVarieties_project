#############################################################################
##
##  FunctorsTorVar.gd     ToricVarieties
##
##                        Sebastian Gutsche
##                        Martin Bies - University of Pennsylvania
##
##  Copyright 2011-2021
##
##  A package to handle toric varieties
##
##  Functors for toric varieties.
##
#############################################################################

########################
##
## PicardGroup
##
########################

DeclareGlobalVariable( "functor_PicardGroup_for_toric_varieties" );

DeclareGlobalFunction( "_Functor_PicardGroup_OnToricVarieties" );
DeclareGlobalFunction( "_Functor_PicardGroup_OnToricMorphisms" );

########################
##
## ClassGroup
##
########################

DeclareGlobalVariable( "functor_ClassGroup_for_toric_varieties" );

DeclareGlobalFunction( "_Functor_ClassGroup_OnToricVarieties" );
DeclareGlobalFunction( "_Functor_ClassGroup_OnToricMorphisms" );
