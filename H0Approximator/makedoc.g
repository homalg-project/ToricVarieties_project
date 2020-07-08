#############################################################################
##
##  PackageInfo.g       H0Approximator package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to estimate global sections of a pullback line bundle on hypersurface curves in dP3
##
#############################################################################

LoadPackage( "AutoDoc" );

AutoDoc( "H0Approximator" : scaffold := true, autodoc :=
             rec( files := [ "doc/Intros.autodoc",
                         "gap/CommonTools.gd",
                         "gap/H0Approx.gd",
                         "examples/H0Approx.g",
                         "gap/H0ApproxFromMaxSplits.gd",
                         "examples/H0ApproxFromMaxSplits.g",
                         "gap/H0ApproxOnH2.gd",
                         "examples/H0ApproxOnH2.g",
                         "gap/H0ApproxFromMaxSplitsOnH2.gd",
                         "examples/H0ApproxFromMaxSplitsOnH2.g"                        
                         ],
             scan_dirs := []
             ),
         maketest := rec( folder := ".",
                          commands :=
                            [ "LoadPackage( \"IO_ForHomalg\" );",
                              "LoadPackage( \"H0Approximator\" );",
                              "HOMALG_IO.show_banners := false;",
                              "HOMALG_IO.suppress_PID := true;",
                              "HOMALG_IO.use_common_stream := true;",
                             ]
                           )
);

QUIT;
