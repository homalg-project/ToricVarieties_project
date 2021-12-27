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
#! @Chapter Tools for investigation of the Higgs and RDQ curve in one Quadrillion F-theory Standard Models
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
DeclareOperation( "LimitRootDistributionForHiggsCurveInQSM", [ IsInt, IsInt, IsBool ] );

#! @Description
#! This operation performs the divide step for the computation of limit root distribution on the Higgs curve in the i-th QSM.
#! @Returns a list
#! @Arguments 
DeclareOperation( "LimitRootDistributionForHiggsCurveInQSMDivideStep", [ IsInt, IsInt ] );
DeclareOperation( "LimitRootDistributionForHiggsCurveInQSMDivideStep", [ IsInt, IsInt, IsBool ] );

#! @Description
#! This operation performs the conquer step for the computation of limit root distribution on the Higgs curve in the i-th QSM.
#! @Returns a list
#! @Arguments 
DeclareOperation( "LimitRootDistributionForHiggsCurveInQSMConquerStep", [ IsInt, IsInt ] );
DeclareOperation( "LimitRootDistributionForHiggsCurveInQSMConquerStep", [ IsInt, IsInt, IsBool ] );

#! @Description
#! This operation returns a list corresponding to the limit root distribution on the Higgs curve in the QSM of the i-th polytope.
#! @Returns a list
#! @Arguments 
DeclareOperation( "LimitRootDistributionForHiggsCurveInQSMByPolytope", [ IsInt, IsInt ] );
DeclareOperation( "LimitRootDistributionForHiggsCurveInQSMByPolytope", [ IsInt, IsInt, IsBool ] );

#! @Description
#! This operation performs the divide step for the computation of limit root distribution on the Higgs curve in the QSM of the i-th polytope.
#! @Returns a list
#! @Arguments 
DeclareOperation( "LimitRootDistributionForHiggsCurveInQSMByPolytopeDivideStep", [ IsInt, IsInt ] );
DeclareOperation( "LimitRootDistributionForHiggsCurveInQSMByPolytopeDivideStep", [ IsInt, IsInt, IsBool ] );

#! @Description
#! This operation performs the conquer step for the computation of limit root distribution on the Higgs curve in the QSM of the i-th polytope.
#! @Returns a list
#! @Arguments 
DeclareOperation( "LimitRootDistributionForHiggsCurveInQSMByPolytopeConquerStep", [ IsInt, IsInt ] );
DeclareOperation( "LimitRootDistributionForHiggsCurveInQSMByPolytopeConquerStep", [ IsInt, IsInt, IsBool ] );

#! @Description
#! This operation returns a list corresponding to the limit root distribution on the Higgs curve in the i-th QSM.
#! @Returns a list
#! @Arguments 
DeclareOperation( "LimitRootDistributionForRDQCurveInQSM", [ IsInt, IsInt ] );
DeclareOperation( "LimitRootDistributionForRDQCurveInQSM", [ IsInt, IsInt, IsBool ] );

#! @Description
#! This operation returns a list corresponding to the limit root distribution on the Higgs curve in the QSM of the i-th polytope.
#! @Returns a list
#! @Arguments 
DeclareOperation( "LimitRootDistributionForRDQCurveInQSMByPolytope", [ IsInt, IsInt ] );
DeclareOperation( "LimitRootDistributionForRDQCurveInQSMByPolytope", [ IsInt, IsInt, IsBool ] );

DeclareOperation( "LimitRootDistributionHiggs", [ IsRecord, IsInt, IsBool ] );
DeclareOperation( "LimitRootDistributionHiggsDivide", [ IsRecord, IsInt, IsBool ] );
DeclareOperation( "LimitRootDistributionHiggsConquer", [ IsRecord, IsInt, IsBool ] );

DeclareOperation( "LimitRootDistributionAlongHiggsPhilosophy", [ IsList, IsBool ] );
DeclareOperation( "LimitRootDistributionAlongHiggsPhilosophyDivide", [ IsList, IsBool ] );
DeclareOperation( "LimitRootDistributionAlongHiggsPhilosophyConquer", [ IsList, IsBool ] );



##############################################################################################
##
#! @Section Save all outfluxes
##
##############################################################################################

#! @Description
#! This operation saves all outfluxes in a file.
#! @Returns true on success and errors otherwise.
#! @Arguments
DeclareOperation( "AllOutfluxesForHiggsCurveInQSMToFile", [ IsInt ] );

#! @Description
#! This operation saves all outfluxes in a file.
#! @Returns true on success and errors otherwise.
#! @Arguments
DeclareOperation( "AllOutfluxesForHiggsCurveInQSMByPolytopeToFile", [ IsInt ] );
DeclareOperation( "WriteOutfuxes", [ IsRecord ] );
