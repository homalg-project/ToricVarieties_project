#############################################################################
##
##  Functions.gd        cohomCalgInterface package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to communicate with the software cohomCalg
##
#! @Chapter Functions supported by cohomCalg
##
#############################################################################



##############################################################################################
##
#! @Section Functions to communicate with cohomCalg
##
##############################################################################################

#! @Description
#! Given a toric variety vari and a list L = [ D_2, ..., D_n ] of degree in the class group,
#! and thereby defining a direct sum of line bundles on vari. The third argument is a non-negative
#! integer i. This function computes the i-th sheaf cohomology by use of cohomCalg and determines
#! if it vanishes. The output is true or false.
#! @Returns True or false
#! @Arguments vari, L, i
DeclareOperation( "VanishingHiByCohomCalg",
                  [ IsToricVariety, IsList, IsInt ] );

#! @Description
#! Given a toric variety vari and a list L = [ D_2, ..., D_n ] of degree in the class group,
#! and thereby defining a direct sum of line bundles on vari, this function computes all
#! of the sheaf cohomology dimensions of this vector bundle by use of cohomCalg. 
#! The output is a list of integers, each representing the corresponding sheaf cohomology dimension.
#! @Returns List
#! @Arguments vari, L
DeclareOperation( "AllHiByCohomCalg",
                  [ IsToricVariety, IsList ] );

#! @Description
#! Given a toric variety vari and a list L = [ D_2, ..., D_n ] of degree in the class group,
#! and thereby defining a direct sum of line bundles on vari. The third argument is a non-negative
#! integer i. This function computes the i-th sheaf cohomology by use of cohomCalg.
#! @Returns Integer
#! @Arguments vari, L, i
DeclareOperation( "HiByCohomCalg",
                  [ IsToricVariety, IsInt, IsList ] );

#! @Description
#! Given a toric variety vari, cohomCalg identifies line bundle cohomology as rationoms, i.e.
#! fractions of monomials. This routine identifies all denominators of such rations,
#! that appear as cohomologies of line bundles on the given toric variety.
#! @Returns List
#! @Arguments vari
DeclareOperation( "ContributingDenominators",
                   [ IsToricVariety ] );

