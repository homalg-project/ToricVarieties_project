#############################################################################
##
##  makedoc.g           SheafCohomologyOnToricVarieties package
##                      Martin Bies
##
##  Copyright 2019      ULB Brussels
##
##  A package to compute sheaf cohomology on toric varieties
##
#############################################################################

LoadPackage( "AutoDoc" );

AutoDoc( "SheafCohomologyOnToricVarieties" : scaffold := true, autodoc :=
             rec( files := [ "doc/Intros.autodoc",
                         "gap/ToolsForFPGradedModules.gd",
                         "examples/ToolsForFPGradedModules.g",
                         "gap/ToricVarietiesAdditionalPropertiesForCAP.gd",
                         "examples/ToricVarietiesAdditionalProperties.g",
                         "gap/CohomologyFromResolution.gd",
                         "examples/CohomologyFromResolution.g",
                         #"gap/MapsInResolution.gd",
                         #"examples/MapsInResolution.g",
                         "gap/SemigroupAndConeWrapper.gd",
                         "examples/SemigroupAndConeWrapper.g",
                         "gap/VanishingSets.gd",
                         "examples/VanishingSets.g",
                         #"gap/DegreeXLayer.gd",
                         #"examples/DegreeXLayerVectorSpaces.g",
                         #"gap/NefAndMoriCone.gd",
                         #"examples/NefAndMori.g",
                         #"gap/ICTCurves.gd",
                         #"examples/ICTCurves.g",
                         #"gap/CohomologyFromMyTheorem.gd",
                         #"examples/CohomologyFromMyTheorem.g",
                         #"gap/CohomologyTools.gd",
                         #"examples/CohomologyTools.g",
                         #"gap/CohomologyOnPn.gd",
                         #"examples/CohomologyOnPn.g",
                         ],
             scan_dirs := []
             ),
         maketest := rec( folder := ".",
                          commands :=
                            [ "LoadPackage( \"IO_ForHomalg\" );",
                              "LoadPackage( \"GaussForHomalg\" );",
                              "LoadPackage( \"ToricVarieties\" );",
                              "LoadPackage( \"SheafCohomologyOnToricVarieties\" );",
                              "HOMALG_IO.show_banners := false;",
                              "HOMALG_IO.suppress_PID := true;",
                              "HOMALG_IO.use_common_stream := true;",
                             ]
                           )
);

QUIT;
