##########################################################################################
##
##  MapsInResolution.gd                SheafCohomologyOnToricVarieties package
##
##  Copyright 2020                     Martin Bies,       University of Oxford
##
#! @Chapter Maps In Resolution
##
#########################################################################################


##############################################################################################
##
#! @Section Compute maps in minimal free resolution of a sheaf
##
##############################################################################################

#! @Description
#! The arguments are a toric variety $V$ and a f.p. graded module presentation $M$ over the Cox ring of this variety.
#! @Returns a list of vector space morphisms
#! @Arguments V, M
DeclareOperation( "MapsInResolution",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ] );

#! @Description
#! The arguments are a toric variety $V$ and a map of projective graded module presentation $m$ over the Cox ring of this variety.
#! @Returns the list of induced vector space morphisms between the sheaf cohomologies of the associated vector bundles
#! @Arguments V, m
DeclareOperation( "InducedCohomologyMaps",
                  [ IsToricVariety, IsCAPCategoryOfProjectiveGradedLeftModulesMorphism ] );
