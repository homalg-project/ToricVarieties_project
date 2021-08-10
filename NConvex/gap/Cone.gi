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

DeclareRepresentation( "IsExternalConeRep",
                       IsCone and IsExternalFanRep,
                       [ ] );

DeclareRepresentation( "IsConvexConeRep",
                       IsExternalConeRep,
                       [ ] );

DeclareRepresentation( "IsInternalConeRep",
                       IsCone and IsInternalFanRep,
                       [ ] );

####################################
##
## Types and Families
##
####################################


BindGlobal( "TheFamilyOfCones",
        NewFamily( "TheFamilyOfCones" , IsCone ) );

BindGlobal( "TheTypeExternalCone",
        NewType( TheFamilyOfCones,
                 IsCone and IsExternalConeRep ) );

BindGlobal( "TheTypeConvexCone",
        NewType( TheFamilyOfCones,
                 IsConvexConeRep ) );

BindGlobal( "TheTypeInternalCone",
        NewType( TheFamilyOfCones,
                 IsInternalConeRep ) );


#####################################
##
## Property Computation
##
#####################################

##
if CddAvailable then
InstallMethod( IsPointed,
                "for homalg cones.",
                [ IsCone ],
                
   function( cone )
     
     return Cdd_IsPointed( ExternalCddCone ( cone ) );
     
end );
fi;

##
if CddAvailable then
InstallMethod( InteriorPoint,
                [ IsConvexObject and IsCone ],
    function( cone )
    local point, denominators;
    point := Cdd_InteriorPoint( ExternalCddCone( cone ) );
    denominators := List( point, DenominatorRat );
    if DuplicateFreeList( denominators ) = [ 1 ] then
        return point;
    else
        return Lcm( denominators )*point;
    fi;
end );
fi;

##
InstallMethod( IsComplete,
               " for cones",
               [ IsCone ],
               
  function( cone )
  local rays; 
  
   if IsPointed( cone ) or not IsFullDimensional( cone ) then
        
        return false;
        
   fi;
    
  rays:= RayGenerators( cone );
  
  return IsFullDimensional( cone ) and ForAll( rays, i-> -i in rays );
  
end );

##  Let N= Z^{1 \times n}. Then N is free Z-modue. Let r_1,...,r_k \in N be the generating rays of the 
##  cone. Let A= [ r_1,..., r_k ]^T \in Z^{ k \times n }. Let M= N/ Z^{1 \times k}A. Now let B the smith
## normal form of A. Then B \in Z^{ k \times n } and there exists l<=k, l<=n with B_{i,i} \neq 0 and B_{i-1,i}| B_{i-1,i} for 
## all 1<i<= l and B_{i,i}=0 for i>l. We have now M= Z/Zb_{1,1} \oplus ... \oplus Z/Zb_{l,l} \oplus Z^{1 \times max{n,k}-l }. 
## If all B_{i,i}=1 for i<=l, then M= Z^{1 \times max{n,k}-l }. i.e. M is free. Thus there is H \subset N with N= H \oplus Z^{1 \times k}A. 
## ( Corollary 7.55, Advanced modern algebra, J.rotman ).
##
InstallMethod( IsSmooth,
               "for cones",
               [ IsCone ],
               
  function( cone )
    local rays, smith;
    
    rays := RayGenerators( cone );
    
    if RankMat( rays ) <> Length( rays ) then
        
        return false;
        
    fi;
    
    smith := SmithNormalFormIntegerMat(rays);
    
    smith := List( Flat( smith ), i -> AbsInt( i ) );
    
    if Maximum( smith ) <> 1 then
        
        return false;
        
    fi;
    
    return true;
    
end );

##
InstallMethod( IsRegularCone,
               "for cones.",
               [ IsCone ],
  function( cone )
    
    return IsSmooth( cone );
    
end );


##
InstallMethod( IsSimplicial,
               " for cones",
               [ IsCone ],
  function( cone )
  local rays;
  
  rays:= RayGenerators( cone );
  
  return Length( rays )= RankMat( rays );
  
end );

##
InstallMethod( IsFullDimensional,
               "for cones",
               [ IsCone ], 
  function( cone )
  
  return RankMat( RayGenerators( cone ) ) = AmbientSpaceDimension( cone );
  
end );
  
##
InstallTrueMethod( HasConvexSupport, IsCone );

##
InstallMethod( IsRay,
               "for cones.",
               [ IsCone ],
               
  function( cone )
    
    return Dimension( cone ) = 1;
    
end );

#####################################
##
## Attribute Computation
##
#####################################

if CddAvailable then
InstallMethod( RayGenerators,
               [ IsCone ],
               
  function( cone )
#   local nmz_cone, l, r;
  
   return Cdd_GeneratingRays( ExternalCddCone( cone ) );
  
#   nmz_cone := ExternalNmzCone( cone );
  
#   r := NmzGenerators( nmz_cone );
  
#   l := NmzMaximalSubspace( nmz_cone );
  
#   return Concatenation( r, l, -l );

  end );
