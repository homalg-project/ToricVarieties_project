#! @Chapter Sheaf cohomology via my theorem

#! @Section Sheaf cohomology via my theorem: Examples 

#! @Subsection Examples for PresentationsByProjectiveGradedModules on P1 and P1xP1

LoadPackage( "SheafCohomologyOnToricVarieties" );

#! @Example

F1 := Fan( [[1],[-1]],[[1],[2]] );
#! <A fan in |R^1>
P1 := ToricVariety( F1 );
#! <A toric variety of dimension 1>
ByASmallerPresentation( ClassGroup( P1 ) );
#! <A free left module of rank 1 on a free generator>
CoxRing( P1 );
#! Q[x_1,x_2]
#! (weights: [ 1, 1 ])
CForCAP := GradedLeftSubmoduleForCAP( [[ "x_1" ], ["x_2" ]], CoxRing( P1 ) );
#! <A graded left ideal of Q[x_1,x_2] (with weights [ 1, 1 ])>
P1xP1 := P1 * P1;
#! <A toric variety of dimension 2 which is a product of 2 toric varieties>
ByASmallerPresentation( ClassGroup( P1xP1 ) );
#! <A free left module of rank 2 on free generators>
C2ForCAP := GradedLeftSubmoduleForCAP( [[ "x_2*x_4" ], [ "x_2*x_1" ], [ "x_3 * x_4" ], 
      [ "x_1 * x_3" ]], CoxRing( P1xP1 ) );
#! <A graded left ideal of Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 0, 1 ], [ 1, 0 ], [ 1, 0 ], [ 0, 1 ] ])>
VForCAP := CAPCategoryOfProjectiveGradedLeftModulesObject( 
     [[[-1,-1],1],[[2,0],1]], CoxRing( P1xP1 ) );
#! <A projective graded left module of rank 2>
VForCAP := ApplyFunctor( EmbeddingOfProjCategory( CapCategory( VForCAP ) ), VForCAP );
#! <A graded left module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 0, 1 ], [ 1, 0 ], [ 1, 0 ], [ 0, 1 ] ])>
VPrimeForCAP := CAPCategoryOfProjectiveGradedLeftModulesObject( [[[-1,-1],1]], CoxRing( P1xP1 ) );
#! <A projective graded left module of rank 1>
VPrimeForCAP := ApplyFunctor( EmbeddingOfProjCategory( CapCategory( VPrimeForCAP ) ), VPrimeForCAP );
#! <A graded left module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 0, 1 ], [ 1, 0 ], [ 1, 0 ], [ 0, 1 ] ])>
Hi( P1, CForCAP, 0, false, false, false );
#! [ 1, <A vector space object over Q of dimension 1> ]
Hi( P1xP1, C2ForCAP, 0, false, false, false );
#! [ 1, <A vector space object over Q of dimension 1> ]
Hi( P1xP1, VForCAP, 0, false, false, false );
#! [ 0, <A vector space object over Q of dimension 4> ]
Hi( P1xP1, VPrimeForCAP, 0, false, false, false );
#! [ 0, <A vector space object over Q of dimension 4> ]
AllHi( P1, CForCAP, false, false );
#! Computing h^0
#! ----------------------------------------------
#!
#! Computing h^1
#! ----------------------------------------------
#!
#! [ [ 1, <A vector space object over Q of dimension 1> ],
#!   [ 1, <A vector space object over Q of dimension 0> ] ]
AllHi( P1xP1, C2ForCAP, false, false );
#! Computing h^0
#! ----------------------------------------------
#!
#! Computing h^1
#! ----------------------------------------------
#!
#! Computing h^2
#! ----------------------------------------------
#!
#! [ [ 1, <A vector space object over Q of dimension 1> ],
#!   [ 1, <A vector space object over Q of dimension 0> ],
#!   [ 0, <A vector space object over Q of dimension 0> ] ]
AllHi( P1xP1, VForCAP, false, false );
#! Computing h^0
#! ----------------------------------------------
#!
#! Computing h^1
#! ----------------------------------------------
#!
#! Computing h^2
#! ----------------------------------------------
#!
#! [ [ 0, <A vector space object over Q of dimension 4> ],
#!   [ 1, <A vector space object over Q of dimension 1> ],
#!   [ 1, <A vector space object over Q of dimension 0> ] ]
AllHi( P1xP1, VPrimeForCAP, false, false );
#! Computing h^0
#! ----------------------------------------------
#!
#! Computing h^1
#! ----------------------------------------------
#!
#! Computing h^2
#! ----------------------------------------------
#!
#! [ [ 0, <A vector space object over Q of dimension 4> ],
#!   [ 0, <A vector space object over Q of dimension 0> ],
#!   [ 0, <A vector space object over Q of dimension 0> ] ]

#! @EndExample