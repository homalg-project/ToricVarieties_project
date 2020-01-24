#############################################################################
##
##  Tools.gd            SpasmInterface package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to communicate with the software Spasm
##
#! @Chapter Interface to Spasm
##
#############################################################################



##############################################################################################
##
#! @Section Finding the SpasmDirectory
##
##############################################################################################

#! @Description
#! This operation identifies the location where the Spasm operations are stored.
#! @Returns the corresponding directory
#! @Arguments none
DeclareOperation( "FindSpasmDirectory", [ ] );



##############################################################################################
##
#! @Section Executing Spasm
##
##############################################################################################

#! @Description
#! This operation executes Spasm with four pieces of input information.
#! The first is the directory of Spasm, the second the name of the binary 
#! that is to be executed, the third is the input required by this binary.
#! The fourth argument is a list of options supported by Spasm and the
#! fifth the list of values for these arguments.
#! @Returns the corresponding quantity as computed by Spasm as a string
#! @Arguments A Directory, a string and two lists
DeclareOperation( "ExecuteSpasm",
                  [ IsDirectory, IsString, IsList, IsList, IsList ] );