fi;

##
InstallMethod( DualCone,
               "for external cones",
               [ IsCone ],
               
  function( cone )
    local dual;
    
    if RayGenerators( cone ) = [ ] then
	dual := ConeByInequalities( [ List( [ 1 .. AmbientSpaceDimension( cone ) ], i -> 0 ) ] );
    else
        dual := ConeByInequalities( RayGenerators( cone ) );
    fi;

    SetDualCone( dual, cone );
    
    SetContainingGrid( dual, ContainingGrid( cone ) );
    
    return dual;
    
end );

##
if CddAvailable then
InstallMethod( DefiningInequalities,
               [ IsCone ],
               
  function( cone )
  local inequalities, new_inequalities, equalities, i, u; 
  
  inequalities:= ShallowCopy( Cdd_Inequalities( ExternalCddCone( cone ) ) );
  
  equalities:= ShallowCopy( Cdd_Equalities( ExternalCddCone( cone ) ) );
  
  for i in equalities do 
  
       Append( inequalities, [ i,-i ] );
       
  od;
    
new_inequalities:= [ ];
    
  for i in inequalities do 
  
       u:= ShallowCopy( i );
       
       Remove( u , 1 );
       
       Add(new_inequalities, u );
       
  od;
  
  return new_inequalities; 
    
end );
fi;

##
InstallMethod( FactorConeEmbedding,
               "for cones",
               [ IsCone ],
               
  function( cone )
    
    return TheIdentityMorphism( ContainingGrid( cone ) );
    
end );

##
if CddAvailable then
InstallMethod( EqualitiesOfCone,
               "for external Cone",
               [ IsCone ],
               
  function( cone )
  local equalities, new_equalities, u, i;
  
    equalities:= Cdd_Equalities( ExternalCddCone( cone ) );
    
    new_equalities:= [ ];
    
  for i in equalities do 
  
       u:= ShallowCopy( i );
       
       Remove( u , 1 );
       
       Add(new_equalities, u );
       
  od;
  
  return new_equalities;

end );
fi;

##
InstallMethod( RelativeInteriorRay,
               "for a cone",
               [ IsCone ],
               
  function( cone )
    local rays, rand_mat;
    
    rays := RayGenerators( cone );
    
    rand_mat := RandomMat( Length( rays ), 1 );
    
    rand_mat := Concatenation( rand_mat );
    
    rand_mat := List( rand_mat, i -> AbsInt( i ) + 1 );
    
    return Sum( [ 1 .. Length( rays ) ], i -> rays[ i ] * rand_mat[ i ] );
    
end );

##
InstallMethod( HilbertBasisOfDualCone,
               "for cone",
               [ IsCone ],
               
  function( cone )
    
        return HilbertBasis( DualCone( cone ) );
        
end );

## This method is commented since it returns a wrong answer for not-pinted cones
## C := Cone( [ e1 ] );
##
# InstallMethod( HilbertBasisOfDualCone,
#                "for cone",
#                [ IsCone ],
               
#   function( cone )
#     local ray_generators, d, i, dim, V, D, max, v, I, b, DpD, d1, d2, Dgens,
#     zero_element, entry;
    
#     ray_generators := RayGenerators( cone );
    
#     dim := AmbientSpaceDimension( cone );
    
#     max := Maximum( List( Concatenation( ray_generators ), AbsInt ) );
    
#     D := [ ]; 
    
#     ## This needs to be done smarter
#     I:= Cartesian( List( [ 1 .. dim ], i -> [ -max .. max ] ) );
    
#     for v in I do
        
#         if ForAll( ray_generators, i -> i * v >= 0 ) then
            
#             Add( D, v );
            
#         fi;
        
#     od;
    
#     DpD := [ ];
    
#     for d1 in D do
        
#         if d1 * d1 <> 0 then
            
#             for d2 in D do
                
#                 if d2 * d2 <> 0 then
                    
#                     Add( DpD, d1 + d2 );
                    
#                 fi;
                
#             od;
            
#         fi;
        
#     od;
    
#     Dgens :=  [ ];
    
#     for d in D do
        
#         if not d in DpD then
            
#             Add( Dgens, d );
            
#         fi;
        
#     od;
    
#     if not Dgens = [ ] then
        
#         zero_element := ListWithIdenticalEntries( Length( Dgens[ 1 ] ), 0 );
        
#         i := Position( Dgens, zero_element );
        
#         if i <> fail then
            
#             Remove( Dgens, i );
            
#         fi;
        
#     fi;
    
#     entry := ToDoListEntry( [ [ cone, "DualCone" ] ], [ DualCone, cone ], "HilbertBasis", Dgens );
    
#     AddToToDoList( entry );
    
#     return Dgens;
    
# end);

