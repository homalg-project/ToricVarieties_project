#############################################################################
##
##  Tools.gd               cohomCalgInterface package
##                              Martin Bies
##
##  Copyright 2021    University of Pennsylvania
##
##  A package to communicate with the software cohomCalg
##
#! @Chapter Communication with cohomCalg
##
#############################################################################



##############################################################################################
##
#! @Section Finding the cohomCalg binary
##
##############################################################################################

#! @Description
#! This operation identifies the cohomCalg directory D and binary B
#! @Returns list [ D, B ]
#! @Arguments none
DeclareOperation( "cohomCalgBinary", [ ] );



##############################################################################################
##
#! @Section Turn toric variety and degree into a command string that we can pass to cohomCalg
##
##############################################################################################

#! @Description
#! Given a toric variety vari and an element d of the class group, this 
#! operation prepares the command string that is handed over to cohomCalg
#! @Returns string
#! @Arguments vari, d
DeclareOperation( "cohomCalgCommandString", 
                   [ IsToricVariety, IsList ] );

#! @Description
#! This is a convenience method. Given a toric variety vari, it calls
#! the previous method with the zero element of the class group.
#! @Returns string
#! @Arguments vari
DeclareOperation( "cohomCalgCommandString", 
                   [ IsToricVariety ] );


##############################################################################################
##
#! @Section New attribute for toric varieties to store their monomial file
##
##############################################################################################

#! @Description
#! The name of the monomial file use for line bundle cohomology computations on this space.
#! @Returns a string
#! @Arguments vari
DeclareAttribute( "MonomialFile",
                  IsToricVariety );

#! @Description
#! By setting this attribute, a special instance of cohomCalg can be used to iterate on
#! the given toric variety. In this case, the value has to be set to the list [ dir, file ]
#! where dir is the directory that contains the cohomCalg binary and file is the gap
#! filename datatype, which points to the actual binary.
#! @Returns list
#! @Arguments vari
DeclareAttribute( "SpecialCohomCalg",
                  IsToricVariety );
