#############################################################################
##
##  LITorSubvar.gi     ToricVarieties
##
##                        Sebastian Gutsche
##                        Martin Bies - University of Pennsylvania
##
##  Copyright 2011-2021
##
##  A package to handle toric varieties
##
##  Logical implications for toric subvarieties.
##
#############################################################################

#############################
##
## True methods
##
#############################

##
InstallTrueMethod( IsWholeVariety, IsOpen and IsClosedSubvariety );

##
InstallTrueMethod( IsOpen, IsWholeVariety );

##
InstallTrueMethod( IsClosedSubvariety, IsWholeVariety );
