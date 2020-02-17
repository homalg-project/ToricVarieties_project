################################################################################################
##
##  Subvarieties.gd                    CoherentSheavesOnToricVarieties package
##
##  Copyright 2020                     Martin Bies,       University of Oxford
##
#! @Chapter Subvarieties of toric varieties
##
################################################################################################


##############################################################################################
##
## GAP category for subvarieties of toric varieties
##
##############################################################################################

# install SMSSparseMatrix and SMSSparseMatrices
DeclareRepresentation( "IsSubvarietyOfToricVarietyRep",
                       IsSubvarietyOfToricVariety and IsAttributeStoringRep, [ ] );

BindGlobal( "TheFamilyOfSubvarietiesOfToricVarieties",
            NewFamily( "TheFamilyOfSubvarietiesOfToricVarieties" ) );

BindGlobal( "TheTypeOfSubvarietyOfToricVariety",
            NewType( TheFamilyOfSubvarietiesOfToricVarieties, IsSubvarietyOfToricVarietyRep ) );


##############################################################################################
##
## Constructor for SMSSparseMatrices
##
##############################################################################################

# constructor for DegreeXLayerVectorSpaces
InstallMethod( SubvarietyOfToricVariety,
               "a toric variety and a list",
               [ IsToricVariety, IsList ],
  function( var, poly_list )
    local subvariety;
    
    # Check for valid input
    if not ForAll( poly_list, IsRingElement ) then
        Error( "Not all list elements are ring elements" );
        return;
    fi;
    if not ForAll( poly_list, function( p ) if HomalgRing( p ) = CoxRing( var ) then return true; else return false; fi; end ) then
        Error( "Not all list elements are elements of the Cox ring of the provided toric variety" );
    fi;
    
    # Then build the subvariety
    subvariety := rec( );
    ObjectifyWithAttributes( subvariety, TheTypeOfSubvarietyOfToricVariety,
                             AmbientToricVariety, var,
                             DefiningEquations, poly_list
                             );
    return subvariety;
    
end );


#################################################
##
## Section: String methods for the new categories
##
#################################################

InstallMethod( String,
              [ IsSubvarietyOfToricVariety ],
  function( subvariety )
    local s;
    
    # obtain name of the toric variety in question
    s := ToricVarietyString( AmbientToricVariety( subvariety ) );
    
    # print out the details
    if Length( DefiningEquations( subvariety ) ) > 1 then
            return Concatenation( "A subvariety of ", s, " defined by ", String( Length( DefiningEquations( subvariety ) ) ), " equations" );
    else
            return Concatenation( "A subvariety of ", s , " defined by one equation" );
    fi;
    
end );


##################################################
##
## Section: Display methods for the new categories
##
##################################################

InstallMethod( Display,
              [ IsSubvarietyOfToricVariety ],
  function( subvariety )
    local i;
    
    Print( "\n" );
    if Length( DefiningEquations( subvariety ) ) > 1 then
        Print( "Defining equations:\n" );
        Print( "-------------------\n" );
        for i in [ 1 .. Length( DefiningEquations( subvariety ) ) ] do
            Print( Concatenation( String( DefiningEquations( subvariety )[ i ] ), "\n" ) );
        od;
    else
        Print( "Defining equation:\n" );
        Print( "-------------------\n" );
        Print( Concatenation( String( DefiningEquations( subvariety )[ 1 ] ), "\n" ) );
    fi;
    Print( "\n" );
    Print( String( subvariety ) );
    Print( "\n\n" );

end );


################################################
##
## Section: View methods for the new categories
##
################################################

InstallMethod( ViewObj,
              [ IsSubvarietyOfToricVariety ],
               999, # FIXME FIXME FIXME!!!
  function( subvariety )

      Print( Concatenation( "<", String( subvariety ), ">" ) );

end );


################################################
##
## Section: Attributes of subvarieties
##
################################################


