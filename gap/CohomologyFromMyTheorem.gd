##########################################################################################
##
##  CohomologyViaGSForCAP.gd         ToricVarieties package
##
##  Copyright 2015- 2016, Sebastian Gutsche, TU Kaiserslautern
##                        Martin Bies,       ITP Heidelberg
##
#! @Chapter Sheaf cohomology via the theorem of Greg. Smith for CAP
##
#########################################################################################



#############################################################
##
#! @Section Specialised InternalHom methods
##
#############################################################

#!
DeclareOperation( "InternalHomDegreeZeroOnObjects",
                [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsGradedLeftOrRightModulePresentationForCAP, IsBool ] );

#!
DeclareOperation( "InternalHomDegreeZeroOnObjectsWrittenToFiles",
                [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsGradedLeftOrRightModulePresentationForCAP ] );

#!
DeclareOperation( "InternalHomDegreeZeroOnMorphisms",
                [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsBool ] );

#!
DeclareOperation( "GradedExtDegreeZeroOnObjects",
                [ IsInt, IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsGradedLeftOrRightModulePresentationForCAP, IsBool ] );


#############################################################
##
#! @Section Computation of H0 by my theorem
##
#############################################################

#! @Description
#! Computation of sheaf cohomology from my own theorem
#! @Returns a list consisting of an integer and a vector space
#! @Arguments vari, M
DeclareOperation( "H0",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool, IsBool, IsBool ] );

DeclareOperation( "H0",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool, IsBool ] );

DeclareOperation( "H0",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool ] );

DeclareOperation( "H0",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ] );



#############################################################
##
#! @Section Computation of Hi by my theorem
##
#############################################################

#! @Description
#! Computation of sheaf cohomology from my own theorem
#! @Returns a list consisting of an integer and a vector space
#! @Arguments vari, M, i
DeclareOperation( "Hi",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsBool, IsBool, IsBool ] );

DeclareOperation( "Hi",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsBool, IsBool ] );

DeclareOperation( "Hi",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsBool ] );

DeclareOperation( "Hi",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt ] );



###################################################################################
##
#! @Section Computation of all sheaf cohomologies from my own theorem
##
###################################################################################

#! @Description
#! Computation of all sheaf cohomology classes from my theorem
#! @Returns a list of lists, which in turn consist each of an integer and a vector space
#! @Arguments vari, M
DeclareOperation( "AllHi",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool, IsBool, IsBool ] );

DeclareOperation( "AllHi",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool, IsBool ] );

DeclareOperation( "AllHi",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool ] );

DeclareOperation( "AllHi",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ] );



#######################################################################
##
#! @Section Write matrices to be used for H0 computation via GS to files
##
#######################################################################

#!
DeclareOperation( "H0ByGSWritingMatricesUsedByFastInternalHomToFilesForCAP",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool ] );

DeclareOperation( "H0ByGSWritingMatricesUsedByFastInternalHomToFilesForCAP",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ] );
