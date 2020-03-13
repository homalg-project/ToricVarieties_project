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
                         "gap/OrdinaryTruncations/MonomsOfDegree.gd",
                         "examples/OrdinaryTruncations/MonomsOfDegree.g",
                         "gap/OrdinaryTruncations/DegreeXLayerVectorSpace.gd",
                         "examples/OrdinaryTruncations/DegreeXLayerVectorSpace.g",
                         "gap/OrdinaryTruncations/TruncationsOfGradedRowsAndColumns.gd",
                         "examples/OrdinaryTruncations/TruncationsOfGradedRowsAndColumns.g",
                         "gap/OrdinaryTruncations/TruncationsOfFPGradedModules.gd",
                         "examples/OrdinaryTruncations/TruncationsOfFPGradedModules.g",
                         "gap/OrdinaryTruncations/TruncationFunctors.gd",
                         "examples/OrdinaryTruncations/TruncationFunctors.g",
                         "gap/OrdinaryTruncations/TruncationOfGradedExt.gd",
                         "examples/OrdinaryTruncations/TruncationOfGradedExt.g",
                         
                         "gap/LocalizedTruncations/LocalizedDegree0Ring.gd",
                         "examples/LocalizedTruncations/LocalizedDegree0Ring.g",
                         "gap/LocalizedTruncations/LocalizedTruncationsOfGradedRowsAndColumns.gd",
                         "examples/LocalizedTruncations/LocalizedTruncationsOfGradedRowsAndColumns.g",
                         "gap/LocalizedTruncations/LocalizedTruncationsOfFPGradedModules.gd",
                         "examples/LocalizedTruncations/LocalizedTruncationsOfFPGradedModules.g",
                         "gap/LocalizedTruncations/LocalizedTruncationsFunctor.gd",
                         "examples/LocalizedTruncations/LocalizedTruncationsFunctor.g",
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
