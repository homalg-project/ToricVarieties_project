# SPDX-License-Identifier: GPL-2.0-or-later
# NConvex: A Gap package to perform polyhedral computations
#
# Implementations
#


####################################
##
## Reps
##
####################################

DeclareRepresentation( "IsExternalFanRep",
                       IsFan and IsExternalConvexObjectRep,
                       [ ]
                      );

DeclareRepresentation( "IsConvexFanRep",
                       IsExternalFanRep,
                       [ ]
                      );

DeclareRepresentation( "IsInternalFanRep",
                       IsFan and IsInternalConvexObjectRep,
                       [ ]
                      );

####################################
##
## Types and Families
##
####################################


BindGlobal( "TheFamilyOfFans",
        NewFamily( "TheFamilyOfFans" , IsFan ) );

BindGlobal( "TheTypeExternalFan",
        NewType( TheFamilyOfFans,
                 IsFan and IsExternalFanRep ) );

BindGlobal( "TheTypeConvexFan",
        NewType( TheFamilyOfFans,
                 IsConvexFanRep ) );

BindGlobal( "TheTypeInternalFan",
        NewType( TheFamilyOfFans,
                 IsInternalFanRep ) );
                 
####################################
##
## Constructors
##
####################################

##
InstallMethod( Fan,
               " for cones",
               [ IsList ],
               
  function( cones )
    local newgens, i, point, extobj, type;
    
    if Length( cones ) = 0 then
        
        Error( " no empty fans allowed." );
        
    fi;
    
    newgens := [ ];
    
    for i in cones do
        
        if IsCone( i ) then
            
            if IsBound( i!.input_rays ) then
                
                Add( newgens, i!.input_rays );
                
            else
                
                Add( newgens, RayGenerators( i ) );
                
            fi;
            
        elif IsList( i ) then
            
            Add( newgens, i );
            
        else
            
            Error( " wrong cones inserted" );
            
        fi;
        
    od;
    
    point := rec( input_cone_list := newgens );
    
    ObjectifyWithAttributes(
        point, TheTypeInternalFan
        );
    
    SetAmbientSpaceDimension( point, Length( newgens[ 1 ][ 1 ] ) );
    
    return point;
    
end );

##
InstallMethod( Fan,
               " for homalg fans",
               [ IsFan ],
               
  IdFunc
  
);


##
InstallMethod( Fan,
               "for rays and cones.",
               [ IsList, IsList ],
               
  function( rays, cones )
    local point, indices;
    
    if Length( cones ) = 0 or Length( rays ) = 0 then
        
        Error( "fan has to have the trivial cone.\n" );
    
    fi;
    
    indices := Set( Flat( cones ) );
    
    if not ForAll( indices, i -> i > 0 and i<= Length( rays ) ) then 
      
      Error( "wrong cones inserted \n" );
    
    fi;
    
    point := rec( input_rays := rays, input_cones := cones );
    
    ObjectifyWithAttributes(
        point, TheTypeConvexFan
        );
    
    SetAmbientSpaceDimension( point, Length( rays[ 1 ] ) );
    
    return point;
  
end );

##
InstallMethod( FanWithFixedRays,
               "for rays and cones.",
               [ IsList, IsList ],
               
  Fan );

