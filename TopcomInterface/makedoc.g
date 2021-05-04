#############################################################################
##
##  PackageInfo.g       TopcomInterface package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to communicate with the software Topcom
##
#############################################################################

LoadPackage( "AutoDoc" );

AutoDoc( "TopcomInterface" : scaffold := true, autodoc :=
             rec( files := [ "doc/Intros.autodoc",
                         "gap/Tools.gd",
                         "gap/Functions.gd",
                         "examples/examples.g"
                         ],
             scan_dirs := []
             ),
         maketest := rec( folder := ".",
                          commands :=
                            [ "LoadPackage( \"IO_ForHomalg\" );",
                              "LoadPackage( \"TopcomInterface\" );",
                              "HOMALG_IO.show_banners := false;",
                              "HOMALG_IO.suppress_PID := true;",
                              "HOMALG_IO.use_common_stream := true;",
                             ]
                           )
);

QUIT;
