##########################################################################################
##
##  TruncationsOfGradedRowsAndColumns.gi   SheafCohomologyOnToricVarieties package
##
##  Copyright 2019                         Martin Bies,       ULB Brussels
##
#! @Chapter Truncations of graded rows and columns
##
#########################################################################################



#########################################################################################
##
## Section Truncations of graded rows and columns to a single degree
##
#########################################################################################

# compute degree X layer of projective graded S-module
InstallMethod( DegreeXLayerOfGradedRowOrColumn,
               " a toric variety, a projective graded module, a list specifying a degree ",
               [ IsToricVariety, IsGradedRowOrColumn, IsList, IsFieldForHomalg ],
  function( variety, projective_module, degree, rationals )
    local left, degree_list, degrees, shifted_degree, extended_degree_list, i, generators, vectorSpace, ring;

    # (1) check for valid input
    # (1) check for valid input

    left := IsGradedRow( projective_module );

    if not IsValidInputForCohomologyComputations( variety ) then

      Error( "The variety has to be smooth, complete (or simplicial, projective if you allow for lazy checks)" );
      return;

    fi;

    if left and not IsIdenticalObj( CapCategory( projective_module ), 
                                      CategoryOfGradedRows( CoxRing( variety ) ) ) then

      Error( "The module is not defined in the category of graded rows of the Cox ring of the variety" );
      return;

    fi;

    if ( not left ) and not IsIdenticalObj( CapCategory( projective_module ), 
                                              CategoryOfGradedColumns( CoxRing( variety ) ) ) then

      Error( "The module is not defined in the category of graded columns of the Cox ring of the variety" );
      return;

    fi;

    if not Rank( ClassGroup( variety ) ) = Length( degree ) then

      Error( "The given list does not specify an element of the class group of the variety" );
      return;

    fi;


    # (2) compute truncation
    # (2) compute truncation

    # (2.1) identify degrees
    degree_list := DegreeList( projective_module );
    extended_degree_list := [];
    for i in [ 1 .. Length( degree_list ) ] do
      shifted_degree := degree - UnderlyingListOfRingElements( degree_list[ i ][ 1 ] );
      extended_degree_list := Concatenation( extended_degree_list, 
                                             ListWithIdenticalEntries( degree_list[ i ][ 2 ], shifted_degree ) );
    od;

    # (2.2) identify the generators
    generators := [];
    for i in [ 1 .. Rank( projective_module ) ] do
    generators := Concatenation( generators,
                                 DegreeXLayerVectorsAsColumnMatrices(
                                             variety, extended_degree_list[ i ], i, Rank( projective_module ) )
                               );
    od;

    # (2.3) construct underlying vector space
    vectorSpace := VectorSpaceObject( Length( generators ), rationals );

    # (2.4) construct ring
    ring := CoxRing( variety );

    # (3) return the result
    # (3) return the result
    return DegreeXLayerVectorSpace( generators, ring, vectorSpace, Rank( projective_module ) );

end );

InstallMethod( DegreeXLayerOfGradedRowOrColumn,
               " a toric variety, a graded row or column, a homalg_module_element",
               [ IsToricVariety, IsGradedRowOrColumn, IsHomalgModuleElement, IsFieldForHomalg ],
  function( variety, projective_module, degree, rationals )

    return DegreeXLayerOfGradedRowOrColumn( variety, projective_module, UnderlyingListOfRingElements( degree ), rationals );

end );

InstallMethod( DegreeXLayerOfGradedRowOrColumn,
               " a toric variety, a graded row or column, a homalg_module_element",
               [ IsToricVariety, IsGradedRowOrColumn, IsList ],
  function( variety, projective_module, degree )

    return DegreeXLayerOfGradedRowOrColumn( variety, projective_module, degree, CoefficientsRing( CoxRing( variety ) ) );

end );

InstallMethod( DegreeXLayerOfGradedRowOrColumn,
               " a toric variety, a graded row or column, a homalg_module_element",
               [ IsToricVariety, IsGradedRowOrColumn, IsHomalgModuleElement ],
  function( variety, projective_module, degree )

    return DegreeXLayerOfGradedRowOrColumn( 
                variety, projective_module, UnderlyingListOfRingElements( degree ), CoefficientsRing( CoxRing( variety ) ) );

end );


##############################################################################################
##
## Truncations of graded rows and columns with further formatting
##
##############################################################################################