##
InstallMethod( DeriveFansFromTriangulation,
               "for a list of rays.",
               [ IsList, IsBool ],
  function( rays, single_fan_desired )
    local triangulations, i, j, fans;
    
    # (0) Check if TopcomInterface is available
    if TestPackageAvailability( "TopcomInterface", ">=2019.06.15" ) = fail then
      Error( "The package TopcomInterface is not available " );
    fi;
    
    # (1) and marked to be loaded as suggested package
    if not IsPackageMarkedForLoading( "TopcomInterface", ">=2019.06.15" ) then
      Error( "The package TopcomInterface has not been marked to be loaded by NConvex if available " );
    fi;
    
    # (2) Check that the given rays are valid input
    
    # (2a) Are the rays all of the same length?
    if Length( DuplicateFreeList( List( [ 1 .. Length( rays ) ], i -> Length( rays[ i ] ) ) ) ) > 1 then
      Error( "The rays must be lists of the equal lengths " );
      return;
    fi;
    
    # (2b) Are the rays lists of integers?
    for i in [ 1 .. Length( rays ) ] do
      for j in [ 1 .. Length( rays[ i ] ) ] do
        if not IsInt( rays[ i ][ j ] ) then
          Error( "The rays must be lists of integers " );
          return;
        fi;
      od;
    od;
    
    # (3) compute all fine and regular triangulations
    triangulations := ValueGlobal( "points2allfinetriangs" )( rays, [], ["regular"] );
    
    # to match the conventions of NConvex, the counting of rays must start at 1
    # whilst topcom (in C++-standard) starts the counting at 0
    Apply( triangulations, i -> i + 1 );
    
    # (4) iterate over the obtained triangulations and turn them into fans
    if single_fan_desired then
      fans := Fan( rays, triangulations[ 1 ] );
    else
      fans := List( [ 1 .. Length( triangulations ) ], i -> Fan( rays, triangulations[ i ] ) );
    fi;
    
    # return the result
    return fans;
    
end );

##
InstallMethod( FansFromTriangulation,
               "for a list of rays.",
               [ IsList ],
  function( rays )
    
    return DeriveFansFromTriangulation( rays, false );
    
end );

##
InstallMethod( FanFromTriangulation,
               "for a list of rays.",
               [ IsList ],
  function( rays )
    
    return DeriveFansFromTriangulation( rays, true );
    
end );

##############################
##
##  Attributes
##
##############################


InstallMethod( RayGenerators, 
               "for fans",
               [ IsFan ], 
  function( fan )
    
    return RayGenerators( CanonicalizeFan( fan ) );
  
end );

InstallMethod( RaysInMaximalCones, 
               [ IsFan ],
  function( fan )
    
    return RaysInMaximalCones( CanonicalizeFan( fan ) );
  
end );

##
InstallMethod( GivenRayGenerators,
               "for external fans.",
               [ IsFan ],
               
  function( fan )
    
    if IsBound( fan!.input_rays ) then
        
        return fan!.input_rays;
    
    elif IsBound( fan!.input_cone_list ) then
        
        #return DuplicateFreeList( Concatenation( fan!.input_cone_list ) );
        return List( Set( Union( fan!.input_cone_list ) ) );
    
    else
        
        Error( "Something went wrong." );
    
    fi;
    
end );

##
InstallMethod( Rays,
               "for fans.",
               [ IsFan ],
               
  function( fan )
    local rays;
    
    rays := RayGenerators( fan );
    
    rays := List( rays, i -> Cone( [ i ] ) );
    
    List( rays, function( i ) SetContainingGrid( i, ContainingGrid( fan ) ); return 0; end );
    
    return rays;
    
end );

## This function ignore the small cones which live in some other cone.

InstallMethod( RaysInTheGivenMaximalCones,
               "for fans",
               [ IsFan ],
               
  function( fan )
    local rays, cones, i, j;
    
    if IsBound( fan!.input_cones ) and IsBound( fan!.input_rays ) then
        
        rays := GivenRayGenerators( fan );
        
        cones := List( [ 1 .. Length( fan!.input_cones ) ], i -> List( [ 1 .. Length( rays ) ], j -> 0 ) );
        
        for i in [ 1 .. Length( fan!.input_cones ) ] do
          
          for j in fan!.input_cones[ i ] do
            
            cones[ i ][ j ] := 1;
            
          od;
        
        od;
        
        return ListOfMaximalConesInList( cones );
    
    fi;
    
    if IsBound( fan!.input_cone_list ) then
      
      rays := GivenRayGenerators( fan );
      
      ## Dont use ListWithIdenticalEntries here since it has new sideeffects.
      cones := List( [ 1 .. Length( fan!.input_cone_list ) ], i -> List( [ 1 .. Length( rays ) ], j -> 0 ) );
      
      for i in [ 1 .. Length( fan!.input_cone_list ) ] do
        
        for j in [ 1 .. Length( rays ) ] do
          
          if rays[ j ] in fan!.input_cone_list[ i ] then
            
            cones[ i ][ j ] := 1;
          
          fi;
        
        od;
      
      od;
      
      return ListOfMaximalConesInList( cones );
      
    fi;
    
    if IsCone( fan ) then
      
      return RaysInMaximalCones( Fan( [ fan ] ) );
    
    fi;
    
    TryNextMethod(  );
  
end );

