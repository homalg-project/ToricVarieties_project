#######################################################################################
##
##  CategoryOfCoherentSheaves.gd    CoherentSheavesOnToricVarieties package
##                                  Martin Bies
##
##  Copyright 2020                  University of Oxford
##
##  A package to model coherent toric sheaves as elements in a Serre quotient category.
##
#! @Chapter Stuff
##
#######################################################################################



#######################################################################################
##
#! @Section Category of coherent sheaves
##
#######################################################################################

#! @Description
#! This operation construct the category of coherent sheaves on a toric variety V
#! via a Serre quotient of the category of f.p. graded left modules over the Cox ring.
#! @Returns a CAP category
#! @Arguments V
DeclareOperation( "CategoryOfCoherentSheaves",
                  [ IsToricVariety ] );
