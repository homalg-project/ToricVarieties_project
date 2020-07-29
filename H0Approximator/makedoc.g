#############################################################################
##
##  PackageInfo.g       H0Approximator package
##
##                      Martin Bies
##                      University of Oxford
##
##                      Muyang Liu
##                      University of Pennsylvania
##
##  Copyright 2020
##
##  A package to estimate global sections of pullback line bundle on hypersurface curves in dP3 and H2
##
#############################################################################


# This file is a script which compiles the package manual.

if fail = LoadPackage("AutoDoc", "2019.05.20") then
    Error("AutoDoc version 2019.05.20 or newer is required.");
fi;

AutoDoc(rec(
    scaffold := true,
    autodoc := rec(
        files := [ "doc/Doc.autodoc" ],
        scan_dirs := [ "gap", "examples" ]
    ),
    extract_examples := rec( units := "Single" ),
));

QUIT;