InstallMethod( MaximalCones,
               "for external fans.",
               [ IsFan ],
               
  function( fan )
    local raylist, rays, conelist, i, lis, j;
    
    raylist := RaysInMaximalCones( fan );
    
    rays := RayGenerators( fan );
    
    conelist := [ ];
    
    for i in [ 1..Length( raylist ) ] do
      
      lis := [ ];
      
      for j in [ 1 .. Length( raylist[ i ] ) ] do
        
        if raylist[ i ][ j ] = 1 then
          
          lis := Concatenation( lis, [ rays[ j ] ] );
        
        fi;
      
      od;
      
      conelist := Concatenation( conelist, [ lis ] );
      
    od;
    
    conelist := List( conelist, Cone );
    
    Perform( conelist, function( i ) SetContainingGrid( i, ContainingGrid( fan ) ); return 0; end );
    
    Perform( conelist, function( i ) SetSuperFan( i, fan ); return 0; end );
    
    return conelist;
    
end );

##
InstallMethod( MaximalCones,
               [ IsFan, IsInt],
               
  function( fan, n )
    local all_max_cones, new_list, i; 
    
    all_max_cones:= MaximalCones( fan );
    
    new_list:= [ ];
    
    for i in all_max_cones do
      
      if Dimension( i ) = n then Add( new_list, i ); fi;
    
    od;
    
    return new_list;
    
end );

##
InstallMethod( GivenMaximalCones,
               "for external fans.",
               [ IsFan ],
               
  function( fan )
    local raylist, rays, conelist, i, lis, j;
    
    raylist := RaysInTheGivenMaximalCones( fan );
    
    rays := GivenRayGenerators( fan );
    
    conelist := [ ];
    
    for i in [ 1..Length( raylist ) ] do
      
      lis := [ ];
      
      for j in [ 1 .. Length( raylist[ i ] ) ] do
        
        if raylist[ i ][ j ] = 1 then
          
          lis := Concatenation( lis, [ rays[ j ] ] );
          
        fi;
        
      od;
      
      conelist := Concatenation( conelist, [ lis ] );
      
    od;
    
    conelist := List( conelist, Cone );
    
    Perform( conelist, function( i ) SetContainingGrid( i, ContainingGrid( fan ) ); return 0; end );
    
    Perform( conelist, function( i ) SetSuperFan( i, fan ); return 0; end );
    
    return conelist;
    
end );

##
InstallMethod( CanonicalizeFan,
               [ IsFan ],
  
  function( fan )
    local list_of_max, new_gen, cones,i,j, F, max_cones, rays_in_max_cones; 
    
    list_of_max := GivenMaximalCones( fan );
    
    new_gen := [ ];
    
    for i in list_of_max do 
      
      Append( new_gen, RayGenerators( i ) );
    
    od;
    
    #new_gen := DuplicateFreeList( new_gen );
    
    new_gen:= List( Set( new_gen ) );
    
    cones := List( [ 1 .. Length( list_of_max ) ], i -> List( [ 1 .. Length( new_gen ) ], j -> 0 ) );
    
    for i in [ 1 .. Length( list_of_max ) ] do
      
      for j in [ 1 .. Length( new_gen ) ] do
        
        if new_gen[ j ] in RayGenerators( list_of_max[ i ] ) then
          
          cones[ i ][ j ] := 1;
          
        fi;
        
      od;
    
    od;
    
    max_cones:= ListOfMaximalConesInList( cones );
    
    rays_in_max_cones:= [ ];
    
    for i in [ 1 .. Length( max_cones ) ] do
      
      Add( rays_in_max_cones, [ ] );
      
      for j in [ 1..Length( new_gen ) ] do 
      
           if max_cones[ i ][ j ] =1 then Add( rays_in_max_cones[ i ], j ); fi;
            
      od;
      
    od;
    
    F := Fan( new_gen, rays_in_max_cones );
    
    SetRayGenerators( F, new_gen );
    
    SetRaysInMaximalCones( F, max_cones );
    
    return F;
  
end );

