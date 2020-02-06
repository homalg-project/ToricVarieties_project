#############################################################################
##
##  Tools2.gd            LinBoxInterface package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to communicate with the software LinBox
##
#! @Chapter Interface to Linbox
##
#############################################################################



##############################################################################################
##
#! @Section Finding the LinboxDirectory
##
##############################################################################################

#! @Description
#! This operation identifies the location of the spasm programs.
#! @Returns the corresponding directory
#! @Arguments none
DeclareOperation( "FindLinboxDirectory", [ ] );


##############################################################################################
##
#! @Section Executing LinBox
##
##############################################################################################

#! @Description
#! This operation executes LinBox with four pieces of input information.
#! The first is the directory of LinBox, the second the name of the binary 
#! that is to be executed, the third is the input required by this binary.
#! The fourth argument is a list of options supported by LinBox and the
#! fifth the list of values for these arguments.
#! @Returns the corresponding quantity as computed by LinBox as a string
#! @Arguments A Directory, a string and two lists
DeclareOperation( "ExecuteLinbox",
                  [ IsDirectory, IsString, IsList ] );
