################################################################################################
##
##  Central.gi                     SheafCohomologyOnToricVarieties package
##
##  Copyright 2020                 Martin Bies,       University of Oxford
##
#! @Chapter Central functions and constants
##
################################################################################################


######################################################
##
## Section Which CAS is being used? Magma or Singular?
##
######################################################

# global variable used to determine if Magma is to be used or not
SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_FIELD := HomalgFieldOfRationalsInSingular();
#SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_FIELD := HomalgFieldOfRationalsInMAGMA();



###################################################
##
## Section Input check for cohomology computations
##
###################################################

#  Global variable that defines testing of input
SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_INTERNAL_LAZY := true;

InstallMethod( IsValidInputForCohomologyComputations,
               " for a toric variety",
               [ IsToricVariety ],

  function( variety )
    local result;

    # initialise value
    result := true;
    
    # check that the variety matches our general requirements
    if SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_INTERNAL_LAZY then

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
