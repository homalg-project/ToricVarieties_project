#! @Chapter Sheaf cohomology via the theorem of Greg. Smith for CAP

#! @Section Sheaf cohomology via the theorem of Greg. Smith for CAP: Examples 

#! @Subsection Examples for graded modules on P1 and P1xP1

LoadPackage( "ToricVarieties" );

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
C2ForCAP := GradedLeftSubmoduleForCAP( [[ "x_2*x_4" ], [ "x_2*x_3" ], [ "x_1 * x_4" ], 
      [ "x_1 * x_3" ]], CoxRing( P1xP1 ) );
#! <A graded left ideal of Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
VForCAP := CAPCategoryOfProjectiveGradedLeftModulesObject( 
     [[[-1,-1],1],[[2,0],1]], CoxRing( P1xP1 ) );
#! <A projective graded left module of rank 2>
VForCAP := ApplyFunctor( EmbeddingOfProjCategory( CapCategory( VForCAP ) ), VForCAP );
#! <A graded left module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
VPrimeForCAP := CAPCategoryOfProjectiveGradedLeftModulesObject( [[[-1,-1],1]], CoxRing( P1xP1 ) );
#! <A projective graded left module of rank 1>
VPrimeForCAP := ApplyFunctor( EmbeddingOfProjCategory( CapCategory( VPrimeForCAP ) ), VPrimeForCAP );
#! <A graded left module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
HiByGSForCAP( P1, CForCAP, 0 );
#! [ 2, <A vector space object over Q of dimension 1> ]
HiByGSForCAP( P1xP1, C2ForCAP, 0 );
#! [ 2, <A vector space object over Q of dimension 1> ]
HiByGSForCAP( P1xP1, VForCAP, 0 );
#! [ 2, <A vector space object over Q of dimension 4> ]
HiByGSForCAP( P1xP1, VPrimeForCAP, 0 );
#! [ 0, <A vector space object over Q of dimension 4> ]
AllCohomologiesByGSForCAP( P1, CForCAP );
#! [ [ 2, <A vector space object over Q of dimension 1> ],
#!   [ 1, <A vector space object over Q of dimension 0> ] ]
AllCohomologiesByGSForCAP( P1xP1, C2ForCAP );
#! [ [ 2, <A vector space object over Q of dimension 1> ],
#!   [ 2, <A vector space object over Q of dimension 0> ],
#!   [ 1, <A vector space object over Q of dimension 0> ] ]
AllCohomologiesByGSForCAP( P1xP1, VForCAP );
#! [ [ 2, <A vector space object over Q of dimension 4> ],
#!   [ 2, <A vector space object over Q of dimension 1> ],
#!   [ 2, <A vector space object over Q of dimension 0> ] ]
AllCohomologiesByGSForCAP( P1xP1, VPrimeForCAP );
#! [ [ 0, <A vector space object over Q of dimension 4> ],
#!   [ 0, <A vector space object over Q of dimension 0> ],
#!   [ 0, <A vector space object over Q of dimension 0> ] ]

#! @EndExample