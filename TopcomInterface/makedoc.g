#############################################################################
##
##  makedoc.g           TopcomInterface package
##
##                      Martin Bies
##                      University of Pennsylvania
##
##  Copyright 2021
##
##  A package to communicate with the software Topcom
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
