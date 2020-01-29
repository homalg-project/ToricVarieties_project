#############################################################################
##
##  Functions.gi        SpasmInterface package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to communicate with the software Spasm
##
#############################################################################


##############################################################################################
##
## Install elementary functions to manipulate SMSSparseMatrices
##
##############################################################################################

InstallMethod( TurnIntoSMSString,
               "a sparse matrix",
               [ IsSMSSparseMatrix ],
  function( matrix )
    local nR, nC, entries, output_string, i;
    
    # extract data
    nR := NumberOfRows( matrix );
    nC := NumberOfColumns( matrix );
    entries := Entries( matrix );
    
    # Check for valid input
    if nR < 0 then
        Error( "Number of rows specified must be non-negative" );
    fi;
    if nC < 0 then
        Error( "Number of columns specified must be non-negative" );
    fi;
    
    # Produce SMS string
    output_string := String( Entries( matrix ) );;
    output_string := ReplacedString( output_string, "], [", "\n" );
    output_string := ReplacedString( output_string, "[ [", "" );
    output_string := ReplacedString( output_string, "] ]", "" );
    output_string := ReplacedString( output_string, ",", "" );
    output_string := Concatenation( String( nR ), " ", String( nC ), " M\n", output_string, "\n 0 0 0\n" );
    
    # Return result
    return output_string;
    
end );


InstallMethod( UnionOfRowsOp,
               "two sparse matrices",
               [ IsSMSSparseMatrix, IsSMSSparseMatrix ],
  function( matrix1, matrix2 )
    local nR1, nC1, entries1, nR2, nC2, entries2, newNR, newNC, newEntries, i;
    
    # extract data of the matrices
    nR1 := NumberOfRows( matrix1 );
    nC1 := NumberOfColumns( matrix1 );
    nR2 := NumberOfRows( matrix2 );
    nC2 := NumberOfColumns( matrix2 );
    
    # check if they can be stacked
    if nC1 <> nC2 then
        Error( "The matrices cannot be stacked as they have different numbers of columns" );
    fi;
    
    # stack them
    newNR := nR1 + nR2;
    newNC := nC1;
    entries1 := List( [ 1 .. Length( Entries( matrix1 ) ) ], i -> [ Entries( matrix1 )[ i ][ 1 ], Entries( matrix1 )[ i ][ 2 ], Entries( matrix1 )[ i ][ 3 ] ] );
    entries2 := List( [ 1 .. Length( Entries( matrix2 ) ) ], i -> [ Entries( matrix2 )[ i ][ 1 ] + nR1, Entries( matrix2 )[ i ][ 2 ], Entries( matrix2 )[ i ][ 3 ] ] );
    newEntries := entries1;
    Append( newEntries, entries2 );
    
    # return result
    return SMSSparseMatrix( newNR, newNC, newEntries );
    
end );


InstallMethod( UnionOfColumnsOp,
               "two sparse matrices",
               [ IsSMSSparseMatrix, IsSMSSparseMatrix ],
  function( matrix1, matrix2 )
    local nR1, nC1, entries1, nR2, nC2, entries2, newNR, newNC, newEntries, i;
    
    # extract data of the matrices
    nR1 := NumberOfRows( matrix1 );
    nC1 := NumberOfColumns( matrix1 );
    nR2 := NumberOfRows( matrix2 );
    nC2 := NumberOfColumns( matrix2 );
    
    # check if they can be stacked
    if nR1 <> nR2 then
        Error( "The matrices cannot be stacked as they have different numbers of rows" );
    fi;
    
    # stack them
    newNR := nR1;
    newNC := nC1 + nC2;
    entries1 := List( [ 1 .. Length( Entries( matrix1 ) ) ], i -> [ Entries( matrix1 )[ i ][ 1 ], Entries( matrix1 )[ i ][ 2 ], Entries( matrix1 )[ i ][ 3 ] ] );
    entries2 := List( [ 1 .. Length( Entries( matrix2 ) ) ], i -> [ Entries( matrix2 )[ i ][ 1 ], Entries( matrix2 )[ i ][ 2 ] + nC1, Entries( matrix2 )[ i ][ 3 ] ] );
    newEntries := entries1;
    Append( newEntries, entries2 );
    
    # return result
    return SMSSparseMatrix( newNR, newNC, newEntries );
    
end );


