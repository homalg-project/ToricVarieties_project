################################################################################################
##
##  Central.gd                     SheafCohomologyOnToricVarieties package
##
##  Copyright 2020                 Martin Bies,       University of Oxford
##
#! @Chapter Central functions and constants
##
################################################################################################


###################################################
##
#! @Section Input check for cohomology computations
##
###################################################

#! @Description
#! Returns if the given variety V is a valid input for cohomology computations.
#! If the variable SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_INTERNAL_LAZY is set to false (default),
#! then we just check if the variety is smooth, complete. In case of success we return true and
#! false otherwise. If however SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_INTERNAL_LAZY is set to true,
#! then we will check if the variety is smooth, complete or simplicial, projective. In case of
#! success we return true and false other.
#! @Arguments V
DeclareProperty( "IsValidInputForCohomologyComputations",
                  IsToricVariety );
