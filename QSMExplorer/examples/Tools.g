#! @Chapter Tools for investigation of one Quadrillion F-theory Standard Models

#! @Section Examples

LoadPackage( "QSMExplorer" );

#! Given the index i of polytope in the Kreuzer and Skarke list, DisplayQSMByPolytope( i ) shows important information of the QSMs built from this polytope. We mention that
#! in particular Sage starts its iterations at 0. Thus, for example the 8-th polytope is in Sage obtained by asking for the polytope with index 7.
#! In the QSM-Explorer, we obtain information about the QSM associated to the 8-th polytope in the Kreuzer-Skarke list as follows:

#! @Log
FullInformationOfQSMByPolytope( 8 );
#!
#! The QSM defined by FRSTs of the 8th 3-dimensional polytope in the Kreuzer-Skarke list
#! ----------------------------------------------------------------------------------------
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
#! (*) Lower bound for rank of Picard lattice: 19
#!
#! Information on the nodal quark-doublet curve:
#! (*) Genus: 4
#! (*) Number of components: 22
#! (*) Components: ["C0", "C1", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "C9", "C14", "C15", "C19", "C20", "C23", "C24", "C26", "C27", "C28", "C29", "C32", "C37"]
#! (*) Genera: [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
#! (*) Degree of Kbar: [1, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
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
#! @EndLog

#! Given the index i of polytope in our database.csv file, DisplayQSM( i ) shows the important information of the QSMs built from this polytope. For example, below is the important information of the QSMs from the 1st polytope in our list, which corresponds to the 3th polytope in the Kreuzer and Skarke list. 

#! @Log
FullInformationOfQSM( 1 );
#!
#! The QSM defined by FRSTs of the 4th 3-dimensional polytope in the Kreuzer-Skarke list
#! ----------------------------------------------------------------------------------------
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
#! (*) IsElliptic: Unknown
#! (*) Lower bound for rank of Picard lattice: 18
#!
#! Information on the nodal quark-doublet curve:
#! (*) Genus: 4
#! (*) Number of components: 21
#! (*) Components: ["C0", "C1", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "C9", "C13", "C14", "C16", "C17", "C21", "C24-0", "C24-1", "C25", "C27", "C28-0", "C28-1"]
#! (*) Genera: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
#! (*) Degree of Kbar: [1, 2, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
#!
#! Information on simplified dual graph:
#! (*) Number of components: 4
#! (*) Components: ["C0", "C1", "C2", "C3"]
#! (*) Genera: [0, 0, 0, 0]
#! (*) Edge list of dual graph: [[3, 0], [2, 0], [2, 3], [1, 0], [1, 3], [1, 2], [1, 2]]
#!
#! Root bundles:
#! (*) Looking for 12th root of line bundle M
#! (*) Degrees of line bundle M: [ 12, 24, 24, 12 ]
#! (*) Total number of root bundles: 429981696
#!
#! true
#! @EndLog

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

#! Let us display the root counting of the 8th polytope in the Kreuzer and Skarke list and the first polytope in our list.

#! @Example
n := CountMinimalLimitRootsOfQSMByPolytope( 8 );;
n;
#! 142560
n := CountMinimalLimitRootsOfQSM( 1 );;
n;
#! 11110
#! @EndExample

#! We can also wonder how many limit roots exist with number of global sections at most L. For example, this is achieved by the following:
#! @Example
n1 := CountLimitRootDistributionOfQSMByPolytope( 8, 4 );;
n1;
#! [ 142560, 0 ]
n2 := CountLimitRootDistributionOfQSM( 10, 6 );;
n2;
#! [ 781680888, 25196800, 106800, 0 ]
#! @EndExample

#! We can also perform a sufficient test to tell if the K3s are elliptic. To this end, it suffices to find an element of Pic( K3 ) with vanishing self-intersection number
#! (i.e. is a g = 1 curve).

#! @Example
IsK3OfQSMByPolytopeElliptic( 8 );
#! true
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
