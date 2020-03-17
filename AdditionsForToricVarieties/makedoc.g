#############################################################################
##
##  makedoc.g           AdditionsForToricVarieties package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to provide additional structures for toric varieties
##
#############################################################################

LoadPackage( "AutoDoc" );

AutoDoc( "AdditionsForToricVarieties" : scaffold := true, autodoc :=
             rec( files := [ "doc/Intros.autodoc",
                         "gap/Input.gd",
                         "gap/MonomsOfDegree.gd",
                         "examples/MonomsOfDegree.g",
                         "gap/ICTCurves.gd",
                         "examples/ICTCurves.g",
                         "gap/NefAndMoriCone.gd",
                         "examples/NefAndMori.g",
                         "gap/SemigroupAndConeWrapper.gd",
                         "examples/SemigroupAndConeWrapper.g",
                         "gap/VanishingSets.gd",
                         "examples/VanishingSets.g",
                         ],
             scan_dirs := []
             ),
         maketest := rec( folder := ".",
                          commands :=
                            [ "LoadPackage( \"IO_ForHomalg\" );",
                              "LoadPackage( \"AdditionsForToricVarieties\" );",
                              "HOMALG_IO.show_banners := false;",
                              "HOMALG_IO.suppress_PID := true;",
                              "HOMALG_IO.use_common_stream := true;",
                             ]
                           )
);

QUIT;
