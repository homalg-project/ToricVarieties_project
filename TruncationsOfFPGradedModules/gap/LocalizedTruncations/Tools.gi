################################################################################################
##
##  Tools.gi                           TruncationsOfFPGradedModules
##
##  Copyright 2020                     Martin Bies,       University of Oxford
##
##  Technical functions
##
################################################################################################


################################################################################################
#  Functions to facilitate localized truncations
################################################################################################

InstallMethod( Get_image_of_generator,
               [ IsList, IsHomalgRingElement ],
  function( generator, homalg_ring_element )
    local element_exponents;
    
    element_exponents := CommonHomalgTableForSingularTools.PolynomialExponents( UnderlyingNonGradedRingElement( homalg_ring_element ) );
    
    return List( element_exponents, i -> i + generator );
    
end );


InstallMethod( Result_of_generator,
               [ IsList, IsHomalgRingElement, IsList, IsList ],
  function( generator, element, new_generators, base_ring_generators )
    local image_of_generator, base_ring_generators_transposed, collected_vectors, current_monomial, i, current_solution,
          inequality_matrix_list, inequality_matrix_list_rhs;
    
    image_of_generator := Get_image_of_generator( generator, element );
    
    collected_vectors := [ ];
    
    if base_ring_generators <> [ ] then
    
        base_ring_generators_transposed := TransposedMat( base_ring_generators );
        
        inequality_matrix_list := IdentityMat( Length( base_ring_generators_transposed[ 1 ] ) );
        inequality_matrix_list_rhs := ListWithIdenticalEntries( Length( base_ring_generators_transposed[ 1 ] ), 0 );
        
        for current_monomial in image_of_generator do
            
            for i in [ 1 .. Length( new_generators ) ] do
                
                ## Unfortunately, there is a bug in 4ti2, not displaying 0 as a solution if
                ## it is the only solution present. We are nevertheless going to prefer this solution.
                
                if ForAll( current_monomial - new_generators[ i ], i -> i = 0 ) then
                    Add( collected_vectors, [ i, 0 ] );
                    break;
                fi;
                
                current_solution := 4ti2Interface_zsolve_equalities_and_inequalities(
                                        base_ring_generators_transposed, current_monomial - new_generators[ i ],
                                        inequality_matrix_list, inequality_matrix_list_rhs );
                
                if current_solution <> [ ] and current_solution[ 1 ] <> [ ] then
                    Add( collected_vectors, [ i, current_solution[ 1 ][ 1 ] ] );
                    break;
                fi;
                
            od;
            
        od;
        
    else
        
        for current_monomial in image_of_generator do
            
            for i in [ 1 .. Length( new_generators ) ] do
                
                if current_monomial = new_generators[ i ] then
                    
                    Add( collected_vectors, [ i, 0 ] );
                    
                fi;
                
            od;
        od;
        
    fi;
    
    return collected_vectors;
    
end );


InstallMethod( Block_matrix_to_matrix,
               [ IsList ],
  function( block_matrix )
    local cols, rows, i, j, k, current_row, current_row_lenth, current_row_cols,
          current_single_row, resulting_mat;
    
    rows := Length( block_matrix );
    cols := Length( block_matrix[ 1 ] );
    
    resulting_mat := [ ];
    
    for i in [ 1 .. rows ] do
        current_row := block_matrix[ i ];
        current_row_lenth := Length( current_row );
        current_row_cols := Length( current_row[ 1 ] );
        
        for j in [ 1 .. current_row_cols ] do
            current_single_row := [ ];
            for k in [ 1 .. current_row_lenth ] do
                Append( current_single_row, current_row[ k ][ j ] );
            od;
            Add( resulting_mat, current_single_row );
            
        od;
        
    od;
    
    return resulting_mat;
    
end );


