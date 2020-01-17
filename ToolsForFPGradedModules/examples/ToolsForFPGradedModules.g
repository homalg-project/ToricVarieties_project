#! @Chapter Tools for FPGradedModules

#! @Section Example: Minimal free resolution and Betti table

LoadPackage( "ToolsForFPGradedModules" );

#! @Example
Q := HomalgFieldOfRationalsInSingular();
#! Q
S := GradedRing( Q * "x_1, x_2, x_3" );
#! Q[x_1,x_2,x_3]
#! (weights: yet unset)
SetWeightsOfIndeterminates( S, [[1],[1],[1]] );
#!
vars := IndeterminatesOfPolynomialRing( S );;
IR := LeftIdealForCAP( [ vars[ 1 ], vars[ 2 ], vars[ 3 ] ], S );;
IsWellDefined( IR );
#! true
resolution := MinimalFreeResolutionForCAP( IR );
#! <An object in Complex category of Category of graded
#! rows over Q[x_1,x_2,x_3] (with weights [ 1, 1, 1 ])>
differential_function :=
                    UnderlyingZFunctorCell( resolution )!.differential_func;
#! function( i ) ... end
IsWellDefined( differential_function( -1 ) );
#! true
IsWellDefined( differential_function( -2 ) );
#! true
IsWellDefined( differential_function( -3 ) );
#! true
BT := BettiTableForCAP( IR );
#! [ [ -1, -1, -1 ], [ -2, -2, -2 ], [ -3 ] ]
#! @EndExample
