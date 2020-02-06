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
#! This operation identifies the location of the spasm programs.
#! @Returns the corresponding directory
#! @Arguments none
DeclareOperation( "FindSpasmDirectory", [ ] );

#! @Description
#! This operation sets and stores the location of the spasm programs.
#! In future operations, the method FindSpasmDirectory will use this path.
#! If you wish to alter this path later, call this function again
#! with the new path. If for example Spasm is installed at /home/person/spasm
#! then the input for this function should be "/home/person/spasm/bench".
#! @Returns the corresponding directory
#! @Arguments none
DeclareOperation( "SetSpasmDirectory", [ IsString ] );


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
