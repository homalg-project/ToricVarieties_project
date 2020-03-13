################################################################################################
##
##  LocalizedTruncationsOfFPGradedModules.gd        TruncationsOfFPGradedModules
##
##  Copyright 2020               Martin Bies,       University of Oxford
##
##  Localized truncations of FPGradedModules
##
################################################################################################


#######################################################################################
##
##  Localized degree-0-layer of f.p. graded modules
##
#######################################################################################


InstallMethod( LocalizedDegreeZero,
               [ IsFpGradedLeftOrRightModulesObject, IsList, IsHomalgGradedRing, IsList, IsCapCategory ],
  function( module, localized_variables, graded_ring, new_ring_data, rows )
    local new_rel_mor, new_object;
    
    # localized truncation of the underlying morphism
    new_rel_mor := LocalizedDegreeZero( RelationMorphism( module ), localized_variables, graded_ring, new_ring_data, rows );
    
    # set up the new object
    new_object := CokernelObject( new_rel_mor );
    new_object!.degree_part_generator_monomials := new_rel_mor!.degree_part_generator_monomials;
    new_object!.deleted_free_parts := new_rel_mor!.deleted_free_parts;
    
    # and return it
    return new_object;
    
end );


InstallMethod( LocalizedDegreeZero,
               [ IsFpGradedLeftOrRightModulesObject, IsList ],
  function( module, localized_variables )
    local graded_ring, new_ring_data, rows;
    
    # compute the localized ring
    graded_ring := UnderlyingHomalgGradedRing( RelationMorphism( module ) );
    new_ring_data := Localized_degree_zero_ring_and_generators( graded_ring, localized_variables );
    
    # initialize the category of rows of the new ring
    rows := CategoryOfRows( new_ring_data[ 2 ] );
    
    # compute the truncation
    return LocalizedDegreeZero( module, localized_variables, graded_ring, new_ring_data, rows );
    
end );


InstallMethod( LocalizedDegreeZero,
               [ IsFpGradedLeftOrRightModulesMorphism, IsList ],
  function( module_morphism, localized_variables )
    local graded_ring, new_ring_data, rows, new_source, new_source_deleted, new_range, new_range_deleted, matrix_as_list_list, 
         i, new_matrix, mor;
    
    # compute the localized ring
    graded_ring := UnderlyingHomalgGradedRing( MorphismDatum( module_morphism ) );
    new_ring_data := Localized_degree_zero_ring_and_generators( graded_ring, localized_variables );
    
    # initialize the category of rows of the new ring
    rows := CategoryOfRows( new_ring_data[ 2 ] );
    
    # truncate source and range
    new_source := LocalizedDegreeZero( Source( module_morphism ), localized_variables, graded_ring, new_ring_data, rows );
    new_source_deleted := new_source!.deleted_free_parts;
    new_range := LocalizedDegreeZero( Range( module_morphism ), localized_variables, graded_ring, new_ring_data, rows );
    new_range_deleted := new_range!.deleted_free_parts;
    
    # extract the underlying matrix
    matrix_as_list_list := EntriesOfHomalgMatrixAsListList(  UnderlyingHomalgMatrix( MorphismDatum( module_morphism ) ) );
    
    # and remove trivial parts
    for i in Reversed( new_source_deleted ) do
        Remove( matrix_as_list_list, i );
    od;
    matrix_as_list_list := TransposedMatMutable( matrix_as_list_list );
    for i in Reversed( new_range_deleted ) do
        Remove( matrix_as_list_list, i );
    od;
    matrix_as_list_list := TransposedMatMutable( matrix_as_list_list );
    
    # finally compute the non-trivial entries
    new_matrix := New_matrix_mapping_by_generator_lists( new_source!.degree_part_generator_monomials,
                                                         new_range!.degree_part_generator_monomials,
                                                         matrix_as_list_list,
                                                         new_ring_data[ 1 ],
                                                         new_ring_data[ 2 ] );
    
    # and form the corresponding morphism
    mor := CategoryOfRowsMorphism( Range( RelationMorphism( new_source ) ), new_matrix, Range( RelationMorphism( new_range ) ) );
    return FreydCategoryMorphism( new_source, mor, new_range );
    
end );
