##########################################################################################
##
##  SparseMatrices.gd         SparseMatrices package
##
##  Copyright 2020            Martin Bies,    University of Oxford
##
#! @Chapter Sparse matrices
##
#########################################################################################


##############################################################################################
##
#! @Section GAP category for sparse matrices in SMS format
##
##############################################################################################

#! @Description
#! The GAP category for sparse matrices in SMS format
#! @Returns true or false
#! @Arguments object
DeclareCategory( "IsSMSSparseMatrix",
                 IsObject );


##############################################################################################
##
#! @Section Constructors for SMSSparseMatrices
##
##############################################################################################

#! @Description
#! The arguments are two integers -- the number of rows and columns -- and a list L of the
#! non-zero entries of the matrix. For example L = [ [ 1,1,2], [ 2,1,3] ] describes a matrix
#! which at position (1,1) has value 2 and at position (2,1) the value 3.
#! @Returns a SMSSparseMatrix
#! @Arguments nR, nC, entries
DeclareOperation( "SMSSparseMatrix",
                  [ IsInt, IsInt, IsList ] );


##############################################################################################
##
#! @Section Attributes for SMSSparseMatrices
##
##############################################################################################

#! @Description
#! The argument is a SMSSparseMatrix. The output is its number of rows.
#! @Returns an integer
#! @Arguments M
DeclareAttribute( "NumberOfRows",
                  IsSMSSparseMatrix );

#! @Description
#! The argument is a SMSSparseMatrix. The output is its number of columns.
#! @Returns an integer
#! @Arguments M
DeclareAttribute( "NumberOfColumns",
                  IsSMSSparseMatrix );

#! @Description
#! The argument is a SMSSparseMatrix. The output is the list of its entries.
#! @Returns a list
#! @Arguments M
DeclareAttribute( "Entries",
                  IsSMSSparseMatrix );


###############################
##
#! @Section Convenience methods
##
###############################

#! @Description
#! The argument is an SMSSparseMatrix. This method displays this sparse matrix in great detail.
#! @Returns detailed information about sparse matrix M
#! @Arguments M
DeclareOperation( "FullInformation",
                 [ IsSMSSparseMatrix ] );