##
InstallMethod( AmbientSpaceDimension,
               "for cones",
               [ IsCone ],
               
  function( cone )
    
    if Length( RayGenerators( cone ) ) > 0 then
    
       return Length( RayGenerators( cone )[ 1 ] );
    
    else 
    
       return 1;
       
    fi;
    
end );

##
InstallMethod( Dimension,
               "for cones",
               [ IsCone and HasRayGenerators ],
               
  function( cone )
    
    if Length( RayGenerators( cone ) ) > 0 then
     
       return RankMat( RayGenerators( cone ) );
      
    else 
    
       return 0;
       
    fi;
   
    TryNextMethod();
    
end );

##
if CddAvailable then
InstallMethod( Dimension, 
               "for cones",
               [ IsCone ],
  function( cone )
 
  return Cdd_Dimension( ExternalCddCone( cone ) );
  
end );
fi;

##
InstallMethod( HilbertBasis,
               "for cones",
               [ IsCone ],
               
  function( cone )
    local ineq, const;

    if not IsPointed( cone ) then
        
        Error( "Hilbert basis for not-pointed cones is not yet implemented, you can use the command 'LatticePointsGenerators' " );
        
    fi;


    if IsPackageMarkedForLoading( "NormalizInterface", ">=1.1.0" ) then

      return Set( ValueGlobal( "NmzHilbertBasis" )( ExternalNmzCone( cone ) ) );
    
    elif IsPackageMarkedForLoading( "4ti2Interface", ">=2018.07.06" ) then
      
      ineq := DefiningInequalities( cone );

      const := ListWithIdenticalEntries( Length( ineq ), 0 );

      return Set( ValueGlobal( "4ti2Interface_zsolve_equalities_and_inequalities" )( [  ], [  ], ineq, const )[ 2 ]: precision := "gmp" );

    else

      Error( "4ti2Interface or NormalizInterface should be loaded!" );

    fi;
  
end );

##
if CddAvailable then
InstallMethod( RaysInFacets,
               " for cones",
               [ IsCone ],
               
  function( cone )
  local external_cone, list_of_facets, generating_rays, list, current_cone, current_list, current_ray_generators, i;  
  
    external_cone := Cdd_H_Rep ( ExternalCddCone ( cone ) );
    
    list_of_facets:= Cdd_Facets( external_cone );
    
    generating_rays:= RayGenerators( cone );
    
    list:= [ ];
    
    for i in list_of_facets do
    
      current_cone := Cdd_ExtendLinearity( external_cone, i );
      
      current_ray_generators := Cdd_GeneratingRays( current_cone ) ;
      
      current_list:= List( [1..Length( generating_rays )], 
                           
                           function(j)

                             if generating_rays[j] in Cone( current_cone ) then
                                return 1;
                             else 
                                return 0;
                             fi;
                           
                           end );
                           
      Add( list, current_list );
      
    od;
      
return list;
    
end );
fi;

##
if CddAvailable then
InstallMethod( RaysInFaces,
               " for cones",
               [ IsCone ],
               
  function( cone )
  local external_cone, list_of_faces, generating_rays, list, current_cone, current_list, current_ray_generators, i,j;  
  
    external_cone := Cdd_H_Rep( ExternalCddCone ( cone ) );
    
    list_of_faces:= Cdd_Faces( external_cone );
    
    generating_rays:= RayGenerators( cone );
    
    list:= [ ];
    
    for i in list_of_faces do
      
      if i[ 1 ] <> 0 then
        
        current_cone := Cdd_ExtendLinearity( external_cone, i[ 2 ] );
       
        current_ray_generators := Cdd_GeneratingRays( current_cone ) ;
            
        current_list:= List( [ 1 .. Length( generating_rays ) ], 
        
                                function(j)

                                  if generating_rays[j] in Cone( current_cone ) then
                                        return 1;                        
                                  else
                                        return 0;
                                  fi;
                                
                                end );

        Add( list, current_list );

      fi;

   od;

return list;

end );
fi;

##
InstallMethod( Facets,
               "for external cones",
               [ IsCone ],
               
  function( cone )
    local raylist, rays, conelist, i, lis, j;
    
    raylist := RaysInFacets( cone );
    
    rays := RayGenerators( cone );
    
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
    
    if conelist = [ [ ] ] then 
       return [ Cone( [ List( [ 1 .. AmbientSpaceDimension( cone ) ], i->0 ) ] ) ];
    fi;
    
    return List( conelist, Cone );
    
end );

##
InstallMethod( FacesOfCone,
               " for external cones",
               [ IsCone ],
               
  function( cone )
    local raylist, rays, conelist, i, lis, j;
    
    raylist := RaysInFaces( cone );
    
    rays := RayGenerators( cone );
    
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
    
    lis := [ Cone( [ List( [ 1 .. AmbientSpaceDimension( cone ) ], i-> 0 ) ] ) ];
    
    return Concatenation( lis, List( conelist, Cone ) );
    
end );

