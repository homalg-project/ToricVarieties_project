#############################################################################
##
##  PackageInfo.g       SpasmInterface package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to communicate with the software Spasm
##
#############################################################################

LoadPackage( "AutoDoc" );

AutoDoc( "SpasmInterface" : scaffold := true, autodoc :=
             rec( files := [ "doc/Intros.autodoc",
                         "gap/Tools.gd",
                         "gap/Functions.gd",
                         "examples/Functions.g"
                         ],
             scan_dirs := []
             ),
         maketest := rec( folder := ".",
                          commands :=
                            [ "LoadPackage( \"IO_ForHomalg\" );",
                              "LoadPackage( \"SpasmInterface\" );",
                              "HOMALG_IO.show_banners := false;",
                              "HOMALG_IO.suppress_PID := true;",
                              "HOMALG_IO.use_common_stream := true;",
                             ]
                           )
);

QUIT;
