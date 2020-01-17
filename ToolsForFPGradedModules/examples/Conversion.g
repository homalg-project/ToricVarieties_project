#! @Chapter Tools for cohomology computations

#! @Section Examples

#! @Subsection Conversion of modules

LoadPackage( "ToolsForFPGradedModules" );

#! @Example
P1 := ProjectiveSpace( 1 );
#! <A projective toric variety of dimension 1>
P1xP1 := P1 * P1;
#! <A projective toric variety of dimension 2
#! which is a product of 2 toric varieties>
irP1xP1 := IrrelevantLeftIdealForCAP( P1xP1 );
#! <An object in Category of f.p. graded left
#! modules over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 0, 1 ], [ 1, 0 ], [ 1, 0 ], [ 0, 1 ] ])>
module2 := TurnIntoOldGradedModule( irP1xP1 );
#! <A graded left module presented by 4 relations for 4 generators>
module3 := TurnIntoCAPGradedModule( module2 );
#! <An object in Category of f.p. graded left
#! modules over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 0, 1 ], [ 1, 0 ], [ 1, 0 ], [ 0, 1 ] ])>
module3 = irP1xP1;
#! true
#! @EndExample
