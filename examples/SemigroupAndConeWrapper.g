#! @Chapter Wrapper for generators of semigroups and hyperplane constraints of cones

LoadPackage( "SheafCohomologyOnToricVarieties" );;

####################################################
#! @Section Examples
####################################################

#! The following commands are used to handle generators of semigroups in $\mathbb{Z}^n$, generators of cones in $\mathbb{Z}^n$
#! as well as hyperplane constraints that define cones in $\mathbb{Z}^n$. Here are some examples:

#! @Example
semigroup1 := SemigroupForPresentationsByProjectiveGradedModules(
              [[ 1,0 ], [ 1,1 ]] );
#! <A cone-semigroup in Z^2 formed as the span of 2 generators>
IsSemigroupForPresentationsByProjectiveGradedModules( semigroup1 );
#! true
GeneratorList( semigroup1 );
#! [ [ 1, 0 ], [ 1, 1 ] ]
semigroup2 := SemigroupForPresentationsByProjectiveGradedModules(
              [[ 2,0 ], [ 1,1 ]] );
#! <A non-cone semigroup in Z^2 formed as the span of 2 generators>
IsSemigroupForPresentationsByProjectiveGradedModules( semigroup2 );
#! true
GeneratorList( semigroup2 );
#! [ [ 2, 0 ], [ 1, 1 ] ]
#! @EndExample

#! We can check if a semigroup in $\mathbb{Z}^n$ is the semigroup of a cone. In case we can look at an H-presentation
#! of this cone.

#! @Example
IsSemigroupOfCone( semigroup1 );
#! true
ConeHPresentationList( semigroup1 );
#! [ [ 0, 1 ], [ 1, -1 ] ]
Display( ConeHPresentationList( semigroup1 ) );
#! [ [   0,  1 ],
#!   [   1, -1 ] ]
IsSemigroupOfCone( semigroup2 );
#! false
HasConeHPresentationList( semigroup2 );
#! false
#! @EndExample

#! We can check membership of points in semigroups.

#! @Example
PointContainedInSemigroup( semigroup2, [ 1,0 ] );
#! false
PointContainedInSemigroup( semigroup2, [ 2,0 ] );
#! true
#! @EndExample

#! Given a semigroup $S \subseteq \mathbb{Z}^n$ and a point $p \in \mathbb{Z}^n$ we can consider
#! $$ H := p + S = \left\{ p + x \; , \; x \in S \right\}. $$
#! We term this an affine semigroup. Given that $S = C \cap \mathbb{Z}^n$ for a cone $C \subseteq \mathbb{Z}^n$, we use
#! the term affine cone_semigroup. The constructors are as follows:

#! @Example
affine_semigroup1 := AffineSemigroupForPresentationsByProjectiveGradedModules(
                     semigroup1, [ -1, -1 ] );
#! <A non-trivial affine cone-semigroup in Z^2>
affine_semigroup2 := AffineSemigroupForPresentationsByProjectiveGradedModules(
                     semigroup2, [ 2, 2 ] );
#! <A non-trivial affine non-cone semigroup in Z^2>
#! @EndExample

#! We can access the properties of these affine semigroups as follows.

#! @Example
IsAffineSemigroupOfCone( affine_semigroup2 );
#! false
UnderlyingSemigroup( affine_semigroup2 );
#! <A non-cone semigroup in Z^2 formed as the span of 2 generators>
Display( UnderlyingSemigroup( affine_semigroup2 ) );
#! A non-cone semigroup in Z^2 formed as the span of 2 generators -
#! generators are as follows:
#! [ [  2,  0 ],
#!   [  1,  1 ] ]
IsAffineSemigroupOfCone( affine_semigroup1 );
#! true
Offset( affine_semigroup2 );
#! [ 2, 2 ]
ConeHPresentationList( UnderlyingSemigroup( affine_semigroup1 ) );
#! [ [ 0, 1 ], [ 1, -1 ] ]
#! @EndExample

#! Of course we can also decide membership in affine (cone_)semigroups.

#! @Example
Display( affine_semigroup1 );
#! A non-trivial affine cone-semigroup in Z^2
#! Offset: [ -1, -1 ]
#! Hilbert basis: [ [ 1, 0 ], [ 1, 1 ] ]
PointContainedInAffineSemigroup( affine_semigroup1, [ -2,-2 ] );
#! false
PointContainedInAffineSemigroup( affine_semigroup1, [ 3,1 ] );
#! true
Display( affine_semigroup2 );
#! A non-trivial affine non-cone semigroup in Z^2
#! Offset: [ 2, 2 ]
#! Semigroup generators: [ [ 2, 0 ], [ 1, 1 ] ]
PointContainedInAffineSemigroup( affine_semigroup2, [ 3,2 ] );
#! false
PointContainedInAffineSemigroup( affine_semigroup2, [ 3,3 ] );
#! true
#! @EndExample
