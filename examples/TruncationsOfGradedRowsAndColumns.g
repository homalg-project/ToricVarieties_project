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
#! Something
trunc1 := DegreeXLayerOfGradedRowOrColumn( P2, row, [ 1 ] );
#! <A vector space embedded into (Q[x_1,x_2,x_3] (with weights [ 1, 1, 1 ]))^1>
Length( Generators( trunc1 ) );
#! 0
trunc2 := DegreeXLayerOfGradedRowOrColumn( P2, row, [ 3 ] );
#! <A vector space embedded into (Q[x_1,x_2,x_3] (with weights [ 1, 1, 1 ]))^1>
Length( Generators( trunc2 ) );
#! 3
#! @EndExample


#! @Subsection Truncatons of morphisms of graded rows and columns