InstallMethod( LeftCoordinateRing,
              [ IsSubvarietyOfToricVariety ],
  function( subvariety )
    local tor;

    tor := AmbientToricVariety( subvariety );
    if Length( DefiningEquations( subvariety ) ) = 0 then
        return CoxRing( tor );
    else
        return CoxRing( tor ) / GradedLeftSubmodule( DefiningEquations( subvariety ), CoxRing( tor ) );
    fi;

end );


InstallMethod( LeftCoordinateRing,
              [ IsToricVariety ],
  function( tor )
    
    return CoxRing( tor );
    
end );


InstallMethod( RightCoordinateRing,
              [ IsSubvarietyOfToricVariety ],
  function( subvariety )
    local tor;

    tor := AmbientToricVariety( subvariety );
    if Length( DefiningEquations( subvariety ) ) = 0 then
        return CoxRing( tor );
    else
        return CoxRing( tor ) / GradedRightSubmodule( DefiningEquations( subvariety ), CoxRing( tor ) );
    fi;

end );


InstallMethod( RightCoordinateRing,
              [ IsToricVariety ],
  function( tor )
    
    return CoxRing( tor );
    
end );


InstallMethod( LeftStructureSheaf,
               "for toric Cartier divisors",
              [ IsSubvarietyOfToricVariety ],
  function( subvariety )
    local S, range, matrix, struc_sheaf;
    
    # identify the Cox ring of the ambient toric variety
    S := CoxRing( AmbientToricVariety( subvariety ) );
    
    # check for degenerate case
    if Length( DefiningEquations( subvariety ) ) = 0 then
        
        struc_sheaf := AsFreydCategoryObject( GradedRow( [[TheZeroElement(DegreeGroup(S)),1]], S ) );
        
    else
        
        # otherwise construct structure sheaf of the subvariety
        range := GradedRow( [[TheZeroElement(DegreeGroup(S)),1]], S );
        matrix := Involution( HomalgMatrix( [DefiningEquations( subvariety )], S ) );
        struc_sheaf := FreydCategoryObject( DeduceSomeMapFromMatrixAndRangeForGradedRows( matrix, range ) );
        
    fi;
    
    # check that this object is indeed well-defined
    if not IsWellDefined( struc_sheaf ) then
        Error( "The structure sheaf is not well-defined" );
    fi;
    
    # create a sheaf and return it
    return CoherentSheafOnToricVariety( AmbientToricVariety( subvariety ), struc_sheaf );
    
end );


InstallMethod( LeftStructureSheaf,
               "for toric Cartier divisors",
              [ IsToricVariety ],
  function( tor )
    
    return CoherentSheafOnToricVariety( tor, AsFreydCategoryObject( GradedRow( [[TheZeroElement(DegreeGroup(CoxRing( tor ))),1]], CoxRing( tor ) ) ) );
    
end );


InstallMethod( RightStructureSheaf,
              [ IsSubvarietyOfToricVariety ],
  function( subvariety )
    local S, range, matrix, struc_sheaf;
    
    # identify the Cox ring of the ambient toric variety
    S := CoxRing( AmbientToricVariety( subvariety ) );
    
    # check for degenerate case
    if Length( DefiningEquations( subvariety ) ) = 0 then
        
        struc_sheaf := AsFreydCategoryObject( GradedColumn( [[TheZeroElement(DegreeGroup(S)),1]], S ) );
        
    else
        
        # otherwise construct structure sheaf of the subvariety
        range := GradedColumn( [[TheZeroElement(DegreeGroup(S)),1]], S );
        matrix := HomalgMatrix( [DefiningEquations( subvariety )], S );
        struc_sheaf := FreydCategoryObject( DeduceSomeMapFromMatrixAndRangeForGradedCols( matrix, range ) );
        
    fi;
    
    # check that this object is indeed well-defined
    if not IsWellDefined( struc_sheaf ) then
        Error( "The structure sheaf is not well-defined" );
    fi;
    
    # return result
    return CoherentSheafOnToricVariety( AmbientToricVariety( subvariety ), struc_sheaf );
    
end );


