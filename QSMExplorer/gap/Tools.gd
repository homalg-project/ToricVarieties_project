###############################################################################################
##
##  Tools.gi            QSMExplorer package
##
##                      Martin Bies
##                      University of Pennsylvania
##
##                      Muyang Liu
##                      University of Pennsylvania
##
##  Copyright 2021
##
##  A package to explore one Quadrillion F-theory Standard Models
##
#! @Chapter Tools for investigation of one Quadrillion F-theory Standard Models
##

##############################################################################################
##
#! @Section Find external files, scripts and binaries
##
##############################################################################################

#! @Description
#! This operation identifies the location of the data base in which we store essential information about Quadrillion F-theory Standard Models.
#! @Returns the corresponding filename
#! @Arguments none
DeclareOperation( "FindDataBase", [ ] );

#! @Description
#! This operation identifies the location of a python script which plots the dual graph of the nodal quark-doublet curve.
#! @Returns the corresponding filename
#! @Arguments none
DeclareOperation( "FindDualGraphScript", [ ] );

#! @Description
#! This operation identifies the location of the C++-program which computes a lower bound to the number of limit roots with minimal number of global sections on a nodal curve.
#! @Returns the directory in which the binary is contained
#! @Arguments none
DeclareOperation( "FindRootCounterDirectory", [ ] );


##############################################################################################
##
#! @Section Read information from database
##
##############################################################################################

#! @Description
#! This function reads out the data of the i-th polytope listed in the QSM database. If the i-th polytope does not exist in the QSM database it returns fail.
#! @Returns List of information
#! @Arguments Integer i
DeclareOperation( "ReadQSM", [ IsInt ] );

#! @Description
#! This function reads out the data of the polytope with number i listed in the QSM database. If this polytope does not exist in the database, this function returns fail.
#! @Returns List of information of false.
#! @Arguments Integer i
DeclareOperation( "ReadQSMByPolytope", [ IsInt ] );


##############################################################################################
##
#! @Section The 708 polytopes and their triangulations
##
##############################################################################################


#! @Description
#! This function returns the polytopes whose FRSTs define the base spaces of the QSM in question.
#! @Returns an integer
#! @Arguments Integer i
DeclareOperation( "PolytopeOfQSM", [ IsInt ] );

#! @Description
#! This function returns the polytopes whose FRSTs define the base spaces of the QSM in question.
#! @Returns an integer
#! @Arguments Integer i
DeclareOperation( "PolytopeOfQSMByPolytope", [ IsInt ] );


#! @Description
#! This function returns the triangulation estimate for a QSM.
#! @Returns an integer
#! @Arguments Integer i
DeclareOperation( "TriangulationEstimateInQSM", [ IsInt ] );

#! @Description
#! This function returns the triangulation estimate for a QSM.
#! @Returns an integer
#! @Arguments Integer i
DeclareOperation( "TriangulationEstimateInQSMByPolytope", [ IsInt ] );


#! @Description
#! This function returns the maximal number of lattice points in the facets of the polytope of a QSM.
#! @Returns an integer
#! @Arguments Integer i
DeclareOperation( "MaxLatticePtsInFacetInQSM", [ IsInt ] );

#! @Description
#! This function returns the maximal number of lattice points in the facets of the polytope of a QSM.
#! @Returns an integer
#! @Arguments Integer i
DeclareOperation( "MaxLatticePtsInFacetInQSMByPolytope", [ IsInt ] );


#! @Description
#! This function returns if the triangulations can be computed in a reasonable time for a QSM.
#! @Returns true or false
#! @Arguments Integer i
DeclareOperation( "TriangulatonQuickForQSM", [ IsInt ] );

#! @Description
#! This function returns if the triangulations can be computed in a reasonable time for a QSM.
#! @Returns true or false
#! @Arguments Integer i
DeclareOperation( "TriangulationQuickForQSMByPolytope", [ IsInt ] );



##############################################################################################
##
#! @Section The toric 3-folds obtained from FRSTs of the 708 polytopes
##
##############################################################################################

#! @Description
#! This function constructs a 3-fold base space for this QSM.
#! @Returns a toric variety
#! @Arguments Integer i
DeclareOperation( "BaseSpaceOfQSM", [ IsInt ] );

#! @Description
#! This function constructs a 3-fold base space for this QSM.
#! @Returns a toric variety
#! @Arguments Integer i
DeclareOperation( "BaseSpaceOfQSMByPolytope", [ IsInt ] );

