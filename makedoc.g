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
                         #"gap/VanishingSets.gd",
                         #"examples/VanishingSets.g",
                         ],
             scan_dirs := []
             ),
         maketest := rec( folder := ".",
                          commands :=
                            [ #"LoadPackage( \"SheafCohomologyOnToricVarieties\" );",
                              "HOMALG_IO.show_banners := false;",
                              "HOMALG_IO.suppress_PID := true;",
                              "HOMALG_IO.use_common_stream := true;",
                             ]
                           )
);

QUIT;
