#! @Chapter Tools for investigation of one Quadrillion F-theory Standard Models

#! @Section Examples

LoadPackage( "QSMExplorer" );

#! Given the index i of polytope in the Kreuzer and Skarke list, DisplayQSMByPolytope( i ) shows important information of the QSMs built from this polytope. We mention that
#! in particular Sage starts its iterations at 0. Thus, for example the 8-th polytope is in Sage obtained by asking for the polytope with index 7.
#! In the QSM-Explorer, we obtain information about the QSM associated to the 8-th polytope in the Kreuzer-Skarke list as follows:

#! @Example
FullInformationOfQSMByPolytope( 8 );
#! The QSM defined by FRSTs of the 8th 3-dimensional polytope in the Kreuzer-Skar\
#! ke list
#! ------------------------------------------------------------------------------\
#! ----------
#! 
#! Information on the 3-dimensional polytope:
#! (*) Vertices: [[-1, -1, -1], [1, -1, -1], [-1, 5, -1], [-1, -1, 5]]
#! (*) Maximal number of lattice points in facets: 28
#! (*) Estimated number of FRSTs: 25780000000000
#! (*) Can be computed in short time: False
#! 
#! Information of ONE particular 3-fold:
#! (*) Kbar^3: 6
#! (*) Number of homogeneous variables: 38
#! (*) Picard group: Z^35
#! 
#! Information about elliptic 4-fold:
#! (*) h11: 40
#! (*) h12: 16
#! (*) h13: 31
#! (*) h22: 296
#! 
#! Information about the K3-surface:
#! (*) IsElliptic: True
#! (*) Rank of Picard lattice: 19
#! 
#! Information on the nodal quark-doublet curve:
#! (*) Genus: 4
#! (*) Number of components: 22
#! (*) Components: ["C0", "C1", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "C9", "\
#! C14", "C15", "C19", "C20", "C23", "C24", "C26", "C27", "C28", "C29", "C32", "C\
#! 37"]
#! (*) Genera: [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
#! (*) Degree of Kbar: [1, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
#! 0, 0, 0]
#! 
#! Information on simplified dual graph:
#! (*) Number of components: 4
#! (*) Components: ["C0", "C1", "C2", "C3"]
#! (*) Genera: [0, 1, 0, 0]
#! (*) Edge list of dual graph: [[3, 0], [2, 0], [2, 3], [0, 1], [1, 3], [1, 2]]
#! 
#! Root bundles:
#! (*) Looking for 12th root of line bundle M
#! (*) Degrees of line bundle M: [ 12, 36, 12, 12 ]
#! (*) Total number of root bundles: 429981696
#! 
#! true
#! @EndExample

#! Given the index i of polytope in our database.csv file, DisplayQSM( i ) shows the important information of the QSMs built from this polytope. For example, below is the important information of the QSMs from the 1st polytope in our list, which corresponds to the 3th polytope in the Kreuzer and Skarke list. 

#! @Example
FullInformationOfQSM( 1 );
#! 
#! The QSM defined by FRSTs of the 4th 3-dimensional polytope in the Kreuzer-Skar\
#! ke list
#! ------------------------------------------------------------------------------\
#! ----------
#! 
#! Information on the 3-dimensional polytope:
#! (*) Vertices: [[-1, -1, -1], [2, -1, -1], [-1, 2, -1], [-1, -1, 5]]
#! (*) Maximal number of lattice points in facets: 16
#! (*) Estimated number of FRSTs: 212533333333.333
#! (*) Can be computed in short time: True
#! 
#! Information of ONE particular 3-fold:
#! (*) Kbar^3: 6
#! (*) Number of homogeneous variables: 29
#! (*) Picard group: Z^26
#! 
#! Information about elliptic 4-fold:
#! (*) h11: 31
#! (*) h12: 10
#! (*) h13: 34
#! (*) h22: 284
#! 
#! Information about the K3-surface:
#! (*) IsElliptic: No
#! (*) Rank of Picard lattice: 18
#! 
#! Information on the nodal quark-doublet curve:
#! (*) Genus: 4
#! (*) Number of components: 21
#! (*) Components: ["C0", "C1", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "C9", "\
#! C13", "C14", "C16", "C17", "C21", "C24-0", "C24-1", "C25", "C27", "C28-0", "C2\
#! 8-1"]
#! (*) Genera: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
#! (*) Degree of Kbar: [1, 2, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
#! 0, 0]
#! 
#! Information on simplified dual graph:
#! (*) Number of components: 4
#! (*) Components: ["C0", "C1", "C2", "C3"]
#! (*) Genera: [0, 0, 0, 0]
#! (*) Edge list of dual graph: [[3, 0], [2, 0], [2, 3], [1, 0], [1, 3], [1, 2], \
#! [1, 2]]
#! 
#! Root bundles:
#! (*) Looking for 12th root of line bundle M
#! (*) Degrees of line bundle M: [ 12, 24, 24, 12 ]
#! (*) Total number of root bundles: 429981696
#! 
#! true
#! @EndExample

