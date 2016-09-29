#! @Chapter Sheaf cohomology via the theorem of Greg. Smith for the package GradedModules

#! @Section Sheaf cohomology via the theorem of Greg. Smith for GradedModules: Examples 

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
C := IrrelevantIdeal( P1 );
#! <A graded torsion-free (left) ideal given by 2 generators>
P1xP1 := P1 * P1;
#! <A toric variety of dimension 2 which is a product of 2 toric varieties>
ByASmallerPresentation( ClassGroup( P1xP1 ) );
#! <A free left module of rank 2 on free generators>
C2 := IrrelevantIdeal( P1xP1 );
#! <A graded torsion-free (left) ideal given by 4 generators>
V := FreeLeftModuleWithDegrees( [[-1,-1],[2,0]], CoxRing( P1xP1 ) );
#! <A graded free left module of rank 2 on free generators>
VPrime := FreeLeftModuleWithDegrees( [[-1,-1]], CoxRing( P1xP1 ) );
#! <A graded free left module of rank 1 on a free generator>
HiByGS( P1, C, 0 );
#! Found integer: 1
#! [ 1, <A vector space object over Q of dimension 1> ]
HiByGS( P1xP1, C2, 0 );
#! Found integer: 1
#! [ 1, <A vector space object over Q of dimension 1> ]
HiByGS( P1xP1, V, 0 );
#! Found integer: 1
#! [ 1, <A vector space object over Q of dimension 4> ]
HiByGS( P1xP1, VPrime, 0 );
#! Found integer: 0
#! [ 0, <A vector space object over Q of dimension 4> ]
AllCohomologiesByGS( P1, C );
#! Found integer: 1
#! Computation finished for i=0
#! An object in Category of matrices over Q.
#! ...
#! Computation finished for i=1
#! An object in Category of matrices over Q.
#! ...
#! [ 1, [ [ 0, <A vector space object over Q of dimension 1> ],
#!        [ 1, <A vector space object over Q of dimension 0> ] ] ]
AllCohomologiesByGS( P1xP1, C2 );
#! Found integer: 1
#! Computation finished for i=0
#! An object in Category of matrices over Q.
#! ...
#! Computation finished for i=1
#! An object in Category of matrices over Q.
#! ...
#! Computation finished for i=2
#! An object in Category of matrices over Q.
#! ...
#! [ 1, [ [ 0, <A vector space object over Q of dimension 1> ],
#!        [ 1, <A vector space object over Q of dimension 0> ],
#!        [ 2, <A vector space object over Q of dimension 0> ] ] ]
AllCohomologiesByGS( P1xP1, V );
#! Found integer: 1
#! Computation finished for i=0
#! An object in Category of matrices over Q.
#! ...
#! Computation finished for i=1
#! An object in Category of matrices over Q.
#! ...
#! Computation finished for i=2
#! An object in Category of matrices over Q.
#! ...
#! [ 1, [ [ 0, <A vector space object over Q of dimension 4> ],
#!        [ 1, <A vector space object over Q of dimension 1> ],
#!        [ 2, <A vector space object over Q of dimension 0> ] ] ]
AllCohomologiesByGS( P1xP1, VPrime );
#! Found integer: 0
#! Computation finished for i=0
#! An object in Category of matrices over Q.
#! ...
#! Computation finished for i=1
#! An object in Category of matrices over Q.
#! ...
#! Computation finished for i=2
#! An object in Category of matrices over Q.
#! ...
#! [ 0, [ [ 0, <A vector space object over Q of dimension 4> ],
#!        [ 1, <A vector space object over Q of dimension 0> ],
#!        [ 2, <A vector space object over Q of dimension 0> ] ] ]

#! @EndExample