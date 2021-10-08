#! @Chapter Tools for investigation of the Higgs curve in one Quadrillion F-theory Standard Models

#! @Section Examples

LoadPackage( "QSMExplorer" );

#! We can compute the root distribution also on the Higgs curve. These computations typically require an extended amount of computational power. It would proceed as follows:

#! @Log
LimitRootDistributionForHiggsCurveInQSM( 1, 4 );
#! @EndLog

#! Alternatively, we can also decide to not display intermediate output from the C++ runs:

#! @Log
LimitRootDistributionForHiggsCurveInQSM( 1, 4, false );
#! @EndLog
