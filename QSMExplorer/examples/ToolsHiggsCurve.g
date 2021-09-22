#! @Chapter Tools for investigation of the Higgs curve in one Quadrillion F-theory Standard Models

#! @Section Examples

LoadPackage( "QSMExplorer" );

#! We can compute the root distribution for all possible weight assignments on the external legs of a quark-doublet curve with the following command.

#! @Example
n := LimitRootDistributionForAllExternalWeightsInQSM( 1, 0, 4 );;
n;
#! [ 0,0,0,0,0 ]
#! @EndExample
