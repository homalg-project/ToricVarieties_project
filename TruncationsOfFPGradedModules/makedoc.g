#############################################################################
##
##  makedoc.g           TruncationsOfFPGradedModules package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to compute truncations of FPGradedModules
##
#############################################################################


LoadPackage( "AutoDoc" );

AutoDoc( "TruncationsOfFPGradedModules" : scaffold := true, autodoc :=
             rec( files := [ "doc/Intros.autodoc",
                         "gap/MonomsOfDegree.gd",
                         "examples/MonomsOfDegree.g",
                         "gap/DegreeXLayerVectorSpace.gd",
                         "examples/DegreeXLayerVectorSpace.g",
                         "gap/TruncationsOfGradedRowsAndColumns.gd",
                         "examples/TruncationsOfGradedRowsAndColumns.g",
                         "gap/TruncationsOfFPGradedModules.gd",
                         "examples/TruncationsOfFPGradedModules.g",
                         "gap/TruncationFunctors.gd",
                         "examples/TruncationFunctors.g",
                         ],
             scan_dirs := []
             ),
         maketest := rec( folder := ".",
                          commands :=
                            [ "LoadPackage( \"IO_ForHomalg\" );",
                              "LoadPackage( \"TruncationsOfFPGradedModules\" );",
                              "HOMALG_IO.show_banners := false;",
                              "HOMALG_IO.suppress_PID := true;",
                              "HOMALG_IO.use_common_stream := true;",
                             ]
                           )
);

QUIT;