#! We can display the dual graph of this polytope by issuing DualGraphOfQSM ( 702 ) and DualGraphOfQSMByPolytope( 7 ).

#! We can compute the limit counting of selected polytope by issuing CountLimitRootsOfQSMByPolytope( i ) that corresponds to the i-th polytope in the Kreuzer and Skarke list. Below is the root counting for the 7-th polytope.

#! @Log
CountMinimalLimitRootOfQSMByPolytope( 8 );
#!
#! Received diagram:
#! -----------------
#! Vertices: 0,1,2,3
#! Edge numbers: 3,3,3,3
#! Degrees: 12,36,12,12
#! Genera: 0,1,0,0
#! Edges: (3,0) (2,0) (2,3) (0,1) (1,3) (1,2) 
#! Degree: 72
#! Root: 12
#! Genus: 4
#! h0_min: 3
#!
#! Executing...
#! ------------
#! Wait for 8 worker threads 
#! Thread complete. Total roots found: 12960
#! Thread complete. Total roots found: 12960
#! Thread complete. Total roots found: 12960
#! Thread complete. Total roots found: 12960
#! Thread complete. Total roots found: 12960
#! Thread complete. Total roots found: 25920
#! Thread complete. Total roots found: 25920
#! Thread complete. Total roots found: 25920
#! Found 142560 minimal roots
#!
#! Time for run: 0[s]
#!
#! 142560
#! @EndLog

#! Alternatively, we can compute the limit counting of selected polytope by issuing CountLimitRootsOfQSM( i ) that corresponds to the i-th polytope in our list. Below is the root counting for the 1st polytope.

#! @Log
CountMinimalLimitRootsOfQSM( 1 );
#!
#! Received diagram:
#! -----------------
#! Vertices: 0,1,2,3
#! Edge numbers: 3,4,4,3
#! Degrees: 12,24,24,12
#! Genera: 0,0,0,0
#! Edges: (3,0) (2,0) (2,3) (1,0) (1,3) (1,2) (1,2) 
#! Degree: 72
#! Root: 12
#! Genus: 4
#! h0_min: 3
#!
#! Executing...
#! ------------
#! Wait for 8 worker threads 
#! Thread complete. Total roots found: 1010
#! Thread complete. Total roots found: 1010
#! Thread complete. Total roots found: 1010
#! Thread complete. Total roots found: 1010
#! Thread complete. Total roots found: 1010
#! Thread complete. Total roots found: 2020
#! Thread complete. Total roots found: 2020
#! Thread complete. Total roots found: 2020
#! Found 11110 minimal roots
#!
#! Time for run: 0[s]
#!
#! 11110
#! @EndLog

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
n1 := CountLimitRootDistributionOfQSMByPolytope( 8, 3, 4, false );;
n1;
#! [ 0, 0, 0, 142560, 0 ]
n2 := CountLimitRootDistributionOfQSM( 10, 3, 6, false );;
n2;
#! [ 0, 0, 0, 781680888, 25196800, 106800, 0 ]
#! @EndExample

#! We can also compute the root distribution with weights on external legs of the quark doublet curve. Here is an example:
#! @Example
dist := CountLimitRootDistributionWithExternalLegsOfQSM( 1, 0, 4, [ 1,1,11,11,11,1 ], false );;
dist;
#! [ 1716, 8325, 1260, 0, 0 ]
dist2 := CountLimitRootDistributionWithExternalLegsOfQSMByPolytope( 8, 0, 4, [ 1, 11, 11, 11, 1, 1 ], false );
#! [ 1573, 109395, 36036, 0, 0 ]
#! @EndExample

#! We can also perform a sufficient test to tell if the K3s are elliptic. To this end, it suffices to find an element of Pic( K3 ) with vanishing self-intersection number
#! (i.e. is a g = 1 curve).

#! @Example
IsK3OfQSMByPolytopeElliptic( 8 );
#! true
IsK3OfQSMByPolytopeElliptic( 4 );
#! false
IsK3OfQSMElliptic( 2 );
#! true
IsK3OfQSMElliptic( 1 );
#! false
#! @EndExample

#! Also, we can compute a lower bound to the rank of the Picard lattice of the K3.

#! @Example
RankOfPicardLatticeOfK3OfQSM( 2 );
#! 19
RankOfPicardLatticeOfK3OfQSMByPolytope( 8 );
#! 19
RankOfPicardLatticeOfK3OfQSM( 1 );
#! 18
#! @EndExample

#! Similarly, we can easily access the triple intersection number of the anti-canonical class of the base space.

#! @Example
Kbar3OfQSM( 2 );
#! 6
Kbar3OfQSMByPolytope( 8 );
#! 6
Kbar3OfQSMByPolytope( 40 );
#! 18
#! @EndExample

#! We can also plot the dual graph of the nodal quark-doublet curve. The corresponding script can be found as follows:

#! @Example
FindDualGraphScript();;
#! @EndExample

#! Each QSM is obtained from triangulations of certain polytopes. These polytopes we can read out:

#! @Example
PolytopeOfQSM( 1 );
#! <A polytope in |R^3>
PolytopeOfQSMByPolytope( 8 );
#! <A polytope in |R^3>
#! @EndExample

#! An estimate (more precisely, an estimated lower bound) of the number of triangulations is distributed with the database in the QSMExplorer. We can read-out these estimates as follows:

#! @Example
TriangulationEstimateInQSM( 1 );
#! 2.12533e+11
TriangulationEstimateInQSMByPolytope( 8 );
#! 25780000000000
#! @EndExample

#! These triangulations are obtained by triangulating facets of the 3d polytopes and then pieces these triangulations together to triangulations of the polytope.
#! Whether or not this is possible, depends on how complicated the facets of the polytope in question are. The latter is measured by the lattice points in the facets.
#! The number of lattice points for the largest facet of the polytope for a QSM can be read-off from our database:

#! @Example
MaxLatticePtsInFacetInQSM( 1 );
#! 16
MaxLatticePtsInFacetInQSMByPolytope( 8 );
#! 28
#! @EndExample

#! We provide a pointer if or if not all these triangulations can be computed in a reasonable time (as used in the physics community):

#! @Example
TriangulatonQuickForQSM( 1 );
#! true
TriangulationQuickForQSMByPolytope( 8 );
#! false
#! @EndExample

#! Each of these triangulations gives rise to a toric 3-fold base space. We provide a method that constructs one of these many bases.

#! @Example
BaseSpaceOfQSM( 1 );
#! <A toric variety of dimension 3>
BaseSpaceOfQSMByPolytope( 8 );
#! <A toric variety of dimension 3>
#! @EndExample

#! For this very base space, we can also construct the toric 5-fold ambient space of the F-theory elliptic 4-fold:

#! @Example
ToricAmbientSpaceOfQSM( 1 );
#! <A toric variety of dimension 5>
ToricAmbientSpaceOfQSMByPolytope( 8 );
#! <A toric variety of dimension 5>
#! @EndExample

#! Explicitly, we can read-out specific data from the QSMs with the following methods:

#! @Example
GeneraOfCurvesInQSM( 1 );;
GeneraOfCurvesInQSMByPolytope( 8 );;
DegreeOfKbarOnCurvesInQSM( 1 );;
DegreeOfKbarOnCurvesInQSMByPolytope( 8 );;
IntersectionNumbersOfCurvesInQSM( 1 );;
IntersectionNumbersOfCurvesInQSMByPolytope( 8 );;
IndicesOfTrivialCurvesInQSM( 1 );;
IndicesOfTrivialCurvesInQSMByPolytope( 8 );;
ComponentsOfDualGraphOfQSM( 1 );;
ComponentsOfDualGraphOfQSMByPolytope( 8 );;
GenusOfComponentsOfDualGraphOfQSM( 1 );;
GenusOfComponentsOfDualGraphOfQSMByPolytope( 8 );;
DegreeOfKbarOnComponentsOfDualGraphOfQSM( 1 );;
DegreeOfKbarOnComponentsOfDualGraphOfQSMByPolytope( 8 );;
IntersectionNumberOfComponentsOfDualGraphOfQSM( 1 );;
IntersectionNumberOfComponentsOfDualGraphOfQSMByPolytope( 8 );;
ComponentsOfSimplifiedDualGraphOfQSM( 1 );;
ComponentsOfSimplifiedDualGraphOfQSMByPolytope( 8 );;
GenusOfComponentsOfSimplifiedDualGraphOfQSM( 1 );;
GenusOfComponentsOfSimplifiedDualGraphOfQSMByPolytope( 8 );;
DegreeOfKbarOnComponentsOfSimplifiedDualGraphOfQSM( 1 );;
DegreeOfKbarOnComponentsOfSimplifiedDualGraphOfQSMByPolytope( 8 );;
EdgeListOfSimplifiedDualGraphOfQSM( 1 );;
EdgeListOfSimplifiedDualGraphOfQSMByPolytope( 8 );;
#! @EndExample

#! We can plot the (simplified) dual graphs as follows:

#! @Log
DualGraphOfQSM( 1 );;
DualGraphOfQSMByPolytope( 8 );;
SimplifiedDualGraphOfQSM( 1 );;
SimplifiedDualGraphOfQSMByPolytope( 8 );;
#! @EndLog

#! With the nodal Higgs curve in mind, we can also consider the nodal quark-doublet curve with external legs:

#! @Log
SimplifiedDualGraphWithExternalLegsOfQSM( 1 );;
SimplifiedDualGraphWithExternalLegsOfQSMByPolytope( 8 );;
#! @EndLog

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
#! @Example
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
#! @EndExample

#! The remaining results can be checked analogousyl as follows:

#! @Example
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
#! @EndExample