##
InstallMethod( RaysInAllCones,
            [ IsFan ],
  
  function( fan )
    local max_cones, cones, current_list_of_faces, rays, L, i;
    
    if IsCone( fan ) then
      
      max_cones := [ fan ];
    
    else
      
      max_cones:= MaximalCones( fan );
    
    fi;
    
    cones := [ ];
    
    for i in max_cones do 
      
      current_list_of_faces:= FacesOfCone( i );
      
      cones := Concatenation( cones, List( current_list_of_faces, RayGenerators ) );
    
    od;
    
    cones := DuplicateFreeList( cones );
    
    rays := RayGenerators( fan );
    
    if not ForAll( DuplicateFreeList( Concatenation( cones ) ), r -> r = [ ] or r in rays ) then
      
      # If this error happens, it means that r is a positive multiple of some element in rays,
      # which is not problem and can be fixed very easily.
      Error( "This should not happen, please report this error!" );
    
    fi;
    
    L := List( cones, cone ->
        List( rays, function( r )
                      if r in cone then
                        return 1;
                      else
                        return 0;
                      fi;
                    end ) );
    
    return DuplicateFreeList( L );
  
end );

##
InstallMethod( AllCones,
        [ IsFan ],
  function( fan )
    local n, rays, rays_in_all_cones;
    
    n := AmbientSpaceDimension( fan );
    
    rays := RayGenerators( fan );
    
    rays_in_all_cones := RaysInAllCones( fan );
    
    rays_in_all_cones := List( rays_in_all_cones, r -> rays{ Positions( r, 1 ) } );
    
    rays_in_all_cones[ Position( rays_in_all_cones, [  ] ) ] := [ ListWithIdenticalEntries( n, 0 ) ];
    
    return List( rays_in_all_cones, Cone );
  
end );

##
InstallMethod( FVector, 
               [ IsFan ], 
  function( fan )
    local dim_of_cones; 
    
    dim_of_cones := List( AllCones( fan ), Dimension );
    
    return List( [ 1.. Dimension( fan ) ], i-> Length( Positions( dim_of_cones, i ) ) );
  
end );
 
##
InstallMethod( Dimension,
               "for fans",
               [ IsFan ],
               
  function( fan )
    
    return Maximum( List(MaximalCones( fan ), i-> Dimension( i ) ) );
    
end );

##
InstallMethod( AmbientSpaceDimension,
               "for fans",
               [ IsFan ],
               
  function( fan )
    
    return Length( RayGenerators( fan )[ 1 ] );
    
end );

##
InstallMethod( PrimitiveCollections,
               "for fans",
               [ IsFan ],
  
  function( fan )
    local rays, max_cones, facets, all_points, d_max, primitive_collections, d, checked, facet,
         I_minus_j, scanner, j, I;
    
    # collect data of the fan
    rays := RayGenerators( fan );
    
    max_cones := MaximalCones( fan );
    
    facets := List( [ 1 .. Length( max_cones ) ],
                        i -> List( RayGenerators( max_cones[ i ] ), k -> Position( rays, k ) ) );
    
    all_points := [ 1 .. Length( rays ) ];
    
    d_max := Maximum( List( facets, i -> Length( i ) ) ) + 1;
    
    # identify and return the primitive collections
    primitive_collections := [];
    
    for d in [ 1 .. d_max ] do
      checked := [];
      
      for facet in facets do
        
        for I_minus_j in Combinations( facet, d ) do
          
          scanner := Difference( all_points, Flat( I_minus_j ) );
          
          for j in scanner do
            
            I := Concatenation( I_minus_j, [ j ] );
            
            if not I in checked then
              
              Add( checked, I );
              
              # (1) I is contained in the primitive collections iff it is not contained in any facet
              if ForAll( [ 1 .. Length( facets ) ],
                            i -> not IsSubsetSet( facets[ i ], I ) ) then
                
                # (2) I is generator of the primitive collections iff
                # primitive_collections does not contain a "smaller" generator
                if ForAll( [ 1 .. Length( primitive_collections ) ],
                              i -> not IsSubsetSet( I, primitive_collections[i] ) ) then
                  
                  # then add this new generator
                  Append( primitive_collections, [ I ] );
                
                fi;
              
              fi;
            
            fi;
          od;
          
        od;
      
      od;
    
    od;
    
    return primitive_collections;
  
end );

