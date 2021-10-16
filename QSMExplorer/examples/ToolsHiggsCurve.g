#! @Chapter Tools for investigation of the Higgs and RDQ curve in one Quadrillion F-theory Standard Models

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

#! Similarly, we can compute the limit root distribution for the RDQ-curve, which is by construction identical to the distribution on the Higgs curve.

#! @Log
LimitRootDistributionForRDQCurveInQSM( 1, 4 );;
LimitRootDistributionForRDQCurveInQSM( 1, 4, false );
#! @EndLog

#! The limit root distributions on the Higgs curve are typically very computationally intensive. However, we can also employ this philosophy for simpler setups. Here are two examples along these lines:

#! @Example
genera := [ 0,0 ];;
degrees_H1 := [ 4, 4 ];;
degrees_H2 := [ 0, 0 ];;
edges := [ [ 0, 1 ], [ 0, 1 ] ];;
total_genus := 1;;
root := 2;;
external_legs := [ 2, 2 ];;
number_processes := 2;;
h0Max := 10;;
data := [ genera, degrees_H1, degrees_H2, edges, total_genus, root, external_legs, number_processes, h0Max ];;
n1 := LimitRootDistributionAlongHiggsPhilosophy( data, false );;
n1;
#! [ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 ]
genera := [ 0, 0, 0, 0, 0 ];;
degrees_H1 := [ 4, 4, 4, 4, 4 ];;
degrees_H2 := [ 0, 0, 0, 0, 0 ];;
edges := [ [ 0, 1 ], [ 0, 1 ], [ 1, 2 ], [ 1, 2 ], [ 1, 3 ], [ 1, 3 ], [ 0, 3 ], [ 0, 3 ], [ 3, 4 ], [ 3, 4 ] ];;
total_genus := 6;;
root := 4;;
external_legs := [ 4, 2, 2, 2, 4 ];;
number_processes := 2;;
h0Max := 10;;
data := [ genera, degrees_H1, degrees_H2, edges, total_genus, root, external_legs, number_processes, h0Max ];;
n2 := LimitRootDistributionAlongHiggsPhilosophy( data, false );;
n2;
#! [ 8374246311441809, 852982581711208, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
#! @EndExample
