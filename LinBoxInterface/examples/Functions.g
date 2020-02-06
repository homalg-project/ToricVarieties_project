#! @Chapter Functionality of Linbox

#! @Section Examples

LoadPackage( "LinBoxInterface" );

#! We can compute kernels with Linbox.

#! @Example
m1 := SMSSparseMatrix( 2, 3, [ [1,1,1],[1,2,1] ] );
#! <A 2x3 sparse matrix in SMS-format>
NumberOfRows( m1 );
#! 2
NumberOfColumns( m1 );
#! 3
Entries( m1 );
#! [ [ 1, 1, 1 ], [ 1, 2, 1 ] ]
k1 := SyzygiesOfColumnsByLinbox( m1 );
#! <A 3x2 sparse matrix in SMS-format>
#! @EndExample

#! We can also compute relative syzygies.

#! @Example
m2 := ColumnSyzygiesGeneratorsByLinbox( m1, m1 );
#! <A 3x5 sparse matrix in SMS-format>
#! @EndExample

#! We can also compute ranks as follows:

#! @Example
RankByLinbox( m1 );
#! 1
RankByLinbox( m2 );
#! 3
#! @EndExample