InstallMethod( RightStructureSheaf,
               "for toric Cartier divisors",
              [ IsToricVariety ],
  function( tor )
    
    return CoherentSheafOnToricVariety( tor, AsFreydCategoryObject( GradedColumn( [[TheZeroElement(DegreeGroup(CoxRing( tor ))),1]], CoxRing( tor ) ) ) );
    
end );


##############################################################################################
##
## Operations on subvarieties of toric varieties
##
##############################################################################################


InstallMethod( LeftIdealSheafOnSubvariety,
              [ IsSubvarietyOfToricVariety, IsList ],
  function( subvariety, polynomials )
    local coxring, M, range, map, source, alpha, ideal_sheaf, matrix;
    
    # Extract the important information
    coxring := CoxRing( AmbientToricVariety( subvariety ) );
    
    # Check that the polynomials are specified in terms of the toric ambient space
    if not ForAll( polynomials, IsRingElement ) then
        Error( "Not all list elements are ring elements" );
        return;
    fi;
    if not ForAll( polynomials, function( p ) if HomalgRing( p ) = coxring then return true; else return false; fi; end ) then
        Error( "Not all list elements are elements of the Cox ring of the provided toric variety" );
    fi;
    
    # Derive map whose image is the ideal in question
    M := Involution( HomalgMatrix( [ polynomials ], 1, Length( polynomials ), LeftCoordinateRing( subvariety ) ) );
    range := GradedRow( [[TheZeroElement(DegreeGroup(coxring)),1]], LeftCoordinateRing( subvariety ) );
    map := DeduceSomeMapFromMatrixAndRangeForGradedRows( M, range );
    source := FreydCategoryObject( WeakKernelEmbedding( map ) );
    range := AsFreydCategoryObject( Range( map ) );
    alpha := FreydCategoryMorphism( source, map, range );

    # Compute the image
    ideal_sheaf := ImageObject( alpha );

    # turn ideal_sheaf into a module over the toric ambient space
    range := GradedRow( DegreeList( Range( RelationMorphism( ideal_sheaf ) ) ), coxring );
    if IsZero( UnderlyingHomalgMatrix( RelationMorphism( ideal_sheaf ) ) ) then
        ideal_sheaf := AsFreydCategoryObject( range );
    else
        matrix := HomalgMatrix( EntriesOfHomalgMatrixAsListList( UnderlyingHomalgMatrix( RelationMorphism( ideal_sheaf ) ) ), coxring );
        ideal_sheaf := FreydCategoryObject( DeduceSomeMapFromMatrixAndRangeForGradedRows( matrix, range ) );
    fi;
    ideal_sheaf := ByASmallerPresentation( TensorProductOnObjects( ideal_sheaf, DefiningModule( LeftStructureSheaf( subvariety ) ) ) );

    # Return result
    return CoherentSheafOnToricVariety( AmbientToricVariety( subvariety ), ideal_sheaf );

end );


InstallMethod( LeftIdealSheafOnSubvariety,
              [ IsToricVariety, IsList ],
  function( tor, polynomials )
    
    return LeftIdealSheafOnSubvariety( SubvarietyOfToricVariety( tor, [] ), polynomials );
    
end );


