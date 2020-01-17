#! @Chapter Tools for cohomology computations

#! @Section Examples

#! @Subsection Approximation of 0-th sheaf cohomology

#! @Example
ApproxH0( P1xP1, 0, irP1xP1 );
#! <A vector space object over Q of dimension 0>
ApproxH0( P1xP1, 1, irP1xP1 );
#! <A vector space object over Q of dimension 1>
ApproxH0( P1xP1, 2, irP1xP1 );
#! <A vector space object over Q of dimension 1>
ApproxH0Parallel( P1xP1, 0, irP1xP1 );
#! <A vector space object over Q of dimension 0>
ApproxH0Parallel( P1xP1, 1, irP1xP1 );
#! <A vector space object over Q of dimension 1>
ApproxH0Parallel( P1xP1, 2, irP1xP1 );
#! <A vector space object over Q of dimension 1>
#! @EndExample


#! @Subsection Approximation of 1-st sheaf cohomology

#! @Example
F1 := Fan( [[1],[-1]],[[1],[2]] );
#! <A fan in |R^1>
P1 := ToricVariety( F1 );
#! <A toric variety of dimension 1>
P1xP1 := P1 * P1;
#! <A toric variety of dimension 2 which is a product of 2 toric varieties>
VForCAP := AsFreydCategoryObject( GradedRow( [[[1,1],1],[[-2,0],1]],
                                                         CoxRing( P1xP1 ) ) );
#! <A projective object in Category of f.p. graded
#! left modules over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 0, 1 ], [ 1, 0 ], [ 1, 0 ], [ 0, 1 ] ])>
ApproxHi( P1xP1, 1, 0, VForCAP );
#! <A vector space object over Q of dimension 0>
ApproxHi( P1xP1, 1, 1, VForCAP );
#! <A vector space object over Q of dimension 1>
ApproxHi( P1xP1, 1, 2, VForCAP );
#! <A vector space object over Q of dimension 1>
ApproxHiParallel( P1xP1, 1, 0, VForCAP );
#! <A vector space object over Q of dimension 0>
ApproxHiParallel( P1xP1, 1, 1, VForCAP );
#! <A vector space object over Q of dimension 1>
ApproxHiParallel( P1xP1, 1, 2, VForCAP );
#! <A vector space object over Q of dimension 1>
#! @EndExample
