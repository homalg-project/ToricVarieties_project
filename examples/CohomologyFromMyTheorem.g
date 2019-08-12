#! @Chapter Sheaf cohomology via my theorem

#! @Section Examples

#! @Subsection Sheaf cohomology of toric vector bundles

LoadPackage( "SheafCohomologyOnToricVarieties" );

#! @Example
F1 := Fan( [[1],[-1]],[[1],[2]] );
#! <A fan in |R^1>
P1 := ToricVariety( F1 );
#! <A toric variety of dimension 1>
P1xP1 := P1 * P1;
#! <A toric variety of dimension 2 which is a product of 2 toric varieties>
VForCAP := AsFreydCategoryObject( GradedRow( [[[1,1],1],[[-2,0],1]], CoxRing( P1xP1 ) ) );
#! <A projective object in Category of f.p. graded
#! left modules over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 0, 1 ], [ 1, 0 ], [ 1, 0 ], [ 0, 1 ] ])>
V2ForCAP := AsFreydCategoryObject( GradedRow( [[[-2,0],1]], CoxRing( P1xP1 ) ) );
#! <A projective object in Category of f.p. graded
#! left modules over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 0, 1 ], [ 1, 0 ], [ 1, 0 ], [ 0, 1 ] ])>
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
AllHiParallel( P1xP1, VForCAP, false, false );
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
AllHi( P1xP1, V2ForCAP, false, false );
#! Computing h^0
#! ----------------------------------------------
#!
#! Computing h^1
#! ----------------------------------------------
#!
#! Computing h^2
#! ----------------------------------------------
#!
#! [ [ 0, <A vector space object over Q of dimension 0> ],
#!   [ 1, <A vector space object over Q of dimension 1> ],
#!   [ 1, <A vector space object over Q of dimension 0> ] ]
AllHiParallel( P1xP1, V2ForCAP, false, false );
#! Computing h^0
#! ----------------------------------------------
#!
#! Computing h^1
#! ----------------------------------------------
#!
#! Computing h^2
#! ----------------------------------------------
#!
#! [ [ 0, <A vector space object over Q of dimension 0> ],
#!   [ 1, <A vector space object over Q of dimension 1> ],
#!   [ 1, <A vector space object over Q of dimension 0> ] ]
#! @EndExample

#! @Subsection Sheaf cohomologies of the irrelevant ideal of P1xP1

#! @Example
irP1xP1 := IrrelevantLeftIdealForCAP( P1xP1 );
#! <An object in Category of f.p. graded left
#! modules over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 0, 1 ], [ 1, 0 ], [ 1, 0 ], [ 0, 1 ] ])>
AllHi( P1xP1, irP1xP1, false, false );
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
AllHiParallel( P1xP1, irP1xP1, false, false );
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
#! @EndExample
