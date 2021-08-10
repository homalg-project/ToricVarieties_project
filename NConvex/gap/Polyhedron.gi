# SPDX-License-Identifier: GPL-2.0-or-later
# NConvex: A Gap package to perform polyhedral computations
#
# Implementations
#



DeclareRepresentation( "IsConvexPolyhedronRep",
                       IsPolyhedron and IsExternalConvexObjectRep,
                       [ ]
                      );

####################################
##
## Types and Families
##
####################################


BindGlobal( "TheFamilyOfPolyhedrons",
        NewFamily( "TheFamilyOfPolyhedrons" , IsPolyhedron ) );

BindGlobal( "TheTypeConvexPolyhedron",
        NewType( TheFamilyOfPolyhedrons,
                 IsPolyhedron and IsConvexPolyhedronRep ) );
                 
                 
#####################################
##
## Structural Elements
##
#####################################

##
InstallMethod( ContainingGrid,
               "for polyhedrons",
               [ IsPolyhedron ],
               
  function( polyhedron )
    
    if HasTailCone( polyhedron ) then
        
        return ContainingGrid( TailCone( polyhedron ) );
        
    elif HasMainRatPolytope( polyhedron ) then
        
        return ContainingGrid( MainRatPolytope( polyhedron ) );
        
    fi;
    
end );

##
if CddAvailable then
InstallMethod( ExternalCddPolyhedron,
               "for polyhedrons",
               [ IsPolyhedron and HasMainRatPolytope and HasTailCone ],
               
  function( polyhedron )
    local verts, rays;
    
    verts := Vertices( MainRatPolytope( polyhedron ) );
    
    verts := List( verts, i -> Concatenation( [ 1 ], i ) );
    
    rays := RayGenerators( TailCone( polyhedron ) );
    
    rays := List( rays, i -> Concatenation( [ 0 ], i ) );
    
    polyhedron := Concatenation( rays, verts );
    
    polyhedron := Cdd_PolyhedronByGenerators( polyhedron );
    
    return polyhedron;
    
end );
fi;

##
if CddAvailable then
InstallMethod( ExternalCddPolyhedron,
               "for polyhedrons",
               [ IsPolyhedron and HasHomogeneousPointsOfPolyhedron ],
               
  function( polyhedron )
    
    return Cdd_PolyhedronByGenerators( HomogeneousPointsOfPolyhedron( polyhedron ) );
    
end );
fi;

##
if CddAvailable then
InstallMethod( InteriorPoint,
                [ IsConvexObject and IsPolyhedron ],
    function( poly )
    return Cdd_InteriorPoint( ExternalCddPolyhedron( poly ) );
end );
fi;

##
if CddAvailable then
InstallMethod( DefiningInequalities, 
               " for polyhedrons",
               [ IsPolyhedron ], 
               
   function( polyhedron )
   local ineq, eq, ex, d;
   
   ex:= ExternalCddPolyhedron( polyhedron );
   
   ineq := Cdd_Inequalities( ex );
   eq   := Cdd_Equalities( ex );
   
   d:= Concatenation( ineq, eq, -eq );
   
   return d;
 
end );
fi;

##
if CddAvailable then
InstallMethod( ExternalCddPolyhedron,
               "for polyhedrons with inequalities",
               [ IsPolyhedron ],
               
  function( polyhedron )
    
    if IsBound( polyhedron!.inequalities ) then
        
        if IsEmpty( polyhedron!.inequalities ) then
            
            polyhedron!.inequalities := [ [ 0 ] ];
            
        fi;
        
        return Cdd_PolyhedronByInequalities( polyhedron!.inequalities );
        
    fi;
    
    TryNextMethod();
    
end );
fi;

InstallMethod( ExternalNmzPolyhedron, 
               [ IsPolyhedron ], 
               
function( poly )
local ineq, new_ineq;

if IsBound( poly!.inequalities ) then 

     ineq:= poly!.inequalities;
     
fi;

ineq:= DefiningInequalities( poly );

new_ineq := List( ineq, function( i )
                        local j;
                        
                        j:= ShallowCopy( i );

                        Add( j, j[ 1 ] );
                        
                        Remove(j ,1 );
                        
                        return j;
                        
                        end );

return ValueGlobal( "NmzCone" )( [ "inhom_inequalities", new_ineq ] );

end );
                        
                        
if CddAvailable then
InstallMethod( Dimension, 
               [ IsPolyhedron ], 
   function( polyhedron )
   
   return Cdd_Dimension( ExternalCddPolyhedron( polyhedron ) );
   
end );
fi;

