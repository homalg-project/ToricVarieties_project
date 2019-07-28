################################################################################################
##
##  ToricVarietiesAdditionalPropertiesForCAP.gd        SheafCohomologyOnToricVarieties package
##
##  Copyright 2019                                     Martin Bies,       ULB Brussels
##
#! @Chapter Additional methods and properties for toric varieties
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


####################################################################
##
#! @Section Stanley-Reisner and irrelevant ideal via FpGradedModules
##
####################################################################

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

#! @Description
#!  Given a toric variety <A>variety</A> one can consider the Cox ring $S$ of this variety, which is graded over the
#!  class group of <A>variety</A>. Subsequently one can consider the category of f.p. graded left $S$-modules. 
#!  This attribute captures the corresponding CapCategory.
#! @Returns a CapCategory
#! @Arguments variety
DeclareAttribute( "SfpgrmodLeft",
                 IsToricVariety );

#! @Description
#!  Given a toric variety <A>variety</A> one can consider the Cox ring $S$ of this variety, which is graded over the
#!  class group of <A>variety</A>. Subsequently one can consider the category of f.p. graded right $S$-modules. 
#!  This attribute captures the corresponding CapCategory.
#! @Returns a CapCategory
#! @Arguments variety
DeclareAttribute( "SfpgrmodRight",
                 IsToricVariety );


##########################################################
##
#! @Section Monoms of given degree in the Cox ring
##
##########################################################

#! @Description
#! Given a smooth and complete toric variety and a list of integers (= degree) corresponding to an element of 
#! the class group of the variety, this method return a list of integer valued lists. These lists correspond 
#! to the exponents of the monomials of degree in the Cox ring of this toric variety.
#! @Returns a list of lists of integers
#! @Arguments vari, degree
DeclareOperation( "Exponents",
               [ IsToricVariety, IsList ] );

#! @Description
#! Given a smooth and complete toric variety and a list of integers (= degree) corresponding to an element
#! of the class group of the variety, this method returns the list of all monomials in the Cox ring of the
#! given degree. This method uses NormalizInterface. 
#! @Returns a list
#! @Arguments vari, degree
DeclareOperation( "MonomsOfCoxRingOfDegreeByNormaliz",
               [ IsToricVariety, IsList ] );

#! @Description
#! Given a smooth and complete toric variety, a list of integers (= degree) corresponding to an element
#! of the class group of the variety and two non-negative integers i and l, this method returns a list
#! of column matrices. The columns are of length l and have at position i the monoms of the Coxring of degree 'degree'.
#! @Returns a list of matrices
#! @Arguments vari, degree, i, l
DeclareOperation( "MonomsOfCoxRingOfDegreeByNormalizAsColumnMatrices",
                 [ IsToricVariety, IsList, IsPosInt, IsPosInt ] );
