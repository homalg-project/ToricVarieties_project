################################################################################################
##
##  LocalizedDegree0Ring.gd            TruncationsOfFPGradedModules
##
##  Copyright 2020                     Martin Bies,       University of Oxford
##
#!  @Chapter Localized degree-0 rings
##
################################################################################################


#######################################################################################
##
#! @Section Localized degree-0-layer of graded rings
##
#######################################################################################

#! @Description
#! This method computes the generators of vanishing degree of
#! of a graded ring R localized at a list L of variables.
#! @Returns a list
#! @Arguments R, L
DeclareOperation( "Localized_degree_zero_monomials",
                  [ IsHomalgGradedRing, IsList ] );

#! @Description
#! This method accepts a homalg graded ring R and a list L of variables
#! on which this ring is to be localized. We then compute the 
#! degree-0-layer of this localization and express it as a
#! quotient ring. This method then returns this quotient ring.
#! @Returns a ring
#! @Arguments R, L
DeclareOperation( "Localized_degree_zero_ring",
                  [ IsHomalgGradedRing, IsList ] );

#! @Description
#! This method accepts a homalg graded ring R and a list L of variables
#! on which this ring is to be localized. We then compute the generators
#! of the degree-0-layer of this localization and the corresponding
#! quotient ring. Finally, we return the list formed from the generators
#! and this quotient ring.
#! @Returns a list
#! @Arguments R, L
DeclareOperation( "Localized_degree_zero_ring_and_generators",
                  [ IsHomalgGradedRing, IsList ] );
