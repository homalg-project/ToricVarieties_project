#############################################################################
##
##  Tools.gd                 TopcomInterface package
##                                Martin Bies
##
##  Copyright 2021      University of Pennsylvania
##
##  A package to communicate with the software Topcom
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
#! This operation identifies the location where the topcom operations are stored.
#! @Returns the corresponding directory
#! @Arguments none
DeclareOperation( "FindTopcomDirectory", [ ] );



##############################################################################################
##
#! @Section Executing topcom
##
##############################################################################################

#! @Description
#! This operation executes topcom with five pieces of input information.
#! The first is the directory of topcom, the second the name of the binary 
#! that is to be executed within topcom, the third is a list of points,
#! the fourth a list containing a seed triangulation (this is optional) and
#! the fifth a number of options (also optional). In case no seed 
#! triangulation or option is to be used, the empty list should be handed to
#! the gap method.
#! @Returns the corresponding quantity as computed by Topcom as a string
#! @Arguments A Directory, a string and three lists
DeclareOperation( "ExecuteTopcomForPoints",
                  [ IsDirectory, IsString, IsList, IsList, IsList ] );

#! @Description
#! This operation executes topcom with five pieces of input information.
#! The first is the directory of topcom, the second the name of the binary 
#! that is to be executed within topcom, the third is a string encoding a chiro,
#! the fourth a list containing a seed triangulation (this is optional) and
#! the fifth a number of options (also optional). In case no seed 
#! triangulation or option is to be used, the empty list should be handed to
#! the gap method.
#! @Returns the corresponding quantity as computed by Topcom as a string
#! @Arguments A Directory, a string, a string and two lists
DeclareOperation( "ExecuteTopcomForChiro",
                  [ IsDirectory, IsString, IsString, IsList, IsList ] );
