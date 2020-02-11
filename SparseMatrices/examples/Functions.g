#! @Chapter Functionality

#! @Section Examples

LoadPackage( "SparseMatrices" );

#! We can create sparse matrices and compute their syzygies of rows, i.e. their left kernels as follows:

#! @Example
entries1 := [ [ 1, 1, 1 ], [ 2, 1, -1 ], [ 3, 2, 1 ] ];;
m1 := SMSSparseMatrix( 3, 2, entries1 );;
NumberOfRows( m1 );
#! 3
NumberOfColumns( m1 );
#! 2
Entries( m1 );
#! [ [ 1, 1, 1 ], [ 2, 1, -1 ], [ 3, 2, 1 ] ]
TurnIntoSMSString( m1 );;
#! @EndExample

#! Here is another example.

#! @Example
entries2 := [ [ 1, 2, 1 ], [ 2, 1, 1 ], [ 2, 2, 1 ], [ 3, 1, -1 ], [ 3, 2, 1 ] ];;
m2 := SMSSparseMatrix( 3, 2, entries2 );;
NumberOfRows( m2 );
#! 3
NumberOfColumns( m2 );
#! 2
TurnIntoSMSString( m2 );;
#! @EndExample

#! Given two sparse matrices, we can stack them in that we take the collection formed from their union of rows and interpret the result as a new sparse matrix. This is also used to compute
#! the relative syzygies of a matrix $m1$ with respect to a second matrix $m2$. We demonstrate this with the above two matrices:

#! @Example
m3 := UnionOfRowsOp( m1, m2 );;
NumberOfRows( m3 );
#! 6
NumberOfColumns( m3 );
#! 2
#! @EndExample

#! We can also pick certain rows and columns and compute the transposed matrix.

#! @Example
m5 := CertainRows( m3, [ 1 ] );
#! <A 1x2 sparse matrix in SMS-format>
m6 := CertainColumns( m3, [ 2 ] );
#! <A 6x1 sparse matrix in SMS-format>
m7 := Involution( m6 );
#! <A 1x6 sparse matrix in SMS-format>
#! @EndExample

#! Also transposition of sparse matrices is supported.
#! @Example
m12 := Involution( m1 );
#! <A 2x3 sparse matrix in SMS-format>
#! @EndExample

#! We can also form sums of rows and columns. Here are some examples
#! @Example
SumOfRows( m2 );
#! [ 0, 3 ]
SumOfColumns( m2 );
#! [ 1, 2, 0 ]
SumEntriesOfSomeRows( m2, 2 );;
SumEntriesOfSomeColumns( m2, 2 );;
#! @EndExample

#! We can also multiply sparse matrices. This works as follows:
#! @Example
Involution( m12 ) * m12;
#! <A 3x3 sparse matrix in SMS-format>
#! @EndExample
