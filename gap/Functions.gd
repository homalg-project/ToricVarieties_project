#############################################################################
##
##  Functions.gd        cohomCalgInterface package
##                      Martin Bies
##
##  Copyright 2019      ULB Brussels
##
##  A package to communicate with the software cohomCalg
##
#! @Chapter Functionality of cohomCalg
##
#############################################################################



##############################################################################################
##
#! @Section Functions to communicate with cohomCalg
##
##############################################################################################

#! @Description
#! Given a toric variety vari and a list L = [ D_2, ..., D_n ] of degree in the class group,
#! and thereby defining a direct sum of line bundles on vari, this function computes all
#! of the sheaf cohomology dimensions of this vector bundle by use of cohomCalg. 
#! The output is a list of integers, each representing the corresponding sheaf cohomology dimension.
#! @Returns List
#! @Arguments vari, L
DeclareOperation( "AllHi",
                  [ IsToricVariety, IsList ] );
