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
#! This function forms the involution or transposition of a SMSSparseMatrix M.
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
#! Compute left kernel of SMSSparseMatrix M by Spasm
#! @Returns SMSSparseMatrix
#! @Arguments SMSSparseMatrix M
DeclareOperation( "SyzygiesOfRowsBySpasm",
                  [ IsSMSSparseMatrix ] );

#! @Description
#! This function computes the SyzygyGenerators of two SMSSparseMatrices M1, M2
#! @Returns SMSSparseMatrix
#! @Arguments SparseMatrices M1, M2
DeclareOperation( "SyzygiesGenerators",
                  [ IsSMSSparseMatrix, IsSMSSparseMatrix ] );