#########################
##
##  Properties
##
#########################

InstallMethod( IsWellDefinedFan, 
               [ IsFan ],
  
  function( fan )
    local max_cones, combi, n;
    
    max_cones := MaximalCones( fan );
    
    n := Length( max_cones );
    
    combi := Combinations( [ 1 .. n ], 2 );
    
    return ForAll( combi,
      function( two_indices )
        local C1, C2, U;
        
        C1 := max_cones[ two_indices[ 1 ] ];
        
        C2 := max_cones[ two_indices[ 2 ] ];
        
        U := IntersectionOfCones( C1, C2 );
        
        if U in FacesOfCone( C1 ) and U in FacesOfCone( C2 ) then
        
          return true ;
        
        else
        
          return false;
        
        fi;
      
      end );
  
end );

##
InstallMethod( IsComplete, 
              [ IsFan ],
  function( fan )
    local list_of_cones, facets, facets_without_duplicates, positions;
    
    if Dimension( fan ) < AmbientSpaceDimension( fan ) then
      
      return false;
    
    fi;
    
    list_of_cones := MaximalCones( fan );
    
    if not ForAll( list_of_cones, IsFullDimensional ) then
      
      return false;
    
    fi;
    
    facets := Concatenation( List( list_of_cones, Facets ) );
    
    facets_without_duplicates := DuplicateFreeList( facets );
    
    positions := List( facets_without_duplicates, 
                  facet -> Length( Positions( facets, facet ) ) );
    
    if Set( positions ) = Set( [ 2 ] ) then
      
      return true;
    
    elif Set( positions ) = Set( [ 1, 2 ] ) then
      
      return false;
    
    else
      
      Print( "This should not happen, This may be caused by a not well-defined fan!\n" );
      return false;
    
    fi;
    
end );
   
##
InstallMethod( IsPointed,
               "for fans",
               [ IsFan ],
               
  function( fan )
    
    return ForAll( MaximalCones( fan ), IsPointed );
    
end );

##
InstallMethod( IsSmooth,
               "for fans",
               [ IsFan ],
               
  function( fan )
    
    return ForAll( MaximalCones( fan ), IsSmooth );
    
end );

##
InstallMethod( IsRegularFan,
               "whether a fan is a normalfan or not",
               [ IsFan ],
  
  function( fan )
    local max_cones, ambient_dim, rays, max_cones_ineqs, embed, nr_rays, nd, equations,
      inequations, r, L1, L0, i, hyper_surface, cone, index_rays;
    
    if not IsComplete( fan ) then
      
      return false;
    
    fi;
    
    if AmbientSpaceDimension( fan ) <= 2 then
      
      return true;
    
    fi;
    
    ## Algorithm is taken from the Maple Convex package.
    rays := RayGenerators( fan );
    
    ambient_dim := AmbientSpaceDimension( fan );
    
    max_cones := MaximalCones( fan );
    
    max_cones_ineqs := List( max_cones, DefiningInequalities );
    
    nr_rays := Length( rays );
    
    nd := ambient_dim * Length( max_cones );
    
    embed := function( a, b, c, d, e )
              local return_list, e1, d1;
              if e < c then  
                 e1 := e;
                 e := c;
                 c := e1;
                 d1 := d;
                 d := b;
                 b := d1;
              fi;
              return_list := ListWithIdenticalEntries( c, 0 );
              return_list := Concatenation( return_list, b );
              return_list := Concatenation( return_list,
              ListWithIdenticalEntries( e - Length( b ) - c, 0 ) );
              return_list := Concatenation( return_list, d );
              return Concatenation( return_list,
                ListWithIdenticalEntries( a - Length( return_list ), 0 ) );
             end;
    
    ## FIXME: Our convention is to handle only pointed fans. 
    ## convex handles fans with lineality spaces, so the lines differ.
    equations := List( [ 1 .. Length( max_cones ) ],
                       i -> List( EqualitiesOfCone( max_cones[ i ] ), 
                                  r -> embed( nd, r, ambient_dim * ( i - 1 ), [ ], 0 ) ) );
    
    equations := Concatenation( equations );
    
    inequations := [ ];
    
    index_rays := [ 1 .. nr_rays ];
    
    for r in [ 1 .. nr_rays ] do
        
        L0 := [];
        
        L1 := [];
        
        for i in [ 1 .. Length( max_cones ) ] do
          
          if rays[ r ] in max_cones[ i ] then
            
            Add( L1, i );
            
          else
            
            Add( L0, i );
            
          fi;
          
        od;
        
        i := ambient_dim * ( L1[ 1 ] - 1 );
        
        index_rays[ r ] := i;
        
        Remove( L1, L1[ 1 ] );
        
        equations := Concatenation( equations,
                          List( L1,
                            j -> embed( nd, rays[ r ], i, - rays[ r ], ambient_dim * ( j - 1 ) ) ) );
        
        inequations := Concatenation( inequations,
                          List( L0,
                            j -> embed( nd, rays[ r ], i, - rays[ r ], ambient_dim * ( j - 1 ) ) ) );
        
    od;
    
    hyper_surface := ConeByEqualitiesAndInequalities( equations, [ ] );
    
    i := AmbientSpaceDimension( hyper_surface ) - Dimension( hyper_surface );
    
    cone := ConeByEqualitiesAndInequalities( equations, inequations );
    
    r := AmbientSpaceDimension( cone ) - Dimension( cone );
    
    return i = r;
    
end );

