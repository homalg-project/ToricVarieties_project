#######################################################################################
##
##  CategoryOfCoherentSheaves.gi    CoherentSheavesOnToricVarieties package
##                                  Martin Bies
##
##  Copyright 2020                  University of Oxford
##
##  A package to model coherent toric sheaves as elements in a Serre quotient category.
##
##  Stuff
##
#######################################################################################


# Construct the category of coherent sheaves over a toric variety
InstallMethod( CategoryOfCoherentSheaves,
               [ IsToricVariety ],
  function( variety )
    local graded_ring, degrees, presentation_category, test_function, rays_in_maximal_cones, irrelevant_ideal_generators, i, j, current_generator, functor_list, functor, serre_quotient_category;
    
    # extract Cox ring and degrees of the indeterminates
    graded_ring := CoxRing( variety );
    degrees := List( WeightsOfIndeterminates( graded_ring ), i -> UnderlyingListOfRingElements( i ) );
    
    # choose presentation of coherent sheaves via left modules
    presentation_category := FpGradedLeftModules( graded_ring );
    
    # set up the test function to decide if a given module sheafifes to zero
    if IsFree( DegreeGroup( graded_ring ) ) and ForAll( degrees, i -> ForAll( i, j -> j >= 0 ) ) and IsSmooth( variety ) then
        
        # in this case, the test is simple
        test_function := module -> IsZero( HilbertPolynomial( UnderlyingMatrixOverNonGradedRing( UnderlyingMatrix( module ) ) ) );
        
    else
        
        # worst case scenario:localize module to each affine patch and check if it sheafifes to zero there - prepare the corresponding functors here
        rays_in_maximal_cones := RaysInMaximalCones( FanOfVariety( variety ) );
        irrelevant_ideal_generators := [ ];
        for i in rays_in_maximal_cones do
            current_generator :=  [ ];
            for j in [ 1 .. Length( i ) ] do
                if i[ j ] = 0 then
                    Add( current_generator, j );
                fi;
            od;
            Add( irrelevant_ideal_generators, current_generator );
        od;
        functor_list := List( irrelevant_ideal_generators, i -> LocalizedTruncationFunctorForFPGradedLeftModules( graded_ring, i ) );
        
        # now set up the corresponding test_function which tells us if the module sheafifes to the trivial sheaf
        test_function := function( module )
            local module_matrix, degree_positions, current_section_module;
            
            # first a quick and dirty test: modules with free parts never sheafify to zero
            module_matrix := UnderlyingHomalgMatrix( RelationMorphism( module ) );
            degree_positions := PositionOfFirstNonZeroEntryPerColumn( module_matrix );
            if ForAny( degree_positions, i -> i = 0 ) then
                return false;
            fi;
            
            # otherwise employ the above functors to test if, on each affine patch, the given module sheafifes to 0
            for functor in functor_list do
                current_section_module := ApplyFunctor( functor, module );
                if not IsZeroForObjects( current_section_module ) = true then
                    return false;
                fi;
            od;
            
            # if all tests where passed, then the module is zero
            return true;
            
        end;
        
    fi;
    
    # finally set up the Serre quotient
    if HasName( variety ) then
        serre_quotient_category := SerreQuotientCategoryByThreeArrows( presentation_category, test_function, Concatenation( "Toric sheaves over ", NameOfVariety( variety ) ) );
    else
        serre_quotient_category := SerreQuotientCategoryByThreeArrows( presentation_category, test_function, Concatenation( "Toric sheaves over ", RingName( graded_ring ) ) );
    fi;
    
    # and return it
    return serre_quotient_category;
    
end );
