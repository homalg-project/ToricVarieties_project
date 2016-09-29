#############################################################################
##
##  makedoc.g           SheafCohomologyOnToricVarieties package
##                      Martin Bies
##
##  Copyright 2016      ITP Universität Heidelberg
##
##  A package to compute sheaf cohomology on toric varieties
##
#############################################################################

LoadPackage( "AutoDoc" );

AutoDoc( "ToricVarieties" : scaffold := true, autodoc :=
             rec( files := [ "doc/Intros.autodoc",
                         "gap/VanishingSets.gd",
                         "examples/examplesmanual/VanishingSets.g",
                         #"gap/DegreeXLayer.gd",
                         #"examples/examplesmanual/DegreeXLayerVectorSpaces.g",
                         #"gap/CohomologyOnPn.gd",
                         #"examples/examplesmanual/CohomologyOnPn.g",
                         #"gap/CohomologyFromBTransform.gd",
                         #"examples/examplesmanual/CohomologyFromBTransform.g",
                         #"gap/ICTCurves.gd",
                         #"examples/examplesmanual/ICTCurves.g",
                         #"gap/NefAndMoriCone.gd",
                         #"examples/examplesmanual/NefAndMori.g",
                         #"gap/CohomologyViaGSForGradedModules.gd",
                         #"examples/examplesmanual/CohomologyViaGSForGradedModules.g",
                         #"gap/CohomologyViaGSForCAP.gd",
                         #"examples/examplesmanual/CohomologyViaGSForCAP.g",
                         #"gap/CohomologyFromCohomCalg.gd",
                         #"gap/CohomologyFromResolution.gd",
                         #"examples/examplesmanual/MyCohom.g",
                         #"gap/MyCohom.gd",
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