DeclareOperation( "BaseSpace", [ IsRecord ] );

#! @Description
#! This function returns the triple intersection number Kbar^3 of the base space of this QSM.
#! @Returns an integer
#! @Arguments Integer i
DeclareOperation( "Kbar3OfQSM", [ IsInt ] );

#! @Description
#! This function returns the triple intersection number Kbar^3 of the base space of this QSM.
#! @Returns an integer
#! @Arguments Integer i
DeclareOperation( "Kbar3OfQSMByPolytope", [ IsInt ] );



##############################################################################################
##
#! @Section The components of the nodal quark-doublet curve
##
##############################################################################################

#! @Description
#! This function returns the genera of the non-trivial curves in a QSM.
#! @Returns a list of integers
#! @Arguments Integer i
DeclareOperation( "GeneraOfCurvesInQSM", [ IsInt ] );

#! @Description
#! This function returns the genera of the non-trivial curves in a QSM.
#! @Returns a list of integers
#! @Arguments Integer i
DeclareOperation( "GeneraOfCurvesInQSMByPolytope", [ IsInt ] );


#! @Description
#! This function returns the degree of Kbar on the non-trivial curves in a QSM.
#! @Returns a list of integers
#! @Arguments Integer i
DeclareOperation( "DegreeOfKbarOnCurvesInQSM", [ IsInt ] );

#! @Description
#! This function returns the degree of Kbar on the non-trivial curves in a QSM.
#! @Returns a list of integers
#! @Arguments Integer i
DeclareOperation( "DegreeOfKbarOnCurvesInQSMByPolytope", [ IsInt ] );


#! @Description
#! This function returns the intersection numbers among the non-trivial curves in a QSM.
#! @Returns a list of lists of integers
#! @Arguments Integer i
DeclareOperation( "IntersectionNumbersOfCurvesInQSM", [ IsInt ] );

#! @Description
#! This function returns the intersection numbers among the non-trivial curves in a QSM.
#! @Returns a list of lists of integers
#! @Arguments Integer i
DeclareOperation( "IntersectionNumbersOfCurvesInQSMByPolytope", [ IsInt ] );


#! @Description
#! This function returns the indices of all trivial curves.
#! @Returns a list of lists of integers
#! @Arguments Integer i
DeclareOperation( "IndicesOfTrivialCurvesInQSM", [ IsInt ] );

#! @Description
#! This function returns the indices of all trivial curves.
#! @Returns a list of lists of integers
#! @Arguments Integer i
DeclareOperation( "IndicesOfTrivialCurvesInQSMByPolytope", [ IsInt ] );



##############################################################################################
##
#! @Section The dual graph of the nodal quark-doublet curve
##
##############################################################################################

#! @Description
#! This function returns the list of the names of the (non-trivial) components of the dual graph.
#! @Returns a list of strings
#! @Arguments Integer i
DeclareOperation( "ComponentsOfDualGraphOfQSM", [ IsInt ] );

#! @Description
#! This function returns the list of the genera of the (non-trivial) components of the dual graph.
#! @Returns a list of strings
#! @Arguments Integer i
DeclareOperation( "ComponentsOfDualGraphOfQSMByPolytope", [ IsInt ] );

#! @Description
#! This function returns the list of the names of the (non-trivial) components of the dual graph.
#! @Returns a list of integers
#! @Arguments Integer i
DeclareOperation( "GenusOfComponentsOfDualGraphOfQSM", [ IsInt ] );

#! @Description
#! This function returns the list of the genera of the (non-trivial) components of the dual graph.
#! @Returns a list of integers
#! @Arguments Integer i
DeclareOperation( "GenusOfComponentsOfDualGraphOfQSMByPolytope", [ IsInt ] );

#! @Description
#! This function returns the list of the degrees of the anticanonical bundle on the (non-trivial) components of the dual graph.
#! @Returns a list of integers
#! @Arguments Integer i
DeclareOperation( "DegreeOfKbarOnComponentsOfDualGraphOfQSM", [ IsInt ] );

#! @Description
#! This function returns the list of the degrees of the anticanonical bundle on the (non-trivial) components of the dual graph.
#! @Returns a list of integers
#! @Arguments Integer i
DeclareOperation( "DegreeOfKbarOnComponentsOfDualGraphOfQSMByPolytope", [ IsInt ] );

