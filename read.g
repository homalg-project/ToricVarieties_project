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
ReadPackage( "ToricVarieties", "gap/ToricVarietiesAdditionalProperties.gi" );
ReadPackage( "ToricVarieties", "gap/ICTCurves.gi" );
ReadPackage( "ToricVarieties", "gap/VanishingSets.gi" );
ReadPackage( "ToricVarieties", "gap/DegreeXLayer.gi" );
ReadPackage( "ToricVarieties", "gap/CohomologyOnPn.gi" );
ReadPackage( "ToricVarieties", "gap/CohomologyFromBTransform.gi" );
ReadPackage( "ToricVarieties", "gap/NefAndMoriCone.gi" );
ReadPackage( "ToricVarieties", "gap/CohomologyViaGSForGradedModules.gi" );
ReadPackage( "ToricVarieties", "gap/CohomologyViaGSForCAP.gi" );
ReadPackage( "ToricVarieties", "gap/CohomologyFromCohomCalg.gi" );
ReadPackage( "ToricVarieties", "gap/CohomologyFromResolution.gi" );
ReadPackage( "ToricVarieties", "gap/MyCohom.gi" );

ReadPackage( "ToricVarieties", "gap/Multitruncations.gi" );
