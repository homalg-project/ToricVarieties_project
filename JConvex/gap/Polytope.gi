#############################################################################
##
##  Functions.gi        JConvex package
##                      Martin Bies
##
##  Copyright 2021      University of Pennsylvania
##
##  A Gap package to do convex geometry by Polymake
##
##  Chapter: Polytopes
##
#############################################################################


####################################
##
##  Attributes of polyopes
##
####################################

    
InstallMethod( ExternalPolymakePolytope,
               "for polyopes",
               [ IsPolytope ],
    function( poly )
    
    if IsBound( poly!.input_points ) then
        return Polymake_PolytopeByGenerators( poly!.input_points );
    fi;
    
    # otherwise our fallback is poly from inequalities
    return Polymake_PolytopeFromInequalities( poly!.input_ineqs );
    
end );


InstallMethod( VerticesOfPolytope,
               "for polyopes",
               [ IsPolytope ],
  function( poly )

    return Set( Polymake_V_Rep( ExternalPolymakePolytope( poly ) )!.vertices );

end );


InstallMethod( DefiningInequalities,
               "for polyopes",
               [ IsPolytope ],
  function( poly )
    local ineqs, eqs;

    ineqs := Polymake_Inequalities( ExternalPolymakePolytope( poly ) );
    eqs := Polymake_Equalities( ExternalPolymakePolytope( poly ) );
    return Set( Concatenation( eqs, (-1) * eqs, ineqs ) );

end );


InstallMethod( FacetInequalities,
               " for external polyopes",
               [ IsExternalPolytopeRep ],
  function( poly )

    return Polymake_Inequalities( ExternalPolymakePolytope( poly ) );

end );


InstallMethod( IsBounded,
               " for external polyopes.",
               [ IsPolytope ],
    function( poly )

    return Polymake_IsBounded( ExternalPolymakePolytope( poly ) );

end );


InstallMethod( LatticePoints,
               [ IsPolytope ],
    function( poly )

    return Polymake_LatticePoints( ExternalPolymakePolytope( poly ) );

end );


InstallMethod( Dimension,
               [ IsPolytope ],
    function( poly )

    return Polymake_Dimension( ExternalPolymakePolytope( poly ) );

end );


InstallMethod( IntersectionOfPolytopes,
               [ IsPolytope, IsPolytope ],
  function( poly1, poly2 )
    local poly, ext_polytope;
    
    if not Rank( ContainingGrid( poly1 ) ) = Rank( ContainingGrid( poly2 ) ) then
        Error( "polytopes are not of the same dimension" );
    fi;

    # compute the intersection
    ext_polytope:= Polymake_Intersection( ExternalPolymakePolytope( poly1 ), ExternalPolymakePolytope( poly2 ) );

    # find the generating vertices of this new polytope and construct the polytope
    # currently, this ignores the lineality space Polymake_Linealities( ext_polytope ) completely!
    poly := Polytope( Polymake_Vertices( ext_polytope ) );

    # set properties
    SetExternalPolymakePolytope( poly, ext_polytope );
    SetContainingGrid( poly, ContainingGrid( poly1 ) );
    SetAmbientSpaceDimension( poly, AmbientSpaceDimension( poly1 ) );

    # return the result
    return poly;

end );
