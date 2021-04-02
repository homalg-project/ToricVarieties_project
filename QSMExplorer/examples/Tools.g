#! @Chapter Tools for investigation of one Quadrillion F-theory Standard Models

#! @Section Examples

LoadPackage( "QSMExplorer" );

#! Given the index i of polytope in the Kreuzer and Skarke list, DisplayQSMByPolytope( i ) shows important information of the QSMs built from this polytope. For example, below is the output expected from the 7-th polytope in the Kreuzer and Skarke list.

#! @Log
DisplayQSMByPolytope( 7 );
#!
#! The QSM defined by FRSTs of the 7th 3-dimensional polytope in the Kreuzer-Skarke list
#! ----------------------------------------------------------------------------------------
#!
#! Information on the 3-fold:
#! (*) Kbar^3: 6
#! (*) Estimated number of triangulations: 25780000000000
#!
#! Information on the elliptic 4-fold:
#! (*) h11: 40
#! (*) h12: 16
#! (*) h13: 31
#! (*) h22: 296
#! 
#! Information on the 3-dimensional polytope:
#! (*) Vertices: [[-1, -1, -1], [1, -1, -1], [-1, 5, -1], [-1, -1, 5]]
#!
#! Information on the nodal quark-doublet curve:
#! (*) Genus: 4
#! (*) Looking for 12th root of line bundle M
#! (*) Total number of root bundles: 429981696
#!
#! Information on reduce dual graph of this nodal curve:
#! (*) Number of components: 4
#! (*) Genera: [0, 1, 0, 0]
#! (*) Edge list of dual graph: [[3, 0], [2, 0], [2, 3], [0, 1], [1, 3], [1, 2]]
#! (*) Degrees of line bundle M: [ 12, 36, 12, 12 ]
#!
#! true
#! @EndLog

#! Given the index i of polytope in our database.csv file, DisplayQSM( i ) shows the important information of the QSMs built from this polytope. For example, below is the important information of the QSMs from the 702 nd polytope in our list, which corresponds to the 3th polytope in the Kreuzer and Skarke list. 

#! @Log
DisplayQSM( 702 );
#!
#! The QSM defined by FRSTs of the 3th 3-dimensional polytope in the Kreuzer-Skarke list
#! ----------------------------------------------------------------------------------------
#!
#! Information on the 3-fold:
#! (*) Kbar^3: 6
#! (*) Estimated number of triangulations: 212533333333.333
#!
#! Information on the elliptic 4-fold:
#! (*) h11: 31
#! (*) h12: 10
#! (*) h13: 34
#! (*) h22: 284
#!
#! Information on the 3-dimensional polytope:
#! (*) Vertices: [[-1, -1, -1], [2, -1, -1], [-1, 2, -1], [-1, -1, 5]]
#!
#! Information on the nodal quark-doublet curve:
#! (*) Genus: 4
#! (*) Looking for 12th root of line bundle M 
#! (*) Total number of root bundles: 429981696
#!
#! Information on reduce dual graph of this nodal curve:
#! (*) Number of components: 4
#! (*) Genera: [0, 0, 0, 0]
#! (*) Edge list of dual graph: [[3, 0], [2, 0], [2, 3], [1, 0], [1, 3], [1, 2], [1, 2]]
#! (*) Degrees of line bundle M: [ 12, 24, 24, 12 ]
#!
#! true
#! @EndLog

#! We can display the dual graph of this polytope by issuing DualGraphOfQSM ( 702 ) and DualGraphOfQSMByPolytope( 7 ).

#! We can compute the limit counting of selected polytope by issuing CountLimitRootsOfQSMByPolytope( i ) that corresponds to the i-th polytope in the Kreuzer and Skarke list. Below is the root counting for the 7-th polytope.

#! @Log
CountLimitRootsOfQSMByPolytope( 7 );
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

#! Alternatively, we can compute the limit counting of selected polytope by issuing CountLimitRootsOfQSM( i ) that corresponds to the i-th polytope in our list. Below is the root counting for the 702-th polytope.

#! @Log
CountLimitRootsOfQSM( 702 );
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

#! @Example for short, below display the root counting of the 7th polytope in the Kreuzer and Skarke list and the 702 nd polytope in our list.
n := CountLimitRootsOfQSMByPolytope( 7 );;
n;
#! 142560
n := CountLimitRootsOfQSM( 702 );;
n;
#! 11110
#! @EndExample
