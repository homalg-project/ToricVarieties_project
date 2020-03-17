################################################################################################
##
##  Central.gi                     AdditionsForToricVarieties package
##
##  Copyright 2020                 Martin Bies,       University of Oxford
##
#! @Chapter Central functions and constants
##
################################################################################################


###################################################
##
## Section Input check for cohomology computations
##
###################################################

# global variable used to determine if we allow for lazy checks or not
ADDITIONS_TORIC_VARIETIES_LAZY_INPUT := false;

InstallMethod( IsValidInputForAdditionsForToricVarieties,
               " for a toric variety",
               [ IsToricVariety ],
    
  function( variety )
    local result;
    
    # initialise value
    result := true;
    
    # check that the variety matches our general requirements
    if ADDITIONS_TORIC_VARIETIES_LAZY_INPUT then
    
      if not ( ( IsSmooth( variety ) and IsComplete( variety ) ) or 
               ( IsSimplicial( FanOfVariety( variety ) ) and IsProjective( variety ) ) ) then
    
        result := false;
    
      fi;
    
    else
    
      if not ( IsSmooth( variety ) and IsComplete( variety ) ) then
    
        result := false;
    
      fi;
    
    fi;
    
    # and return result
    return result;
    
end );
