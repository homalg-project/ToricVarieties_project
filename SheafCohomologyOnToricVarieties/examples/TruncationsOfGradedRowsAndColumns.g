#! @Chapter Truncations of graded rows and columns

#! @Section Examples

#! @Subsection Truncations of graded rows and columns

LoadPackage( "SheafCohomologyOnToricVarieties" );

#! @Example
P2 := ProjectiveSpace( 2 );
#! <A projective toric variety of dimension 2>
cox_ring := CoxRing( P2 );
#! Q[x_1,x_2,x_3]
#! (weights: [ 1, 1, 1 ])
row := GradedRow( [[[2],1]], cox_ring );
#! <A graded row of rank 1>
trunc1 := DegreeXLayerOfGradedRowOrColumn( P2, row, [ -3 ] );
#! <A vector space embedded into (Q[x_1,x_2,x_3] (with weights [ 1, 1, 1 ]))^1>
Length( Generators( trunc1 ) );
#! 0
trunc2 := DegreeXLayerOfGradedRowOrColumn( P2, row, [ -1 ] );
#! <A vector space embedded into (Q[x_1,x_2,x_3] (with weights [ 1, 1, 1 ]))^1>
Length( Generators( trunc2 ) );
#! 3
#! @EndExample


#! @Subsection Formats for generators of truncations of graded rows and columns

#! @Example
row2 := GradedRow( [[[2],2]], cox_ring );
#! <A graded row of rank 2>
gens1 := GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListOfColumnMatrices
            (P2, row2, [ -1 ] );;
Length( gens1 );
#! 6
gens1[ 1 ];
#! <A 2 x 1 matrix over a graded ring>
Display( gens1[ 1 ] );
#! x_1,
#! 0
#! (over a graded ring)
Display( gens1[ 4 ] );
#! 0,
#! x_1
#! (over a graded ring)
gens2 := GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListsOfRecords
            (P2, row2, [ -1 ] );
#! [ 6, [ rec( x_1 := 1, x_2 := 2, x_3 := 3 ),
#!        rec( x_1 := 4, x_2 := 5, x_3 := 6 ) ] ]
gens3 := GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsUnionOfColumnMatrices
            (P2, row2, [ -1 ] );
#! <A 2 x 6 mutable matrix over a graded ring>
Display( gens3 );
#! x_1,x_2,x_3,0,  0,  0, 
#! 0,  0,  0,  x_1,x_2,x_3
#! (over a graded ring)
gens4 := GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListList
            (P2, row2, [ -1 ] );
#! [ [ 1, x_1 ], [ 1, x_2 ], [ 1, x_3 ], [ 2, x_1 ], [ 2, x_2 ], [ 2, x_3 ] ]
#! @EndExample

#! @Subsection Truncatons of morphisms of graded rows and columns

#! @Example
source := GradedRow( [[[-1],1]], cox_ring );
#! <A graded row of rank 1>
range := GradedRow( [[[0],1]], cox_ring );
#! <A graded row of rank 1>
trunc_generators := GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListsOfRecords
                     (P2, range, [ 2 ] );
#! [ 6, [ rec( ("x_1*x_2") := 2, ("x_1*x_3") := 4, ("x_1^2") := 1,
#!             ("x_2*x_3") := 5, ("x_2^2") := 3, ("x_3^2") := 6 ) ] ]
vars := IndeterminatesOfPolynomialRing( cox_ring );;
matrix := HomalgMatrix( [[ vars[ 1 ] ]], cox_ring );
#! <A 1 x 1 matrix over a graded ring>
mor := GradedRowOrColumnMorphism( source, matrix, range );
#! <A morphism in Category of graded rows over
#! Q[x_1,x_2,x_3] (with weights [ 1, 1, 1 ])>
IsWellDefined( mor );
#! true
trunc_mor := TruncateGradedRowOrColumnMorphism( P2, mor, [ 2 ] );
#! <A morphism in Category of matrices over Q (with weights [ 1 ])>
Display( UnderlyingMatrix( trunc_mor ) );
#! 1,0,0,0,0,0,
#! 0,1,0,0,0,0,
#! 0,0,0,1,0,0 
#! (over a graded ring)
matrix2 := HomalgMatrix( [[ 1/2*vars[ 1 ] ]], cox_ring );
#! <A 1 x 1 matrix over a graded ring>
mor2 := GradedRowOrColumnMorphism( source, matrix2, range );
#! <A morphism in Category of graded rows over
#! Q[x_1,x_2,x_3] (with weights [ 1, 1, 1 ])>
IsWellDefined( mor2 );
#! true
trunc_mor2 := TruncateGradedRowOrColumnMorphism( P2, mor2, [ 2 ] );
#! <A morphism in Category of matrices over Q (with weights [ 1 ])>
Display( UnderlyingMatrix( trunc_mor2 ) );
#! 1/2,0,0,0,0,0,
#! 0,1/2,0,0,0,0,
#! 0,0,0,1/2,0,0 
#! (over a graded ring)
#! @EndExample


#! @Subsection Truncatons of morphisms of graded rows and columns in parallel

#! @Example
trunc_mor_parallel := TruncateGradedRowOrColumnMorphismInParallel
                                              ( P2, mor, [ 2 ], 2 );
#! <A morphism in Category of matrices over Q (with weights [ 1 ])>
Display( UnderlyingMatrix( trunc_mor_parallel ) );
#! 1,0,0,0,0,0,
#! 0,1,0,0,0,0,
#! 0,0,0,1,0,0
#! (over a graded ring)
trunc_mor2_parallel := TruncateGradedRowOrColumnMorphismInParallel
                                              ( P2, mor2, [ 2 ], 2 );
#! <A morphism in Category of matrices over Q (with weights [ 1 ])>
Display( UnderlyingMatrix( trunc_mor2_parallel ) );
#! 1/2,0,0,0,0,0,
#! 0,1/2,0,0,0,0,
#! 0,0,0,1/2,0,0
#! (over a graded ring)
trunc_mor2_parallel2 := TruncateGradedRowOrColumnMorphismInParallel
                                              ( P2, mor2, [ 10 ], 3 );;
IsWellDefined( trunc_mor2_parallel2 );
#! true
NrRows( UnderlyingMatrix( trunc_mor2_parallel2 ) );
#! 55
NrColumns( UnderlyingMatrix( trunc_mor2_parallel2 ) );
#! 66
#! @EndExample
