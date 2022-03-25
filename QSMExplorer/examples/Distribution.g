#! @Chapter Tools for computing root bundle distributions in the Quadrillion F-theory Standard Models

#! @Section Examples

LoadPackage( "QSMExplorer" );

#! Given the index i of polytope in the Kreuzer and Skarke list, DisplayQSMByPolytope( i ) shows important information of the QSMs built from this polytope. We mention that
#! in particular Sage starts its iterations at 0. Thus, for example the 8-th polytope is in Sage obtained by asking for the polytope with index 7.
#! We can compute the limit counting of selected polytope by issuing CountLimitRootsOfQSMByPolytope( i ) that corresponds to the i-th polytope in the Kreuzer and Skarke list. 
#! Let us compute the number of minimal roots for the 8th polytope in the Kreuzer and Skarke list and the first polytope in our list. We pass as 2nd argument "false" to not display intermediate results of the C++ run.

#! @Example
n := CountMinimalLimitRootsOfQSMByPolytope( 8, false );;
n;
#! [ 0, 0, 0, 142560 ]
n := CountMinimalLimitRootsOfQSM( 1, false );;
n;
#! [ 0, 0, 0, 11110 ]
#! @EndExample

#! We can also wonder how many limit roots exist with number of global sections at most L. For example, this is achieved by the following:
#! @Example
n1 := CountMinimalLimitRootDistributionOfQSMByPolytope( 8, 3, 4, false );;
n1;
#! [ 0, 0, 0, 142560, 0 ]
n2 := CountMinimalLimitRootDistributionOfQSM( 10, 3, 6, false );;
n2;
#! [ 0, 0, 0, 781680888, 25196800, 106800, 0 ]
#! @EndExample

#! We verify that the results computed in our PRD letter for the spaces with Kbar^3 = 6 are still reproduced by this software:
#! @Example
CountMinimalLimitRootsOfQSMByPolytope( 8, false );
#! [ 0, 0, 0, 142560 ]
CountMinimalLimitRootsOfQSMByPolytope( 4, false );
#! [ 0, 0, 0, 11110 ]
CountMinimalLimitRootsOfQSMByPolytope( 134, false );
#! [ 0, 0, 0, 10010 ]
CountMinimalLimitRootsOfQSMByPolytope( 128, false );
#! [ 0, 0, 0, 8910 ]
CountMinimalLimitRootsOfQSMByPolytope( 130, false );
#! [ 0, 0, 0, 8910 ]
CountMinimalLimitRootsOfQSMByPolytope( 136, false );
#! [ 0, 0, 0, 8910 ]
CountMinimalLimitRootsOfQSMByPolytope( 236, false );
#! [ 0, 0, 0, 8910 ]
#! @EndExample

#! Finally, we also verify that the results computed in our PRD letter for some spaces with Kbar^3 = 10 are still reproduced by this software:
#! @Log
CountMinimalLimitRootsOfQSMByPolytope( 88, false );
#! [ 0, 0, 0, 781680888 ]
CountMinimalLimitRootsOfQSMByPolytope( 110, false );
#! [ 0, 0, 0, 738662983 ]
CountMinimalLimitRootsOfQSMByPolytope( 272, false );
#! [ 0, 0, 0, 736011640 ]
CountMinimalLimitRootsOfQSMByPolytope( 274, false );
#! [ 0, 0, 0, 736011640 ]
CountMinimalLimitRootsOfQSMByPolytope( 387, false );
#! [ 0, 0, 0, 733798300 ]
#! @EndLog

#! The remaining results can be checked analogousyl as follows:

#! @Log
CountMinimalLimitRootsOfQSMByPolytope( 798, false );
#! [ 0, 0, 0, 690950608 ]
CountMinimalLimitRootsOfQSMByPolytope( 808, false );
#! [ 0, 0, 0, 690950608 ]
CountMinimalLimitRootsOfQSMByPolytope( 810, false );
#! [ 0, 0, 0, 690950608 ]
CountMinimalLimitRootsOfQSMByPolytope( 812, false );
#! [ 0, 0, 0, 690950608 ]
CountMinimalLimitRootsOfQSMByPolytope( 254, false );
#! [ 0, 0, 0, 35004914 ]
CountMinimalLimitRootsOfQSMByPolytope( 52, false );
#! [ 0, 0, 0, 34980351 ]
CountMinimalLimitRootsOfQSMByPolytope( 302, false );
#! [ 0, 0, 0, 34908682 ]
CountMinimalLimitRootsOfQSMByPolytope( 786, false );
#! [ 0, 0, 0, 32860461 ]
CountMinimalLimitRootsOfQSMByPolytope( 762, false );
#! [ 0, 0, 0, 32858151 ]
CountMinimalLimitRootsOfQSMByPolytope( 417, false );
#! [ 0, 0, 0, 32857596 ]
CountMinimalLimitRootsOfQSMByPolytope( 838, false );
#! [ 0, 0, 0, 32845047 ]
CountMinimalLimitRootsOfQSMByPolytope( 782, false );
#! [ 0, 0, 0, 32844379 ]
CountMinimalLimitRootsOfQSMByPolytope( 377, false );
#! [ 0, 0, 0, 30846440 ]
CountMinimalLimitRootsOfQSMByPolytope( 499, false );
#! [ 0, 0, 0, 30846440 ]
CountMinimalLimitRootsOfQSMByPolytope( 503, false );
#! [ 0, 0, 0, 30846440 ]
CountMinimalLimitRootsOfQSMByPolytope( 1348, false );
#! [ 0, 0, 0, 30845702 ]
CountMinimalLimitRootsOfQSMByPolytope( 882, false );
#! [ 0, 0, 0, 30840098 ]
CountMinimalLimitRootsOfQSMByPolytope( 1340, false );
#! [ 0, 0, 0, 28954543 ]
CountMinimalLimitRootsOfQSMByPolytope( 1879, false );
#! [ 0, 0, 0, 28950852 ]
CountMinimalLimitRootsOfQSMByPolytope( 1384, false );
#! [ 0, 0, 0, 27178020 ]
CountMinimalLimitRootsOfQSMByPolytope( 856, false );
#! [ 0, 0, 0, 30840098 ]
#! @EndLog

#! By now, we support advanced functionality to analysis limit root line bundles obtained from partial blowups. For example, we have the following:

#! @Example
CountPartialBlowupLimitRootDistributionOfQSMByPolytope(4,3,3);;
#! @EndExample