# compute degree X layer of projective graded S-module
InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListOfColumnMatrices,
               " a toric variety, a projective graded module, a list specifying a degree ",
               [ IsToricVariety, IsGradedRowOrColumn, IsList ],
  function( variety, projective_module, degree )
    local left, degree_list, degrees, extended_degree_list, i, generators;

    # check if we have to deal with a left or right module morphism
    left := IsGradedRow( projective_module );

    # check that the input is valid to work with
    if not IsValidInputForCohomologyComputations( variety ) then

      Error( "The variety has to be smooth, complete (or simplicial, projective if you allow for lazy checks)" );
      return;

    elif left and not IsIdenticalObj( CapCategory( projective_module ), 
                                      CategoryOfGradedRows( CoxRing( variety ) ) ) then

      Error( Concatenation( "The module is not defined in the category of projective graded left-modules",
                                   " over the Coxring of the variety" ) );
      return;

    elif ( not left ) and not IsIdenticalObj( CapCategory( projective_module ), 
                                              CategoryOfGradedColumns( CoxRing( variety ) ) ) then

      Error( Concatenation( "The module is not defined in the category of projective graded left-modules",
                            " over the Coxring of the variety" ) );
      return;

    elif not IsFieldForHomalg( CoefficientsRing( CoxRing( variety ) ) ) then

      Error( Concatenation( "DegreeXLayer operations are currently only supported if the coefficient ring",
                            " of the Cox ring is a field" ) );
      return;

    elif not Rank( ClassGroup( variety ) ) = Length( degree ) then

      Error( "The given list does not specify an element of the class group of the variety in question" );
      return;

    fi;

    # compute the degree layers of S that need to be computed
    degree_list := DegreeList( projective_module );

    # 'unzip' the degree_list
    extended_degree_list := [];
    for i in [ 1 .. Length( degree_list ) ] do
      extended_degree_list := Concatenation( extended_degree_list,
                                        ListWithIdenticalEntries( degree_list[ i ][ 2 ],
                                                                  degree - UnderlyingListOfRingElements( degree_list[ i ][ 1 ] )
                                                                 ) );
    od;

    # now extract the generators
    generators := [];
    for i in [ 1 .. Rank( projective_module ) ] do

      generators := Concatenation( 
                          generators, 
                          DegreeXLayerVectorsAsColumnMatrices( variety, extended_degree_list[ i ], i, Rank( projective_module ) )
                          );

    od;

    # then return the DegreeXLayerVectorSpace
    return generators;

end );

InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListOfColumnMatrices,
               " a toric variety, a projective graded module, a homalg_module_element specifying a degree ",
               [ IsToricVariety, IsGradedRowOrColumn, IsHomalgModuleElement ],
  function( variety, projective_module, degree )

    return DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListOfColumnMatrices( 
                                               variety, projective_module, UnderlyingListOfRingElements( degree ) );

end );

# compute degree X layer of projective graded S-module
InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListsOfRecords,
               " a toric variety, a projective graded module, a list specifying a degree ",
               [ IsToricVariety, IsGradedRowOrColumn, IsList ],
  function( variety, projective_module, degree )
    local left, degree_list, extended_degree_list, i, j, record_entries_list, record_list, offset, buffer;

    # check if we have to deal with a left or right module morphism
    left := IsGradedRow( projective_module );

    # check that the input is valid to work with
    if not IsValidInputForCohomologyComputations( variety ) then

      Error( "The variety has to be smooth, complete (or simplicial, projective if you allow for lazy checks)" );
      return;

    elif left and not IsIdenticalObj( CapCategory( projective_module ), 
                                      CategoryOfGradedRows( CoxRing( variety ) ) ) then

      Error( Concatenation( "The module is not defined in the category of projective graded left-modules",
                                   " over the Coxring of the variety" ) );
      return;

    elif ( not left ) and not IsIdenticalObj( CapCategory( projective_module ), 
                                              CategoryOfGradedColumns( CoxRing( variety ) ) ) then

      Error( Concatenation( "The module is not defined in the category of projective graded left-modules",
                            " over the Coxring of the variety" ) );
      return;

    elif not IsFieldForHomalg( CoefficientsRing( CoxRing( variety ) ) ) then

      Error( Concatenation( "DegreeXLayer operations are currently only supported if the coefficient ring",
                            " of the Cox ring is a field" ) );
      return;

    elif not Rank( ClassGroup( variety ) ) = Length( degree ) then

      Error( "The given list does not specify an element of the class group of the variety in question" );
      return;

    fi;

    # compute the degree layers of S that need to be computed
    degree_list := DegreeList( projective_module );

    # 'unzip' the degree_list
    extended_degree_list := [];
    for i in [ 1 .. Length( degree_list ) ] do
      extended_degree_list := Concatenation( extended_degree_list,
                                      ListWithIdenticalEntries( degree_list[ i ][ 2 ],
                                                                degree - UnderlyingListOfRingElements( degree_list[ i ][ 1 ] )
                                                               ) );
    od;

    # now extract the generators
    record_entries_list := List( [ 1 .. Length( extended_degree_list ) ],
                  i -> List( MonomsOfCoxRingOfDegreeByNormaliz( variety, extended_degree_list[ i ] ), j -> String( j ) ) );


    # and create the list of records
    offset := 0;
    record_list := [];
    for i in [ 1 .. Length( record_entries_list ) ] do
      buffer := rec();
      for j in [ 1 .. Length( record_entries_list[ i ] ) ] do
        buffer.( record_entries_list[ i ][ j ] ) := j + offset;
      od;
      Add( record_list, buffer );
      offset := offset + Length( record_entries_list[ i ] );
    od;

    # return the result
    return [ offset, record_list ];

end );

InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListsOfRecords,
               " a toric variety, a projective graded module, a homalg_module_element specifying a degree ",
               [ IsToricVariety, IsGradedRowOrColumn, IsHomalgModuleElement ],
  function( variety, projective_module, degree )

    return DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListsOfRecords(
                                               variety, projective_module, UnderlyingListOfRingElements( degree ) );

end );

