################################################################################################
##
##  Central.gd                     AdditionsForToricVarieties package
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
#! Returns if the given variety V is a valid input for the additional operations.
#! This is the case if it is smooth and complete. If the boolean
#! ADDITIONS_TORIC_VARIETIES_LAZY_INPUT is set to true, then this will
#! also be satisfied if the variety is simplicial and projective.
#! @Arguments V
DeclareProperty( "IsValidInputForAdditionsForToricVarieties",
                  IsToricVariety );
