###############################################################################################
##
##  Speciality.gd            QSMExplorer package
##
##                                  Martin Bies
##                                  University of Pennsylvania
##
##                                  Muyang Liu
##                                  University of Pennsylvania
##
##  Copyright 2021
##
##  A package to explore one Quadrillion F-theory Standard Models
##
#! @Chapter Check speciality of line bundles
##

##############################################################################################
##
#! @Section Determine if line bundle on nodal curve is special.
##
##############################################################################################

#! @Description
#! This operation constructs a simple nodal curve $C$ from a list of edges $E$ and a line bundle $L$ from its list of degrees $D$ on it. Provided that $C$ is tree-like, this method determines if $(C,L)$ is special. This algorithm has been formulated and proven by Prof. Dr. Ron Donagi (University of Pennsylvania). The current implementation performs no checks to tell if $C$ is indeed tree-like. It is the responsibility of the user to ensure that this is the case. An optional 3rd argument can be provided to supress intermediate output.
#! @Returns a bool
#! @Arguments D, L
DeclareOperation( "Speciality", [ IsList, IsList ] );
DeclareOperation( "Speciality", [ IsList, IsList, IsBool ] );