# compute degree X layer of projective graded S-module
InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsUnionOfColumnMatrices,
               " a toric variety, a projective graded module, a list specifying a degree ",
               [ IsToricVariety, IsGradedRowOrColumn, IsList ],
  function( variety, projective_module, degree )
    local left, degree_list, degrees, extended_degree_list, i, generators, matrix, pos;

    # check if we have to deal with a left or right module morphism
    left := IsGradedRow( projective_module );

    # check that the input is valid to work with
    if not IsValidInputForCohomologyComputations( variety ) then

      Error( "The variety has to be smooth, complete (or simplicial, projective if you allow for lazy checks)" );
      return;

    elif left and not IsIdenticalObj( CapCategory( projective_module ), 
                                      CategoryOfGradedRows( CoxRing( variety ) ) ) then

      Error( Concatenation( "The module is not defined in the category of projective graded left-modules",
                                   " over the Coxring of the variety" ) );
      return;

    elif ( not left ) and not IsIdenticalObj( CapCategory( projective_module ), 
                                              CategoryOfGradedColumns( CoxRing( variety ) ) ) then

      Error( Concatenation( "The module is not defined in the category of projective graded left-modules",
                            " over the Coxring of the variety" ) );
      return;

    elif not IsFieldForHomalg( CoefficientsRing( CoxRing( variety ) ) ) then

      Error( Concatenation( "DegreeXLayer operations are currently only supported if the coefficient ring",
                            " of the Cox ring is a field" ) );
      return;

    elif not Rank( ClassGroup( variety ) ) = Length( degree ) then

      Error( "The given list does not specify an element of the class group of the variety in question" );
      return;

    fi;

    # compute the degree layers of S that need to be computed
    degree_list := DegreeList( projective_module );

    # 'unzip' the degree_list
    extended_degree_list := [];
    for i in [ 1 .. Length( degree_list ) ] do
      extended_degree_list := Concatenation( extended_degree_list,
                                        ListWithIdenticalEntries( degree_list[ i ][ 2 ],
                                                                  degree - UnderlyingListOfRingElements( degree_list[ i ][ 1 ] )
                                                                 ) );
    od;

    # now extract the generators
    generators := [];
    for i in [ 1 .. Rank( projective_module ) ] do

      generators := Concatenation(
                          generators,
                          DegreeXLayerVectorsAsColumnMatrices( variety, extended_degree_list[ i ], i, Rank( projective_module ) )
                          );

    od;

    # construct the matrix
    matrix := HomalgInitialMatrix( Rank( projective_module ), Length( generators ), CoxRing( variety ) );
    for i in [ 1 .. Length( generators ) ] do
      pos := NonZeroRows( generators[ i ] );
      SetMatElm( matrix, pos[ 1 ], i, EntriesOfHomalgMatrix( CertainRows( generators[ i ], pos ) )[ 1 ] );
    od;

    # then return the DegreeXLayerVectorSpace
    return matrix;

end );

InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsUnionOfColumnMatrices,
               " a toric variety, a projective graded module, a homalg_module_element specifying a degree ",
               [ IsToricVariety, IsGradedRowOrColumn, IsHomalgModuleElement ],
  function( variety, projective_module, degree )

    return DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsUnionOfColumnMatrices( 
                                               variety, projective_module, UnderlyingListOfRingElements( degree ) );

end );

# compute degree X layer of projective graded S-module
InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListList,
               " a toric variety, a projective graded module, a list specifying a degree ",
               [ IsToricVariety, IsGradedRowOrColumn, IsList ],
  function( variety, projective_module, degree )
    local left, degree_list, extended_degree_list, i, generators, mons;

    # check if we have to deal with a left or right module morphism
    left := IsGradedRow( projective_module );

    # check that the input is valid to work with
    if not IsValidInputForCohomologyComputations( variety ) then

      Error( "The variety has to be smooth, complete (or simplicial, projective if you allow for lazy checks)" );
      return;

    elif left and not IsIdenticalObj( CapCategory( projective_module ), 
                                      CategoryOfGradedRows( CoxRing( variety ) ) ) then

      Error( Concatenation( "The module is not defined in the category of projective graded left-modules",
                                   " over the Coxring of the variety" ) );
      return;

    elif ( not left ) and not IsIdenticalObj( CapCategory( projective_module ), 
                                              CategoryOfGradedColumns( CoxRing( variety ) ) ) then

      Error( Concatenation( "The module is not defined in the category of projective graded left-modules",
                            " over the Coxring of the variety" ) );
      return;

    elif not IsFieldForHomalg( CoefficientsRing( CoxRing( variety ) ) ) then

      Error( Concatenation( "DegreeXLayer operations are currently only supported if the coefficient ring",
                            " of the Cox ring is a field" ) );
      return;

    elif not Rank( ClassGroup( variety ) ) = Length( degree ) then

      Error( "The given list does not specify an element of the class group of the variety in question" );
      return;

    fi;

    # compute the degree layers of S that need to be computed
    degree_list := DegreeList( projective_module );

    # 'unzip' the degree_list
    extended_degree_list := [];
    for i in [ 1 .. Length( degree_list ) ] do
      extended_degree_list := Concatenation( extended_degree_list,
                                        ListWithIdenticalEntries( degree_list[ i ][ 2 ],
                                                                  degree - UnderlyingListOfRingElements( degree_list[ i ][ 1 ] )
                                                                 ) );
    od;

    # now extract the generators
    generators := [];
    for i in [ 1 .. Rank( projective_module ) ] do

      mons := MonomsOfCoxRingOfDegreeByNormaliz( variety, extended_degree_list[ i ] );
      mons := List( [ 1 .. Length( mons ) ], k -> [ i, mons[ k ] ] );
      Append( generators, mons );

    od;

    # return the result
    return generators;