##
if CddAvailable then
InstallMethod( FVector,
               "for cones",
               [ IsCone ],
  function( cone )
    local external_cone, faces;

    external_cone := Cdd_H_Rep( ExternalCddCone( cone ) );
  
    faces := Cdd_Faces( external_cone );

    return List( [ 1 .. Dimension( cone ) ], 
                i -> Length( PositionsProperty( faces, face -> face[ 1 ] = i ) ) );
  end );
fi;

##
if CddAvailable then
InstallMethod( LinearSubspaceGenerators,
               [ IsCone ],
               
  function( cone )
  local inequalities, basis, new_basis;
  
  inequalities:=  DefiningInequalities( cone );
  
  basis := NullspaceMat( TransposedMat( inequalities ) );
  
  new_basis := List( basis, i-> LcmOfDenominatorRatInList( i )*i  );
  
  return  new_basis;
   
end );
fi;

##
InstallMethod( LinealitySpaceGenerators,
               [ IsCone ],
   
   LinearSubspaceGenerators
   
 );
 
##
InstallMethod( GridGeneratedByCone,
               " for homalg cones.",
               [ IsCone ],
               
  function( cone )
    local rays, M, grid;
    
    rays := RayGenerators( cone );
    
    M := HomalgMatrix( rays, HOMALG_MATRICES.ZZ );
    
    M := HomalgMap( M, "free", ContainingGrid( cone ) );
    
    grid := ImageSubobject( M );
    
    SetFactorGrid( cone, FactorObject( grid ) );
    
    SetFactorGridMorphism( cone, CokernelEpi( M ) );
    
    return grid;
    
end );

##
InstallMethod( GridGeneratedByOrthogonalCone,
               " for homalg cones.",
               [ IsCone ],
               
  function( cone )
    local rays, M;
    
    rays := RayGenerators( cone );
    
    M := HomalgMatrix( rays, HOMALG_MATRICES.ZZ );
    
    M := Involution( M );
    
    M := HomalgMap( M, ContainingGrid( cone ), "free" );
    
    return KernelSubobject( M );
    
end );

##
InstallMethod( FactorGrid,
               " for homalg cones.",
               [ IsCone ],
               
  function( cone )
    local rays, M, grid;
    
    rays := RayGenerators( cone );
    
    M := HomalgMatrix( rays, HOMALG_MATRICES.ZZ );
    
    M := HomalgMap( M, "free", ContainingGrid( cone ) );
    
    grid := ImageSubobject( M );
    
    SetGridGeneratedByCone( cone, grid );
    
    SetFactorGridMorphism( cone, CokernelEpi( M ) );
    
    return FactorObject( grid );
    
end );

##
InstallMethod( FactorGridMorphism,
               " for homalg cones.",
               [ IsCone ],
               
  function( cone )
    local rays, grid, M;
    
    rays := RayGenerators( cone );
    
    M := HomalgMatrix( rays, HOMALG_MATRICES.ZZ );
    
    M := HomalgMap( M, "free", ContainingGrid( cone ) );
    
    grid := ImageSubobject( M );
    
    SetGridGeneratedByCone( cone, grid );
    
    SetFactorGrid( cone, FactorObject( grid ) );
    
    return CokernelEpi( M );
    
end );

InstallMethod( LatticePointsGenerators, 
               [ IsCone ], 
               
    function( cone )
    local n;
    
    n:= AmbientSpaceDimension( cone );
    
    return LatticePointsGenerators( Polyhedron( [ List( [ 1 .. n ], i -> 0 ) ], cone ) );
    
end ); 

##
InstallMethod( StarSubdivisionOfIthMaximalCone,
               " for homalg cones and fans",
               [ IsFan, IsInt ],
               
  function( fan, noofcone )
    local maxcones, cone, ray, cone2;
    
    maxcones := MaximalCones( fan );
 
    if Length( maxcones ) < noofcone then
        
        Error( " not enough maximal cones" );
        
    fi;
    
    if not IsSmooth( maxcones[ noofcone ] ) then

      Error( " the specified cone is not smooth!" );

    fi;

    maxcones := List( maxcones, RayGenerators );
     
    cone := maxcones[ noofcone ];
    
    ray := Sum( cone );
    
    cone2 := Concatenation( cone, [ ray ] );
    
    cone2 := UnorderedTuples( cone2, Length( cone2 ) - 1 );
    
    Apply( cone2, Set );
    
    Apply( maxcones, Set );
    
    maxcones := Concatenation( maxcones, cone2 );
    
    maxcones := Difference( maxcones, [ Set( cone ) ] );
    
    maxcones := Fan( maxcones );
    
    SetContainingGrid( maxcones, ContainingGrid( fan ) );
    
    return maxcones;
    
end );


##
InstallMethod( StarFan,
               " for homalg cones in fans",
               [ IsCone and HasSuperFan ],
               
  function( cone )
    
    return StarFan( cone, SuperFan( cone ) );
    
end );