##
## This is implementation of the Shephard's criterion
## (Theorem 4.7, Combinatorial convexity and algebraic geometry, Ewald, Guenter)
##
InstallMethod( IsNormalFan,
          [ IsFan ],
  
  function( fan )
      local rays, cones, mat, G, polytopes, P, M;
      
      if not IsComplete( fan ) then
        
        return false;
      
      fi;
      
      if AmbientSpaceDimension( fan ) <= 2 then
        
        return true;
      
      fi;
      
      if HasIsRegularFan( fan ) then
        
        return IsRegularFan( fan );
      
      fi;
      
      rays := RayGenerators( fan );
      
      cones := ShallowCopy( RaysInAllCones( fan ) );
      
      Remove( cones, PositionProperty( cones, IsZero ) );
      
      mat := HomalgMatrix( rays, HOMALG_RATIONALS );
      
      G := GaleTransform( mat );
      
      if IsZero( G ) then
        
        return true;
      
      fi;
      
      G := EntriesOfHomalgMatrixAsListList( G );
      
      polytopes := List( cones, cone -> Set( DuplicateFreeList( G{ Positions( cone, 0 ) } ) ) );
      
      polytopes := DuplicateFreeList( polytopes );
      
      polytopes := List( polytopes, l -> Polytope( l ) );
      
      P := Iterated( polytopes, IntersectionOfPolytopes );
      
      if Dimension( P ) = -1 then
        
        return false;
      
      elif Dimension( P ) = 0 then
        
        M := Vertices( P )[ 1 ];
        
        return ForAll( polytopes, P -> IsInteriorPoint( M, P ) );
      
      else
        
        M := RandomInteriorPoint( P );
        
        if ForAll( polytopes, P -> IsInteriorPoint( M, P ) ) then
          
          return true;
        
        else
          
          return false;
        
        fi;
      
      fi;
  
end );

##
InstallMethod( IsRegularFan, [ IsFan ], IsNormalFan );

##
InstallMethod( IsFullDimensional,
               "for fans",
               [ IsFan ],
               
  function( fan )
    
    return ForAny( MaximalCones( fan ), i -> Dimension( i ) = AmbientSpaceDimension( i ) );
    
end );


##
InstallMethod( IsSimplicial,
               " for homalg fans",
               [ IsFan ],
               
  function( fan )
    
    fan := MaximalCones( fan );
    
    return ForAll( fan, IsSimplicial );
    
end );

##
InstallMethod( IsFanoFan,
            [ IsFan ],
  function( fan )
    local polyt;
    
    if HasIsComplete( fan ) and not IsComplete( fan ) then
      
      return false;
    
    fi;
    
    polyt := Polytope( RayGenerators( fan ) );
      
      if not IsFullDimensional( polyt ) or
            not IsInteriorPoint(
              ListWithIdenticalEntries( AmbientSpaceDimension( polyt ), 0 ), polyt ) then
        
        return false;
      
      fi;
    
    return fan = NormalFan( PolarPolytope( polyt ) );
  
end );

