#############################################################################
##
##  ProjectiveToricVariety.gi         ToricVarieties package
##
##                        Sebastian Gutsche
##                        Martin Bies - University of Pennsylvania
##
##  Copyright 2011-2021
##
##  A package to handle toric varieties
##
##  The Category of projective toric Varieties
##
#############################################################################

#################################
##
## Representations
##
#################################

DeclareRepresentation( "IsProjectiveSheafRep",
                       IsProjectiveToricVariety and IsSheafRep,
                       [ "Sheaf" ]
                      );

DeclareRepresentation( "IsProjectiveCombinatorialRep",
                       IsProjectiveToricVariety and IsCombinatorialRep,
                       [ ]
                      );

DeclareRepresentation( "IsPolytopeRep",
                       IsProjectiveCombinatorialRep and IsFanRep,
                       [ PolytopeOfVariety ]
                      );

##################################
##
## Family and Type
##
##################################

BindGlobal( "TheTypePolytopeToricVariety",
        NewType( TheFamilyOfToricVarietes,
                 IsPolytopeRep ) );

##################################
##
## Properties
##
##################################

##
InstallMethod( IsNormalVariety,
               "for polytope varieties.",
               [ IsToricVariety and HasPolytopeOfVariety ],
               
  function( variety )
    
    return IsNormalPolytope( PolytopeOfVariety( variety ) );
    
end );

##################################
##
## Attributes
##
##################################

##
InstallMethod( AffineCone,
               "for polytopal varieties",
               [ IsToricVariety and HasPolytopeOfVariety ],
               
  function( variety )
    
    return ToricVariety( AffineCone( PolytopeOfVariety( variety ) ) );
    
end );

##
InstallMethod( FanOfVariety,
               "for projective varieties",
               [ IsPolytopeRep ],
               
  function( variety )
    
    return NormalFan( PolytopeOfVariety( variety ) );
    
end );

##
InstallMethod( PolytopeOfVariety,
               "for products",
               [ IsToricVariety ],
               
  function( variety )
    local factors, polytopes_of_factors;
    
    factors := IsProductOf( variety );
    
    if Length( factors ) > 1 then
        
        polytopes_of_factors := List( factors, PolytopeOfVariety );
        
        return Product( polytopes_of_factors );
        
    fi;
    
    TryNextMethod();
    
end );

##
InstallMethod( ProjectiveEmbedding,
               "for projective varieties",
               [ IsToricVariety and HasPolytopeOfVariety ],
               
  function( variety )
    local gridpoints;
    
    gridpoints := LatticePoints( PolytopeOfVariety( variety ) );
    
    return List( gridpoints, i -> CharacterToRationalFunction( i, variety ) );
    
end );

##
RedispatchOnCondition( ProjectiveEmbedding, true, [ IsToricVariety ], [ PolytopeOfVariety ], 0 );

## check if a toric variety is P^N
InstallMethod( IsIsomorphicToProjectiveSpace,
               " for a toric variety ",
               [ IsToricVariety ],
  function( variety )
  local rank, S, degrees, B1, B2;
  
  if not IsSmooth( variety ) or not IsProjective( variety ) then
      
    return false;
      
  fi;
  
  # obtain rank of the class group
  rank := Rank( ClassGroup( variety ) );
  
  # initialise CoxRing and extract the weights of its indeterminantes
  S := CoxRing( variety );
  
  degrees := WeightsOfIndeterminates( S );

  
  # extract irrelevant ideal and its generators
  B1 := IrrelevantIdeal( variety );
  B2 := GradedLeftSubmodule( IndeterminatesOfPolynomialRing( S ) );
  
  # now check if this variety is CPN 
  if not rank = 1 then
  
    return false;
  
  elif not degrees = List( [ 1..Length( degrees ) ] , x -> 1 ) then
  
    return false;
     
  elif not B1 = B2 then
  
    return false;
  
  fi;

  # all tests passed, so this is a P^N -> return true
  return true;
  
end );

## check if toric variety is direct product of PNs
InstallMethod( IsDirectProductOfPNs,
                " for toric varieties.",
                [ IsToricVariety ],
  function( variety )
    local constituents, i;

    # we first need to check that the toric variety is really a product of Pn's, so
    constituents := IsProductOf( variety );
    
    # now check if they are all Pn's
    for i in constituents do
    
      # check if it is projective and otherwise cause an error and exit with false
      if not IsIsomorphicToProjectiveSpace( i ) then
      
        return false;

      fi;
    
    od;
        
    # all tests passed
    return true;
  
end );

##################################
##
## Methods
##
##################################

##
InstallMethod( Polytope,
               "for toric varieties",
               [ IsToricVariety and IsProjective ],
               
  function( variety )
    
    return PolytopeOfVariety( variety );
    
end );

# Suppose that 'variety' is a toric variety constructed from a polytope. Then one can compute the divisor associated
# to this polytope. This divisor happens to be ample by general theory.
InstallMethod( AmpleDivisor,
               " for a polytope",
               [ IsToricVariety and HasPolytopeOfVariety ],
  function( variety )
    local polytope, facetineqs, divisor_coefficients, facetnormals, i, buffer, raygenerators, primedivisors, 
         primedivisorsOfFacets, pos, divisor;

    # strategy:
    # D = \sum a_F D_F where F is known to be ample by theory, where F runs over all facets of the polytope P
    # To compute this divisor, we look at facetinequalities - which is a list of lists
    # Every 'sublist' is of the form [ a_F, facet_normal ] - so the first entry immediately gives us the coefficients
    # needed for computing D. We compare the facet_normals to the ray generators of X_{polytope}. When a ray \rho 
    # matches such a facet normal we have D_F = D_{\rho}. This gives us all the information needed to construct D.

    # obtain the polytope
    polytope := PolytopeOfVariety( variety );
    
    # a_F
    facetineqs := FacetInequalities( polytope );
    divisor_coefficients := List( [ 1..Length( facetineqs ) ], x -> facetineqs[ x ][ 1 ] );
  
    # facet_normals
    facetnormals := [];
    for i in [ 1.. Length( facetineqs ) ] do
    
      buffer := ShallowCopy( facetineqs[ i ] );
      Remove( buffer, 1 );
      Add( facetnormals, buffer );
      
    od;
  
    # torus invariant prime divisors associated to the facet normals of the polytope
    raygenerators := RayGenerators( FanOfVariety( variety ) );
    primedivisors := TorusInvariantPrimeDivisors( variety );    
    primedivisorsOfFacets := [];
    for i in [ 1.. Length( facetnormals ) ] do

      pos := Position( raygenerators, facetnormals[ i ] );
      Add( primedivisorsOfFacets, primedivisors[ pos ] );
    
    od;
    
    # construct the divisor
    divisor := Sum( List( [ 1.. Length( divisor_coefficients ) ], x -> divisor_coefficients[ x ] * primedivisorsOfFacets[ x ] ) );
        
    # and return it
    return divisor;

end );


##################################
##
## Constructors
##
##################################

##
InstallMethod( ToricVariety,
               "for homalg polytopes",
               [ IsPolytope ],
               
  function( polytope )
    local variety;
    
    variety := rec( WeilDivisors := WeakPointerObj( [ ] ) );
    
    ObjectifyWithAttributes(
                            variety, TheTypePolytopeToricVariety,
                            IsProjective, true,
                            IsAffine, false,
                            IsComplete, true,
                            PolytopeOfVariety, polytope
                            );
    
    return variety;
    
end );