##
InstallMethod( StarFan,
               " for homalg cones",
               [ IsCone, IsFan ],
               
  function( cone, fan )
    local maxcones;
    
    maxcones := MaximalCones( fan );
    
    maxcones := Filtered( maxcones, i -> Contains( i, cone ) );
    
    maxcones := List( maxcones, HilbertBasis );
    
    ## FIXME: THIS IS BAD CODE! REPAIR IT!
    maxcones := List( maxcones, i -> List( i, j -> HomalgMap( HomalgMatrix( [ j ], HOMALG_MATRICES.ZZ ), 1 * HOMALG_MATRICES.ZZ, ContainingGrid( cone ) ) ) );
    
    maxcones := List( maxcones, i -> List( i, j -> UnderlyingListOfRingElementsInCurrentPresentation( ApplyMorphismToElement( ByASmallerPresentation( FactorGridMorphism( cone ) ), HomalgElement( j ) ) ) ) );
    
    maxcones := Fan( maxcones );
    
    return maxcones;
    
end );

##############################
##
## Methods
##
##############################

##
InstallMethod( FourierProjection,
               [ IsCone, IsInt ],
  function( cone, n )
  local ray_generators, new_rays, i, j;
  
  ray_generators:= RayGenerators( cone );
  
  new_rays:= [ ];
  
  for i in ray_generators do
  
     j:= ShallowCopy( i );
     Remove(j, n );
     Add( new_rays, j );
     
  od;
  
  return Cone( new_rays );
  
end );

InstallMethod( \*,
               [ IsInt, IsCone ],
    function( n, cone )

    if n>0 then
        return cone;
    elif n=0 then
        return Cone( [ List([ 1 .. AmbientSpaceDimension( cone ) ], i-> 0 ) ] );
    else
        return Cone( -RayGenerators( cone ) );
    fi;
    
end );

##
InstallMethod( \*,
               " cartesian product for cones.",
               [ IsCone, IsCone ],
               
  function( cone1, cone2 )
    local rays1, rays2, i, j, raysnew;
    
    rays1 := RayGenerators( cone1 );
    
    rays2 := RayGenerators( cone2 );
    
    rays1 := Concatenation( rays1, [ List( [ 1 .. Length( rays1[ 1 ] ) ], i -> 0 ) ] );
    
    rays2 := Concatenation( rays2, [ List( [ 1 .. Length( rays2[ 1 ] ) ], i -> 0 ) ] );
    
    raysnew := [ 1 .. Length( rays1 ) * Length( rays2 ) ];
    
    for i in [ 1 .. Length( rays1 ) ] do
        
        for j in [ 1 .. Length( rays2 ) ] do
            
            raysnew[ (i-1)*Length( rays2 ) + j ] := Concatenation( rays1[ i ], rays2[ j ] );
            
        od;
        
    od;
    
    raysnew := Cone( raysnew );
    
    SetContainingGrid( raysnew, ContainingGrid( cone1 ) + ContainingGrid( cone2 ) );
    
    return raysnew;
    
end );
 
##
InstallMethod( NonReducedInequalities,
               "for a cone",
               [ IsCone ],
               
  function( cone )
    local inequalities;
    
    if HasDefiningInequalities( cone ) then
        
      return DefiningInequalities( cone );
        
    fi;
    
    inequalities := [ ];
    
    if IsBound( cone!.input_equalities ) then
        
      inequalities := Concatenation( inequalities, cone!.input_equalities, - cone!.input_equalities );
        
    fi;
    
    if IsBound( cone!.input_inequalities ) then
        
      inequalities := Concatenation( inequalities, cone!.input_inequalities );
        
    fi;
    
    if inequalities <> [ ] then
        
      return inequalities;
        
    fi;
    
    return DefiningInequalities( cone );
    
end );

InstallMethod( IntersectionOfCones,
               "for homalg cones",
               [ IsCone and HasDefiningInequalities, IsCone and HasDefiningInequalities ],
               
  function( cone1, cone2 )
    local inequalities, cone;
    
    if not Rank( ContainingGrid( cone1 ) )= Rank( ContainingGrid( cone2 ) ) then
        
        Error( "cones are not from the same grid" );
        
    fi;
    
    inequalities := Unique( Concatenation( [ NonReducedInequalities( cone1 ), NonReducedInequalities( cone2 ) ]  ) );
    
    cone := ConeByInequalities( inequalities );
    
    SetContainingGrid( cone, ContainingGrid( cone1 ) );
    
    return cone;
    
end );

##
if CddAvailable then
InstallMethod( IntersectionOfCones,
               "for homalg cones",
               [ IsCone, IsCone ],
               
  function( cone1, cone2 )
    local cone, ext_cone;
    
    if not Rank( ContainingGrid( cone1 ) )= Rank( ContainingGrid( cone2 ) ) then
        
        Error( "cones are not from the same grid" );
        
    fi;
    
    ext_cone := Cdd_Intersection( ExternalCddCone( cone1), ExternalCddCone( cone2 ) );
    
    cone := Cone( ext_cone );
    
    SetContainingGrid( cone, ContainingGrid( cone1 ) );
    
    return cone;
    
end );
fi;

