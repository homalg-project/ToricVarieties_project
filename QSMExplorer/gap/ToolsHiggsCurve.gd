###############################################################################################
##
##  ToolsHiggsCurve.gi              QSMExplorer package
##
##                                              Martin Bies
##                                              University of Pennsylvania
##
##                                              Muyang Liu
##                                              University of Pennsylvania
##
##  Copyright 2021
##
##  A package to explore one Quadrillion F-theory Standard Models
##
#! @Chapter Tools for investigation of the Higgs curve in one Quadrillion F-theory Standard Models
##

##############################################################################################
##
#! @Section Find root distribution for all external weights on quark-doublet curve
##
##############################################################################################

#! @Description
#! This operation return a record. For each weight assignment on the external legs on the quark-doublet curve of the i-th QSM, this record contains the root distribution.
#! @Returns a record
#! @Arguments 
DeclareOperation( "LimitRootDistributionForAllExternalWeightsInQSM", [ IsInt, IsInt, IsInt ] );
DeclareOperation( "LimitRootDistributionForAllExternalWeightsInQSM", [ IsInt, IsInt, IsInt, IsInt ] );

#! @Description
#! This operation return a record. For each weight assignment on the external legs on the quark-doublet curve of the QSM of the i-th polytope, this record contains the root distribution.
#! @Returns a record
#! @Arguments 
DeclareOperation( "LimitRootDistributionForAllExternalWeightsInQSMByPolytope", [ IsInt, IsInt, IsInt ] );
DeclareOperation( "LimitRootDistributionForAllExternalWeightsInQSMByPolytope", [ IsInt, IsInt, IsInt, IsInt ] );

DeclareOperation( "LimitRootDistributionWithExternalLegs", [ IsRecord, IsInt, IsInt, IsInt ] );


##############################################################################################
##
#! @Section Find root distribution for all influxes on quark-doublet curve
##
##############################################################################################

#! @Description
#! This operation return a list of lists. For each influx on each component fo the quark-doublet curve, this list contains the distribution of limit root line distribution.
#! @Returns a list of lists of integers
#! @Arguments 
DeclareOperation( "LimitRootDistributionForAllExternalInfluxesInQSM", [ IsInt, IsInt, IsInt ] );
DeclareOperation( "LimitRootDistributionForAllExternalInfluxesInQSM", [ IsInt, IsInt, IsInt, IsInt ] );

#! @Description
#! This operation return a list of lists. For each influx on each component fo the quark-doublet curve, this list contains the distribution of limit root line distribution.
#! @Returns a list of lists of integers
#! @Arguments 
DeclareOperation( "LimitRootDistributionForAllExternalInfluxesInQSMByPolytope", [ IsInt, IsInt, IsInt ] );
DeclareOperation( "LimitRootDistributionForAllExternalInfluxesInQSMByPolytope", [ IsInt, IsInt, IsInt, IsInt ] );

DeclareOperation( "LimitRootDistributionForAllInfluxes", [ IsRecord, IsInt, IsInt, IsInt ] );
