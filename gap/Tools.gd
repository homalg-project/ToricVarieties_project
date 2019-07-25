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
#! @Section Finding the cohomCalg binary
##
##############################################################################################

#! @Description
#! This operation identifies the cohomCalg directory D and binary B
#! @Returns list [ D, B ]
#! @Arguments none
DeclareOperation( "cohomCalgBinary", [ ] );



##############################################################################################
##
#! @Section Turn toric variety and degree into a command string that we can pass to cohomCalg
##
##############################################################################################

#! @Description
#! Given a toric variety vari and an element d of the class group, this 
#! operation prepares the command string that is handed over to cohomCalg
#! @Returns string
#! @Arguments vari, d
DeclareOperation( "cohomCalgCommandString", 
                   [ IsToricVariety, IsList ] );

#! @Description
#! This is a convenience method. Given a toric variety vari, it calls
#! the previous method with the zero element of the class group.
#! @Returns string
#! @Arguments vari
DeclareOperation( "cohomCalgCommandString", 
                   [ IsToricVariety ] );
