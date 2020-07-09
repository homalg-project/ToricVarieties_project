#############################################################################
##
##  PackageInfo.g       H0Approximator package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to estimate global sections of pullback line bundle on hypersurface curves in dP3 and H2
##
#############################################################################

LoadPackage( "AutoDoc" );

AutoDoc( "H0Approximator" : scaffold := true, autodoc :=
             rec( files := [ "doc/Intros.autodoc",
                         "gap/CommonTools.gd",
                         "gap/H0ApproxOndP3.gd",
                         "examples/H0ApproxOndP3.g",
                         "gap/H0ApproxFromMaxSplitsOndP3.gd",
                         "examples/H0ApproxFromMaxSplitsOndP3.g",
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
