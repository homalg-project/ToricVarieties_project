##########################################################################################
##
##  SparseMatrices.gd         SpasmInterface package
##
##  Copyright 2020            Martin Bies,    University of Oxford
##
#! @Chapter Sparse matrices
##
#########################################################################################


##############################################################################################
##
## GAP category for sparse matrices in SMS format
##
##############################################################################################

# install SMSSparseMatrix and SMSSparseMatrices
DeclareRepresentation( "IsSMSSparseMatrixRep",
                       IsSMSSparseMatrix and IsAttributeStoringRep, [ ] );

BindGlobal( "TheFamilyOfSMSSparseMatrices",
            NewFamily( "TheFamilyOfSMSSparseMatrices" ) );

BindGlobal( "TheTypeOfSMSSparseMatrix",
            NewType( TheFamilyOfSMSSparseMatrices, IsSMSSparseMatrixRep ) );


##############################################################################################
##
## Constructor for SMSSparseMatrices
##
##############################################################################################

# constructor for DegreeXLayerVectorSpaces
InstallMethod( SMSSparseMatrix,
               " a list",
               [ IsInt, IsInt, IsList ],
  function( nR, nC, entries )
    local sparse_matrix;
    
    # check for valid input
    if nR < 0 then
        Error( "Number of rows must be non-negative" );
    fi;
    if nC < 0 then
        Error( "Number of columns must be non-negative" );
    fi;
    
    # no detailed check for the entries just yet, but can in principle be performed
    
    # now objectify to form a DegreeXLayerVectorSpace
    sparse_matrix := rec( );
    ObjectifyWithAttributes( sparse_matrix, TheTypeOfSMSSparseMatrix,
                             NumberOfRows, nR,
                             NumberOfColumns, nC,
                             Entries, entries
                             );
    return sparse_matrix;
    
end );


#################################################
##
## Section: String methods for the new categories
##
#################################################

InstallMethod( String,
              [ IsSMSSparseMatrix ],
  function( matrix )
    
    return Concatenation( "A ", String( NumberOfRows( matrix ) ), "x", String( NumberOfColumns( matrix ) ), " sparse matrix in SMS-format" );
    
end );


##################################################
##
## Section: Display methods for the new categories
##
##################################################

InstallMethod( Display,
              [ IsSMSSparseMatrix ],
  function( matrix )
    
    Print( "Entries:\n" );
    Print( Concatenation( String( Entries( matrix ) ), "\n\n" ) );
    Print( Concatenation( String( matrix ), "\n" ) );
    
end );

################################################
##
## Section: View methods for the new categories
##
################################################

InstallMethod( ViewObj,
              [ IsSMSSparseMatrix ],
               999, # FIXME FIXME FIXME!!!
  function( matrix )

      Print( Concatenation( "<", String( matrix ), ">" ) );

end );


################################################################################################################
##
#! @Section Convenient methods to display all information about vector space presentations and morphisms thereof
##
################################################################################################################

InstallMethod( FullInformation,
               [ IsSMSSparseMatrix ],
  function( matrix )
    
    Print( "Yet to be implemented..\n" );
    
end );
