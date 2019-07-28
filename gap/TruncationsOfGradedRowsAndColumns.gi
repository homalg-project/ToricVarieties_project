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

# compute degree X layer of graded row or column
InstallMethod( InputTest,
               " a toric variety, a projective graded module, a list",
               [ IsToricVariety, IsGradedRowOrColumn, IsList ],
  function( variety, projective_module, degree )
    local left;

    left := IsGradedRow( projective_module );

    if not IsValidInputForCohomologyComputations( variety ) then

      Error( "The variety has to be smooth, complete (or simplicial, projective if you allow for lazy checks)" );
      return false;

    fi;

    if left and not IsIdenticalObj( CapCategory( projective_module ),
                                      CategoryOfGradedRows( CoxRing( variety ) ) ) then

      Error( "The module is not defined in the category of graded rows of the Cox ring of the variety" );
      return false;

    fi;

    if ( not left ) and not IsIdenticalObj( CapCategory( projective_module ),
                                              CategoryOfGradedColumns( CoxRing( variety ) ) ) then

      Error( "The module is not defined in the category of graded columns of the Cox ring of the variety" );
      return false;

    fi;

    if not Rank( ClassGroup( variety ) ) = Length( degree ) then

      Error( "The given list does not specify an element of the class group of the variety" );
      return false;

    fi;

    return true;

end );

# compute degree X layer of graded row or column
InstallMethod( InputTest,
               " a toric variety, a projective graded module, a list",
               [ IsToricVariety, IsGradedRowOrColumnMorphism, IsList ],
  function( variety, graded_row_or_column_morphism, degree )
    local left;

    left := IsGradedRowMorphism( graded_row_or_column_morphism );

    if not IsValidInputForCohomologyComputations( variety ) then

      Error( "The variety has to be smooth, complete (or simplicial, projective if you allow for lazy checks)" );
      return false;

    fi;

    if left and not IsIdenticalObj( CapCategory( graded_row_or_column_morphism ),
                                      CategoryOfGradedRows( CoxRing( variety ) ) ) then

      Error( "The module is not defined in the category of graded rows of the Cox ring of the variety" );
      return false;

    fi;

    if ( not left ) and not IsIdenticalObj( CapCategory( graded_row_or_column_morphism ),
                                              CategoryOfGradedColumns( CoxRing( variety ) ) ) then

      Error( "The module is not defined in the category of graded columns of the Cox ring of the variety" );
      return false;

    fi;

    if not Rank( ClassGroup( variety ) ) = Length( degree ) then

      Error( "The given list does not specify an element of the class group of the variety" );
      return false;

    fi;

    return true;

end );

# compute degree X layer of graded row or column
InstallMethod( ExtendedDegreeList,
               " a toric variety, a projective graded module, a list",
               [ IsToricVariety, IsGradedRowOrColumn, IsList ],
  function( variety, projective_module, degree )
    local degree_list, degrees, i, shifted_degree, extended_degree_list;

    # initalise extended_degree_list
    extended_degree_list := false;

    if InputTest( variety, projective_module, degree ) then

        degree_list := DegreeList( projective_module );
        extended_degree_list := [];
        for i in [ 1 .. Length( degree_list ) ] do
            shifted_degree := degree + UnderlyingListOfRingElements( degree_list[ i ][ 1 ] );
            extended_degree_list := Concatenation( extended_degree_list, 
                                             ListWithIdenticalEntries( degree_list[ i ][ 2 ], shifted_degree ) );
        od;

    fi;

    return extended_degree_list;

end );

