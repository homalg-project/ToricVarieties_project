#############################################################################
##
##  LITorDiv.gi     ToricVarieties
##
##                        Sebastian Gutsche
##                        Martin Bies - University of Pennsylvania
##
##  Copyright 2011-2021
##
##  A package to handle toric varieties
##
##  Logical implications for toric divisors
##
#############################################################################

#############################
##
## True methods
##
#############################

##
## <=
##

##
InstallTrueMethod( IsCartier, IsPrincipal );

##
InstallTrueMethod( IsBasepointFree, IsAmple );

##
InstallTrueMethod( IsNumericallyEffective, IsBasepointFree );

#############################
##
## Immediate Methods
##
#############################

##
InstallImmediateMethod( IsPrincipal,
                        IsToricDivisor and IsCartier,
                        0,
  function( divisor )
    local ambient_variety;
    
    ambient_variety := AmbientToricVariety( divisor );
    
    if HasIsAffine( ambient_variety ) then
        
        if IsAffine( ambient_variety ) then
            
            return true;
            
        fi;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsAmple,
                        IsToricDivisor and HasIsBasepointFree,
                        0,
                        
  function( divisor )
    
    if not IsBasepointFree( divisor ) then
        
        return false;
        
    fi;
    
    TryNextMethod();
    
end );

##
InstallImmediateMethod( IsBasepointFree,
                        IsToricDivisor and IsCartier,
                        0,
                        
  function( divisor )
    
    if not IsCartier( divisor ) then
        
        return false;
        
    fi;
    
    TryNextMethod();
    
end );

## A variety has an ample divisor if and only if it is projective
##
# InstallImmediateMethod( twitter,
#                         IsToricDivisor and IsAmple,
#                         0,
#   function( divisor )
#     
#     if not HasIsProjective( AmbientToricVariety( divisor ) ) then
#         
#         SetIsProjective( AmbientToricVariety( divisor ), true );
#         
#     fi;
#     
#     TryNextMethod();
#     
# end );

# ##
# InstallImmediateMethod( IsCartier,
#                         IsToricDivisor,
#                         0,
#   function( divisor )
#     
#     if HasIsSmooth( AmbientToricVariety( divisor ) ) and IsSmooth( AmbientToricVariety( divisor ) ) then
#         
#         return true;
#         
#     fi;
#     
#     TryNextMethod();
#     
# end );

