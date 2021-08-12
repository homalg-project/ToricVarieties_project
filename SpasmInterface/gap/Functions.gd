#############################################################################
##
##  Functions.gd          SpasmInterface package
##                                Martin Bies
##
##  Copyright 2021      University of Pennsylvania
##
##  A package to communicate with the software Spasm
##
#! @Chapter Functionality of Spasm
##
#############################################################################


##############################################################################################
##
#! @Section Computation of syzygies
##
##############################################################################################

#! @Description
#! Compute left kernel of SMSSparseMatrix M by Spasm.
#! By default we compute it over the finite field of order 42013.
#! As second argument, an integer can be provided to overwrite this default.
#! @Returns SMSSparseMatrix
#! @Arguments SMSSparseMatrix M
DeclareOperation( "SyzygiesOfRowsBySpasm",
                  [ IsSMSSparseMatrix ] );
DeclareOperation( "SyzygiesOfRowsBySpasm",
                  [ IsSMSSparseMatrix, IsInt ] );

#! @Description
#! Compute right kernel of SMSSparseMatrix M by Spasm.
#! By default we compute it over the finite field of order 42013.
#! As second argument, an integer can be provided to overwrite this default.
#! @Returns SMSSparseMatrix
#! @Arguments SMSSparseMatrix M
DeclareOperation( "SyzygiesOfColumnsBySpasm",
                  [ IsSMSSparseMatrix ] );
DeclareOperation( "SyzygiesOfColumnsBySpasm",
                  [ IsSMSSparseMatrix, IsInt ] );

#! @Description
#! This function computes the RowSyzygyGenerators of two SMSSparseMatrices M1, M2.
#! By default we compute it over the finite field of order 42013.
#! As second argument, an integer can be provided to overwrite this default.
#! @Returns SMSSparseMatrix
#! @Arguments SparseMatrices M1, M2
DeclareOperation( "RowSyzygiesGeneratorsBySpasm",
                  [ IsSMSSparseMatrix, IsSMSSparseMatrix ] );
DeclareOperation( "RowSyzygiesGeneratorsBySpasm",
                  [ IsSMSSparseMatrix, IsSMSSparseMatrix, IsInt ] );

#! @Description
#! This function computes the ColumnSyzygyGenerators of two SMSSparseMatrices M1, M2.
#! By default we compute it over the finite field of order 42013.
#! As second argument, an integer can be provided to overwrite this default.
#! @Returns SMSSparseMatrix
#! @Arguments SparseMatrices M1, M2
DeclareOperation( "ColumnSyzygiesGeneratorsBySpasm",
                  [ IsSMSSparseMatrix, IsSMSSparseMatrix ] );
DeclareOperation( "ColumnSyzygiesGeneratorsBySpasm",
                  [ IsSMSSparseMatrix, IsSMSSparseMatrix, IsInt ] );


##############################################################################################
##
#! @Section Computation of rank
##
##############################################################################################

#! @Description
#! Compute the rank of an SMSSparseMatrix M by Spasm by GPLU.
#! By default we compute it over the finite field of order 42013.
#! As second argument, an integer can be provided to overwrite this default.
#! @Returns Integer
#! @Arguments SMSSparseMatrix M
DeclareOperation( "RankGPLUBySpasm",
                  [ IsSMSSparseMatrix ] );
DeclareOperation( "RankGPLUBySpasm",
                  [ IsSMSSparseMatrix, IsInt ] );

#! @Description
#! Compute the rank of an SMSSparseMatrix M by Spasm. This uses an
#! algorithm designed for handeling dense matrices, but is here applied to
#! a sparse matrix nonetheless. By default we compute it over the finite
#! field of order 42013. As second argument, an integer can be provided
#! to overwrite this default.
#! @Returns Integer
#! @Arguments SMSSparseMatrix M
DeclareOperation( "RankDenseBySpasm",
                  [ IsSMSSparseMatrix ] );
DeclareOperation( "RankDenseBySpasm",
                  [ IsSMSSparseMatrix, IsInt ] );

#! @Description
#! Compute the rank of an SMSSparseMatrix M by Spasm. This uses the
#! hybrid strategy described in [PASCO'17].
#! By default we compute it over the finite field of order 42013.
#! As second argument, an integer can be provided to overwrite this default.
#! @Returns Integer
#! @Arguments SMSSparseMatrix M
DeclareOperation( "RankHybridBySpasm",
                  [ IsSMSSparseMatrix ] );
DeclareOperation( "RankHybridBySpasm",
                  [ IsSMSSparseMatrix, IsInt ] );