#########################
##
##  Methods
##
#########################

##
InstallMethod( \=,
            [ IsFan, IsFan ],
  function( fan1, fan2 )
    
    if RayGenerators( fan1 ) = RayGenerators( fan2 ) and
        Set( RaysInMaximalCones( fan1 ) ) = Set( RaysInMaximalCones( fan2 ) ) then
          
          return true;
    
    fi;
    
    if RayGenerators( fan1 ) <> RayGenerators( fan2 ) and
        Set( RayGenerators( fan1 ) ) = Set( RayGenerators( fan2 ) ) then
          
          Error( "This should not happen! Please report this error." );
    
    fi;
    
    return false;
  
end );

##
InstallMethod( \*,
               "for fans.",
               [ IsFan, IsFan ],
               
  function( fan1, fan2 )
    local rays1, rays2, m1, m2, new_m, new_rays, cones1, cones2, i, j, k, new_cones, akt_cone, new_fan;
    
    rays1 := RayGenerators( fan1 );
    
    rays2 := RayGenerators( fan2 );
    
    m1 := Rank( ContainingGrid( fan1 ) );
    
    m2 := Rank( ContainingGrid( fan2 ) );
    
    m1 := List( [ 1 .. m1 ], i -> 0 );
    
    m2 := List( [ 1 .. m2 ], i -> 0 );
    
    rays1 := List( rays1, i -> Concatenation( i, m2 ) );
    
    rays2 := List( rays2, i -> Concatenation( m1, i ) );
    
    new_rays := Concatenation( rays1, rays2 );
    
    cones1 := RaysInMaximalCones( fan1 );
    
    cones2 := RaysInMaximalCones( fan2 );
    
    new_cones := [ ];
    
    m1 := Length( rays1 );
    
    m2 := Length( rays2 );
    
    for i in cones1 do
      
      for j in cones2 do
        
        akt_cone := [ ];
        
        for k in [ 1 .. m1 ] do
          
          if i[ k ] = 1 then
            
            Add( akt_cone, k );
          
          fi;
        
        od;
        
        for k in [ 1 .. m2 ] do
          
          if j[ k ] = 1 then
            
            Add( akt_cone, k + m1 );
          
          fi;
        
        od;
        
        Add( new_cones, akt_cone );
      
      od;
    
    od;
    
    new_fan := FanWithFixedRays( new_rays, new_cones );
    
    SetContainingGrid( new_fan, ContainingGrid( fan1 ) + ContainingGrid( fan2 ) );
    
    return new_fan;
    
end );

##
InstallMethod( ToricStarFan,
               "for fans",
               [ IsFan, IsCone ],
               
  function( fan, cone )
    local maximal_cones, rays_of_cone, defining_inequalities, value_list, cone_list, i, j, breaker;
    
    maximal_cones := MaximalCones( fan );
    
    rays_of_cone := RayGenerators( cone );
    
    cone_list := [ ];
    
    breaker := false;
    
    for i in maximal_cones do
      
      defining_inequalities := DefiningInequalities( i );
      
      for j in rays_of_cone do
        
        value_list := List( defining_inequalities, k -> k * j );
        
        if not ForAll( value_list, k -> k >= 0 ) or not 0 in value_list then
          
          breaker := true;
          
          continue;
          
        fi;
        
      od;
      
      if breaker then
        
        breaker := false;
        
        continue;
        
      fi;
      
      Add( cone_list, cone );
      
    od;
    
    cone_list := Fan( cone_list );
    
    SetContainingGrid( cone_list, ContainingGrid( fan ) );
    
end );
##
InstallMethod( \*,
               "for homalg fans.",
               [ IsCone, IsFan ],
               
  function( cone, fan )
    
    return Fan( [ cone ] ) * fan;
    
end );

##
InstallMethod( \*,
               "for homalg fans.",
               [ IsFan, IsCone ],
               
  function( fan, cone )
    
    return fan * Fan( [ cone ] );
    
end );

