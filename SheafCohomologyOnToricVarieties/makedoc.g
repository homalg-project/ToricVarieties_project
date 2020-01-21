#############################################################################
##
##  makedoc.g           SheafCohomologyOnToricVarieties package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to compute sheaf cohomology on toric varieties
##
#############################################################################

LoadPackage( "AutoDoc" );

AutoDoc( "SheafCohomologyOnToricVarieties" : scaffold := true, autodoc :=
             rec( files := [ "doc/Intros.autodoc",
                         "gap/Input.gd",
                         "gap/CohomologyFromResolution.gd",
                         "examples/CohomologyFromResolution.g",
                         "gap/CohomologyFromMyTheorem.gd",
                         "examples/CohomologyFromMyTheorem.g",
                         "gap/CohomologyTools.gd",
                         "examples/CohomologyTools.g",
                         #"gap/MapsInResolution.gd",
                         #"examples/MapsInResolution.g",
                         #"gap/CohomologyOnPn.gd",
                         #"examples/CohomologyOnPn.g",
                         "gap/CohomologyWithSpasm.gd",
                         "examples/CohomologyWithSpasm.g",
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
