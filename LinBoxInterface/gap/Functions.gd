#############################################################################
##
##  Functions.gd        LinBoxInterface package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to communicate with the software LinBox
##
#! @Chapter Functionality of Linbox
##
#############################################################################


##############################################################################################
##
#! @Section Computation of syzygies
##
##############################################################################################

#! @Description
#! Compute right kernel of SMSSparseMatrix M by Linbox.
#! @Returns SMSSparseMatrix
#! @Arguments SMSSparseMatrix M
DeclareOperation( "SyzygiesOfColumnsByLinbox",
                  [ IsSMSSparseMatrix ] );
                  
DeclareOperation( "ColumnSyzygiesGeneratorsByLinbox",
                  [ IsSMSSparseMatrix, IsSMSSparseMatrix ] );
