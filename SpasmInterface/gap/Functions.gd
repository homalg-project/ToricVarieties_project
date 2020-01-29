#############################################################################
##
##  Functions.gd        SpasmInterface package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to communicate with the software Spasm
##
#! @Chapter Functionality of Spasm
##
#############################################################################



##############################################################################################
##
#! @Section Elementary manipulations of SMSSparseMatrices
##
##############################################################################################

#! @Description
#! Turn an SMSSparseMatrix M into a string used as input for Spasm
#! @Returns String
#! @Arguments SMSSparseMatrix M
DeclareOperation( "TurnIntoSMSString",
                  [ IsSMSSparseMatrix ] );

#! @Description
#! This functions forms the union of the rows of two SMSSparseMatrices M1, M2.
#! @Returns SMSSparseMatrix
#! @Arguments SMSSparseMatrices M1, M2
DeclareOperation( "UnionOfRowsOp",
                  [ IsSMSSparseMatrix, IsSMSSparseMatrix ] );

#! @Description
#! This functions forms the union of the columns of two SMSSparseMatrices M1, M2.
#! @Returns SMSSparseMatrix
#! @Arguments SMSSparseMatrices M1, M2
DeclareOperation( "UnionOfColumnsOp",
                  [ IsSMSSparseMatrix, IsSMSSparseMatrix ] );

#! @Description
#! This function forms the involution or transposition of a SMSSparseMatrix M.
#! Note that this operation is always performed modulo 42013 in spasm.
#! @Returns SMSSparseMatrix
#! @Arguments SparseMatrix M
DeclareOperation( "Involution",
                  [ IsSMSSparseMatrix ] );

#! @Description
#! This function forms a new SMSSparseMatrix from all rows of an SMSSparseMatrix M
#! whose index is contained in the list L
#! @Returns SMSSparseMatrix
#! @Arguments SparseMatrix M, List of indices L
DeclareOperation( "CertainRows",
                  [ IsSMSSparseMatrix, IsList ] );

#! @Description
#! This function forms a new SMSSparseMatrix from all columns of an SMSSparseMatrix M
#! whose index is contained in the list L
#! @Returns SMSSparseMatrix
#! @Arguments SparseMatrix M, List of indices L
DeclareOperation( "CertainColumns",
                  [ IsSMSSparseMatrix, IsList ] );

#! @Description
#! This function adds the columns of a given SMSSparseMatrix
#! @Returns List
#! @Arguments SparseMatrix M
DeclareOperation( "SumOfColumns",
                  [ IsSMSSparseMatrix ] );

#! @Description
#! This function adds the rows of a given SMSSparseMatrix
#! @Returns List
#! @Arguments SparseMatrix M
DeclareOperation( "SumOfRows",
                  [ IsSMSSparseMatrix ] );

#! @Description
#! This function picks N columns a given SMSSparseMatrix 
#! by random and sums the absolute values of their entries.
#! @Returns List
#! @Arguments SparseMatrix M, integer N
DeclareOperation( "SumEntriesOfSomeColumns",
                  [ IsSMSSparseMatrix, IsInt ] );

#! @Description
#! This function picks N rows a given SMSSparseMatrix 
#! by random and sums the absolute values of their entries.
#! @Returns List
#! @Arguments SparseMatrix M, integer N
DeclareOperation( "SumEntriesOfSomeRows",
                  [ IsSMSSparseMatrix, IsInt ] );

##############################################################################################
##
#! @Section Attributes of SMSSparseMatrices
##
##############################################################################################

#! @Description
#! This function accepts a SMSSparseMatrix M and finds all non-zero rows of this matrix.
#! @Returns List
#! @Arguments SparseMatrix M
DeclareAttribute( "NonZeroRows",
                  IsSMSSparseMatrix );
                  
#! @Description
#! This function accepts a SMSSparseMatrix M and finds all non-zero columns of this matrix.
#! @Returns List
#! @Arguments SparseMatrix M
DeclareAttribute( "NonZeroColumns",
                  IsSMSSparseMatrix );


##############################################################################################
##
#! @Section Computation of syzygies
##
##############################################################################################

#! @Description
#! Compute left kernel of SMSSparseMatrix M by Spasm.
#! By default we compute it over the finite field of order 42013.
#! @Returns SMSSparseMatrix
#! @Arguments SMSSparseMatrix M
DeclareOperation( "SyzygiesOfRowsBySpasm",
                  [ IsSMSSparseMatrix ] );

#! @Description
#! Compute left kernel of SMSSparseMatrix M by Spasm.
#! The third argument is a prime number and specifies
#! in which finite field we perform this computation.
#! @Returns SMSSparseMatrix
#! @Arguments SMSSparseMatrix M
DeclareOperation( "SyzygiesOfRowsBySpasm",
                  [ IsSMSSparseMatrix, IsInt ] );

#! @Description
#! This function computes the SyzygyGenerators of two SMSSparseMatrices M1, M2.
#! By default we compute it over the finite field of order 42013.
#! @Returns SMSSparseMatrix
#! @Arguments SparseMatrices M1, M2
DeclareOperation( "RowSyzygiesGenerators",
                  [ IsSMSSparseMatrix, IsSMSSparseMatrix ] );

#! @Description
#! This function computes the SyzygyGenerators of two SMSSparseMatrices M1, M2
#! The third argument is a prime number and specifies
#! in which finite field we perform this computation.
#! @Returns SMSSparseMatrix
#! @Arguments SparseMatrices M1, M2
DeclareOperation( "RowSyzygiesGenerators",
                  [ IsSMSSparseMatrix, IsSMSSparseMatrix, IsInt ] );


##############################################################################################
##
#! @Section Computation of rank
##
##############################################################################################

#! @Description
#! Compute the rank of an SMSSparseMatrix M by Spasm.
#! By default we compute it over the finite field of order 42013.
#! @Returns Integer
#! @Arguments SMSSparseMatrix M
DeclareOperation( "RankBySpasm",
                  [ IsSMSSparseMatrix ] );

#! @Description
#! Compute the rank of an SMSSparseMatrix M by Spasm.
#! The second argument is a prime number and specifies
#! in which finite field we perform this computation.
#! @Returns Integer
#! @Arguments SMSSparseMatrix M
DeclareOperation( "RankBySpasm",
                  [ IsSMSSparseMatrix, IsInt ] );
