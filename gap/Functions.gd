#############################################################################
##
##  Functions.gd        TopcomInterface package
##                      Martin Bies
##
##  Copyright 2019      ULB Brussels
##
##  A package to communicate with the software Topcom
##
#############################################################################



##############################################################################################
##
#! @Section Install functions to communicate with Topcom
##
##############################################################################################

#! @Description
#! The argument is a list of integral points in Z^n.
#! @Returns Via topcom all fine triangulations of these points are computed and returned.
#! @Arguments List L
DeclareOperation( "points2allfinetriangs",
                  [ IsList ] );
