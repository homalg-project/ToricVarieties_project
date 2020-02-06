#############################################################################
##
##  Tools.gd            SparseMatrices package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to handle sparse matrices in gap
##
#! @Chapter Interface to smasto
##
#############################################################################



##############################################################################################
##
#! @Section Finding the SmastoDirectory
##
##############################################################################################

#! @Description
#! This operation identifies the location of the smasto programs.
#! @Returns the corresponding directory
#! @Arguments none
DeclareOperation( "FindSmastoDirectory", [ ] );