#! @Description
#! This function returns the intersection numbers among the (non-trivial) components of the dual graph.
#! @Returns a list of lists of integers
#! @Arguments Integer i
DeclareOperation( "IntersectionNumberOfComponentsOfDualGraphOfQSM", [ IsInt ] );

#! @Description
#! This function returns the intersection numbers among the (non-trivial) components of the dual graph.
#! @Returns a list of lists of integers
#! @Arguments Integer i
DeclareOperation( "IntersectionNumberOfComponentsOfDualGraphOfQSMByPolytope", [ IsInt ] );

#! @Description
#! This function prints the dual graph of a QSM.
#! @Returns true or fail
#! @Arguments Integer i
DeclareOperation( "DualGraphOfQSM", [ IsInt ] );

#! @Description
#! This function prints the dual graph of a QSM.
#! @Returns true or fail
#! @Arguments Integer i
DeclareOperation( "DualGraphOfQSMByPolytope", [ IsInt ] );

DeclareOperation( "PlotDualGraph", [ IsRecord ] );


##############################################################################################
##
#! @Section The simplified dual graph of the nodal quark-doublet curve
##
##############################################################################################

#! @Description
#! This function returns the list of the names of the (non-trivial) components of the simplified dual graph.
#! @Returns a list of strings
#! @Arguments Integer i
DeclareOperation( "ComponentsOfSimplifiedDualGraphOfQSM", [ IsInt ] );

#! @Description
#! This function returns the list of the genera of the (non-trivial) components of the simplified dual graph.
#! @Returns a list of strings
#! @Arguments Integer i
DeclareOperation( "ComponentsOfSimplifiedDualGraphOfQSMByPolytope", [ IsInt ] );

#! @Description
#! This function returns the list of the names of the (non-trivial) components of the simplified dual graph.
#! @Returns a list of integers
#! @Arguments Integer i
DeclareOperation( "GenusOfComponentsOfSimplifiedDualGraphOfQSM", [ IsInt ] );

#! @Description
#! This function returns the list of the genera of the (non-trivial) components of the simplified dual graph.
#! @Returns a list of integers
#! @Arguments Integer i
DeclareOperation( "GenusOfComponentsOfSimplifiedDualGraphOfQSMByPolytope", [ IsInt ] );

#! @Description
#! This function returns the list of the degrees of the anticanonical bundle on the (non-trivial) components of the simplified dual graph.
#! @Returns a list of integers
#! @Arguments Integer i
DeclareOperation( "DegreeOfKbarOnComponentsOfSimplifiedDualGraphOfQSM", [ IsInt ] );

#! @Description
#! This function returns the list of the degrees of the anticanonical bundle on the (non-trivial) components of the simplified dual graph.
#! @Returns a list of integers
#! @Arguments Integer i
DeclareOperation( "DegreeOfKbarOnComponentsOfSimplifiedDualGraphOfQSMByPolytope", [ IsInt ] );

#! @Description
#! This function returns the intersection numbers among the (non-trivial) components of the simplified dual graph.
#! @Returns a list of lists of integers
#! @Arguments Integer i
DeclareOperation( "EdgeListOfSimplifiedDualGraphOfQSM", [ IsInt ] );

#! @Description
#! This function returns the intersection numbers among the (non-trivial) components of the simplified dual graph.
#! @Returns a list of lists of integers
#! @Arguments Integer i
DeclareOperation( "EdgeListOfSimplifiedDualGraphOfQSMByPolytope", [ IsInt ] );

#! @Description
#! This function prints the simplified dual graph of a QSM.
#! @Returns true or fail
#! @Arguments Integer i
DeclareOperation( "SimplifiedDualGraphOfQSM", [ IsInt ] );

#! @Description
#! This function prints the simplified dual graph of a QSM.
#! @Returns true or fail
#! @Arguments Integer i
DeclareOperation( "SimplifiedDualGraphOfQSMByPolytope", [ IsInt ] );

DeclareOperation( "PlotSimplifiedDualGraph", [ IsRecord ] );


##############################################################################################
##
#! @Section The toric ambient space of the elliptic 4-fold
##
##############################################################################################

#! @Description
#! This function returns the toric variety PF11, i.e. the fibre ambient space.
#! @Returns a toric variety
#! @Arguments
DeclareOperation( "PF11", [ ] );

