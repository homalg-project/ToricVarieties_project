#############################################################################
##
##  Tools.gd            cohomCalgInterface package
##                      Martin Bies
##
##  Copyright 2019      ULB Brussels
##
##  A package to communicate with the software cohomCalg
##
#! @Chapter Interface to Topcom
##
#############################################################################



##############################################################################################
##
#! @Section Finding the TopcomDirectory
##
##############################################################################################

#! @Description
#! This operation identifies the cohomCalg directory D and binary B
#! @Returns list L = [ D, B ]
#! @Arguments none
DeclareOperation( "cohomCalgBinary", [ ] );



##############################################################################################
##
#! @Section Executing topcom
##
##############################################################################################

#! @Description
#! This operation executes topcom with three pieces of input information.
#! @Returns the corresponding quantity as computed by Topcom as a string
#! @Arguments TopcomBinary (as Filename) and three lists
DeclareOperation( "ExecuteTopcom",
                  [ IsDirectory, IsString, IsList, IsList, IsList ] );