InstallMethod( RightIdealSheafOnSubvariety,
              [ IsSubvarietyOfToricVariety, IsList ],
  function( subvariety, polynomials )
    local coxring, M, range, map, source, alpha, ideal_sheaf, matrix;
    
    # Extract the important information
    coxring := CoxRing( AmbientToricVariety( subvariety ) );
    
    # Check that the polynomials are specified in terms of the toric ambient space
    if not ForAll( polynomials, IsRingElement ) then
        Error( "Not all list elements are ring elements" );
        return;
    fi;
    if not ForAll( polynomials, function( p ) if HomalgRing( p ) = coxring then return true; else return false; fi; end ) then
        Error( "Not all list elements are elements of the Cox ring of the provided toric variety" );
    fi;
    
    # Derive map whose image is the ideal in question
    M := HomalgMatrix( [ polynomials ], 1, Length( polynomials ), RightCoordinateRing( subvariety ) );
    range := GradedColumn( [[TheZeroElement(DegreeGroup(coxring)),1]], RightCoordinateRing( subvariety ) );
    map := DeduceSomeMapFromMatrixAndRangeForGradedCols( M, range );
    source := FreydCategoryObject( WeakKernelEmbedding( map ) );
    range := AsFreydCategoryObject( Range( map ) );
    alpha := FreydCategoryMorphism( source, map, range );

    # Compute the image
    ideal_sheaf := ImageObject( alpha );

    # turn ideal_sheaf into a module over the toric ambient space
    range := GradedColumn( DegreeList( Range( RelationMorphism( ideal_sheaf ) ) ), coxring );
    if IsZero( UnderlyingHomalgMatrix( RelationMorphism( ideal_sheaf ) ) ) then
        ideal_sheaf := AsFreydCategoryObject( range );
    else
        matrix := HomalgMatrix( EntriesOfHomalgMatrixAsListList( UnderlyingHomalgMatrix( RelationMorphism( ideal_sheaf ) ) ), coxring );
        ideal_sheaf := FreydCategoryObject( DeduceSomeMapFromMatrixAndRangeForGradedCols( matrix, range ) );
    fi;
    ideal_sheaf := ByASmallerPresentation( TensorProductOnObjects( ideal_sheaf, DefiningModule( RightStructureSheaf( subvariety ) ) ) );

    # Return result
    return CoherentSheafOnToricVariety( AmbientToricVariety( subvariety ), ideal_sheaf );

end );


InstallMethod( RightIdealSheafOnSubvariety,
              [ IsToricVariety, IsList ],
  function( tor, polynomials )
    
    return RightIdealSheafOnSubvariety( SubvarietyOfToricVariety( tor, [] ), polynomials );
    
end );


InstallMethod( InverseOfLeftIdealSheafOnSubvariety,
              [ IsSubvarietyOfToricVariety, IsList ],
  function( subvariety, polynomials )
    local coxring, M, range, map, source, alpha, ideal_sheaf_inverse, matrix;
    
    # Extract the important information
    coxring := CoxRing( AmbientToricVariety( subvariety ) );
    
    # Check that the polynomials are specified in terms of the toric ambient space
    if not ForAll( polynomials, IsRingElement ) then
        Error( "Not all list elements are ring elements" );
        return;
    fi;
    if not ForAll( polynomials, function( p ) if HomalgRing( p ) = coxring then return true; else return false; fi; end ) then
        Error( "Not all list elements are elements of the Cox ring of the provided toric variety" );
    fi;
    
    # Derive map whose image is the ideal in question
    M := Involution( HomalgMatrix( [ polynomials ], 1, Length( polynomials ), LeftCoordinateRing( subvariety ) ) );
    range := GradedRow( [[TheZeroElement(DegreeGroup(coxring)),1]], LeftCoordinateRing( subvariety ) );
    map := DeduceSomeMapFromMatrixAndRangeForGradedRows( M, range );
    source := FreydCategoryObject( WeakKernelEmbedding( map ) );
    range := AsFreydCategoryObject( Range( map ) );
    alpha := FreydCategoryMorphism( source, map, range );

    # Compute the image
    ideal_sheaf_inverse := DualOnObjects( ImageObject( alpha ) );

    # turn ideal_sheaf_inverse into a module over the toric ambient space
    range := GradedRow( DegreeList( Range( RelationMorphism( ideal_sheaf_inverse ) ) ), coxring );
    if IsZero( UnderlyingHomalgMatrix( RelationMorphism( ideal_sheaf_inverse ) ) ) then
        ideal_sheaf_inverse := AsFreydCategoryObject( range );
    else
        matrix := HomalgMatrix( EntriesOfHomalgMatrixAsListList( UnderlyingHomalgMatrix( RelationMorphism( ideal_sheaf_inverse ) ) ), coxring );
        ideal_sheaf_inverse := FreydCategoryObject( DeduceSomeMapFromMatrixAndRangeForGradedRows( matrix, range ) );
    fi;
    ideal_sheaf_inverse := ByASmallerPresentation( TensorProductOnObjects( ideal_sheaf_inverse, DefiningModule( LeftStructureSheaf( subvariety ) ) ) );

    # Return result
    return CoherentSheafOnToricVariety( AmbientToricVariety( subvariety ), ideal_sheaf_inverse );

end );