end );

InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListList,
               " a toric variety, a projective graded module, a homalg_module_element specifying a degree ",
               [ IsToricVariety, IsGradedRowOrColumn, IsHomalgModuleElement ],
  function( variety, projective_module, degree )

    return DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListList( 
                                               variety, projective_module, UnderlyingListOfRingElements( degree ) );

end );

if false then

# compute degree X layer of projective graded S-module morphism
InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism,
               " a toric variety, a projective graded module morphism, a list specifying a degree ",
               [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism, IsList, IsHomalgRing, IsBool ],
  function( variety, projective_module_morphism, degree, rationals, display_messages )
    local left, gens_source, gens_range, dim_range, matrix, mapping_matrix, counter, i, comparer, j, non_zero_rows,
         poly, poly_split, poly_split2, k, pos, coeff, l, name_of_indeterminates, vector_space_morphism, split_pos;

    # check if we have to deal with a left or right module morphism
    left := IsCategoryOfGradedRowsMorphism( projective_module_morphism );

    # check that the input is valid to work with
    if not IsValidInputForCohomologyComputations( variety ) then

      Error( "The variety has to be smooth, complete (or simplicial, projective if you allow for lazy checks)" );
      return;

    elif left and not IsIdenticalObj( CapCategory( projective_module_morphism ), 
                                      CategoryOfGradedRows( CoxRing( variety ) ) ) then

      Error( Concatenation( "The module is not defined in the category of projective graded left-modules",
                            " over the Coxring of the variety" ) );
      return;

    elif ( not left ) and not IsIdenticalObj( CapCategory( projective_module_morphism ), 
                                              CategoryOfGradedColumns( CoxRing( variety ) ) ) then

      Error( Concatenation( "The module is not defined in the category of projective graded left-modules",
                            " over the Coxring of the variety" ) );
      return;

    elif not IsFieldForHomalg( CoefficientsRing( CoxRing( variety ) ) ) then

      Error( Concatenation( "DegreeXLayer operations are currently only supported if the coefficient ring",
                            " of the Cox ring is a field" ) );
      return;

    elif not Rank( ClassGroup( variety ) ) = Length( degree ) then

      Error( "The given list does not specify an element of the class group of the variety in question" );
      return;

    fi;

    # extract source and range generators
    gens_source := DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListOfColumnMatrices(
                                                                           variety,
                                                                           Source( projective_module_morphism ), 
                                                                           degree
                                                                         );
    gens_range := DegreeXLayerOfProjectiveGradedLeftOrRightModuleGeneratorsAsListsOfRecords(
                                                                          variety,
                                                                          Range( projective_module_morphism ),
                                                                          degree
                                                                         );

    # compute the dimension of the range
    dim_range := gens_range[ 1 ];
    gens_range := gens_range[ 2 ];

    # check for degenerate cases
    if Length( gens_source ) = 0 then

      if display_messages then
        Print( "Starting the matrix computation now... \n \n" );
      fi;

      matrix := HomalgZeroMatrix( dim_range,
                                  0,
                                  rationals
                                 );

      if display_messages then
        Print( Concatenation( "NrRows: ", String( NrRows( matrix ) ), "\n" ) );
        Print( Concatenation( "NrColumns: ", String( NrColumns( matrix ) ), "\n" ) );
        Print( "matrix created... \n" );
      fi;

    elif dim_range = 0 then

      if display_messages then
        Print( "Starting the matrix computation now... \n \n" );
      fi;

      matrix := HomalgZeroMatrix( 0,
                                  Length( gens_source ),
                                  rationals
                                 );

      if display_messages then
        Print( Concatenation( "NrRows: ", String( NrRows( matrix ) ), "\n" ) );
        Print( Concatenation( "NrColumns: ", String( NrColumns( matrix ) ), "\n" ) );
        Print( "matrix created... \n" );
      fi;

    else;

      # both vector spaces are of non-zero dimension
      # -> so here is the non-trivial case

      # This is the most crucial piece of the code in DegreeXLayer, and thus a few explaining words are appropriate:

      # Note:
      # gens_source and gens_range are lists. Each entry is a generator of the source/ range vector spaces.
      # These generators themselves are lists, whose length matches the rank of source/range vector space respectively.
      # The entries are elements of the underlying graded homalg_ring.
      #
      # Consequently, turning such a generator into a matrix means that we can for left presentations multiply the mapping
      # matrix from the left with such a generator. For right presentations, we can multiply a generator_matrix from the right
      # onto the mapping matrix.
      #
      # We turn the generators of the source into such matrices. We then compute products of the following type:
      # AsMatrix( source_generator[ i ] ) * mapping_matrix         (for left modules)
      # mapping_matrix * AsMatrix( source_generator[ i ] )         (for right modules)
      #
      # The results of these multiplications are elements of the vector space spanned by gens_range. So we should try to
      # express the result in terms of these generators. Therefore we form a matrix M from the listlist gens_range such that:
      #
      # for left modules, each generator in gens_range is a row of that matrix
      # for right modules, each generator in gens_range is a column of that matrix
      #
      # Expressing the elements in terms of the generators of the range is then the task to find a matrix B such that
      #
      # for left modules:   AsMatrix( source_generator[ i ] ) * mapping_matrix = B * M
      #                     RightDivide( AsMatrix( source_generator[ i ] ) * mapping_matrix, M ) = B
      # for right modules:  mapping_matrix * AsMatrix( source_generator[ i ] ) = M * B
      #                     LeftDivide( M, mapping_matrix * AsMatrix( source_generator[ i ] ) ) = B
      #
      # for each i, B will be a row (for left modules)/ a column (for right modules)
      # the union of these rows/columns then gives a morphism of left/right vector spaces
      #
      # MatrixCategory( ) in LinearAlgebraForCAP solemnly supports left vector spaces. Therefore we need to turn morphisms
      # of right vector_spaces into morphisms of left_vector spaces at the end of the computation.

      # extract the underlying matrix of the morphism
      mapping_matrix := UnderlyingHomalgMatrix( projective_module_morphism );

      # if a left module was provided we have to transpose the mapping matrix
      if left then

        # remember that the mapping_matrix should be used as transposed matrix for left modules
        mapping_matrix := Involution( mapping_matrix );

      fi;

      # figure out what names are used for the variables in the Cox ring
      # we will later look for appearences of this char in a string (that is way faster than e.g. left divide and so on)
      # this works only if the underlying ring is a polynomial ring and the variable names are of the form 'x1 x2 ...' or 'w_1, w_2' but for
      # example 'hans1 hans2 hans3...' will lead to problems
      name_of_indeterminates := String( IndeterminatesOfPolynomialRing( HomalgRing( mapping_matrix ) )[ 1 ] )[ 1 ];

      # initialise the matrix as a sparse matrix
      matrix := HomalgInitialMatrix( dim_range,
                                     Length( gens_source ),
                                     rationals
                                    );

      # print status of the computation
      if display_messages then
        Print( "Starting the matrix computation now... \n \n" );
        Print( Concatenation( "NrRows: ", String( NrRows( matrix ) ), "\n" ) );
        Print( Concatenation( "NrColumns: ", String( NrColumns( matrix ) ), "\n" ) );
        Print( Concatenation( "Have to go until i = ", String( Length( gens_source ) ), "\n" ) );
      fi;

      counter := 1;

      for i in [ 1 .. Length( gens_source ) ] do

        # information about the status
        if not ( Int( i / Length( gens_source ) * 100 ) < counter ) then

          # express current status as multiply of 10%, so we compute this number first
          counter := Int( i / Length( gens_source ) * 10 ) * 10;

          # then inform the user
          if display_messages then
            Print( Concatenation( String( counter ), "% done...\n" ) );
          fi;

          # and finally increase counter
          counter := counter + 10;

        fi;

        # compute image of the i-th source generator
        comparer := mapping_matrix * gens_source[ i ];

        # extract the non_zero rows of this image-column
        non_zero_rows := NonZeroRows( comparer );
        comparer := EntriesOfHomalgMatrix( comparer );

        # now work over each and every nontrivial entry of comparer
        for j in [ 1 .. Length( non_zero_rows ) ] do

          # consider the non_zero_rows[j]-th image as a string
          poly := String( comparer[ non_zero_rows[ j ] ] );

          # find positions of plus and minus
          split_pos := [ 1 ];
          Append( split_pos, Positions( poly, '-' ) );
          Append( split_pos, Positions( poly, '+' ) );
          split_pos := DuplicateFreeList( split_pos );
          Sort( split_pos );

          # initialise the split string
          poly_split := List( [ 1 .. Length( split_pos ) ] );

          # and extract the substrings
          for k in [ 1 .. Length( poly_split ) ] do
             if k <> Length( poly_split ) then
               poly_split[ k ] := List( [ 1 .. split_pos[ k+1 ] - split_pos[ k ] ], l -> poly[ split_pos[ k ] - 1 + l ] );
             else
               poly_split[ k ] := List( [ 1 .. Length( poly ) - split_pos[ k ] + 1 ], l -> poly[ split_pos[ k ] - 1 + l ] );
             fi;
          od;

          # -> we have now split the string at each occurance of '+' and '-'
          # note that SplitString would throw away the signs, but we need to keep track of them (mixed entries in a matrix give 
          # different cokernel than say only positive ones)
          # -> therefore we cannot use SplitString
          # -> the above code is really necessary!

          # now initialise poly_split2
          poly_split2 := List( [ 1 .. Length( poly_split ) ] );

          # now extract the coefficients of the individual monoms
          for k in [ 1 .. Length( poly_split ) ] do
            if poly_split[ k ][ 1 ] = name_of_indeterminates then

              poly_split2[ k ] := [ One( rationals ), poly_split[ k ] ];

            elif poly_split[ k ][ 1 ] <> name_of_indeterminates then

              # find first occurance of 'x' (or more generally the variables names used)
              # -> whatever is in front of it will be our coefficient
              pos := Position( poly_split[ k ], name_of_indeterminates );

              if pos <> fail then
                # at least one 'x' does appear in this string
                coeff := List( [ 1 .. pos-1 ], l -> poly_split[ k ][ l ] );

                # massage the coefficient
                if coeff[ Length( coeff ) ] = '*' then
                  Remove( coeff );
                fi;

                # check for degenerate case
                if coeff = "-" then
                  coeff := "-1";
                elif coeff = "+" then
                  coeff := "+1";
                fi;

                # remove the coefficient part from poly_split
                for l in [ 1 .. pos-1 ] do
                  Remove( poly_split[ k ], 1 );
                od;

                # finally save the coefficient and the monom
                poly_split2[ k ] := [ EvalString( coeff ) / rationals, poly_split[ k ] ];

              else
                # no 'x' (or more generally, variable name) appears, so the entire string is the coefficient and the monom is just 1
                poly_split2[ k ] := [ Int( poly_split[ k ] ) / rationals, "1" ];

              fi;

            fi;

          od;

          # next figure out which range monoms did appear from gens_range[ non_zero_rows ]
          for k in [ 1 .. Length( poly_split2 ) ] do

            pos := gens_range[ non_zero_rows[ j ] ].( poly_split2[ k ][ 2 ] );
            SetMatElm( matrix, pos, i, poly_split2[ k ][ 1 ] );

          od;

        od;

      od;

      # and return the result
      if display_messages then
        Print( "matrix created... \n" );
      fi;

    fi;

    # and create the vector space morphism
    # note that CAP only supports left vector spaces, but the above matrix is the mapping matrix of right vector spaces
    # -> so we need 'Involution'
    vector_space_morphism := VectorSpaceMorphism( VectorSpaceObject( NrColumns( matrix ), rationals ),
                                                  Involution( matrix ),
                                                  VectorSpaceObject( NrRows( matrix ), rationals )
                                                 );

    # finally return the result
    return DegreeXLayerVectorSpaceMorphism( DegreeXLayerOfProjectiveGradedLeftOrRightModule(
                                                              variety, Source( projective_module_morphism ), degree, rationals ),
                                            vector_space_morphism,
                                            DegreeXLayerOfProjectiveGradedLeftOrRightModule(
                                                               variety, Range( projective_module_morphism ), degree, rationals )
                                           );

