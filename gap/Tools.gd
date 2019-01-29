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
#! @Section Turn toric variety and degree into a command string that we can pass to cohomCalg
##
##############################################################################################

#! @Description
#! This operation prepares the command string that is handed over to cohomCalg
#! @Returns string
#! @Arguments a toric variety and an element of the class group (thereby encoding a line bundle)
DeclareOperation( "cohomCalgCommandString", 
                   [ IsToricVariety, IsList ] );

#! @Description
#! This is a convenience method. It call the previous method with the zero element of the class group.
#! @Returns string
#! @Arguments a toric variety
DeclareOperation( "cohomCalgCommandString", 
                   [ IsToricVariety ] );
