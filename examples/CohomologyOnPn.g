#! @Chapter Sheaf cohomology on (direct products of) projective spaces

#! @Section Sheaf cohomology on direct product of projective spaces: Examples 

#! @Subsection Examples for graded modules on P1 and P1xP1

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
C := GradedLeftSubmodule( [ "x_1", "x_2" ], CoxRing( P1 ) );
#! <A graded torsion-free (left) ideal given by 2 generators>
P1xP1 := P1 * P1;
#! <A toric variety of dimension 2 which is a product of 2 toric varieties>
ByASmallerPresentation( ClassGroup( P1xP1 ) );
#! <A free left module of rank 2 on free generators>
C2 := GradedLeftSubmoduleForCAP( [[ "x_2*x_4" ], [ "x_2*x_3" ], [ "x_1 * x_4" ], 
      [ "x_1 * x_3" ]], CoxRing( P1xP1 ) );
#! <A graded left ideal of Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 0, 1 ], [ 1, 0 ], [ 1, 0 ], [ 0, 1 ] ])>
V := CAPCategoryOfProjectiveGradedLeftModulesObject( 
     [[[-1,-1],1],[[2,0],1]], CoxRing( P1xP1 ) );
#! <A projective graded left module of rank 2>
V := ApplyFunctor( EmbeddingOfProjCategory( CapCategory( V ) ), V );
#! <A graded left module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 0, 1 ], [ 1, 0 ], [ 1, 0 ], [ 0, 1 ] ])>
VPrime := CAPCategoryOfProjectiveGradedLeftModulesObject( [[[-1,-1],1]], CoxRing( P1xP1 ) );
#! <A projective graded left module of rank 1>
VPrime := ApplyFunctor( EmbeddingOfProjCategory( CapCategory( VPrime ) ), VPrime );
#! <A graded left module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 0, 1 ], [ 1, 0 ], [ 1, 0 ], [ 0, 1 ] ])>

#! @EndExample




#! @Subsection Examples for cohomology computations on P1

#! Note that these computations still rely on the GradedModules package and thus do not yet use CAP.
#! This will hopefully change soon.

#! @Example
H0OnProjectiveSpaceViaLinearRegularity( P1, C );
#! 1
H0OnProjectiveSpaceInRangeViaLinearRegularity( P1, C, [ 0 .. 5 ] );
#! [ [ 0, 1 ], [ 1, 2 ], [ 2, 3 ], [ 3, 4 ], [ 4, 5 ], [ 5, 6 ] ]
#! @EndExample