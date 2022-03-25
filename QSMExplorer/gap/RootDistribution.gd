###############################################################################################
##
##  RootDistribution.gd            QSMExplorer package
##
##                      Martin Bies
##                      University of Pennsylvania
##
##  Copyright 2022
##
##  A package to explore one Quadrillion F-theory Standard Models
##
#! @Chapter Tools for computing root bundle distributions in the Quadrillion F-theory Standard Models
##

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
DeclareOperation( "CountMinimalLimitRootsOfQSM", [ IsInt, IsBool ] );

#! @Description
#! This function computes the number of limit roots in the QSM defined by polytope i.
#! @Returns integer or fail
#! @Arguments Integer i
DeclareOperation( "CountMinimalLimitRootsOfQSMByPolytope", [ IsInt ] );
DeclareOperation( "CountMinimalLimitRootsOfQSMByPolytope", [ IsInt, IsBool ] );


##############################################################################################
##
#! @Section Counting distribution of full-blowup limit roots
##
##############################################################################################

#! @Description
#! This function computes the number of limit roots in the i-th QSM with at at least min and at most max global sections.
#! @Returns integer or fail
#! @Arguments Integer i, integer min, integer max
DeclareOperation( "CountMinimalLimitRootDistributionOfQSM", [ IsInt, IsInt, IsInt ] );
DeclareOperation( "CountMinimalLimitRootDistributionOfQSM", [ IsInt, IsInt, IsInt, IsBool ] );

#! @Description
#! This function computes the number of limit roots in the QSM defined by polytope i with at least min and at most max global sections.
#! @Returns integer or fail
#! @Arguments Integer i, integer min, integer max
DeclareOperation( "CountMinimalLimitRootDistributionOfQSMByPolytope", [ IsInt, IsInt, IsInt ] );
DeclareOperation( "CountMinimalLimitRootDistributionOfQSMByPolytope", [ IsInt, IsInt, IsInt, IsBool ] );


##############################################################################################
##
#! @Section Counting distribution of all (even partial blowup) limit roots
##
##############################################################################################

#! @Description
#! This function computes the number of (partial blowup) limit roots in the i-th QSM with at least min and at most max global sections.
#! @Returns integer or fail
#! @Arguments Integer i, integer min, integer max
DeclareOperation( "CountPartialBlowupLimitRootDistributionOfQSM", [ IsInt, IsInt, IsInt ] );
DeclareOperation( "CountPartialBlowupLimitRootDistributionOfQSM", [ IsInt, IsInt, IsInt, IsBool ] );

#! @Description
#! This function computes the number of (partial blowup) limit roots in the QSM defined by polytope i with at least min and at most max global sections.
#! @Returns integer or fail
#! @Arguments Integer i, integer min, integer max
DeclareOperation( "CountPartialBlowupLimitRootDistributionOfQSMByPolytope", [ IsInt, IsInt, IsInt ] );
DeclareOperation( "CountPartialBlowupLimitRootDistributionOfQSMByPolytope", [ IsInt, IsInt, IsInt, IsBool ] );

DeclareOperation( "CountPartialBlowupLimitRootDistribution", [ IsRecord, IsInt, IsInt, IsInt, IsInt, IsBool ] );


##############################################################################################
##
#! @Section Counting distribution of limit roots with external legs
##
##############################################################################################

#! @Description
#! This function computes the number of limit roots in the i-th QSM with at most L global sections for an assignment of weights w on the external legs.
#! @Returns integer or fail
#! @Arguments Integer i, integer L, list w
DeclareOperation( "CountLimitRootDistributionWithExternalLegsOfQSM", [ IsInt, IsInt, IsInt, IsList ] );
DeclareOperation( "CountLimitRootDistributionWithExternalLegsOfQSM", [ IsInt, IsInt, IsInt, IsList, IsBool ] );

#! @Description
#! This function computes the number of limit roots in the QSM defined by polytope i  with at most L global sections  for an assignment of weights w on the external legs.
#! @Returns integer or fail
#! @Arguments Integer i, integer L, list w
DeclareOperation( "CountLimitRootDistributionWithExternalLegsOfQSMByPolytope", [ IsInt, IsInt, IsInt, IsList ] );
DeclareOperation( "CountLimitRootDistributionWithExternalLegsOfQSMByPolytope", [ IsInt, IsInt, IsInt, IsList, IsBool ] );

DeclareOperation( "CountLimitRootDistributionWithExternalLegs", [ IsRecord, IsInt, IsInt, IsList, IsBool ] );
