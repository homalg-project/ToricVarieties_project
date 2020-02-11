#############################################################################
##
##  Functions.gi        SparseMatrices package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to handle sparse matrices in gap
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


InstallMethod( SaveToSMSFile,
               "a sparse matrix and a filename",
               [ IsSMSSparseMatrix, IsString ],
  function( matrix, name )
    local file, stream;
    
    # open filestream
    file := Filename( DirectoryCurrent(), name );
    stream := OutputTextFile( file, false );
    
    # Write content
    PrintTo( stream, TurnIntoSMSString( matrix ) );
    
    # close stream and signal success
    CloseStream( stream );
    return true;
    
end );


InstallMethod( ReadFromSMSFile,
               "a filename",
               [ IsString ],
  function( name )
    local file, stream, s, data, nR, nC, entries, run;
    
    # open stream
    file := Filename( DirectoryCurrent(), name );
    if not IsReadableFile( file ) then
        Error( Concatenation( "Cannot read from file ", String( file ) ) );
        return false;
    fi;
    stream := InputTextFile( file );
    
    # read header
    s := ReadLine( stream );
    Chomp( s );
    NormalizeWhitespace( s );
    s := ReplacedString( s, " ", "," );
    s := ReplacedString( s, "M", "0" );
    s := Concatenation( "[", s, "];" );
    data := EvalString( s );
    nR := data[ 1 ];
    nC := data[ 2 ];
    
    # read entries
    entries := [];
    run := true;
    while run do
        s := ReadLine( stream );
        Chomp( s );
        NormalizeWhitespace( s );
        s := ReplacedString( s, " ", "," );
        s := Concatenation( "[", s, "];" );
        data := EvalString( s );
        if ( data[ 1 ] = 0 and data[ 2 ] = 0 and data[ 3 ] = 0 ) then
            run := false;
        else
            Append( entries, [ data ] );
        fi;
    od;
    CloseStream( stream );
    
    # build matrix from the result
    return SMSSparseMatrix( nR, nC, entries );
    
end );

##############################################################################################
##
#! @Section Elementary operations of SMSSparseMatrices
##
##############################################################################################

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
        
        return Involution( UnionOfRowsOp( Involution( matrix1 ), Involution( matrix2 ) ) );
        
end );


InstallMethod( Involution,
               "a sparse matrix",
               [ IsSMSSparseMatrix ],
  function( matrix )
    local new_entries, i;
    
    # (1) do a rough transposition of the entries
    new_entries := [];
    for i in [ 1 .. Length( Entries( matrix ) ) ] do
        Append( new_entries, [ [ Entries( matrix )[ i ][ 2 ], Entries( matrix )[ i ][ 1 ], Entries( matrix )[ i ][ 3 ] ] ] );
    od;
    
    # (3) form new matrix and return it
    return SMSSparseMatrix( NumberOfColumns( matrix ), NumberOfRows( matrix ), new_entries );
    
end );

InstallMethod( Transpose,
               "a sparse matrix",
               [ IsSMSSparseMatrix ],
  function( matrix )
    
    return Involution( matrix );
    
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
