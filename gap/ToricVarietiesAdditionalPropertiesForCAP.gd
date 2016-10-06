####################################################################################
##
##  ToricVarietiesAdditionalProperties.gd    SheafCohomologyOnToricVarieties package
##
##  Copyright 2011- 2016, Martin Bies, ITP Heidelberg
##
## Additional methods/properties for toric varieties
##
#####################################################################################

######################
#! @Section Attributes
######################

#! @Description
#! Returns the irrelevant left ideal of the Cox ring of the variety <A>vari</A>, using the language of CAP.
#! @Returns a graded left ideal for CAP
#! @Arguments vari
DeclareAttribute( "IrrelevantLeftIdealForCAP",
                  IsToricVariety );

#! @Description
#! Returns the irrelevant right ideal of the Cox ring of the variety <A>vari</A>, using the language of CAP.
#! @Returns a graded right ideal for CAP
#! @Arguments vari
DeclareAttribute( "IrrelevantRightIdealForCAP",
                  IsToricVariety );

#! @Description
#! Returns the Stanley-Reißner left ideal of the Cox ring of the variety <A>vari</A>, using the langauge of CAP.
#! @Returns a graded left ideal for CAP
#! @Arguments vari
DeclareAttribute( "SRLeftIdealForCAP",
                 IsToricVariety );

#! @Description
#! Returns the Stanley-Reißner right ideal of the Cox ring of the variety <A>vari</A>, using the langauge of CAP.
#! @Returns a graded right ideal for CAP
#! @Arguments vari
DeclareAttribute( "SRRightIdealForCAP",
                 IsToricVariety );


########################
#! @Section Constructors
########################

#! @Description
#! Creates a toric variety from a number of GLSM charges
#! @Returns a variety
#! @Arguments a list of lists of integers
DeclareOperation( "ToricVarietyFromGLSMCharges",
                  [ IsList ] );