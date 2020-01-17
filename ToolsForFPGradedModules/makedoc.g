#############################################################################
##
##  makedoc.g           ToolsForFPGradedModules package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to provide additional structures for toric varieties
##
#############################################################################


LoadPackage( "AutoDoc" );

AutoDoc( "ToolsForFPGradedModules" : scaffold := true, autodoc :=
             rec( files := [ "doc/Intros.autodoc",
                         "gap/ToolsForFPGradedModules.gd",
                         "examples/ToolsForFPGradedModules.g",
                         "gap/TruncationOfGradedExt.gd",
                         "examples/TruncationOfGradedExt.g",
                         ],
             scan_dirs := []
             ),
         maketest := rec( folder := ".",
                          commands :=
                            [ "LoadPackage( \"IO_ForHomalg\" );",
                              "LoadPackage( \"ToolsForFPGradedModules\" );",
                              "HOMALG_IO.show_banners := false;",
                              "HOMALG_IO.suppress_PID := true;",
                              "HOMALG_IO.use_common_stream := true;",
                             ]
                           )
);

QUIT;
