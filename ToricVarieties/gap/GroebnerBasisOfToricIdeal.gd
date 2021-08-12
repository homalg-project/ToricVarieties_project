#############################################################################
##
##  GroebnerBasisOfToricIdeal.gd     ToricVarieties
##
##                        Sebastian Gutsche
##                        Martin Bies - University of Pennsylvania
##
##  Copyright 2011-2021
##
##  A package to handle toric varieties
##
##  Groebner Basis computations of toric ideals.
##
#############################################################################

# DeclareOperationWithDocumentation( "GeneratingSetOfToricIdealGivenByHilbertBasis",
#                                    [ IsMatrix ],
#                                    [ "Computes the generating set of a toric ideal given by the",
#                                      "Hilbert basis of a cone" ],
#                                      "a Matrix",
#                                      "a",
#                                    [ "Groebner_Basis", "Groebner_Basis_of_a_toric_ideal" ] );

DeclareOperation( "GeneratingSetOfToricIdealGivenByHilbertBasis",
                  [ IsList ] );

DeclareGlobalFunction( "cmp_forGeneratingSetOfToricIdealGivenByHilbertBasis" );

DeclareGlobalFunction( "normalize_forGeneratingSetOfToricIdealGivenByHilbertBasis" );

DeclareGlobalFunction( "prepareIdeal_forGeneratingSetOfToricIdealGivenByHilbertBasis" );

DeclareGlobalFunction( "divides_forGeneratingSetOfToricIdealGivenByHilbertBasis" );

DeclareGlobalFunction( "findDivisor_forGeneratingSetOfToricIdealGivenByHilbertBasis" );

DeclareGlobalFunction( "reduce_forGeneratingSetOfToricIdealGivenByHilbertBasis" );
