#############################################################################
##
##  PackageInfo.g       TopcomInterface package
##                      Martin Bies
##
##  Copyright 2019      ULB Brussels
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
                              "LoadPackage( \"cohomCalgInterface\" );",
                              "HOMALG_IO.show_banners := false;",
                              "HOMALG_IO.suppress_PID := true;",
                              "HOMALG_IO.use_common_stream := true;",
                             ]
                           )
);

QUIT;