##
InstallMethod( IntersectionOfCones,
               "for a list of convex cones",
               [ IsList ],
               
  function( list_of_cones )
    local grid, inequalities, equalities, i, cone;
    
    if list_of_cones = [ ] then
        
        Error( "Cannot create an empty cone\n" );
        
    fi;
    
    if not ForAll( list_of_cones, IsCone ) then
        
        Error( "not all list elements are cones\n" );
        
    fi;
    
    grid := ContainingGrid( list_of_cones[ 1 ] );
    
    inequalities := [ ];
    
    equalities := [ ];
    
    for i in list_of_cones do
        
        if HasDefiningInequalities( i ) then
            
            Add( inequalities, DefiningInequalities( i ) );
            
        elif IsBound( i!.input_inequalities ) then
            
            Add( inequalities, i!.input_inequalities );
            
            if IsBound( i!.input_equalities ) then
                
                Add( equalities, i!.input_equalities );
                
            fi;
            
        else
            
            Add( inequalities, DefiningInequalities( i ) );
            
        fi;
        
    od;
    
    if equalities <> [ ] then
        
        cone := ConeByEqualitiesAndInequalities( Concatenation( equalities ), Concatenation( inequalities ) );
        
    else
        
        cone := ConeByInequalities( Concatenation( inequalities ) );
        
    fi;
    
    SetContainingGrid( cone, grid );
    
    return cone;
    
end );

##
InstallMethod( Contains,
               " for homalg cones",
               [ IsCone, IsCone ],
               
  function( ambcone, cone )
    local ineq;
   
    if HasRayGenerators( ambcone ) and HasRayGenerators( cone ) then

      if IsSubset( Set( RayGenerators( ambcone ) ), Set( RayGenerators( cone )  ) ) then

        return true;

      fi;

    fi;

    if HasDefiningInequalities( ambcone ) and HasDefiningInequalities( cone ) then

      if IsSubset( Set( DefiningInequalities( cone ) ), Set( DefiningInequalities( ambcone )  ) ) then

        return true;

      fi;

    fi;

    ineq := NonReducedInequalities( ambcone );
    
    cone := RayGenerators( cone );
    
    ineq := List( cone, i -> ineq * i );
    
    ineq := Flat( ineq );
    
    return ForAll( ineq, i -> i >= 0 );
    
end );

##
InstallMethod( \*,
               "for a matrix and a cone",
               [ IsHomalgMatrix, IsCone ],
               
  function( matrix, cone )
    local ray_list, multiplied_rays, ring, new_cone;
    
    ring := HomalgRing( matrix );
    
    ray_list := RayGenerators( cone );
    
    ray_list := List( ray_list, i -> HomalgMatrix( i, ring ) );
    
    multiplied_rays := List( ray_list, i -> matrix * i );
    
    multiplied_rays := List( multiplied_rays, i -> EntriesOfHomalgMatrix( i ) );
    
    new_cone := Cone( multiplied_rays );
    
    SetContainingGrid( new_cone, ContainingGrid( cone ) );
    
    return new_cone;
    
end );



##
InstallMethod( \=,
               "for two cones",
               [ IsCone, IsCone ],
               
  function( cone1, cone2 )
    
    return Contains( cone1, cone2 ) and Contains( cone2, cone1 );
    
end );

BindGlobal( "RayGeneratorContainedInCone", \in );

##
InstallMethod( \in,
               "for cones",
               [ IsList, IsCone ],
               
  function( raygen, cone )
    local ineq;
    
    ineq := NonReducedInequalities( cone );
    
    ineq := List( ineq, i -> Sum( [ 1 .. Length( i ) ], j -> i[ j ]*raygen[ j ] ) );
    
    return ForAll( ineq, i -> i >= 0 );
    
end );

##
InstallMethod( \in,
               "for cones",
               [ IsList, IsCone and IsSimplicial ],
               
  function( raygen, cone )
    local ray_generators, matrix;
    
    ray_generators := RayGenerators( cone );
    
    ##FIXME: One can use homalg for this, but at the moment
    ##       we do not want the overhead.
    matrix := SolutionMat( ray_generators, raygen );
    
    return ForAll( matrix, i -> i >= 0 );
    
end );

##
InstallMethod( IsRelativeInteriorRay,
               "for cones",
               [ IsList, IsCone ],
               
  function( ray, cone )
    local ineq, mineq, equations;
    
    ineq := NonReducedInequalities( cone );
    
    mineq := -ineq;
    
    equations := Intersection( ineq, mineq );
    
    ineq := Difference( ineq, equations );
    
    ineq := List( ineq, i -> i * ray );
    
    equations := List( equations, i -> i * ray );
    
    return ForAll( ineq, i -> i > 0 ) and ForAll( equations, i -> i = 0 );
    
end );


