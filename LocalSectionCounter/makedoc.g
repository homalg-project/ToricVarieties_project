#############################################################################
##
##  PackageInfo.g       LocalSectionCounter package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to estimate global sections of a line bundle on curves in dP3
##
#############################################################################

LoadPackage( "AutoDoc" );

AutoDoc( "LocalSectionCounter" : scaffold := true, autodoc :=
             rec( files := [ "doc/Intros.autodoc",
                         "gap/MaxSplits.gd",
                         "examples/MaxSplits.g"
                         ],
             scan_dirs := []
             ),
         maketest := rec( folder := ".",
                          commands :=
                            [ "LoadPackage( \"IO_ForHomalg\" );",
                              "LoadPackage( \"LocalSectionCounter\" );",
                              "HOMALG_IO.show_banners := false;",
                              "HOMALG_IO.suppress_PID := true;",
                              "HOMALG_IO.use_common_stream := true;",
                             ]
                           )
);

QUIT;
