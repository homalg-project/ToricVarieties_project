#############################################################################
##
##  read.g              SheafCohomologyOnToricVarieties package
##                      Martin Bies
##
##  Copyright 2016      ITP Universität Heidelberg
##
##  A package to compute sheaf cohomology on toric varieties
##
#############################################################################

# the cohomology pieces
ReadPackage( "SheafCohomologyOnToricVarieties", "gap/ToricVarietiesAdditionalProperties.gi" );
ReadPackage( "SheafCohomologyOnToricVarieties", "gap/ICTCurves.gi" );
ReadPackage( "SheafCohomologyOnToricVarieties", "gap/VanishingSets.gi" );
ReadPackage( "SheafCohomologyOnToricVarieties", "gap/DegreeXLayer.gi" );
ReadPackage( "SheafCohomologyOnToricVarieties", "gap/CohomologyOnPn.gi" );
ReadPackage( "SheafCohomologyOnToricVarieties", "gap/CohomologyFromBTransform.gi" );
ReadPackage( "SheafCohomologyOnToricVarieties", "gap/NefAndMoriCone.gi" );
ReadPackage( "SheafCohomologyOnToricVarieties", "gap/CohomologyFromMyTheorem.gi" );
ReadPackage( "SheafCohomologyOnToricVarieties", "gap/CohomologyFromCohomCalg.gi" );
#ReadPackage( "SheafCohomologyOnToricVarieties", "gap/CohomologyFromResolution.gi" );