#######################################
##
## Methods to construct external cones
##
#######################################

if CddAvailable then
InstallMethod( ExternalCddCone, 
               [ IsCone ], 
               
   function( cone )
   
   local list, new_list, number_of_equalities, linearity, i, u ;
   
   new_list:= [ ];
   if IsBound( cone!.input_rays ) and Length( cone!.input_rays )= 1 and IsZero( cone!.input_rays ) then
   
      new_list:= [ Concatenation( [ 1 ], cone!.input_rays[ 1 ] ) ];
      
      return Cdd_PolyhedronByGenerators( new_list );
      
   fi;
   
   if IsBound( cone!.input_rays ) then 
   
      list := cone!.input_rays;
      
      for i in [1..Length( list ) ] do 
          
          u:= ShallowCopy( list[ i ] );
          
          Add( u, 0, 1 );
          
          Add( new_list, u );
      
      od;
      
      return Cdd_PolyhedronByGenerators( new_list );
   
   fi;
   
   
   if IsBound( cone!.input_equalities ) then
   
      list := StructuralCopy( cone!.input_equalities );
      
      number_of_equalities:= Length( list );
      
      linearity := [1..number_of_equalities];
      
      Append( list, StructuralCopy( cone!.input_inequalities ) );
      
      for i in [1..Length( list ) ] do 
      
          u:= ShallowCopy( list[ i ] );
          
          Add( u, 0, 1 );
          
          Add( new_list, u );
      
      od;
      
      return Cdd_PolyhedronByInequalities( new_list, linearity );
   
   else 
   
      list:= StructuralCopy( cone!.input_inequalities );
      
      for i in [1..Length( list ) ] do 
          
          u:= ShallowCopy( list[ i ] );
          
          Add( u, 0, 1 );
          
          Add( new_list, u );
          
      od;
      
      return Cdd_PolyhedronByInequalities( new_list );
   
   fi;
   
end );
fi;
      
InstallMethod( ExternalNmzCone, 
              [ IsCone ],
  function( cone )
  local a, list, equalities, i;
  
  list:= [];
   
   if IsBound( cone!.input_rays ) then 
   
        list := StructuralCopy( cone!.input_rays );
        
        if ForAll( Concatenation( list ), IsInt ) then

            return ValueGlobal( "NmzCone" )( [ "integral_closure", list ] );
        
        else

            a := DuplicateFreeList( List( Concatenation( list ), l -> DenominatorRat( l ) ) );
            
            list := Lcm( a ) * list;

            return ValueGlobal( "NmzCone" )( [ "integral_closure", list ] );

        fi;

   fi;
   
   list:= StructuralCopy( cone!.input_inequalities );
   
   if IsBound( cone!.input_equalities ) then
      
      equalities:= StructuralCopy( cone!.input_equalities );
      
      for i in equalities do
      
          Append( list, [ i, -i ] );
          
      od;
      
   fi;
      
    if ForAll( Concatenation( list ), IsInt ) then

        return ValueGlobal( "NmzCone" )( ["inequalities", list ] );
        
    else

        a := DuplicateFreeList( List( Concatenation( list ), l -> DenominatorRat( l ) ) );
            
        list := Lcm( a ) * list;

        return ValueGlobal( "NmzCone" )( ["inequalities", list ] );

    fi;

    Error( "The cone should be defined by vertices or inequalities!" );
    
end );

#####################################
##
## Constructors
##
#####################################

##
InstallMethod( ConeByInequalities,
               "constructor for Cones by inequalities",
               [ IsList ],
               
  function( inequalities )
    local cone, newgens, i, vals;
    
     if Length( inequalities ) = 0 then
        
        Error( "someone must set a dimension\n" );
        
    fi;
    
    cone := rec( input_inequalities := inequalities );
    
    ObjectifyWithAttributes( 
        cone, TheTypeConvexCone
     );
    
    SetAmbientSpaceDimension( cone, Length( inequalities[ 1 ] ) );
    
    return cone;
    
end );

##
InstallMethod( ConeByEqualitiesAndInequalities,
               "constructor for cones by equalities and inequalities",
               [ IsList, IsList ],
               
  function( equalities, inequalities )
    local cone, newgens, i, vals;
    
    if Length( equalities ) = 0 and Length( inequalities ) = 0 then
        
        Error( "someone must set a dimension\n" );
        
    fi;
    
    cone := rec( input_inequalities := inequalities, input_equalities := equalities );
    
    ObjectifyWithAttributes( 
        cone, TheTypeConvexCone
     );
    
    if Length( equalities ) > 0 then
        
        SetAmbientSpaceDimension( cone, Length( equalities[ 1 ] ) );
        
    else
        
        SetAmbientSpaceDimension( cone, Length( inequalities[ 1 ] ) );
        
    fi;
    
    return cone;
    
end );
 
