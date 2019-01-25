#############################################################################
##
##  Tools.gd            TopcomInterface package
##                      Martin Bies
##
##  Copyright 2019      ULB Brussels
##
##  A package to communicate with the software Topcom
##
#############################################################################



##############################################################################################
##
#! @Section Find the TopcomDirectory
##
##############################################################################################

#! @Description
#! This operation identifies the location of the software topcom. The name of the latter has 
#! to be provided as string
#! @Returns the corresponding directory
#! @Arguments Name of the binary as string
DeclareOperation( "FindTopcomDirectory",
                  [ IsString ] );