InstallMethod( New_matrix_mapping_by_generator_lists,
               [ IsList, IsList, IsList, IsList, IsHomalgRing ],
  function( source_generator_list_list, range_generator_list_list, homalg_matrix_as_list_list, ring_generators, new_ring )
    local mapped_matrix, polynomial_coeffs, i, j, matrix_prototype, k, current_source_generator_map, l, matrix_mapping, base_ring_indets;
    
    base_ring_indets := Indeterminates( new_ring );
    
    mapped_matrix := List( source_generator_list_list, i -> ListWithIdenticalEntries( Length( range_generator_list_list ), 0 ) );
    
    for i in [ 1 .. Length( source_generator_list_list ) ] do
        for j in [ 1 .. Length( range_generator_list_list ) ] do
            mapped_matrix[ i ][ j ] := List( source_generator_list_list[ i ],
                                                              k -> Result_of_generator( k, homalg_matrix_as_list_list[ i ][ j ],
                                                                                        range_generator_list_list[ j ], ring_generators ) );
        od;
    od;
    
    polynomial_coeffs := List( homalg_matrix_as_list_list, i -> List( i, j -> SplitString( CommonHomalgTableForSingularTools.PolynomialCoefficients( UnderlyingNonGradedRingElement( j ) ), "," ) ) );
    
    for i in [ 1 .. Length( source_generator_list_list ) ] do
        for j in [ 1 .. Length( range_generator_list_list ) ] do
            
            matrix_prototype := List( [ 1 .. Length( source_generator_list_list[ i ] ) ], x -> List( [ 1 .. Length( range_generator_list_list[ j ] ) ], y -> [ ] ) );
            
            for k in [ 1 .. Length( mapped_matrix[ i ][ j ] ) ] do
                current_source_generator_map := mapped_matrix[ i ][ j ][ k ];
                
                for l in [ 1 .. Length( current_source_generator_map ) ] do
                    
                    Add( matrix_prototype[ k ][ current_source_generator_map[ l ][ 1 ] ], polynomial_coeffs[ i ][ j ][ l ] );
                    
                    if( current_source_generator_map[ l ][ 2 ] = 0 ) then
                        Add( matrix_prototype[ k ][ current_source_generator_map[ l ][ 1 ] ], String( 1 ) );
                    else
                        Add( matrix_prototype[ k ][ current_source_generator_map[ l ][ 1 ] ], 
                            String( Product( [ 1 .. Length( base_ring_indets ) ], x -> base_ring_indets[ x ]^current_source_generator_map[ l ][ 2 ][ x ] ) ) );
                    fi;
                    
                od;
                
            od;
            
            for k in [ 1 .. Length( source_generator_list_list[ i ] ) ] do
                for l in [ 1 .. Length( range_generator_list_list[ j ] ) ] do
                    if matrix_prototype[ k ][ l ] = [ ] then
                        matrix_prototype[ k ][ l ] := String( 0 );
                    else
                        matrix_prototype[ k ][ l ] := JoinStringsWithSeparator( matrix_prototype[ k ][ l ], "*" );
                    fi;
                od;
            od;
            
            mapped_matrix[ i ][ j ] := matrix_prototype;
            
        od;
    od;
    
    matrix_mapping := Block_matrix_to_matrix( mapped_matrix );
    
    matrix_mapping := HomalgMatrix( matrix_mapping, new_ring );
    
    return matrix_mapping;
    
end );


################################################################################################
#  Functions to convert rows and columns (and presentations thereof)
################################################################################################

InstallMethod( TurnIntoColumn,
               [ IsCategoryOfRowsObject ],
  function( row )
    
    return CategoryOfColumnsObject( RankOfObject( row ), CategoryOfColumns( UnderlyingRing( row ) ) );
    
end );

InstallMethod( TurnIntoRow,
               [ IsCategoryOfColumnsObject ],
  function( column )
    
    return CategoryOfRowsObject( RankOfObject( column ), CategoryOfRows( UnderlyingRing( column ) ) );
    
end );

InstallMethod( TurnIntoColumnMorphism,
               [ IsCategoryOfRowsMorphism ],
  function( row_mor )
    local new_source, new_matrix, new_range;
    
    new_source := TurnIntoColumn( Source( row_mor ) );
    new_matrix := Involution( UnderlyingMatrix( row_mor ) );
    new_range := TurnIntoColumn( Range( row_mor ) );
    return CategoryOfColumnsMorphism( new_source, new_matrix, new_range );
    
end );

