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
#! The first argument is a list of integral points in Z^n. The second can be a triangulation
#! for reference. But this can also be left blank by handing over the empty list [] as second
#! argument. The third argument is a list of strings corresponding to options, which topcom 
#! offers for this computation.
#! @Returns Via topcom all fine triangulations of these points (w.r.t. the reference triangulation
#! and the provided options) are computed and returned.
#! @Arguments List L
DeclareOperation( "points2allfinetriangs",
                  [ IsList, IsList, IsList ] );
