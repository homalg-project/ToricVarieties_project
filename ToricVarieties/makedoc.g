#############################################################################
##
##  makedoc.g     ToricVarieties package
##                        Sebastian Gutsche
##                        Martin Bies - University of Pennsylvania
##
##  Copyright 2011-2021
##
##  A package to handle toric varieties
##
#############################################################################
#
# This file is a script which compiles the package manual.
#
if fail = LoadPackage("AutoDoc", "2019.05.20") then
    Error("AutoDoc version 2019.05.20 or newer is required.");
fi;

AutoDoc(rec(
    scaffold := true,
    autodoc := rec(
        files := [ "doc/Doc.autodoc" ],
        scan_dirs := [ "gap", "examples/examplesmanual" ]
    ),
    extract_examples := rec( units := "Single" ),
));

QUIT;
