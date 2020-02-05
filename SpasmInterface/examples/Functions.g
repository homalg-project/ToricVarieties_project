#! @Chapter Functionality of Spasm

#! @Section Examples

LoadPackage( "SpasmInterface" );

#! We can compute syzygies of rows and columns as follows:

#! @Example
entries1 := [ [ 1, 1, 1 ], [ 2, 1, -1 ], [ 3, 2, 1 ] ];;
m1 := SMSSparseMatrix( 3, 2, entries1 );;
k1 := SyzygiesOfRowsBySpasm( m1 );;
SyzygiesOfColumnsBySpasm( m1 );;
NumberOfRows( k1 );
#! 1
NumberOfColumns( k1 );
#! 3
#! @EndExample

#! Here is another example.

#! @Example
entries2 := [ [ 1, 2, 1 ], [ 2, 1, 1 ], [ 2, 2, 1 ], [ 3, 1, -1 ], [ 3, 2, 1 ] ];;
m2 := SMSSparseMatrix( 3, 2, entries2 );;
NumberOfRows( m2 );
#! 3
NumberOfColumns( m2 );
#! 2
s2 := TurnIntoSMSString( m2 );;
k2 := SyzygiesOfRowsBySpasm( m2 );;
SyzygiesOfColumnsBySpasm( m2 );;
NumberOfRows( k2 );
#! 1
NumberOfColumns( k2 );
#! 3
#! @EndExample

#! Given two sparse matrices, we can stack them in that we take the collection formed from their union of rows and interpret the result as a new sparse matrix. This is also used to compute
#! the relative syzygies of a matrix $m1$ with respect to a second matrix $m2$. We demonstrate this with the above two matrices:

#! @Example
m3 := UnionOfRowsOp( m1, m2 );;
NumberOfRows( m3 );
#! 6
NumberOfColumns( m3 );
#! 2
m4 := RowSyzygiesGenerators( m1, m2 );
#! <A 4x3 sparse matrix in SMS-format>
ColumnSyzygiesGenerators( m1, m2 );
#! <A 2x1 sparse matrix in SMS-format>
NumberOfRows( m4 );
#! 4
NumberOfColumns( m4 );
#! 3
#! @EndExample

#! Spasm also supports various algorithms for computing ranks of sparse matrices. Here are some examples

#! @Example
RankGPLUBySpasm( m3 );
#! 2
RankDenseBySpasm( m3 );
#! 2
RankHybridBySpasm( m3 );
#! 2
#! @EndExample
