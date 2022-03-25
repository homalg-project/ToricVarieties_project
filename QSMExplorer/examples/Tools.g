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
