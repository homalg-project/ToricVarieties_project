#############################################################################
##
##  Cone.gi             JConvex package
##                      Martin Bies
##
##  Copyright 2021      University of Pennsylvania
##
##  A Gap package to do convex geometry by Polymake
##
## Chapter: Cones
##
#############################################################################


InstallMethod( ExternalPolymakeCone,
               [ IsCone ],
   function( cone )
    
    if IsBound( cone!.input_rays ) and Length( cone!.input_rays ) = 1 and IsZero( cone!.input_rays ) then
        return Polymake_ConeByGenerators( cone!.input_rays[ 1 ] );
    fi;
    
    if IsBound( cone!.input_rays ) then
        return Polymake_ConeByGenerators( cone!.input_rays );
    fi;
    
    if IsBound( cone!.input_equalities ) then
        return Polymake_ConeFromInequalities( cone!.input_inequalities, cone!.input_equalities );
    fi;
    
    # otherwise our fallback is cone from inequalities
    return Polymake_ConeFromInequalities( cone!.input_inequalities );
    
end );


InstallMethod( RayGenerators,
               [ IsCone ],
    function( cone )
    local rays, lin;

    rays := Polymake_Rays( ExternalPolymakeCone( cone ) );
    lin := Polymake_Lineality( ExternalPolymakeCone( cone ) );
    return Set( Concatenation( rays, lin, (-1) * lin ) );

end );

InstallMethod( IsPointed,
               [ IsCone ],
    function( cone )

    return Polymake_IsPointed( ExternalPolymakeCone( cone ) );

end );

InstallMethod( Dimension,
               [ IsCone ],
    function( cone )

    return Polymake_Dimension( ExternalPolymakeCone( cone ) );

end );


InstallMethod( DefiningInequalities,
               [ IsCone ],
  function( cone )
    local ineqs, eqs;

    ineqs := Polymake_Inequalities( ExternalPolymakeCone( cone ) );
    eqs := Polymake_Equalities( ExternalPolymakeCone( cone ) );
    return Set( Concatenation( eqs, (-1) * eqs, ineqs ) );

end );


InstallMethod( LinealitySpaceGenerators,
               [ IsCone ],
  function( cone )

    return Set( Polymake_Lineality( ExternalPolymakeCone( cone ) ) );

end );



InstallMethod( RaysInFacets,
               [ IsCone ],
    function( cone )

    return Polymake_RaysInFacets( ExternalPolymakeCone( cone ) );

end );


InstallMethod( RaysInFaces,
               " for cones",
               [ IsCone ],

  function( cone )

    return Set( Polymake_RaysInFaces( ExternalPolymakeCone( cone ) ) );

end );


InstallMethod( IntersectionOfCones,
               "for homalg cones",
               [ IsCone, IsCone ],
  function( cone1, cone2 )
    local ext_cone, ineqs, eqs, cone;
    
    if not Rank( ContainingGrid( cone1 ) ) = Rank( ContainingGrid( cone2 ) ) then
        Error( "cones are not from the same grid" );
    fi;

    # compute the intersection cone in Polymake
    ext_cone := Polymake_Intersection( ExternalPolymakeCone( cone1 ), ExternalPolymakeCone( cone2 ) );
    ineqs := ext_cone!.inequalities;
    eqs := ext_cone!.equalities;
    cone := ConeByEqualitiesAndInequalities( eqs, ineqs );
    SetContainingGrid( cone, ContainingGrid( cone1 ) );

    # and return it
    return cone;

end );