end );

# compute degree X layer of projective graded S-module
InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism,
               " a toric variety, a projective graded module morphism, a homalg_module_element specifying a degree ",
               [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism, IsHomalgModuleElement, IsHomalgRing, IsBool ],
  function( variety, projective_module_morphism, degree, rationals, display_messages )

    return DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                   variety, projective_module_morphism, UnderlyingListOfRingElements( degree ), rationals, display_messages );

end );

InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism,
               " a toric variety, a projective graded module morphism, a homalg_module_element specifying a degree ",
               [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism, IsList, IsBool ],
  function( variety, projective_module_morphism, degree, display_messages )

    return DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                       variety, projective_module_morphism, degree, CoefficientsRing( CoxRing( variety ) ), display_messages );

end );

InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism,
               " a toric variety, a projective graded module morphism, a homalg_module_element specifying a degree ",
               [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism, IsHomalgModuleElement, IsBool ],
  function( variety, projective_module_morphism, degree, display_messages )

    return DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
               variety, projective_module_morphism, UnderlyingListOfRingElements( degree ), CoefficientsRing( CoxRing( variety ) ),
               display_messages 
           );

end );

InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism,
               " a toric variety, a projective graded module morphism, a homalg_module_element specifying a degree ",
               [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism, IsList ],
  function( variety, projective_module_morphism, degree )

    return DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                       variety, projective_module_morphism, degree, CoefficientsRing( CoxRing( variety ) ), false );

