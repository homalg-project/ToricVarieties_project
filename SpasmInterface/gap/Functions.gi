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
## Section Computation of syzygies
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


InstallMethod( RowSyzygiesGeneratorsBySpasm,
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

InstallMethod( RowSyzygiesGeneratorsBySpasm,
               "two sparse matrices",
               [ IsSMSSparseMatrix, IsSMSSparseMatrix ],
  function( matrix1, matrix2 )
    
    return RowSyzygiesGeneratorsBySpasm( matrix1, matrix2, 42013 );
    
end );

InstallMethod( ColumnSyzygiesGeneratorsBySpasm,
               "two sparse matrices",
               [ IsSMSSparseMatrix, IsSMSSparseMatrix ],
  function( matrix1, matrix2 )
    
    return Involution( RowSyzygiesGeneratorsBySpasm( Involution( matrix1 ), Involution( matrix2 ), 42013 ) );
    
end );

InstallMethod( ColumnSyzygiesGeneratorsBySpasm,
               "two sparse matrices",
               [ IsSMSSparseMatrix, IsSMSSparseMatrix, IsInt ],
  function( matrix1, matrix2, prime )
    
    return Involution( RowSyzygiesGeneratorsBySpasm( Involution( matrix1 ), Involution( matrix2 ), prime ) );
    
end );

##############################################################################################
##
## Section Computation of rank
##
##############################################################################################

InstallMethod( RankGPLUBySpasm,
               "a sparse matrix",
               [ IsSMSSparseMatrix, IsInt ],
  function( matrix, p )
    local prime, output_string;
    
    if not IsPrimeInt( p ) then
        prime := NextPrimeInt( p );
    else
        prime := p;
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

InstallMethod( RankDenseBySpasm,
               "a sparse matrix",
               [ IsSMSSparseMatrix, IsInt ],
  function( matrix, p )
    local prime, output_string;
    
    if not IsPrimeInt( p ) then
        prime := NextPrimeInt( p );
    else
        prime := p;
    fi;
    
    # Compute kernel matrix by SPASM
    output_string := ExecuteSpasm( FindSpasmDirectory( ), "rank_dense", TurnIntoSMSString( matrix ), [ "--modulus" ], [ String( 42013 ) ] );
    
    # 'Polish' the output string
    output_string := SplitString( output_string, "=" )[ 2 ];
    output_string := SplitString( output_string, "[" )[ 1 ];
    
    # Return the rank
    return EvalString( output_string );
    
end );

InstallMethod( RankDenseBySpasm,
               "a sparse matrix",
               [ IsSMSSparseMatrix ],
  function( matrix )
    
    return RankDenseBySpasm( matrix, 42013 );
    
end );

InstallMethod( RankHybridBySpasm,
               "a sparse matrix",
               [ IsSMSSparseMatrix, IsInt ],
  function( matrix, p )
    local prime, output_string;
    
    if not IsPrimeInt( p ) then
        prime := NextPrimeInt( p );
    else
        prime := p;
    fi;
    
    # Compute kernel matrix by SPASM
    output_string := ExecuteSpasm( FindSpasmDirectory( ), "rank_hybrid", TurnIntoSMSString( matrix ), [ "--modulus" ], [ String( 42013 ) ] );
    
    # 'Polish' the output string
    output_string := SplitString( output_string, "=" )[ 2 ];
    output_string := SplitString( output_string, "[" )[ 1 ];
    
    # Return the rank
    return EvalString( output_string );
    
end );

InstallMethod( RankHybridBySpasm,
               "a sparse matrix",
               [ IsSMSSparseMatrix ],
  function( matrix )
    
    return RankHybridBySpasm( matrix, 42013 );
    
end );