InstallMethod( Involution,
               "a sparse matrix",
               [ IsSMSSparseMatrix ],
  function( matrix )
    local output_string, data, number_Rows, number_Columns;

    # Compute involution by SPASM
    output_string := ExecuteSpasm( FindSpasmDirectory( ), "transpose", TurnIntoSMSString( matrix ), [ ], [ ] );
    
    # Format the output string
    output_string := Chomp( output_string ); # Remove trailing \n
    output_string := ReplacedString( output_string, "\n", "],[" );
    output_string := ReplacedString( output_string, " ", "," );
    output_string := Concatenation( "[[", output_string, "]]" );
    output_string := ReplacedString( output_string, "M", "0" ); # Remove the 'M' which indicates that we are working with matrices over the integers
    
    # Eval the resulting string and extract data from it
    data := EvalString( output_string );
    number_Rows := data[ 1 ][ 1 ];
    number_Columns := data[ 1 ][ 2 ];
    Remove( data, 1 );
    Remove( data );
    
    # Return result
    return SMSSparseMatrix( number_Rows, number_Columns, data );    
    
end );


InstallMethod( CertainRows,
               "a sparse matrix and a list of rows indices",
               [ IsSMSSparseMatrix, IsList ],
  function( matrix, row_indices )
    local nR, nC, entries, newNR, newNC, new_entries, i, newRowPos;
    
    # check for valid input
    for i in [ 1 .. Length( row_indices ) ] do
        if not ( row_indices[ i ] > 0 ) then
            Error( "All specified row indicies must be positive" );
        fi;
        if not ( row_indices[ i ] <= NumberOfRows( matrix ) ) then
            Error( "The row indicies must not exceed the number of rows of the given matrix" );
        fi;
    od;
    
    # extract data of matrix
    nR := NumberOfRows( matrix );
    nC := NumberOfColumns( matrix );
    entries := StructuralCopy( Entries( matrix ) );
    
    # now select some columns of this matrix
    newNR := Length( row_indices );
    newNC := nC;
    new_entries := [];
    for i in [ 1 .. Length( entries ) ] do
        newRowPos := Position( row_indices, entries[ i ][ 1 ] );
        if newRowPos <> fail then
            Append( new_entries, [ [ newRowPos, entries[ i ][ 2 ], entries[ i ][ 3 ] ] ] );
        fi;
    od;
    
    # return the result
    return SMSSparseMatrix( newNR, newNC, new_entries );
    
end );


InstallMethod( CertainColumns,
               "a sparse matrix and a list of column indices",
               [ IsSMSSparseMatrix, IsList ],
  function( matrix, column_indices )
    local nR, nC, entries, newNR, newNC, new_entries, i, newColPos;
    
    # check for valid input
    for i in [ 1 .. Length( column_indices ) ] do
        if not ( column_indices[ i ] > 0 ) then
            Error( "All specified column indicies must be positive" );
        fi;
        if not ( column_indices[ i ] <= NumberOfColumns( matrix ) ) then
            Error( "The column indicies must not exceed the number of columns of the given matrix" );
        fi;
    od;
    
    # extract data of matrix
    nR := NumberOfRows( matrix );
    nC := NumberOfColumns( matrix );
    entries := StructuralCopy( Entries( matrix ) );
    
    # now select some columns of this matrix
    newNR := nR;
    newNC := Length( column_indices );
    new_entries := [];
    for i in [ 1 .. Length( entries ) ] do
        newColPos := Position( column_indices, entries[ i ][ 2 ] );
        if newColPos <> fail then
            Append( new_entries, [ [ entries[ i ][ 1 ], newColPos, entries[ i ][ 3 ] ] ] );
        fi;
    od;
    
    # return the result
    return SMSSparseMatrix( newNR, newNC, new_entries );
    
end );


InstallMethod( SumOfColumns,
               "a sparse matrix",
               [ IsSMSSparseMatrix ],
  function( matrix )
    local sum, i, pos, j;
    
    # sum up all columns
    sum := [];
    for i in [ 1 .. NumberOfRows( matrix ) ] do
        
        # find all entries in the i-th row
        pos := PositionsProperty( Entries( matrix ), function( ent ) if ent[ 1 ] = i then return true; else return false; fi; end );
        
        # add these values
        if Length( pos ) > 0 then
            Append( sum, [ Sum( List( [ 1 .. Length( pos ) ], j -> Entries( matrix )[ pos[ j ] ][ 3 ] ) ) ] );
        else
            Append( sum, [ 0 ] );
        fi;
        
    od;
    
    # return the result
    return sum;
    
end );


InstallMethod( SumOfRows,
               "a sparse matrix",
               [ IsSMSSparseMatrix ],
  function( matrix )
    local sum, i, pos, j;
    
    # sum up all rows
    sum := [];
    for i in [ 1 .. NumberOfColumns( matrix ) ] do
        
        # find all entries in the i-th column
        pos := PositionsProperty( Entries( matrix ), function( ent ) if ent[ 2 ] = i then return true; else return false; fi; end );
        
        # add these values
        if Length( pos ) > 0 then
            Append( sum, [ Sum( List( [ 1 .. Length( pos ) ], j -> Entries( matrix )[ pos[ j ] ][ 3 ] ) ) ] );
        else
            Append( sum, [ 0 ] );
        fi;
        
    od;
    
    # return the result
    return sum;
    
end );


