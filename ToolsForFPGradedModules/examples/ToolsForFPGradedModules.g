#! @Chapter Tools for FPGradedModules

#! @Section Example: Ideal, minimal free resolution and Betti table

LoadPackage( "ToolsForFPGradedModules" );

#! @Example
HOMALG_IO.show_banners := false;;
HOMALG_IO.suppress_PID := true;;
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
FullInformation( resolution );
#! [ [ -1, 3 ] ]
#!  ^ 
#!  | 
#! 0,   -x_3,x_2,
#! -x_3,0,   x_1,
#! -x_2,x_1, 0   
#! (over a graded ring)
#!  | 
#! [ [ -2, 3 ] ]
#!  ^ 
#!  | 
#! x_1,-x_2,x_3
#! (over a graded ring)
#!  | 
#! [ [ -3, 1 ] ]
#!
IR_right := TurnIntoFpGradedRightModule( IR );;
resolution_right := MinimalFreeResolutionForCAP( IR_right );
#! <An object in Complex category of Category of graded
#! columns over Q[x_1,x_2,x_3] (with weights [ 1, 1, 1 ])>
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
