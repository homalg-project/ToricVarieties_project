#############################################################################
##
##  init.g              SheafCohomologyOnToricVarieties package
##                      Martin Bies
##
##  Copyright 2016      ITP Universität Heidelberg
##
##  A package to compute sheaf cohomology on toric varieties
##
#############################################################################

# the cohomology pieces
ReadPackage( "ToricVarieties", "gap/ToricVarietiesAdditionalProperties.gd" );
ReadPackage( "ToricVarieties", "gap/ICTCurves.gd" );
ReadPackage( "ToricVarieties", "gap/VanishingSets.gd" );
ReadPackage( "ToricVarieties", "gap/DegreeXLayer.gd" );
ReadPackage( "ToricVarieties", "gap/CohomologyOnPn.gd" );
ReadPackage( "ToricVarieties", "gap/CohomologyFromBTransform.gd" );
ReadPackage( "ToricVarieties", "gap/NefAndMoriCone.gd" );
ReadPackage( "ToricVarieties", "gap/CohomologyViaGSForGradedModules.gd" );
ReadPackage( "ToricVarieties", "gap/CohomologyViaGSForCAP.gd" );
ReadPackage( "ToricVarieties", "gap/CohomologyFromCohomCalg.gd" );
ReadPackage( "ToricVarieties", "gap/CohomologyFromResolution.gd" );
ReadPackage( "ToricVarieties", "gap/MyCohom.gd" );

ReadPackage( "ToricVarieties", "gap/Multitruncations.gd" );
