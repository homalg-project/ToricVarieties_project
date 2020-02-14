################################################################################################
##
##  Sheaves.gi                         CoherentSheavesOnToricVarieties package
##
##  Copyright 2020                     Martin Bies,       University of Oxford
##
##  Coherent sheaves on toric varieties
##
################################################################################################


##############################################################################################
##
## GAP category for coherent sheaves
##
##############################################################################################

# install gap categories for sheaves
DeclareRepresentation( "IsCoherentSheafOnToricVarietyRep",
                       IsCoherentSheafOnToricVariety and IsAttributeStoringRep, [ ] );

BindGlobal( "TheFamilyOfCoherentSheavesOnToricVarieties",
            NewFamily( "TheFamilyOfCoherentSheavesOnToricVarieties" ) );

BindGlobal( "TheTypeOfCoherentSheafOnToricVariety",
            NewType( TheFamilyOfCoherentSheavesOnToricVarieties, IsCoherentSheafOnToricVarietyRep ) );

##
InstallMethod( ToricVarietyString,
               " for toric varieties",
               [ IsToricVariety, IsBool ],
  function( var, capital )
    local proj, string_list;
    
    proj := false;
    
    if capital then
        string_list := [ "A" ];
    else
        string_list := [ "a" ];
    fi;
    
    if HasIsAffine( var ) and IsAffine( var ) then
        Append( string_list, [ "n affine" ] );
    fi;
    
    if HasIsProjective( var ) and IsProjective( var ) then
        Append( string_list, [ " projective" ] );
        proj := true;
    fi;
    
    if HasIsNormalVariety( var ) and IsNormalVariety( var ) then
        Append( string_list, [ " normal" ] );
    fi;
    
    if HasIsSmooth( var ) then
        if IsSmooth( var ) then
            Append( string_list, [ " smooth" ] );
        else
            Append( string_list, [ " non smooth" ] );
        fi;
    fi;
    
    if HasIsComplete( var ) and IsComplete( var ) then
        if not proj then
            Append( string_list, [ " complete" ] );
        fi;
    fi;
    
    if IsToricVariety( var ) and not IsToricSubvariety( var ) then
        Append( string_list, [ " toric variety" ] );
    elif IsToricSubvariety( var ) then
        Append( string_list, [ " toric subvariety" ] );
    fi;
    
    if HasDimension( var ) then
        Append( string_list, [ Concatenation( " of dimension ", String( Dimension( var ) ) ) ] );
    fi;
    
    if HasHasTorusfactor( var ) and HasTorusfactor( var ) then
        Append( string_list, [ Concatenation( " with a torus factor of dimension ", String( DimensionOfTorusfactor( var ) ) ) ] );
    fi;
    
    if HasIsProductOf( var ) and Length( IsProductOf( var ) ) > 1 then
        Append( string_list, [ Concatenation( " which is a product of ", String( Length( IsProductOf( var ) ) ), " toric varieties" ) ] );
    fi;
    
    # return the string
    return JoinStringsWithSeparator( string_list, "" );
    
end );



##############################################################################################
##
## Constructor for coherent sheaves
##
##############################################################################################

# constructor for coherent sheaves
InstallMethod( CoherentSheafOnToricVariety,
               "a toric variety and an fp graded left- or right-module",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject ],
  function( variety, module )
    local sheaf;
    
    # Check for valid input
    if not IsIdenticalObj( UnderlyingHomalgGradedRing( RelationMorphism( module ) ), CoxRing( variety ) ) then
        Error( "The module is not defined over the Coxring of the toric variety" );
        return;
    fi;
    
    # Then build the sheaf
    sheaf := rec( );
    ObjectifyWithAttributes( sheaf, TheTypeOfCoherentSheafOnToricVariety,
                             AmbientToricVariety, variety,
                             DefiningModule, module
                             );
    return sheaf;
    
end );


#################################################
##
## Section: String methods for coherent sheaves
##
#################################################

InstallMethod( String,
              [ IsCoherentSheafOnToricVariety ],
  function( sheaf )
    
    return Concatenation( "A coherent sheaf on ", ToricVarietyString( AmbientToricVariety( sheaf ), false ) );
    
end );


##################################################
##
## Section: Display methods for the new categories
##
##################################################

InstallMethod( Display,
              [ IsCoherentSheafOnToricVariety ],
  function( sheaf )
    local variety;
    
    variety := AmbientToricVariety( sheaf );
    
    Print( "\n" );
    Print( "################################################\n" );
    Print( "Ambient toric variety:\n" );
    Print( "################################################\n\n" );
    
    Print( "---------------------------\n" );
    Print( "Ray generators\n" );
    Print( "---------------------------\n\n" );
    Display( RayGenerators( FanOfVariety( variety ) ) );
    Print( "\n" );
    
    Print( "---------------------------\n" );
    Print( "Rays in maximal cones\n" );
    Print( "---------------------------\n\n" );
    Display( RaysInMaximalCones( FanOfVariety( variety ) ) );
    Print( "\n" );
    
    Print( "---------------------------\n" );
    Print( "General description\n" );
    Print( "---------------------------\n\n" );
    Print( ToricVarietyString( AmbientToricVariety( sheaf ), true ) );
    
    Print( "\n\n\n" );
    Print( "################################################\n" );
    Print( "Defining module:\n" );
    Print( "################################################\n" );
    Display( DefiningModule( sheaf ) );
    
    Print( "\n" );
    Print( "################################################\n" );
    Print( "General description:\n" );
    Print( "################################################\n" );
    Print( "\n" );
    Print( String( sheaf ) );
    Print( "\n\n" );

end );


################################################
##
## Section: View methods for the new categories
##
################################################

InstallMethod( ViewObj,
              [ IsCoherentSheafOnToricVariety ],
               999, # FIXME FIXME FIXME!!!
  function( sheaf )

      Print( Concatenation( "<", String( sheaf ), ">" ) );

end );
