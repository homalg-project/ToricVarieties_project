################################################################################################
##
##  SRAndIRForCAP.gd           SheafCohomologyOnToricVarieties package
##
##  Copyright 2020             Martin Bies,       University of Oxford
##
#! @Chapter Stanley Reisner and irrelevant ideal as FPGradedModules
##
################################################################################################


####################################################################
##
#! @Section Irrelevant ideal via FpGradedModules
##
####################################################################

#! @Description
#! Returns the lift of generators of the irrelevant ideal of the variety <A>vari</A>.
#! @Returns a list
#! @Arguments vari
DeclareAttribute( "GeneratorsOfIrrelevantIdeal",
                  IsToricVariety );

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


####################################################################
##
#! @Section Stanley-Reisner ideal via FPGradedModules
##
####################################################################

#! @Description
#! Returns the lift of generators of the Stanley-Reisner-ideal of the variety <A>vari</A>.
#! @Returns a list
#! @Arguments vari
DeclareAttribute( "GeneratorsOfSRIdeal",
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



####################################################################
##
#! @Section FPGraded left and right modules over the Cox ring
##
####################################################################

#! @Description
#!  Given a toric variety <A>variety</A> one can consider the Cox ring $S$ of this variety, which is graded over the
#!  class group of <A>variety</A>. Subsequently one can consider the category of f.p. graded left $S$-modules.
#!  This attribute captures the corresponding CapCategory.
#! @Returns a CapCategory
#! @Arguments variety
DeclareAttribute( "FpGradedLeftModules",
                 IsToricVariety );

#! @Description
#!  Given a toric variety <A>variety</A> one can consider the Cox ring $S$ of this variety, which is graded over the
#!  class group of <A>variety</A>. Subsequently one can consider the category of f.p. graded right $S$-modules.
#!  This attribute captures the corresponding CapCategory.
#! @Returns a CapCategory
#! @Arguments variety
DeclareAttribute( "FpGradedRightModules",
                 IsToricVariety );
