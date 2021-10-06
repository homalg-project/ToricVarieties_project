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
#! @Section Find root distribution on Higgs curve
##
##############################################################################################

#! @Description
#! This operation returns a list corresponding to the limit root distribution on the Higgs curve in the i-th QSM.
#! @Returns a list
#! @Arguments 
DeclareOperation( "LimitRootDistributionForHiggsCurveInQSM", [ IsInt, IsInt ] );
DeclareOperation( "LimitRootDistributionForHiggsCurveInQSM", [ IsInt, IsInt, IsInt ] );

#! @Description
#! This operation returns a list corresponding to the limit root distribution on the Higgs curve in the QSM of the i-th polytope.
#! @Returns a list
#! @Arguments 
DeclareOperation( "LimitRootDistributionForHiggsCurveInQSMByPolytope", [ IsInt, IsInt ] );
DeclareOperation( "LimitRootDistributionForHiggsCurveInQSMByPolytope", [ IsInt, IsInt, IsInt ] );

DeclareOperation( "LimitRootDistributionHiggs", [ IsRecord, IsInt, IsInt, IsBool ] );