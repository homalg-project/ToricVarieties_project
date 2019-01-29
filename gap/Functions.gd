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
#! This function computes all of the sheaf cohomology dimensions of a vector bundle on a toric 
#! variety by use of cohomCalg. To this end, the vector bundle must be the direct sum of line 
#! bundles of degrees D1, ... D_n. The output is a list of integers, each representing the
#! corresponding sheaf cohomology dimension.
#! @Returns List
#! @Arguments ToricVariety var and list L = [ D1, ..., D_n ], i.e. L is a list of lists of integers
DeclareOperation( "AllHi",
                  [ IsToricVariety, IsList ] );