InstallMethod( SumEntriesOfSomeColumns,
               "a sparse matrix",
               [ IsSMSSparseMatrix, IsInt ],
  function( matrix, samples )
    local rs, i, cols, sum, pos, j;
    
    # pick rougly 'sample' of columns at random
    rs := RandomSource(IsMersenneTwister);
    cols := List( [ 1 .. samples ], i -> Random( rs, [ 1 .. NumberOfColumns( matrix ) ] ) );
    cols := DuplicateFreeList( cols );
    
    # and add them up
    sum := [];
    for i in cols do
        
        # find all entries in the i-th column
        pos := PositionsProperty( Entries( matrix ), function( ent ) if ent[ 2 ] = i then return true; else return false; fi; end );
        
        # add these values
        if Length( pos ) > 0 then
            Append( sum, [ Sum( List( [ 1 .. Length( pos ) ], j -> AbsoluteValue( Entries( matrix )[ pos[ j ] ][ 3 ] ) ) ) ] );
        else
            Append( sum, [ 0 ] );
        fi;
        
    od;
    
    # return the result
    return sum;
    
end );


InstallMethod( SumEntriesOfSomeRows,
               "a sparse matrix",
               [ IsSMSSparseMatrix, IsInt ],
  function( matrix, samples )
    local rs, i, cols, sum, pos, j;
    
    # pick rougly 'sample' of columns at random
    rs := RandomSource(IsMersenneTwister);
    cols := List( [ 1 .. samples ], i -> Random( rs, [ 1 .. NumberOfRows( matrix ) ] ) );
    cols := DuplicateFreeList( cols );
    
    # and add them up
    sum := [];
    for i in cols do
        
        # find all entries in the i-th column
        pos := PositionsProperty( Entries( matrix ), function( ent ) if ent[ 1 ] = i then return true; else return false; fi; end );
        
        # add these values
        if Length( pos ) > 0 then
            Append( sum, [ Sum( List( [ 1 .. Length( pos ) ], j -> AbsoluteValue( Entries( matrix )[ pos[ j ] ][ 3 ] ) ) ) ] );
        else
            Append( sum, [ 0 ] );
        fi;
        
    od;
    
    # return the result
    return sum;
    
end );


##############################################################################################
##
## Attributes of SMSSparseMatrices
##
##############################################################################################

InstallMethod( NonZeroRows,
               "a sparse matrix",
               [ IsSMSSparseMatrix ],
  function( matrix )
    local non_zeros, i;
    
    non_zeros := List( [ 1 .. NumberOfRows( matrix ) ], i -> false );
    for i in [ 1 .. Length( Entries( matrix ) ) ] do
        non_zeros[ Entries( matrix )[ i ][ 1 ] ] := true;
    od;
    
    return Filtered( [ 1 .. NumberOfRows( matrix ) ], i -> non_zeros[ i ] );
    
end );


InstallMethod( NonZeroColumns,
               "a sparse matrix",
               [ IsSMSSparseMatrix ],
  function( matrix )
    local non_zeros, i;
    
    non_zeros := List( [ 1 .. NumberOfColumns( matrix ) ], i -> false );
    for i in [ 1 .. Length( Entries( matrix ) ) ] do
        non_zeros[ Entries( matrix )[ i ][ 2 ] ] := true;
    od;
    
    return Filtered( [ 1 .. NumberOfColumns( matrix ) ], i -> non_zeros[ i ] );
    
end );


##############################################################################################
##
#! @Section Computation of syzygies
##
##############################################################################################

InstallMethod( SyzygiesOfRowsBySpasm,
               "a sparse matrix and an integer",
               [ IsSMSSparseMatrix, IsInt ],
  function( matrix, p )
    local prime, nR, nC, entries, output_string, data, number_Rows, number_Columns;
    
    if not IsPrimeInt( p ) then
        prime := NextPrimeInt( p );
    else
        prime := p;
    fi;
    
    # Extract information on the matrix
    nR := NumberOfRows( matrix );
    nC := NumberOfColumns( matrix );
    entries := Entries( matrix );
    
    # Check for valid input
    if nR < 0 then
        Error( "Number of rows specified must be non-negative" );
    fi;
    if nC < 0 then
        Error( "Number of columns specified must be non-negative" );
    fi;
    
    # Compute kernel matrix by SPASM
    output_string := ExecuteSpasm( FindSpasmDirectory( ), "kernel", TurnIntoSMSString( matrix ), [ "--matrix", "--modulus" ], [ "no-value", String( prime ) ] );
    
    # Format the output string
    output_string := Chomp( output_string ); # Remove trailing \n
    output_string := ReplacedString( output_string, "\n", "],[" );
    output_string := ReplacedString( output_string, " ", "," );
    output_string := Concatenation( "[[", output_string, "]]" );
    output_string := ReplacedString( output_string, "M", "0" ); # Remove the 'M' which indicates that we are working with matrices over the integers
    
    # Eval the resulting string and extract data from it
    data := EvalString( output_string );
    number_Rows := data[ 1 ][ 1 ];
    number_Columns := data[ 1 ][ 2 ];
    Remove( data, 1 );
    Remove( data );
    
    # Return the result as SMSSparseMatrix
    return SMSSparseMatrix( number_Rows, number_Columns, data );
    
end );

