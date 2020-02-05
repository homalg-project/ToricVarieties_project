#############################################################################
##
##  Tools.gd            SparseMatrices package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to handle sparse matrices in gap
##
#! @Chapter Interface to smasto
##
#############################################################################



##############################################################################################
##
#! @Section Finding the SmastoDirectory
##
##############################################################################################

#! @Description
#! This operation identifies the location of the smasto programs.
#! @Returns the corresponding directory
#! @Arguments none
DeclareOperation( "FindSmastoDirectory", [ ] );

#! @Description
#! This operation sets and stores the location of the smasto programs.
#! In future operations, the method FindSmastoDirectory will use this path.
#! If you wish to alter this path later, call this function again
#! with the new path. If for example Smasto is installed at /home/person/smasto
#! then the input for this function should be "/home/person/smasto".
#! @Returns the corresponding directory
#! @Arguments none
DeclareOperation( "SetSmastoDirectory", [ IsString ] );


##############################################################################################
##
#! @Section Executing Smasto
##
##############################################################################################

#! @Description
#! This operation executes Spasm with four pieces of input information.
#! The first is the directory of Smasto, the second the name of the binary 
#! that is to be executed, the third is the input required by this binary.
#! The fourth argument is a list of options supported by Smasto and the
#! fifth the list of values for these arguments.
#! @Returns the corresponding quantity as computed by Smasto as a string
#! @Arguments A Directory, a string and two lists
DeclareOperation( "ExecuteSmasto",
                  [ IsDirectory, IsString, IsList, IsList, IsList ] );