InstallMethod( MainRatPolytope, 
               "for polyhedrons",
               [ IsPolyhedron ],
               
  function( polyhedron )
    
    return Polytope( VerticesOfMainRatPolytope( polyhedron ) );
    
end );

##
InstallMethod( MainPolytope,
              [ IsPolyhedron ],
  
  function( polyhedron )
    local V;

    V := VerticesOfMainRatPolytope( polyhedron );

    if ForAll( V, v -> ForAll( v, IsInt ) ) then

      return MainRatPolytope( polyhedron );

    fi;
  
    return Polytope( LatticePointsGenerators( polyhedron )[ 1 ] );
    
end );

##
InstallMethod( VerticesOfMainPolytope,
              [ IsPolyhedron ], 
              
  function( polyhedron )
    local V;
    
    V := VerticesOfMainRatPolytope( polyhedron );
    
    if ForAll( V, v -> ForAll( v, IsInt ) ) then

      return V;

    fi;

    return Vertices( MainPolytope( polyhedron ) );

end );

##
if CddAvailable then
InstallMethod( VerticesOfMainRatPolytope,
               "for polyhedrons",
               [ IsPolyhedron ],
               
  function( polyhedron )
    local v;
    
    if IsBound( polyhedron!.inequalities ) then 
    
        v:= Cdd_GeneratingVertices( ExternalCddPolyhedron( polyhedron ) );

        if Length( v ) > 0 then 
        
               return v;
               
        else 
        
               return [ ListWithIdenticalEntries(AmbientSpaceDimension( polyhedron ), 0 ) ];
               
        fi;
        
        
    else 
    
        return Vertices( MainRatPolytope( polyhedron ) );
        
    fi;
    
end );
fi;

InstallMethod( TailCone,
               "for polyhedrons",
               [ IsPolyhedron ],
               
  function( polyhedron )
    
  if RayGeneratorsOfTailCone( polyhedron ) <> [ ] then 
  
         return Cone( RayGeneratorsOfTailCone( polyhedron ) );
         
  else 
  
  
         return Cone( [ ListWithIdenticalEntries( AmbientSpaceDimension( polyhedron ), 0 ) ] );
   
  fi;
  
end );

##
if CddAvailable then
InstallMethod( RayGeneratorsOfTailCone,
               "for polyhedrons",
               [ IsPolyhedron ],
               
  function( polyhedron )
    
     if IsBound( polyhedron!.inequalities ) then 
    
        return Cdd_GeneratingRays( ExternalCddPolyhedron( polyhedron ) );

     else
       
        return RayGenerators( TailCone( polyhedron ) );
        
     fi;
    
end );
fi;

##
InstallMethod( HomogeneousPointsOfPolyhedron,
               "for polyhedrons",
               [ IsPolyhedron ],
               
  function( polyhedron )
    local verts, rays;
    
    verts := Vertices( MainRatPolytope( polyhedron ) );
    
    verts := List( verts, i -> Concatenation( [ 1 ], i ) );
    
    rays := RayGenerators( TailCone( polyhedron ) );
    
    rays := List( rays, i -> Concatenation( [ 0 ], i ) );
    
    polyhedron := Concatenation( rays, verts );
    
    return polyhedron;
    
end );


InstallMethod( LatticePointsGenerators, 
                 [ IsPolyhedron ], 
                 
  function( p )
    local external_poly,nmz_points_in_main_polytope, points_in_main_polytope, 
                       nmz_hilbert_basis, hilbert_basis, nmz_lineality, lineality, ineq, const;
    
    if IsPackageMarkedForLoading( "NormalizInterface", ">=1.1.0" ) then

      external_poly:= ExternalNmzPolyhedron( p );

      nmz_points_in_main_polytope:= ValueGlobal( "NmzModuleGenerators" )( external_poly ); 

      points_in_main_polytope:= 
        List( nmz_points_in_main_polytope ,
          function( i ) 
            local j;
                       
            j := ShallowCopy( i );
                       
            Remove( j, Length( i ) );
                       
            return j;
                       
          end );
                                          
      nmz_hilbert_basis:= ValueGlobal( "NmzHilbertBasis" )( external_poly );
     
      hilbert_basis :=                
        List( nmz_hilbert_basis ,
          function( i ) 
            local j;
                             
            j := ShallowCopy( i );
                             
            Remove( j, Length( i ) );
                             
            return j;
                             
          end );
      
      nmz_lineality := ValueGlobal( "NmzMaximalSubspace" )( external_poly );
     
      lineality:= List( nmz_lineality, 
        function( i )
          local j;
                                   
          j := ShallowCopy( i );
                                   
          Remove( j, Length( i ) );
                                   
          return j;
                                   
        end );

      return [ Set( points_in_main_polytope ), Set( hilbert_basis ), Set( lineality ) ];
    
    elif IsPackageMarkedForLoading( "4ti2Interface", ">=2018.07.06" ) then
     
     ineq := TransposedMat( DefiningInequalities( p ) );

     const := -ineq[ 1 ];

     ineq := TransposedMat( ineq{ [ 2 .. Length( ineq ) ] } );

     return List( ValueGlobal( "4ti2Interface_zsolve_equalities_and_inequalities" )( [  ], [  ], ineq, const : precision := "gmp" ), Set );

    else

      Error( "4ti2Interface or NormalizInterface should be loaded!" );

    fi;
    
end );
    