InstallMethod( SyzygiesOfRowsBySpasm,
               "a sparse matrix",
               [ IsSMSSparseMatrix ],
  function( matrix )
    local nR, nC, entries, output_string, data, number_Rows, number_Columns;

    return SyzygiesOfRowsBySpasm( matrix, 42013 );

end );


InstallMethod( SyzygiesOfColumnsBySpasm,
               "a sparse matrix",
               [ IsSMSSparseMatrix ],
  function( matrix )

    return Involution( SyzygiesOfRowsBySpasm( Involution( matrix ), 42013 ) );

end );


InstallMethod( SyzygiesOfColumnsBySpasm,
               "a sparse matrix and an integer",
               [ IsSMSSparseMatrix, IsInt ],
  function( matrix, prime )

    return Involution( SyzygiesOfRowsBySpasm( Involution( matrix ), prime ) );

end );


InstallMethod( RowSyzygiesGenerators,
               "two sparse matrices and an integer",
               [ IsSMSSparseMatrix, IsSMSSparseMatrix, IsInt ],
  function( matrix1, matrix2, p )
    local prime, rowUnion, kernelMatrix, selection;
    
    if not IsPrimeInt( p ) then
        prime := NextPrimeInt( p );
    else
        prime := p;
    fi;
    
    # Compute a mutual syzygies matrix
    rowUnion := UnionOfRowsOp( matrix1, matrix2 );
    kernelMatrix := SyzygiesOfRowsBySpasm( rowUnion, prime );
    
    # Pick only those columns corresponding to mapping into matrix1 and return this result
    return CertainColumns( kernelMatrix, [ 1 .. NumberOfRows( matrix1 ) ] );
    
end );

InstallMethod( RowSyzygiesGenerators,
               "two sparse matrices",
               [ IsSMSSparseMatrix, IsSMSSparseMatrix ],
  function( matrix1, matrix2 )
    
    return RowSyzygiesGenerators( matrix1, matrix2, 42013 );
    
end );

InstallMethod( ColumnSyzygiesGenerators,
               "two sparse matrices",
               [ IsSMSSparseMatrix, IsSMSSparseMatrix ],
  function( matrix1, matrix2 )
    
    return Involution( RowSyzygiesGenerators( Involution( matrix1 ), Involution( matrix2 ), 42013 ) );
    
end );

InstallMethod( ColumnSyzygiesGenerators,
               "two sparse matrices",
               [ IsSMSSparseMatrix, IsSMSSparseMatrix, IsInt ],
  function( matrix1, matrix2, prime )
    
    return Involution( RowSyzygiesGenerators( Involution( matrix1 ), Involution( matrix2 ), prime ) );
    
end );

##############################################################################################
##
#! @Section Computation of rank
##
##############################################################################################

InstallMethod( RankGPLUBySpasm,
               "a sparse matrix",
               [ IsSMSSparseMatrix, IsInt ],
  function( matrix, prime )
    local nR, nC, entries, output_string, data, number_Rows, number_Columns;
    
    if not IsPrime( prime ) then
        Error( "We support this operation only over finite fields Z_p with p a prime number" );
    fi;
    
    # Extract information on the matrix
    nR := NumberOfRows( matrix );
    nC := NumberOfColumns( matrix );
    entries := Entries( matrix );
    
    # Check for valid input
    if nR < 0 then
        Error( "Number of rows specified must be non-negative" );
    fi;
    if nC < 0 then
        Error( "Number of columns specified must be non-negative" );
    fi;
    
    # Compute kernel matrix by SPASM
    output_string := ExecuteSpasm( FindSpasmDirectory( ), "rank_gplu", TurnIntoSMSString( matrix ), [ "--modulus" ], [ String( prime ) ] );
    
    # 'Polish' the output string
    output_string := SplitString( output_string, "=" )[ 2 ];
    output_string := SplitString( output_string, "[" )[ 1 ];
    
    # Return the rank
    return EvalString( output_string );
    
end );


InstallMethod( RankGPLUBySpasm,
               "a sparse matrix",
               [ IsSMSSparseMatrix ],
  function( matrix )
    
    return RankGPLUBySpasm( matrix, 42013 );
    
end );