end );

InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism,
               " a toric variety, a projective graded module morphism, a homalg_module_element specifying a degree ",
               [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism, IsHomalgModuleElement ],
  function( variety, projective_module_morphism, degree )

    return DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
               variety, projective_module_morphism, UnderlyingListOfRingElements( degree ), CoefficientsRing( CoxRing( variety ) ), false );

end );

# a minimal version to compute degree X layer of projective graded S-module morphism
InstallMethod( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphismMinimal,
               " a toric variety, a projective graded module morphism, a list specifying a degree ",
               [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism, IsList, IsList, IsHomalgRing, IsBool ],
  function( variety, projective_module_morphism, gens_source, gens_range_original, rationals, display_messages )
    local left, dim_range, gens_range, matrix, mapping_matrix, name_of_indeterminates, counter, i, 
         comparer, j, non_zero_rows, poly, poly_split, poly_split2, k, pos, coeff, l, split_pos;

    # check if we have to deal with a left or right module morphism
    left := IsCategoryOfGradedRowsMorphism( projective_module_morphism );

    # compute the dimension of the range
    dim_range := gens_range_original[ 1 ];
    gens_range := gens_range_original[ 2 ];

    # extract the underlying matrix of the morphism
    mapping_matrix := UnderlyingHomalgMatrix( projective_module_morphism );

    # if a left module was provided we have to transpose the mapping matrix
    if left then

      # remember that the mapping_matrix should be used as transposed matrix for left modules
      mapping_matrix := Involution( mapping_matrix );

    fi;

    # figure out what names are used for the variables in the Cox ring
    # we will later look for appearences of this char in a string (that is way faster than e.g. left divide and so on)
    # this works only if the underlying ring is a polynomial ring and the variable names are of the form 'x1 x2 ...' or 'w_1, w_2' but for
    # example 'hans1 hans2 hans3...' will lead to problems
    name_of_indeterminates := String( IndeterminatesOfPolynomialRing( HomalgRing( mapping_matrix ) )[ 1 ] )[ 1 ];

    # initialise the matrix as a sparse matrix
    matrix := HomalgInitialMatrix( Length( gens_source ), dim_range, rationals );

    # print status of the computation
    if display_messages then
      Print( "Starting the matrix computation now... \n \n" );
      Print( Concatenation( "NrRows: ", String( NrRows( matrix ) ), "\n" ) );
      Print( Concatenation( "NrColumns: ", String( NrColumns( matrix ) ), "\n" ) );
      Print( Concatenation( "Have to go until i = ", String( NrColumns( matrix ) ), "\n" ) );
    fi;

    counter := 1;

    for i in [ 1 .. Length( gens_source ) ] do

      # information about the status
      if not ( Int( i / Length( gens_source ) * 100 ) < counter ) then

        # express current status as multiply of 10%, so we compute this number first
        counter := Int( i / Length( gens_source ) * 10 ) * 10;

        # then inform the user
        if display_messages then
          Print( Concatenation( String( counter ), "% done...\n" ) );
        fi;

        # and finally increase counter
        counter := counter + 10;

      fi;

      # compute image of the i-th source generator
      comparer := mapping_matrix * gens_source[ i ];

      # extract the non_zero rows of this image-column
      non_zero_rows := NonZeroRows( comparer );
      comparer := EntriesOfHomalgMatrix( comparer );

      # now work over each and every nontrivial entry of comparer
      for j in [ 1 .. Length( non_zero_rows ) ] do

        # consider the non_zero_rows[j]-th image as a string
        poly := String( comparer[ non_zero_rows[ j ] ] );

        # find positions of plus and minus
        split_pos := [ 1 ];
        Append( split_pos, Positions( poly, '-' ) );
        Append( split_pos, Positions( poly, '+' ) );
        split_pos := DuplicateFreeList( split_pos );
        Sort( split_pos );

        # initialise the split string
        poly_split := List( [ 1 .. Length( split_pos ) ] );

        # and extract the substrings
        for k in [ 1 .. Length( poly_split ) ] do
           if k <> Length( poly_split ) then
             poly_split[ k ] := List( [ 1 .. split_pos[ k+1 ] - split_pos[ k ] ], l -> poly[ split_pos[ k ] - 1 + l ] );
           else
             poly_split[ k ] := List( [ 1 .. Length( poly ) - split_pos[ k ] + 1 ], l -> poly[ split_pos[ k ] - 1 + l ] );
           fi;
        od;

        # now initialise poly_split2
        poly_split2 := List( [ 1 .. Length( poly_split ) ] );

        # now extract the coefficients of the individual monoms
        for k in [ 1 .. Length( poly_split ) ] do
          if poly_split[ k ][ 1 ] = name_of_indeterminates then

            poly_split2[ k ] := [ One( rationals ), poly_split[ k ] ];

          elif poly_split[ k ][ 1 ] <> name_of_indeterminates then

            # find first occurance of 'x' (or more generally the variables names used)
            # -> whatever is in front of it will be our coefficient
            pos := Position( poly_split[ k ], name_of_indeterminates );

            if pos <> fail then
              # at least one 'x' does appear in this string
              coeff := List( [ 1 .. pos-1 ], l -> poly_split[ k ][ l ] );

              # massage the coefficient
              if coeff[ Length( coeff ) ] = '*' then
                Remove( coeff );
              fi;

              # check for degenerate case
              if coeff = "-" then
                coeff := "-1";
              elif coeff = "+" then
                coeff := "+1";
              fi;

              # remove the coefficient part from poly_split
              for l in [ 1 .. pos-1 ] do
                Remove( poly_split[ k ], 1 );
              od;

              # finally save the coefficient and the monom
              poly_split2[ k ] := [ EvalString( coeff ) / rationals, poly_split[ k ] ];

            else
              # no 'x' (or more generally, variable name) appears, so the entire string is the coefficient
              # and the monom is just 1
              poly_split2[ k ] := [ Int( poly_split[ k ] ) / rationals, "1" ];

            fi;

          fi;

        od;

        # next figure out which range monoms did appear from gens_range[ non_zero_rows ]
        for k in [ 1 .. Length( poly_split2 ) ] do

          pos := gens_range[ non_zero_rows[ j ] ].( poly_split2[ k ][ 2 ] );
          SetMatElm( matrix, i, pos, poly_split2[ k ][ 1 ] );

        od;

      od;

    od;

    # and return the result
    if display_messages then
      Print( "matrix created... \n \n" );
    fi;

    # finally return the result
    return matrix;

end );