##
InstallMethod( BasisOfLinealitySpace,
               "for polyhedrons",
               [ IsPolyhedron ],
               
  function( polyhedron )
    
    return LinealitySpaceGenerators( TailCone( polyhedron ) );
    
end );

##
if CddAvailable then
InstallMethod( FVector,
            [ IsPolyhedron ],
    function( polyhedron )
      local external_polyhedron, faces;
      
      external_polyhedron := Cdd_H_Rep( ExternalCddPolyhedron( polyhedron ) );
      
      faces := Cdd_Faces( external_polyhedron );
      
      return List( [ 0 .. Dimension( polyhedron ) - 1 ], 
                i -> Length( PositionsProperty( faces, face -> face[ 1 ] = i ) ) );

end );
fi;

#####################################
##
##  Properties
##
#####################################

##
if CddAvailable then
InstallMethod( IsBounded,
               " for external polytopes.",
               [ IsPolyhedron ],
               
  function( polyhedron )

  return Length( Cdd_GeneratingRays( ExternalCddPolyhedron( polyhedron ) ) ) = 0;
  
end );
fi;

##
if CddAvailable then
InstallMethod( IsNotEmpty,
               " for external polytopes.",
               [ IsPolyhedron ],
               
  function( polyhedron )

  return not Cdd_IsEmpty( ExternalCddPolyhedron( polyhedron ) );
  
end );
fi;

InstallMethod( IsPointed,
               [ IsPolyhedron ], 
      
  function( polyhedron )
  
  return IsPointed( TailCone( polyhedron ) );
  
end );

#####################################
##
## Constructors
##
#####################################

##
InstallMethod( PolyhedronByInequalities,
               "for list of inequalities",
               [ IsList ],
               
  function( inequalities )
    local polyhedron;
    
    polyhedron := rec();
    
    ObjectifyWithAttributes( polyhedron, TheTypeConvexPolyhedron );
    
    polyhedron!.inequalities := inequalities;
    
    if not IsEmpty( inequalities ) then
        
        SetAmbientSpaceDimension( polyhedron, Length( inequalities[ 1 ] ) - 1 );
        
    else
        
        SetAmbientSpaceDimension( polyhedron, 0 );
    fi;
    
    return polyhedron;
    
end );

##
InstallMethod( Polyhedron,
               "for a polytope and a cone",
               [ IsPolytope, IsCone ],
               
  function( polytope, cone )
    local polyhedron;
    
    if not Rank( ContainingGrid( polytope ) )= Rank( ContainingGrid( cone ) ) then
        
        Error( "Two objects are not comparable" );
        
    fi;
    
    polyhedron := rec();
    
    ObjectifyWithAttributes( polyhedron, TheTypeConvexPolyhedron,
                                          MainRatPolytope, polytope,
                                          TailCone, cone,
                                          ContainingGrid, ContainingGrid( polytope ),
                                          AmbientSpaceDimension, AmbientSpaceDimension( polytope )
                                        );
    
    return polyhedron;
    
end );

##
InstallMethod( Polyhedron,
               "for a polytope and a list",
               [ IsPolytope, IsList ],
               
  function( polytope, cone )
    local polyhedron;
    
    if Length( cone ) > 0 and Length( cone[ 1 ] ) <> AmbientSpaceDimension( polytope ) then
        
        Error( "the two objects are not comparable" );
        
    fi;
    
    polyhedron := rec( );
    
    if Length( cone ) = 0 then
        
        cone := [ List( [ 1 .. AmbientSpaceDimension( polytope ) ], i -> 0 ) ];
        
    fi;
    
    ObjectifyWithAttributes( polyhedron, TheTypeConvexPolyhedron,
                                          MainRatPolytope, polytope,
                                          TailCone, Cone( cone ),
                                          ContainingGrid, ContainingGrid( polytope ),
                                          AmbientSpaceDimension, AmbientSpaceDimension( polytope )
                                        );
    
    return polyhedron;
    
end );