##
InstallMethod( ToricStarFan,
               "for fans",
               [ IsFan, IsCone ],
               
  function( fan, cone )
    local maximal_cones, rays_of_cone, defining_inequalities, value_list, cone_list, i, j, breaker;
    
    maximal_cones := MaximalCones( fan );
    
    rays_of_cone := RayGenerators( cone );
    
    cone_list := [ ];
    
    breaker := false;
    
    for i in maximal_cones do
      
      defining_inequalities := DefiningInequalities( i );
      
      for j in rays_of_cone do
        
        value_list := List( defining_inequalities, k -> k * j );
        
        if not ForAll( value_list, k -> k >= 0 ) or not 0 in value_list then
          
          breaker := true;
          
          continue;
          
        fi;
        
      od;
      
      if breaker then
        
        breaker := false;
        
        continue;
        
      fi;
      
      Add( cone_list, cone );
      
    od;
    
    cone_list := Fan( cone_list );
    
    SetContainingGrid( cone_list, ContainingGrid( fan ) );
    
    return cone_list;
    
end );

#########################
##
##  Simple functions
##
#########################

InstallMethod( FirstLessTheSecond,
               [ IsList, IsList],
               
  function( u, v )
    
    if Length( u ) <> Length( v ) then
      
      Error( "The two lists should have the same length!" );
    
    fi;
    
    return ForAll( [ 1 .. Length( u ) ], i-> u[ i ] <= v[ i ] );
  
end );

InstallMethod( OneMaximalConeInList,
              [ IsList ],
  function( u )
    local list, max, new_u, i;
    
    #new_u:= DuplicateFreeList( ShallowCopy( u ) );
    new_u:= List( Set( u ) );
    
    max := new_u[ 1 ];
    
    for i in new_u do
      
      if FirstLessTheSecond( max, i ) then 
        
        max := i;
      
      fi;
    
    od;
    
    list := [ ];
    
    for i in new_u do 
      
      if FirstLessTheSecond( i, max ) then 
        
        Add( list, i );
      
      fi;
    
    od;
    
    return [ max, list ];
    
 end );

##
InstallMethod( ListOfMaximalConesInList,
               [ IsList ],
               
  function( L )
    local l, list_of_max, current, new_L;
    
    list_of_max := [ ];
    
    #new_L:= DuplicateFreeList( L );
    new_L := Set( L );
    
    while Length( new_L )<> 0 do
      
      current := OneMaximalConeInList( new_L );
      
      Add( list_of_max, current[ 1 ] );
      
      SubtractSet( new_L, current[ 2] );
    
    od;
    
    return list_of_max;
    
end );

####################################
##
## Display Methods
##
####################################

##
InstallMethod( ViewObj,
               "for homalg fans",
               [ IsFan ],
               
  function( fan )
    local str;
    
    Print( "<A" );
    
    if HasIsComplete( fan ) then
      
      if IsComplete( fan ) then
          
          Print( " complete" );
          
      fi;
    
    fi;
    
    if HasIsPointed( fan ) then
      
      if IsPointed( fan ) then
          
          Print( " pointed" );
          
      fi;
    
    fi;
      
    if HasIsSmooth( fan ) then
      
      if IsSmooth( fan ) then
          
          Print( " smooth" );
          
      fi;
    
    fi;
    
    Print( " fan in |R^" );
    
    Print( String( AmbientSpaceDimension( fan ) ) );
    
    if HasRays( fan ) then
      
      Print( " with ", String( Length( Rays( fan ) ) )," rays" );
      
    fi;
    
    Print( ">" );
    
end );

##
InstallMethod( Display,
               "for homalg polytopes",
               [ IsFan ],
               
  function( fan )
    local str;
    
    Print( "A" );
    
    if HasIsComplete( fan ) then
      
      if IsComplete( fan ) then
        
        Print( " complete" );
        
      fi;
    
    fi;
    
    Print( " fan in |R^" );
    
    Print( String( AmbientSpaceDimension( fan ) ) );
    
    if HasRays( fan ) then
      
      Print( " with ", String( Length( Rays( fan ) ) )," rays" );
      
    fi;
    
    Print( ".\n" );
    
end );

