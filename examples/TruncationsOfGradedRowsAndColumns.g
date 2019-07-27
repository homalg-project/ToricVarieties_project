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
trunc1 := DegreeXLayerOfGradedRowOrColumn( P2, row, [ 1 ] );
#! <A vector space embedded into (Q[x_1,x_2,x_3] (with weights [ 1, 1, 1 ]))^1>
Length( Generators( trunc1 ) );
#! 0
trunc2 := DegreeXLayerOfGradedRowOrColumn( P2, row, [ 3 ] );
#! <A vector space embedded into (Q[x_1,x_2,x_3] (with weights [ 1, 1, 1 ]))^1>
Length( Generators( trunc2 ) );
#! 3
#! @EndExample


#! @Subsection Formats for generators of truncations of graded rows and columns

#! @Example
row2 := GradedRow( [[[2],2]], cox_ring );
#! <A graded row of rank 2>
gens1 := GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListOfColumnMatrices
            (P2, row2, [ 3 ] );;
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
            (P2, row2, [ 3 ] );
#! [ 6, [ rec( x_1 := 1, x_2 := 2, x_3 := 3 ),
#!        rec( x_1 := 4, x_2 := 5, x_3 := 6 ) ] ]
gens3 := GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsUnionOfColumnMatrices
            (P2, row2, [ 3 ] );
#! <A 2 x 6 mutable matrix over a graded ring>
Display( gens3 );
#! x_1,x_2,x_3,0,  0,  0, 
#! 0,  0,  0,  x_1,x_2,x_3
#! (over a graded ring)
gens4 := GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListList
            (P2, row2, [ 3 ] );
#! [ [ 1, x_1 ], [ 1, x_2 ], [ 1, x_3 ], [ 2, x_1 ], [ 2, x_2 ], [ 2, x_3 ] ]
#! @EndExample

#! @Subsection Truncatons of morphisms of graded rows and columns
