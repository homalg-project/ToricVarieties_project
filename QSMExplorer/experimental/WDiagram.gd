###############################################################################################
##
##  WDiagrams.gd           QSMExplorer package
##
##                                    Martin Bies
##                                    University of Pennsylvania
##
##                                    Muyang Liu
##                                    University of Pennsylvania
##
##  Copyright 2021
##
##  A package to explore one Quadrillion F-theory Standard Models
##
#! @Chapter Computation of minimal roots and their distribution for arbitrary nodal curves.
##

##############################################################################################
##
#! @Section Computation of minimal roots
##
##############################################################################################

#! @Description
#! This operation constructs a nodal curve based on the user input, which consists of a list of the genera, a list of the line bundle degrees, the list of the edges, the total genus and the radicant (i.e. telling us which roots to consider - 2 for 2nd roots, 3 for 3rd roots etc.).
#! @Returns A list
#! @Arguments none
DeclareOperation( "CountMinimals", [ IsList, IsList, IsList, IsInt, IsInt ] );
DeclareOperation( "CountMinimals", [ IsList, IsList, IsList, IsInt, IsInt, IsBool ] );

##############################################################################################
##
#! @Section Computation of distributions
##
##############################################################################################

#! @Description
#! This operation constructs a nodal curve based on the user input, which consists of a list of the genera, the list of the line bundle degrees, a list of the edges, the total genus, the radicant (i.e. telling us which roots to consider - 2 for 2nd roots, 3 for 3rd roots etc.) and finally an integer $L$, telling us to focus on limit roots with number of global sections not larger than $L$.
#! @Returns A list
#! @Arguments none
DeclareOperation( "CountDistribution", [ IsList ] );
DeclareOperation( "CountDistribution", [ IsList, IsBool ] );
