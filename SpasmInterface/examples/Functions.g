#! @Chapter Functionality of Spasm

#! @Section Examples

LoadPackage( "SpasmInterface" );

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
s1 := TurnIntoSMSString( m1 );;
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

#! We can also pick certain rows and columns and compute the transposed matrix.

#! @Example
m5 := CertainRows( m3, [ 1 ] );
#! <A 1x2 sparse matrix in SMS-format>
m6 := CertainColumns( m3, [ 2 ] );
#! <A 6x1 sparse matrix in SMS-format>
m7 := Involution( m6 );
#! <A 1x6 sparse matrix in SMS-format>
#! @EndExample


#! Finally let us create a matrix with trivial columns and rows. We can identify and strip these. Also, after minor modifications, they are taken into account by Spasm when computing kernels.

#! @Example
entries3 := [ [ 1, 1, 1 ], [ 1, 2, 1 ], [ 1, 3, -1 ], [ 3, 2, 1 ] ];;
m8 := SMSSparseMatrix( 3, 4, entries3 );
#! <A 3x4 sparse matrix in SMS-format>
m9 := NonZeroRows( m8 );
#! [ 1,3 ]
m10 := NonZeroColumns( m8 );
#! [ 1,2,3 ]
m11 := SyzygiesOfRowsBySpasm( m8 );
#! <A 1x3 sparse matrix in SMS-format>
#! @EndExample

#! Also transposition of sparse matrices is supported by spasms. As of this writing, this will always be performed modulo 42013.
#! @Example
m12 := Involution( m1 );
#! <A 2x3 sparse matrix in SMS-format>
#! @EndExample

#! We can also add rows and columns. Here are some examples
#! @Example
SumOfRows( m2 );
#! [ 0, 3 ]
SumOfColumns( m2 );
#! [ 1, 2, 0 ]
SumEntriesOfSomeRows( m2, 2 );;
SumEntriesOfSomeColumns( m2, 2 );;
#! @EndExample
