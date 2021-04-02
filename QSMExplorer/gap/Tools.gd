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
##  A package to explor one Quadrillion F-theory Standard Models
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
#! @Section Display information about a QSM
##
##############################################################################################

#! @Description
#! This function prints important information about the i-th QSM (if it exists).
#! @Returns true or fail
#! @Arguments Integer i
DeclareOperation( "DisplayQSM", [ IsInt ] );

#! @Description
#! This function prints important information about the QSM defined by the i-th polytope in the Kreuzer-Skarke list (if it exists and gives rise to a QSM).
#! @Returns true or fail
#! @Arguments Integer i
DeclareOperation( "DisplayQSMByPolytope", [ IsInt ] );

DeclareOperation( "PrintQSM", [ IsRecord ] );


##############################################################################################
##
#! @Section Plot dual graph
##
##############################################################################################

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

DeclareOperation( "PrintDualGraph", [ IsRecord ] );


##############################################################################################
##
#! @Section Count limit roots
##
##############################################################################################

#! @Description
#! This function computes the number of limit roots in the i-th QSM.
#! @Returns integer or fail
#! @Arguments Integer i
DeclareOperation( "CountLimitRootsOfQSM", [ IsInt ] );
DeclareOperation( "CountLimitRootsOfQSM", [ IsInt, IsInt ] );

#! @Description
#! This function computes the number of limit roots in the QSM defined by polytope i.
#! @Returns integer or fail
#! @Arguments Integer i
DeclareOperation( "CountLimitRootsOfQSMByPolytope", [ IsInt ] );
DeclareOperation( "CountLimitRootsOfQSMByPolytope", [ IsInt, IsInt ] );

DeclareOperation( "CountLimitRoots", [ IsRecord, IsInt ] );
