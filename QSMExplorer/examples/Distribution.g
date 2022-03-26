#! @Chapter Tools for computing root bundle distributions in the Quadrillion F-theory Standard Models

#! @Section Example: Root bundles on the quark-doublet curve

LoadPackage( "QSMExplorer" );

#! Given the index i of polytope in the Kreuzer and Skarke list, DisplayQSMByPolytope( i ) shows important information of the QSMs built from this polytope. We mention that
#! in particular Sage starts its iterations at 0. Thus, for example the 8-th polytope is in Sage obtained by asking for the polytope with index 7.
#! We can compute the limit counting of selected polytope by issuing CountLimitRootsOfQSMByPolytope( i ) that corresponds to the i-th polytope in the Kreuzer and Skarke list. 
#! Let us compute the number of minimal roots for the 8th polytope in the Kreuzer and Skarke list and the first polytope in our list. We pass as 2nd argument "false" to not display intermediate results of the C++ run.

#! @Example
n := CountMinimalLimitRootsOfQSMByPolytope( 8, false );;
n;
#! [ 0, 0, 0, 142560 ]
#! @EndExample

#! We can also wonder how many limit roots exist with number of global sections at most L. For example, this is achieved by the following:
#! @Example
n := CountMinimalLimitRootDistributionOfQSMByPolytope( 8, 3, 4, false );;
n;
#! [ 0, 0, 0, 142560, 0 ]
#! @EndExample

#! We verify that 5 (random) results computed in our PRD letter for spaces with Kbar^3 = 6 and 10 are correct:
#! @Example
setups := [8, 4, 134, 128, 88, 110, 272, 274, 387, 798, 808, 810, 812, 254, 52, 302,
                  786, 762, 417, 838, 782, 377, 499, 503, 1348, 882, 1340, 1879, 1384, 856 ];;
results := [
[ 0, 0, 0, 142560 ],
[ 0, 0, 0, 11110 ],
[ 0, 0, 0, 10010 ],
[ 0, 0, 0, 8910 ],
[ 0, 0, 0, 781680888 ],
[ 0, 0, 0, 738662983 ],
[ 0, 0, 0, 736011640 ],
[ 0, 0, 0, 736011640 ],
[ 0, 0, 0, 733798300 ],
[ 0, 0, 0, 690950608 ],
[ 0, 0, 0, 690950608 ],
[ 0, 0, 0, 690950608 ],
[ 0, 0, 0, 690950608 ],
[ 0, 0, 0, 35004914 ],
[ 0, 0, 0, 34980351 ],
[ 0, 0, 0, 34908682 ],
[ 0, 0, 0, 32860461 ],
[ 0, 0, 0, 32858151 ],
[ 0, 0, 0, 32857596 ],
[ 0, 0, 0, 32845047 ],
[ 0, 0, 0, 32844379 ],
[ 0, 0, 0, 30846440 ],
[ 0, 0, 0, 30846440 ],
[ 0, 0, 0, 30846440 ],
[ 0, 0, 0, 30845702 ],
[ 0, 0, 0, 30840098 ],
[ 0, 0, 0, 28954543 ],
[ 0, 0, 0, 28950852 ],
[ 0, 0, 0, 27178020 ],
[ 0, 0, 0, 30840098 ]];;
indexes := DuplicateFreeList(List([1..5], k -> Random([1..Length(setups)])));;
List([1..5], k -> CountMinimalLimitRootsOfQSMByPolytope(setups[indexes[k]], false)=results[indexes[k]]);
#! [true, true]
#! @EndExample

#! By now, we support advanced functionality to analyze limit root line bundles obtained also from partial blowups. For example, we have the following:

#! @Example
n := CountPartialBlowupLimitRootDistributionOfQSMByPolytope(4,3,3);
#! [ [ [ 11110, 7601, 1562, 264, 0, 0, 0, 0 ] ], [ [ 0, 0, 110, 11, 66, 11, 0, 1 ] ] ]
n2 := CountPartialBlowupLimitRootDistributionOfQSMByPolytope(88,3,5);
#! [ [ [ 781680888, 163221088, 13270504, 504800, 0, 0, 0, 0, 0, 0 ], [ 25196800, 5967200, 399200, 0, 0, 0, 0, 0, 0, 0 ], [ 106800, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ], 
#! [ [ 62712, 206886912, 66489896, 9361600, 692000, 24800, 1600, 0, 0, 0 ], [ 0, 5200000, 880400, 45600, 0, 0, 0, 0, 0, 0 ], [ 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0 ] ] ]
#! @EndExample