InstallMethod( TurnIntoRowMorphism,
               [ IsCategoryOfColumnsMorphism ],
  function( col_mor )
    local new_source, new_matrix, new_range;
    
    new_source := TurnIntoRow( Source( col_mor ) );
    new_matrix := Involution( UnderlyingMatrix( col_mor ) );
    new_range := TurnIntoRow( Range( col_mor ) );
    return CategoryOfRowsMorphism( new_source, new_matrix, new_range );
    
end );

InstallMethod( TurnIntoColumnPresentation,
               [ IsFreydCategoryObject ],
  function( row_presentation )
    local ring, new_source, new_matrix, new_range;
    
    # check if the input really is a row presentation
    if not HasUnderlyingRing( RelationMorphism( row_presentation ) ) then
        Error( "Input must be a row presentation" );
    fi;
    
    # extract the ring
    ring := UnderlyingRing( RelationMorphism( row_presentation ) );
    
    # check categories
    if not CapCategory( RelationMorphism( row_presentation ) ) = CategoryOfRows( ring ) then
        Error( "Input must be a row presentation" );
    fi;
    
    # now perform conversion
    new_source := TurnIntoColumn( Source( RelationMorphism( row_presentation ) ) );
    new_matrix := Involution( UnderlyingMatrix( RelationMorphism( row_presentation ) ) );
    new_range := TurnIntoColumn( Range( RelationMorphism( row_presentation ) ) );
    return FreydCategoryObject( CategoryOfColumnsMorphism( new_source, new_matrix, new_range ) );
    
end );

InstallMethod( TurnIntoRowPresentation,
               [ IsFreydCategoryObject ],
  function( column_presentation )
    local ring, new_source, new_matrix, new_range;
    
    # check if the input really is a row presentation
    if not HasUnderlyingRing( RelationMorphism( column_presentation ) ) then
        Error( "Input must be a column presentation" );
    fi;
    
    # extract the ring
    ring := UnderlyingRing( RelationMorphism( column_presentation ) );
    
    # check categories
    if not CapCategory( RelationMorphism( column_presentation ) ) = CategoryOfColumns( ring ) then
        Error( "Input must be a column presentation" );
    fi;
    
    # now perform conversion
    new_source := TurnIntoRow( Source( RelationMorphism( column_presentation ) ) );
    new_matrix := Involution( UnderlyingMatrix( RelationMorphism( column_presentation ) ) );
    new_range := TurnIntoRow( Range( RelationMorphism( column_presentation ) ) );
    return FreydCategoryObject( CategoryOfRowsMorphism( new_source, new_matrix, new_range ) );
    
end );

InstallMethod( TurnIntoColumnPresentationMorphism,
               [ IsFreydCategoryMorphism ],
  function( row_presentation_morphism )
    local new_source, new_mor_datum, new_range;
    
    # now perform conversion
    new_source := TurnIntoColumnPresentation( Source( row_presentation_morphism ) );
    new_mor_datum := TurnIntoColumnMorphism( MorphismDatum( row_presentation_morphism ) );
    new_range := TurnIntoColumnPresentation( Range( row_presentation_morphism ) );
    return FreydCategoryMorphism( new_source, new_mor_datum, new_range );
    
end );

InstallMethod( TurnIntoRowPresentationMorphism,
               [ IsFreydCategoryMorphism ],
  function( col_presentation_morphism )
    local new_source, new_mor_datum, new_range;
    
    # now perform conversion
    new_source := TurnIntoRowPresentation( Source( col_presentation_morphism ) );
    new_mor_datum := TurnIntoRowMorphism( MorphismDatum( col_presentation_morphism ) );
    new_range := TurnIntoRowPresentation( Range( col_presentation_morphism ) );
    return FreydCategoryMorphism( new_source, new_mor_datum, new_range );
    
end );