##
InstallMethod( Polyhedron,
               "for a polytope and a cone",
               [ IsList, IsCone ],
               
  function( polytope, cone )
    local polyhedron;
    
    if Length( polytope ) > 0 and Length( polytope[ 1 ] ) <> AmbientSpaceDimension( cone ) then
        
        Error( "the two objects are not comparable" );
        
    fi;
    
    polytope := Polytope( polytope );
    
    SetContainingGrid( polytope, ContainingGrid( cone ) );
    
    polyhedron := rec( );
    
    ObjectifyWithAttributes( polyhedron, TheTypeConvexPolyhedron,
                                          MainRatPolytope, polytope,
                                          TailCone, cone,
                                          ContainingGrid, ContainingGrid( cone ),
                                          AmbientSpaceDimension, AmbientSpaceDimension( cone )
                                        );
    
    return polyhedron;
    
end );

##
InstallMethod( Polyhedron,
               "for a polytope and a cone",
               [ IsList, IsList ],
               
  function( polytope, cone )
    local polyhedron;
    
    if Length( polytope ) > 0 and Length( cone ) > 0 and Length( cone[ 1 ] ) <> Length( polytope[ 1 ] ) then
        
        Error( "two objects are not comparable\n" );
        
    fi;
    
    if Length( polytope ) = 0 then
        
        Error( "The polytope of a polyhedron should at least contain one point!" );
        
    fi;
    
    if Length( cone ) = 0 then
        
        cone := [ List( [ 1 .. Length( polytope[ 1 ] ) ], i -> 0 ) ];
        
    fi;
    
    polyhedron := rec();
    
    ObjectifyWithAttributes( polyhedron, TheTypeConvexPolyhedron,
                                          MainRatPolytope, Polytope( polytope ),
                                          TailCone, Cone( cone ),
                                          AmbientSpaceDimension, Length( polytope[ 1 ] ) 
                                        );
    
    SetContainingGrid( TailCone( polyhedron ), ContainingGrid( MainRatPolytope( polyhedron ) ) );
    
    SetContainingGrid( polyhedron, ContainingGrid( MainRatPolytope( polyhedron ) ) );
    
    return polyhedron;
    
end );

## Solving linear programs
##
if CddAvailable then
BindGlobal( "SOLVE_LINEAR_PROGRAM_USING_CDD",
  function( P, max_or_min, target_func, constructor )
    local ext_cdd_poly, cdd_linear_program; 
    
    ext_cdd_poly := constructor( P );
    
    cdd_linear_program := Cdd_LinearProgram( ext_cdd_poly, max_or_min, target_func );
    
    return Cdd_SolveLinearProgram( cdd_linear_program );

end );
fi;

##
if CddAvailable then
InstallMethod( SolveLinearProgram,
  [ IsPolyhedron, IsString, IsList ],
  function( P, max_or_min, target_func )
    
    return SOLVE_LINEAR_PROGRAM_USING_CDD( P, max_or_min, target_func, ExternalCddPolyhedron );

end );
fi;

##
if CddAvailable then
InstallMethod( SolveLinearProgram,
  [ IsPolytope, IsString, IsList ],
  function( P, max_or_min, target_func )
    
    return SOLVE_LINEAR_PROGRAM_USING_CDD( P, max_or_min, target_func, ExternalCddPolytope );

end );
fi;

##############################
##
## View & Display
##
##############################

##
InstallMethod( ViewObj,
               "for homalg polyhedrons",
               [ IsPolyhedron ],
               
  function( polyhedron )
    local str;
    
    Print( "<A" );
    
    if HasIsNotEmpty( polyhedron ) then
        
        if IsNotEmpty( polyhedron ) then
            
            Print( " not empty" );
            
        fi;
    
    fi;
    
    Print( " polyhedron in |R^" );
    
    Print( String( AmbientSpaceDimension( polyhedron ) ) );
    
    if HasDimension( polyhedron ) then
        
        Print( " of dimension ", String( Dimension( polyhedron ) ) );
        
    fi;
    
    Print( ">" );
    
end );

##
InstallMethod( Display,
               "for homalg polyhedrons",
               [ IsPolyhedron ],
               
  function( polyhedron )
    local str;
    
    Print( "A" );
    
    if HasIsNotEmpty( polyhedron ) then
        
        if IsNotEmpty( polyhedron ) then
            
            Print( " not empty" );
            
        fi;
    
    fi;
    
    Print( " polyhedron in |R^" );
    
    Print( String( AmbientSpaceDimension( polyhedron ) ) );
    
    if HasDimension( polyhedron ) then
        
        Print( " of dimension ", String( Dimension( polyhedron ) ) );
        
    fi;
    
    Print( ".\n" );
    
end );