######################################################################################################
##
## Section Truncation a PROJECTIVE graded module morphism and write the corresponding matrix to a file
##         formated for use in gap
##
######################################################################################################

# compute degree X layer of projective graded S-module morphism and write the corresponding matrix to a file
InstallMethod( ComputeDegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphismMinimally,
               " a list of information and a string",
               [ IsList, IsBool ],
  function( infos, display_messages )

  return ComputeDegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphismMinimally( 
  infos, display_messages, 1, Length( infos[ 1 ] ) );

end );


# compute degree X layer of projective graded S-module morphism and write the corresponding matrix to a file
InstallMethod( ComputeDegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphismMinimally,
               " a list of information and a string",
               [ IsList, IsBool, IsInt, IsInt ],
  function( infos, display_messages, starting_pos, ending_pos )
    local images, gens_range, name_of_indeterminates, dim_range, path, file, stream, counter, i,
         comparer, non_zero_rows, j, poly, poly_split, poly_split2, k, pos, coeff, l, split_pos, positions;

    # extract the data
    images := infos[ 1 ];
    gens_range := infos[ 2 ];
    name_of_indeterminates := infos[ 3 ];

    # compute the dimension of the range
    dim_range := gens_range[ 1 ];
    gens_range := gens_range[ 2 ];

    # initialise positions
    positions := [];

    # print status of the computation
    if display_messages then
      Print( "starting the matrix computation... \n \n" );
      Print( Concatenation( "NrRows: ", String( Length( images ) ), "\n" ) );
      Print( Concatenation( "NrColumns: ", String( dim_range ), "\n" ) );
      Print( Concatenation( "Have to go until i = ", String( Length( images ) ), "\n" ) );
    fi;

    # set the counter
    counter := 1;

    # check that the ranges are meaningful
    if starting_pos < 0 then
      Error( "the starting position must be non-negative" );
    elif starting_pos > ending_pos then
      Error( "the starting position must not be bigger than the ending position" );
    elif ending_pos > Length( images ) then
      Error( "the ending position must not be bigger than the number of images to translate" );
    fi;

    # now perform the computation
    for i in [ starting_pos .. ending_pos ] do

      # information about the status
      if not ( Int( i / Length( images ) * 100 ) < counter ) then

        # express current status as multiply of 10%, so we compute this number first
        counter := Int( i / Length( images ) * 10 ) * 10;

        # then inform the user
        if display_messages then
          Print( Concatenation( String( counter ), "% done...\n" ) );
        fi;

        # and finally increase counter
        counter := counter + 10;

      fi;

      # read image of the i-th source generator and the non_zero rows of this image_column
      comparer := images[ i ][ 2 ];
      non_zero_rows := images[ i ][ 1 ];

      # now work over each and every nontrivial entry of comparer
      for j in [ 1 .. Length( non_zero_rows ) ] do

        # consider the non_zero_rows[j]-th image as a string
        poly := String( comparer[ non_zero_rows[ j ] ] );

        # find positions of plus and minus
        split_pos := [ 1 ];
        Append( split_pos, Positions( poly, '-' ) );
        Append( split_pos, Positions( poly, '+' ) );
        split_pos := DuplicateFreeList( split_pos );
        Sort( split_pos );

        # initialise the split string
        poly_split := List( [ 1 .. Length( split_pos ) ] );

        # and extract the substrings
        for k in [ 1 .. Length( poly_split ) ] do
          if k <> Length( poly_split ) then
            poly_split[ k ] := List( [ 1 .. split_pos[ k+1 ] - split_pos[ k ] ], l -> poly[ split_pos[ k ] - 1 + l ] );
          else
            poly_split[ k ] := List( [ 1 .. Length( poly ) - split_pos[ k ] + 1 ], l -> poly[ split_pos[ k ] - 1 + l ] );
          fi;
        od;

        # now initialise poly_split2
        poly_split2 := List( [ 1 .. Length( poly_split ) ] );

        # now extract the coefficients of the individual monoms
        for k in [ 1 .. Length( poly_split ) ] do
          if poly_split[ k ][ 1 ] = name_of_indeterminates then

            poly_split2[ k ] := [ "1", poly_split[ k ] ];

          elif poly_split[ k ][ 1 ] <> name_of_indeterminates then

            # find first occurance of 'x' (or more generally the variables names used) 
            # -> whatever is in front of it will be our coefficient
            pos := Position( poly_split[ k ], name_of_indeterminates );

            if pos <> fail then
              # at least one 'x' does appear in this string
              coeff := List( [ 1 .. pos-1 ], l -> poly_split[ k ][ l ] );

              # massage the coefficient
              if coeff[ Length( coeff ) ] = '*' then
                Remove( coeff );
              fi;

              # check for degenerate case
              if coeff = "-" then
                coeff := "-1";
              elif coeff = "+" then
                coeff := "+1";
              fi;

              # remove the coefficient part from poly_split
              for l in [ 1 .. pos-1 ] do
                Remove( poly_split[ k ], 1 );
              od;

              # finally save the coefficient and the monom
              poly_split2[ k ] := [ coeff, poly_split[ k ] ];

            else
              # no 'x' (or more generally, variable name) appears, so the entire string is the coefficient 
              # and the monom is just 1
              poly_split2[ k ] := [ String( poly_split[ k ] ), "1" ];

            fi;

          fi;

        od;

        # next figure out which range monoms did appear from gens_range[ non_zero_rows ]
        for k in [ 1 .. Length( poly_split2 ) ] do

          # identify the position
          pos := gens_range[ non_zero_rows[ j ] ].( poly_split2[ k ][ 2 ] );

          # remove '+' from poly_split2
          RemoveCharacters( poly_split2[ k ][ 1 ], "+" );

          # and append the evaluation to integer
          Append( positions, [ [ i, pos, Rat( poly_split2[ k ][ 1 ] ) ] ] );

        od;

      od;

    od;

    # signal end of computation
    if display_messages then
      Print( "matrix entries have been identified... \n \n" );
    fi;

    # return the result
    return positions;

end );

fi;
