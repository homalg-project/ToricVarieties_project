#############################################################################
##
##  Functions.gi        LinBoxInterface package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to communicate with the software LinBox
##
#############################################################################


##############################################################################################
##
#! @Section Computation of syzygies
##
##############################################################################################


InstallMethod( SyzygiesOfColumnsByLinbox,
               "a sparse matrix and an integer",
               [ IsSMSSparseMatrix ],
  function( matrix )
    local output_string, data;
    
    # Compute kernel matrix by Linbox
    output_string := ExecuteLinbox( FindLinboxDirectory(), "./nullspacebasis", TurnIntoSMSString( matrix ) );
    
    # Format the output string
    output_string := Chomp( output_string ); # Remove trailing \n
    data := EvalString( output_string );
    
    # Return the result as SMSSparseMatrix
    return SMSSparseMatrix( data[ 1 ], data[ 2 ], data[ 3 ] );
    
end );


InstallMethod( ColumnSyzygiesGeneratorsByLinbox,
               "two sparse matrices and an integer",
               [ IsSMSSparseMatrix, IsSMSSparseMatrix ],
  function( matrix1, matrix2 )
    local colUnion, kernelMatrix, selection;
    
    # Compute a mutual syzygies matrix
    colUnion := UnionOfColumnsOp( matrix1, matrix2 );
    kernelMatrix := SyzygiesOfColumnsByLinbox( colUnion );
    
    # Pick only those columns corresponding to mapping into matrix1 and return this result
    return CertainRows( kernelMatrix, [ 1 .. NumberOfColumns( matrix1 ) ] );
    
end );