InstallMethod( InverseOfLeftIdealSheafOnSubvariety,
              [ IsToricVariety, IsList ],
  function( tor, polynomials )
    
    return InverseOfLeftIdealSheafOnSubvariety( SubvarietyOfToricVariety( tor, [] ), polynomials );
    
end );


InstallMethod( InverseOfRightIdealSheafOnSubvariety,
              [ IsSubvarietyOfToricVariety, IsList ],
  function( subvariety, polynomials )
    local coxring, M, range, map, source, alpha, ideal_sheaf_inverse, matrix;
    
    # Extract the important information
    coxring := CoxRing( AmbientToricVariety( subvariety ) );
    
    # Check that the polynomials are specified in terms of the toric ambient space
    if not ForAll( polynomials, IsRingElement ) then
        Error( "Not all list elements are ring elements" );
        return;
    fi;
    if not ForAll( polynomials, function( p ) if HomalgRing( p ) = coxring then return true; else return false; fi; end ) then
        Error( "Not all list elements are elements of the Cox ring of the provided toric variety" );
    fi;
    
    # Derive map whose image is the ideal in question
    M := HomalgMatrix( [ polynomials ], 1, Length( polynomials ), RightCoordinateRing( subvariety ) );
    range := GradedColumn( [[TheZeroElement(DegreeGroup(coxring)),1]], RightCoordinateRing( subvariety ) );
    map := DeduceSomeMapFromMatrixAndRangeForGradedCols( M, range );
    source := FreydCategoryObject( WeakKernelEmbedding( map ) );
    range := AsFreydCategoryObject( Range( map ) );
    alpha := FreydCategoryMorphism( source, map, range );

    # Compute the image
    ideal_sheaf_inverse := DualOnObjects( ImageObject( alpha ) );

    # turn ideal_sheaf_inverse into a module over the toric ambient space
    range := GradedColumn( DegreeList( Range( RelationMorphism( ideal_sheaf_inverse ) ) ), coxring );
    if IsZero( UnderlyingHomalgMatrix( RelationMorphism( ideal_sheaf_inverse ) ) ) then
        ideal_sheaf_inverse := AsFreydCategoryObject( range );
    else
        matrix := HomalgMatrix( EntriesOfHomalgMatrixAsListList( UnderlyingHomalgMatrix( RelationMorphism( ideal_sheaf_inverse ) ) ), coxring );
        ideal_sheaf_inverse := FreydCategoryObject( DeduceSomeMapFromMatrixAndRangeForGradedCols( matrix, range ) );
    fi;
    ideal_sheaf_inverse := ByASmallerPresentation( TensorProductOnObjects( ideal_sheaf_inverse, DefiningModule( RightStructureSheaf( subvariety ) ) ) );

    # Return result
    return CoherentSheafOnToricVariety( AmbientToricVariety( subvariety ), ideal_sheaf_inverse );

end );


InstallMethod( InverseOfRightIdealSheafOnSubvariety,
              [ IsToricVariety, IsList ],
  function( tor, polynomials )
    
    return InverseOfRightIdealSheafOnSubvariety( SubvarietyOfToricVariety( tor, [] ), polynomials );
    
end );