##
InstallMethod( ConeByGenerators,
               "constructor for cones by generators",
               [ IsList ],
               
   function( raylist )
    local cone, newgens, i, vals;
    
    if Length( raylist ) = 0 then
        
        # Think again about this
        return ConeByGenerators( [ [ ] ] );
        
    fi;

    newgens := [ ];
    
    for i in raylist do
        
        if IsList( i ) then
            
            Add( newgens, i );
            
        elif IsCone( i ) then
            
            Append( newgens, RayGenerators( i ) );
            
        else
            
            Error( " wrong rays" );
            
        fi;
        
    od;
    
    cone := rec( input_rays := newgens );
   
    ObjectifyWithAttributes( 
        cone, TheTypeConvexCone
     );
      
     if Length( raylist ) =1 and IsZero( raylist[ 1 ] ) then 
        
        SetIsZero( cone, true );
        
     fi;
     
    newgens := Set( newgens );
    
    SetAmbientSpaceDimension( cone, Length( newgens[ 1 ] ) );
    
    if Length( newgens ) = 1 and not Set( newgens[ 1 ] ) = [ 0 ] then
        
        SetIsRay( cone, true );
        
    else
        
        SetIsRay( cone, false );
        
    fi;
    
    return cone;
    
end );

##
InstallMethod( Cone,
              "construct cone from list of generating rays",
                  [ IsList ],
                  
      ConeByGenerators

    );
   
if CddAvailable then
InstallMethod( Cone, 
              "Construct cone from Cdd cone",
              [ IsCddPolyhedron ],
              
   function( cdd_cone )
   local inequalities, equalities, 
         new_inequalities, new_equalities, u, i;
   
   if cdd_cone!.rep_type = "H-rep" then 
       
           inequalities:= Cdd_Inequalities( cdd_cone );
           
           new_inequalities:= [ ];
           
           for i in inequalities do 
                
                 u:= ShallowCopy( i );
                
                 Remove( u , 1 );
                
                 Add(new_inequalities, u );
               
           od;
           
           if cdd_cone!.linearity <> [] then
               
                 equalities:= Cdd_Equalities( cdd_cone );
                 
                 new_equalities:= [ ];
                 
                 for i in equalities do 
                    
                     u:= ShallowCopy( i );
                     
                     Remove( u , 1 );
                     
                     Add(new_equalities, u );
                    
                 od;
                 
                 return ConeByEqualitiesAndInequalities( new_equalities, new_inequalities);
                 
           fi;
           
           return ConeByInequalities( new_inequalities );
           
    else 
    
           return ConeByGenerators( Cdd_GeneratingRays( cdd_cone ) );
           
    fi;
    
end );
   
fi;


################################
##
## Displays and Views
##
################################

##
InstallMethod( ViewObj,
               "for homalg cones",
               [ IsCone ],
               
  function( cone )
    local str;
    
    Print( "<A" );
    
    if HasIsSmooth( cone ) then
        
        if IsSmooth( cone ) then
            
            Print( " smooth" );
            
        fi;
        
    fi;
    
    if HasIsPointed( cone ) then
        
        if IsPointed( cone ) then
            
            Print( " pointed" );
            
        fi;
        
    fi;
    
    if HasIsSimplicial( cone ) then
        
        if IsSimplicial( cone ) then
            
            Print( " simplicial" );
            
        fi;
        
    fi;
    
    if HasIsRay( cone ) and IsRay( cone ) then
        
        Print( " ray" );
        
    else
        
        Print( " cone" );
        
    fi;
    
    Print( " in |R^" );
    
    Print( String( AmbientSpaceDimension( cone ) ) );
    
    if HasDimension( cone ) then
        
        Print( " of dimension ", String( Dimension( cone ) ) );
        
    fi;
    
    if HasRayGenerators( cone ) then
        
        Print( " with ", String( Length( RayGenerators( cone ) ) )," ray generators" );
        
    fi;
    
    Print( ">" );
    
end );

##
InstallMethod( Display,
               "for homalg cones",
               [ IsCone ],
               
  function( cone )
    local str;
    
    Print( "A" );
    
    if HasIsSmooth( cone ) then
        
        if IsSmooth( cone ) then
            
            Print( " smooth" );
            
        fi;
        
    fi;
    
    if HasIsPointed( cone ) then
        
        if IsPointed( cone ) then
            
            Print( " pointed" );
            
        fi;
        
    fi;
    
    if IsRay( cone ) then
        
        Print( " ray" );
        
    else
        
        Print( " cone" );
        
    fi;
    
    Print( " in |R^" );
    
    Print( String( AmbientSpaceDimension( cone ) ) );
    
    if HasDimension( cone ) then
        
        Print( " of dimension ", String( Dimension( cone ) ) );
        
    fi;
    
    if HasRayGenerators( cone ) then
        
        Print( " with ray generators ", String( RayGenerators( cone ) ) );
        
    fi;
    
    Print( ".\n" );
    
end );
