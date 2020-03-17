#######################################################################################
##
##  PackageInfo.g       CoherentSheavesOnToricVarieties package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to model coherent toric sheaves as elements in a Serre quotient category.
##
#######################################################################################

LoadPackage( "AutoDoc" );

AutoDoc( "CoherentSheavesOnToricVarieties" : scaffold := true, autodoc :=
             rec( files := [ "doc/Intros.autodoc",
                         "gap/CoherentSheaves.gd",
                         "examples/CoherentSheaves.g",
                         "gap/Sheaves.gd",
                         "examples/Sheaves.g",
                         #"gap/Subvarieties.gd",
                         #"examples/Subvarieties.g",
                         ],
             scan_dirs := []
             ),
         maketest := rec( folder := ".",
                          commands :=
                            [ "LoadPackage( \"IO_ForHomalg\" );",
                              "LoadPackage( \"SheafCohomologyOnToricVarieties\" );",
                              "LoadPackage( \"CoherentSheavesOnToricVarieties\" );",
                              "HOMALG_IO.show_banners := false;",
                              "HOMALG_IO.suppress_PID := true;",
                              "HOMALG_IO.use_common_stream := true;",
                             ]
                           )
);

QUIT;
