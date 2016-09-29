#! @Chapter Sheaf cohomology via B-transform

#! @Section Sheaf cohomology via B-transform: Examples on P1 

#! @Subsection Cohomology of coherent sheaves on P1

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
C2 := GradedLeftSubmoduleForCAP( [[ "x_2*x_4" ], [ "x_2*x_3" ], [ "x_1 * x_4" ], 
      [ "x_1 * x_3" ]], CoxRing( P1xP1 ) );
#! <A graded left ideal of Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
V := CAPCategoryOfProjectiveGradedLeftModulesObject( 
     [[[-1,-1],1],[[2,0],1]], CoxRing( P1xP1 ) );
#! <A projective graded left module of rank 2>
V := ApplyFunctor( EmbeddingOfProjCategory( CapCategory( V ) ), V );
#! <A graded left module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
VPrime := CAPCategoryOfProjectiveGradedLeftModulesObject( [[[-1,-1],1]], CoxRing( P1xP1 ) );
#! <A projective graded left module of rank 1>
VPrime := ApplyFunctor( EmbeddingOfProjCategory( CapCategory( VPrime ) ), VPrime );
#! <A graded left module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
H0FromBTransform( P1, CForCAP );
#! <A vector space object over Q of dimension 1>
H0FromBTransform( P1xP1, C2 );
#! <A vector space object over Q of dimension 1>
H0FromBTransform( P1xP1, V );
#! <A vector space object over Q of dimension 4>
H0FromBTransform( P1xP1, VPrime );
#! <A vector space object over Q of dimension 4>

#! @EndExample