#! @Description
#! This function return the ray generators of the toric ambient space 5-fold of a QSM.
#! @Returns a list of lists of integers
#! @Arguments Integer i
DeclareOperation( "ToricAmbientSpaceOfQSM", [ IsInt ] );

#! @Description
#! This function return the ray generators of the toric ambient space 5-fold of a QSM.
#! @Returns a list of lists of integers
#! @Arguments Integer i
DeclareOperation( "ToricAmbientSpaceOfQSMByPolytope", [ IsInt ] );

DeclareOperation( "ConstructX5", [ IsToricVariety ] );


##############################################################################################
##
#! @Section The Picard lattice of the K3
##
##############################################################################################

#! @Description
#! This function returns true if the K3 is elliptic and false otherwise.
#! @Returns true or false
#! @Arguments Integer i
DeclareOperation( "IsK3OfQSMElliptic", [ IsInt ] );

#! @Description
#! This function returns true if the K3 is elliptic and false otherwise.
#! @Returns true or false
#! @Arguments Integer i
DeclareOperation( "IsK3OfQSMByPolytopeElliptic", [ IsInt ] );

#! @Description
#! This function returns the rank of the K3 in a QSM.
#! @Returns an integer
#! @Arguments Integer i
DeclareOperation( "RankOfPicardLatticeOfK3OfQSM", [ IsInt ] );

#! @Description
#! This function returns the rank of the K3 in a QSM.
#! @Returns an integer
#! @Arguments Integer i
DeclareOperation( "RankOfPicardLatticeOfK3OfQSMByPolytope", [ IsInt ] );


##############################################################################################
##
#! @Section Data summary of Quadrillion F-theory Standard Model build from given polytope
##
##############################################################################################

#! @Description
#! This function prints important information about the i-th QSM in our list.
#! @Returns true or fail
#! @Arguments Integer i
DeclareOperation( "FullInformationOfQSM", [ IsInt ] );
DeclareOperation( "FullInformationOfQSM", [ IsInt, IsBool ] );

#! @Description
#! This function prints important information about the QSM constructed from polytope i in our list.
#! @Returns true or fail
#! @Arguments Integer i
DeclareOperation( "FullInformationOfQSMByPolytope", [ IsInt ] );
DeclareOperation( "FullInformationOfQSMByPolytope", [ IsInt, IsBool ] );

DeclareOperation( "DisplayFullInformationOfQSM", [ IsRecord, IsBool ] );


##############################################################################################
##
#! @Section Counting limit roots with minimal number of global sections
##
##############################################################################################

#! @Description
#! This function computes the number of limit roots in the i-th QSM.
#! @Returns integer or fail
#! @Arguments Integer i
DeclareOperation( "CountMinimalLimitRootsOfQSM", [ IsInt ] );
DeclareOperation( "CountMinimalLimitRootsOfQSM", [ IsInt, IsInt ] );

#! @Description
#! This function computes the number of limit roots in the QSM defined by polytope i.
#! @Returns integer or fail
#! @Arguments Integer i
DeclareOperation( "CountMinimalLimitRootsOfQSMByPolytope", [ IsInt ] );
DeclareOperation( "CountMinimalLimitRootsOfQSMByPolytope", [ IsInt, IsInt ] );

DeclareOperation( "CountMinimalLimitRoots", [ IsRecord, IsInt ] );


##############################################################################################
##
#! @Section Counting distribution of limit roots
##
##############################################################################################


#! @Description
#! This function computes the number of limit roots in the i-th QSM with at most L global sections.
#! @Returns integer or fail
#! @Arguments Integer i, integer L
DeclareOperation( "CountLimitRootDistributionOfQSM", [ IsInt, IsInt, IsInt ] );
DeclareOperation( "CountLimitRootDistributionOfQSM", [ IsInt, IsInt, IsInt, IsInt ] );

#! @Description
#! This function computes the number of limit roots in the QSM defined by polytope i  with at most L global sections.
#! @Returns integer or fail
#! @Arguments Integer i, integer L
DeclareOperation( "CountLimitRootDistributionOfQSMByPolytope", [ IsInt, IsInt, IsInt ] );
DeclareOperation( "CountLimitRootDistributionOfQSMByPolytope", [ IsInt, IsInt, IsInt, IsInt ] );

DeclareOperation( "CountLimitRootDistribution", [ IsRecord, IsInt, IsInt, IsInt ] );