# compute degree X layer of graded row or column
InstallMethod( DegreeXLayerOfGradedRowOrColumn,
               " a toric variety, a projective graded module, a list",
               [ IsToricVariety, IsGradedRowOrColumn, IsList, IsFieldForHomalg ],
  function( variety, projective_module, degree, rationals )
    local extended_degree_list, i, generators, vectorSpace, ring;

    # (1) check for valid input and identify extended_degree_list
    extended_degree_list := ExtendedDegreeList( variety, projective_module, degree );

    # (2) find and format the generators accordingly
    generators := [];
    for i in [ 1 .. Rank( projective_module ) ] do
    generators := Concatenation( generators,
                                 MonomsOfCoxRingOfDegreeByNormalizAsColumnMatrices(
                                             variety, extended_degree_list[ i ], i, Rank( projective_module ) )
                               );
    od;

    # (3) construct underlying vector space
    vectorSpace := VectorSpaceObject( Length( generators ), rationals );

    # (4) construct ring
    ring := CoxRing( variety );

    # (5) return the result
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
##  Generators of truncations of graded rows and columns
##
##############################################################################################

# generators of degree X layer of graded row or column as list of column matrices
InstallMethod( GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListOfColumnMatrices,
               " a toric variety, a projective graded module, a list",
               [ IsToricVariety, IsGradedRowOrColumn, IsList ],
  function( variety, projective_module, degree )

    return Generators( DegreeXLayerOfGradedRowOrColumn( variety, projective_module, degree ) );

end );

InstallMethod( GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListOfColumnMatrices,
               " a toric variety, a projective graded module, a homalg_module_element",
               [ IsToricVariety, IsGradedRowOrColumn, IsHomalgModuleElement ],
  function( variety, projective_module, degree )

    return Generators( DegreeXLayerOfGradedRowOrColumn( variety, projective_module, degree ) );

end );


# compute generators of degree X layer of graded row or column as union of column matrices
InstallMethod( GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsUnionOfColumnMatrices,
               " a toric variety, a projective graded module, a list",
               [ IsToricVariety, IsGradedRowOrColumn, IsList ],
  function( variety, projective_module, degree )
    local generators, matrix, i, pos;

    # (1) extract the generators
    generators := GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListOfColumnMatrices( variety, projective_module, degree );

    # (2) construct the matrix
    matrix := HomalgInitialMatrix( Rank( projective_module ), Length( generators ), CoxRing( variety ) );
    for i in [ 1 .. Length( generators ) ] do
      pos := NonZeroRows( generators[ i ] );
      SetMatElm( matrix, pos[ 1 ], i, EntriesOfHomalgMatrix( CertainRows( generators[ i ], pos ) )[ 1 ] );
    od;

    # (3) and return it
    return matrix;

end );

InstallMethod( GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsUnionOfColumnMatrices,
               " a toric variety, a projective graded module, a homalg_module_element",
               [ IsToricVariety, IsGradedRowOrColumn, IsHomalgModuleElement ],
  function( variety, projective_module, degree )

    return GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsUnionOfColumnMatrices(
                                    variety, projective_module, UnderlyingListOfRingElements( degree ) );

end );


# generators of degree X layer as list of records
InstallMethod( GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListsOfRecords,
               " a toric variety, a projective graded module, a list",
               [ IsToricVariety, IsGradedRowOrColumn, IsList ],
  function( variety, projective_module, degree )
    local extended_degree_list, record_entries_list, offset, record_list, i, j, buffer;

    # (1) check for valid input and identify extended_degree_list
    extended_degree_list := ExtendedDegreeList( variety, projective_module, degree );

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

InstallMethod( GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListsOfRecords,
               " a toric variety, a projective graded module, a homalg_module_element",
               [ IsToricVariety, IsGradedRowOrColumn, IsHomalgModuleElement ],
  function( variety, projective_module, degree )

    return GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListsOfRecords(
                                               variety, projective_module, UnderlyingListOfRingElements( degree ) );

end );


# compute generators of degree X layer of graded row or column as listlist
InstallMethod( GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListList,
               " a toric variety, a projective graded module, a list",
               [ IsToricVariety, IsGradedRowOrColumn, IsList ],
  function( variety, projective_module, degree )
    local extended_degree_list, i, generators, mons;

    # (1) check for valid input and identify extended_degree_list
    extended_degree_list := ExtendedDegreeList( variety, projective_module, degree );

    # (2) extract and format the generators
    generators := [];
    for i in [ 1 .. Rank( projective_module ) ] do

      mons := MonomsOfCoxRingOfDegreeByNormaliz( variety, extended_degree_list[ i ] );
      mons := List( [ 1 .. Length( mons ) ], k -> [ i, mons[ k ] ] );
      Append( generators, mons );

    od;

    # (3) return them
    return generators;

end );

InstallMethod( GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListList,
               " a toric variety, a projective graded module, a homalg_module_element",
               [ IsToricVariety, IsGradedRowOrColumn, IsHomalgModuleElement ],
  function( variety, projective_module, degree )

    return GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListList(
                                variety, projective_module, UnderlyingListOfRingElements( degree ) );

end );




##############################################################################################
##
#! @Section Truncations of graded row and column morphisms
##
##############################################################################################

# Method to interpret image polynomial in above method in terms of the generators of the range module
InstallMethod( FindVarsAndCoefficients,
               " a string, a string and a ring",
               [ IsString, IsChar, IsFieldForHomalg ],
  function( poly, name_of_indeterminates, rationals )
    local split_pos, poly_split, k, poly_split2, pos, coeff, l;

    # poly is a linear combination of generators in the range, so first identify the positions of plus and minus
    split_pos := [ 1 ];
    Append( split_pos, Positions( poly, '-' ) );
    Append( split_pos, Positions( poly, '+' ) );
    split_pos := DuplicateFreeList( split_pos );
    Sort( split_pos );

    # identify all of the substrings
    poly_split := List( [ 1 .. Length( split_pos ) ] );
    for k in [ 1 .. Length( split_pos ) ] do
       if k < Length( split_pos ) then
          poly_split[ k ] := List( [ 1 .. split_pos[ k+1 ] - split_pos[ k ] ], l -> poly[ split_pos[ k ] - 1 + l ] );
       else
          poly_split[ k ] := List( [ 1 .. Length( poly ) - split_pos[ k ] + 1 ], l -> poly[ split_pos[ k ] - 1 + l ] );
       fi;
    od;

    # next evaluate each of the substrings, thereby carefully tell apart the coefficient and the generator
    poly_split2 := List( [ 1 .. Length( poly_split ) ] );
    for k in [ 1 .. Length( poly_split ) ] do

       # split strings start with indeterminate -> coefficient is 1
       if poly_split[ k ][ 1 ] = name_of_indeterminates then

         poly_split2[ k ] := [ One( rationals ), poly_split[ k ] ];

       # else there is a non-trivial coefficient
       elif poly_split[ k ][ 1 ] <> name_of_indeterminates then

         # find first occurance of name_of_indeterminates -> whatever is in front of it will be our coefficient
         pos := Position( poly_split[ k ], name_of_indeterminates );

         # there indeed appear an indeterminate
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
           poly_split2[ k ] := [ Rat( coeff ) / rationals, poly_split[ k ] ];

         # no indeterminate appears, so the entire string is the coefficient and the monom is just 1
         else

           poly_split2[ k ] := [ Rat( poly_split[ k ] ) / rationals, "1" ];

         fi;

       fi;

    od;

    # and return the result
    return poly_split2;

end );

# Method to perform truncation of morphism of graded rows/columns in non-trivial cases:
InstallMethod( NonTrivialMorphismTruncation,
               " a list, as list, a morphism of graded rows of columns, a list, a ring, a bool",
               [ IsList, IsGradedRowOrColumnMorphism, IsFieldForHomalg, IsBool ],
  function( input, projective_module_morphism, rationals, display_messages )
    local gens_source, generators_range,
          mapping_matrix, name_of_indeterminates, matrix, gens_range, counter, i, comparer, non_zero_rows, j,
          coeffsAndVars, pos, k;

    # extract generators
    gens_source := input[ 1 ];
    generators_range := input[ 2 ];

    # extract the underlying matrix of the morphism
    mapping_matrix := UnderlyingHomalgMatrix( projective_module_morphism );
    if IsGradedRowMorphism( projective_module_morphism ) then
      mapping_matrix := Involution( mapping_matrix );
    fi;

    # identify the names of the indeterminates in the Cox ring (we later search for these)
    name_of_indeterminates := String( IndeterminatesOfPolynomialRing( HomalgRing( mapping_matrix ) )[ 1 ] )[ 1 ];

    # initialise the matrix as a sparse matrix
    matrix := HomalgInitialMatrix( generators_range[ 1 ], Length( gens_source ), rationals );

    # and identify the list of all generators of the range from the given input
    gens_range := generators_range[ 2 ];

    # initalise the counter
    counter := 1;

    # print status of the computation
    if display_messages then
        Print( Concatenation( "NrRows: ", String( NrRows( matrix ) ), "\n" ) );
        Print( Concatenation( "NrColumns: ", String( NrColumns( matrix ) ), "\n" ) );
        Print( Concatenation( "Have to go until i = ", String( Length( gens_source ) ), "\n" ) );
    fi;

    # now iterate over all generators in the source
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
        non_zero_rows := NonZeroRows( comparer );
        comparer := EntriesOfHomalgMatrix( comparer );

        # express this image in terms of the range generators and set the matrix entries accordingly
        for j in [ 1 .. Length( non_zero_rows ) ] do

          # the following method identifies the appearing range generators and their coefficients
          # (it is quicker than LeftDivide, which is why I use it)
          coeffsAndVars := FindVarsAndCoefficients( String( comparer[ non_zero_rows[ j ] ] ),
                                                    name_of_indeterminates,
                                                    rationals
                                                 );

          # set the entries of the matrix accordingly
          for k in [ 1 .. Length( coeffsAndVars ) ] do

            pos := gens_range[ non_zero_rows[ j ] ].( coeffsAndVars[ k ][ 2 ] );
            SetMatElm( matrix, pos, i, coeffsAndVars[ k ][ 1 ] );

          od;

        od;

      od;

      # and return the result
      if display_messages then
        Print( "matrix created... \n" );
      fi;

    # and return the matrix
    return matrix;

end );

# compute degree X layer of morphism of graded rows or columns
InstallMethod( TruncateGradedRowOrColumnMorphism,
               " a toric variety, a projective graded module morphism, a list",
               [ IsToricVariety, IsGradedRowOrColumnMorphism, IsList, IsFieldForHomalg, IsBool ],
  function( variety, projective_module_morphism, degree, rationals, display_messages )
    local gens_source, gens_range, matrix;

    # input test
    if not InputTest( variety, projective_module_morphism, degree ) then
      return;
    fi;

    # extract source and range generators
    gens_source := GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListOfColumnMatrices(
                                                   variety, Source( projective_module_morphism ), degree );
    gens_range := GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListsOfRecords(
                                                   variety, Range( projective_module_morphism ), degree );

    # signal start of the matrix computation
    if display_messages then
        Print( "Starting the matrix computation now... \n \n" );
    fi;

    # truncate the mapping matrix
    if Length( gens_source ) = 0 then
      matrix := HomalgZeroMatrix( gens_range[ 1 ], 0, rationals );
    elif gens_range[ 1 ] = 0 then
      matrix := HomalgZeroMatrix( 0, Length( gens_source ), rationals );
    else;
      matrix := NonTrivialMorphismTruncation( [ gens_source, gens_range ], projective_module_morphism, rationals, display_messages );
    fi;

    # signal end of matrix computation
    if display_messages then
      Print( Concatenation( "NrRows: ", String( NrRows( matrix ) ), "\n" ) );
      Print( Concatenation( "NrColumns: ", String( NrColumns( matrix ) ), "\n" ) );
      Print( "matrix created... \n" );
    fi;

    # and return the corresponding vector space morphism
    # LinearAlgebraForCAP supports left vector spaces, but matrix is the mapping matrix of right vector spaces -> 'Involution'
    return VectorSpaceMorphism( VectorSpaceObject( NrColumns( matrix ), rationals ),
                                Involution( matrix ),
                                VectorSpaceObject( NrRows( matrix ), rationals ) );

end );


# compute degree X layer of projective graded S-module
InstallMethod( TruncateGradedRowOrColumnMorphism,
               " a toric variety, a projective graded module morphism, a homalg_module_element",
               [ IsToricVariety, IsGradedRowOrColumnMorphism, IsHomalgModuleElement, IsHomalgRing, IsBool ],
  function( variety, projective_module_morphism, degree, rationals, display_messages )

    return TruncateGradedRowOrColumnMorphism(
                   variety, projective_module_morphism, UnderlyingListOfRingElements( degree ), rationals, display_messages );

end );

InstallMethod( TruncateGradedRowOrColumnMorphism,
               " a toric variety, a projective graded module morphism, a homalg_module_element",
               [ IsToricVariety, IsGradedRowOrColumnMorphism, IsList, IsBool ],
  function( variety, projective_module_morphism, degree, display_messages )

    return TruncateGradedRowOrColumnMorphism(
                                       variety, projective_module_morphism, degree, CoefficientsRing( CoxRing( variety ) ), display_messages );

end );

InstallMethod( TruncateGradedRowOrColumnMorphism,
               " a toric variety, a projective graded module morphism, a homalg_module_element",
               [ IsToricVariety, IsGradedRowOrColumnMorphism, IsHomalgModuleElement, IsBool ],
  function( variety, projective_module_morphism, degree, display_messages )

    return TruncateGradedRowOrColumnMorphism(
               variety, projective_module_morphism, UnderlyingListOfRingElements( degree ), CoefficientsRing( CoxRing( variety ) ),
               display_messages 
           );

end );

InstallMethod( TruncateGradedRowOrColumnMorphism,
               " a toric variety, a projective graded module morphism, a homalg_module_element",
               [ IsToricVariety, IsGradedRowOrColumnMorphism, IsList ],
  function( variety, projective_module_morphism, degree )

    return TruncateGradedRowOrColumnMorphism(
                                       variety, projective_module_morphism, degree, CoefficientsRing( CoxRing( variety ) ), false );

end );

InstallMethod( TruncateGradedRowOrColumnMorphism,
               " a toric variety, a projective graded module morphism, a homalg_module_element",
               [ IsToricVariety, IsGradedRowOrColumnMorphism, IsHomalgModuleElement ],
  function( variety, projective_module_morphism, degree )

    return TruncateGradedRowOrColumnMorphism(
               variety, projective_module_morphism, UnderlyingListOfRingElements( degree ), CoefficientsRing( CoxRing( variety ) ), false );

end );

# compute degree X layer of morphism of graded rows or columns
InstallMethod( DegreeXLayerOfGradedRowOrColumnMorphism,
               " a toric variety, a projective graded module morphism, a list",
               [ IsToricVariety, IsGradedRowOrColumnMorphism, IsList, IsFieldForHomalg, IsBool ],
  function( variety, projective_module_morphism, degree, rationals, display_messages )
    local vector_space_morphism;

    # identify the underlying vector space morphism
    vector_space_morphism := TruncateGradedRowOrColumnMorphism(
                                                     variety, projective_module_morphism, degree, rationals, display_messages );

    # and dress it as DegreeXLayer presentation thereof
    return DegreeXLayerVectorSpaceMorphism(
                   DegreeXLayerOfGradedRowOrColumn( variety, Source( projective_module_morphism ), degree, rationals ),
                   vector_space_morphism,
                   DegreeXLayerOfGradedRowOrColumn( variety, Range( projective_module_morphism ), degree, rationals ) );

end );

# compute degree X layer of projective graded S-module
InstallMethod( DegreeXLayerOfGradedRowOrColumnMorphism,
               " a toric variety, a projective graded module morphism, a homalg_module_element",
               [ IsToricVariety, IsGradedRowOrColumnMorphism, IsHomalgModuleElement, IsHomalgRing, IsBool ],
  function( variety, projective_module_morphism, degree, rationals, display_messages )

    return DegreeXLayerOfGradedRowOrColumnMorphism(
                   variety, projective_module_morphism, UnderlyingListOfRingElements( degree ), rationals, display_messages );

end );

InstallMethod( DegreeXLayerOfGradedRowOrColumnMorphism,
               " a toric variety, a projective graded module morphism, a homalg_module_element",
               [ IsToricVariety, IsGradedRowOrColumnMorphism, IsList, IsBool ],
  function( variety, projective_module_morphism, degree, display_messages )

    return DegreeXLayerOfGradedRowOrColumnMorphism(
                                       variety, projective_module_morphism, degree, CoefficientsRing( CoxRing( variety ) ), display_messages );

end );

InstallMethod( DegreeXLayerOfGradedRowOrColumnMorphism,
               " a toric variety, a projective graded module morphism, a homalg_module_element",
               [ IsToricVariety, IsGradedRowOrColumnMorphism, IsHomalgModuleElement, IsBool ],
  function( variety, projective_module_morphism, degree, display_messages )

    return DegreeXLayerOfGradedRowOrColumnMorphism(
               variety, projective_module_morphism, UnderlyingListOfRingElements( degree ), CoefficientsRing( CoxRing( variety ) ),
               display_messages 
           );

end );

InstallMethod( DegreeXLayerOfGradedRowOrColumnMorphism,
               " a toric variety, a projective graded module morphism, a homalg_module_element",
               [ IsToricVariety, IsGradedRowOrColumnMorphism, IsList ],
  function( variety, projective_module_morphism, degree )

    return DegreeXLayerOfGradedRowOrColumnMorphism(
                                       variety, projective_module_morphism, degree, CoefficientsRing( CoxRing( variety ) ), false );

end );

InstallMethod( DegreeXLayerOfGradedRowOrColumnMorphism,
               " a toric variety, a projective graded module morphism, a homalg_module_element",
               [ IsToricVariety, IsGradedRowOrColumnMorphism, IsHomalgModuleElement ],
  function( variety, projective_module_morphism, degree )

    return DegreeXLayerOfGradedRowOrColumnMorphism(
               variety, projective_module_morphism, UnderlyingListOfRingElements( degree ), CoefficientsRing( CoxRing( variety ) ), false );

end );


######################################################################################################
##
## Section Truncation a PROJECTIVE graded module morphism and write the corresponding matrix to a file
##         formated for use in gap
##
######################################################################################################

# Method to interpret image polynomial in above method in terms of the generators of the range module
InstallMethod( FindVarsAndCoefficientsWithoutEvaluation,
               " a string, a string",
               [ IsString, IsChar ],
  function( poly, name_of_indeterminates )
    local split_pos, poly_split, k, poly_split2, pos, coeff, l;

    # poly is a linear combination of generators in the range, so first identify the positions of plus and minus
    split_pos := [ 1 ];
    Append( split_pos, Positions( poly, '-' ) );
    Append( split_pos, Positions( poly, '+' ) );
    split_pos := DuplicateFreeList( split_pos );
    Sort( split_pos );

    # identify all of the substrings
    poly_split := List( [ 1 .. Length( split_pos ) ] );
    for k in [ 1 .. Length( split_pos ) ] do
       if k < Length( split_pos ) then
          poly_split[ k ] := List( [ 1 .. split_pos[ k+1 ] - split_pos[ k ] ], l -> poly[ split_pos[ k ] - 1 + l ] );
       else
          poly_split[ k ] := List( [ 1 .. Length( poly ) - split_pos[ k ] + 1 ], l -> poly[ split_pos[ k ] - 1 + l ] );
       fi;
    od;

    # next evaluate each of the substrings, thereby carefully tell apart the coefficient and the generator
    poly_split2 := List( [ 1 .. Length( poly_split ) ] );
    for k in [ 1 .. Length( poly_split ) ] do

       # split strings start with indeterminate -> coefficient is 1
       if poly_split[ k ][ 1 ] = name_of_indeterminates then

         poly_split2[ k ] := [ "1", poly_split[ k ] ];

       # else there is a non-trivial coefficient
       elif poly_split[ k ][ 1 ] <> name_of_indeterminates then

         # find first occurance of name_of_indeterminates -> whatever is in front of it will be our coefficient
         pos := Position( poly_split[ k ], name_of_indeterminates );

         # there indeed appear an indeterminate
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

         # no indeterminate appears, so the entire string is the coefficient and the monom is just 1
         else

           poly_split2[ k ] := [ poly_split[ k ], "1" ];

         fi;

       fi;

       # remove "+" from coefficient for easier processing
       RemoveCharacters( poly_split2[ k ][ 1 ], "+" );

    od;

    # return the result
    return poly_split2;

end );




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
    local images, gens_range, name_of_indeterminates, dim_range, positions, counter, i,
         comparer, non_zero_rows, j, l, pos, coeffsAndVars;

    # check for valid input
    if starting_pos < 0 then
      Error( "the starting position must be non-negative" );
    elif starting_pos > ending_pos then
      Error( "the starting position must not be bigger than the ending position" );
    elif ending_pos > Length( images ) then
      Error( "the ending position must not be bigger than the number of images to translate" );
    fi;

    # extract data to perform calculation with
    images := infos[ 1 ];
    gens_range := infos[ 2 ];
    name_of_indeterminates := infos[ 3 ];
    dim_range := gens_range[ 1 ];
    gens_range := gens_range[ 2 ];

    # initialise variables
    positions := [];
    counter := 1;

    # print status of the computation
    if display_messages then
      Print( "starting the matrix computation... \n \n" );
      Print( Concatenation( "NrRows: ", String( Length( images ) ), "\n" ) );
      Print( Concatenation( "NrColumns: ", String( dim_range ), "\n" ) );
      Print( Concatenation( "Have to go until i = ", String( Length( images ) ), "\n" ) );
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

        # the following method identifies the appearing range generators and their coefficients
        # (it is quicker than LeftDivide, which is why I use it)
        coeffsAndVars := FindVarsAndCoefficientsWithoutEvaluation(
                                  String( comparer[ non_zero_rows[ j ] ] ), name_of_indeterminates );

        # next figure out which range monoms did appear
        for k in [ 1 .. Length( coeffsAndVars ) ] do

          pos := gens_range[ non_zero_rows[ j ] ].( coeffsAndVars[ k ][ 2 ] );
          Append( positions, [ [ i, pos, Rat( coeffsAndVars[ k ][ 1 ] ) ] ] );

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


# compute degree X layer of morphism of graded rows or columns
InstallMethod( TruncateGradedRowOrColumnMorphismInParallel,
               " a toric variety, a projective graded module morphism, a list",
               [ IsToricVariety, IsGradedRowOrColumnMorphism, IsList, IsFieldForHomalg, IsBool, IsInt ],
  function( variety, projective_module_morphism, degree, rationals, display_messages, NrJobs )
    local gens_source, gens_range, matrix;

    # input test
    if not InputTest( variety, projective_module_morphism, degree ) then
      return;
    fi;

    # extract source and range generators
    gens_source := GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListOfColumnMatrices(
                                                   variety, Source( projective_module_morphism ), degree );
    gens_range := GeneratorsOfDegreeXLayerOfGradedRowOrColumnAsListsOfRecords(
                                                   variety, Range( projective_module_morphism ), degree );

    # signal start of the matrix computation
    if display_messages then
        Print( "Starting the matrix computation now... \n \n" );
    fi;

    # truncate the mapping matrix
    if Length( gens_source ) = 0 then
      matrix := HomalgZeroMatrix( gens_range[ 1 ], 0, rationals );
    elif gens_range[ 1 ] = 0 then
      matrix := HomalgZeroMatrix( 0, Length( gens_source ), rationals );
    else;
      matrix := NonTrivialMorphismTruncation( [ gens_source, gens_range ], projective_module_morphism, rationals, display_messages );
    fi;

    # signal end of matrix computation
    if display_messages then
      Print( Concatenation( "NrRows: ", String( NrRows( matrix ) ), "\n" ) );
      Print( Concatenation( "NrColumns: ", String( NrColumns( matrix ) ), "\n" ) );
      Print( "matrix created... \n" );
    fi;

    # and return the corresponding vector space morphism
    # LinearAlgebraForCAP supports left vector spaces, but matrix is the mapping matrix of right vector spaces -> 'Involution'
    return VectorSpaceMorphism( VectorSpaceObject( NrColumns( matrix ), rationals ),
                                Involution( matrix ),
                                VectorSpaceObject( NrRows( matrix ), rationals ) );

end );
