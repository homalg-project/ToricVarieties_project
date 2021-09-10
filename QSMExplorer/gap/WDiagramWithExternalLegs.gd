###############################################################################################
##
##  WDiagramWithExternalLegs.gd           QSMExplorer package
##
##                                                              Martin Bies
##                                                              University of Pennsylvania
##
##                                                              Muyang Liu
##                                                              University of Pennsylvania
##
##  Copyright 2021
##
##  A package to explore one Quadrillion F-theory Standard Models
##
#! @Chapter Computation of minimal roots and their distribution for arbitrary nodal curves with external legs.
##

##############################################################################################
##
#! @Section Computation of root distributions on nodal curves with external legs.
##
##############################################################################################

#! @Description
#! This operation constructs a simple nodal curve with external legs and then computes a simple distribution of limit roots on it.
#! @Returns A list
#! @Arguments none
DeclareOperation( "CountSimpleDistributionWithExternalLegs", [ ] );

#! @Description
#! This operation constructs a nodal curve based on the user input, which consists of a list of the genera, the list of the line bundle degrees, a list of the edges, the total genus, the radicant (i.e. telling us which roots to consider - 2 for 2nd roots, 3 for 3rd roots etc.) and an integer $$L$$, telling us to focus on limit roots with number of global sections not larger than $$L$$. In addition, we provide a list which specifies the external legs and a second list which provides the weights on these external legs. We collect all of this data in a single list. Then this function cmputes the distribution of these roots on this nodal curve with external legs.
#! @Returns A list
#! @Arguments none
DeclareOperation( "CountDistributionWithExternalLegs", [ IsList ] );
