#############################################################################
##
##  PackageInfo.g       SparseMatrices package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to handle sparse matrices in gap
##
#############################################################################

LoadPackage( "AutoDoc" );

AutoDoc( "SparseMatrices" : scaffold := true, autodoc :=
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
                              "LoadPackage( \"SparseMatrices\" );",
                              "HOMALG_IO.show_banners := false;",
                              "HOMALG_IO.suppress_PID := true;",
                              "HOMALG_IO.use_common_stream := true;",
                             ]
                           )
);

QUIT;
