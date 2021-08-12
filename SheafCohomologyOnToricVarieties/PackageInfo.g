#############################################################################
##
##  PackageInfo.g       SheafCohomologyOnToricVarieties package
##                      Martin Bies
##
##  Copyright 2021      University of Pennsylvania
##
##  A package to compute sheaf cohomology on toric varieties
##
#############################################################################

SetPackageInfo( rec(

PackageName := "SheafCohomologyOnToricVarieties",

Subtitle := "A package to compute sheaf cohomology on toric varieties",

Version := Maximum( [
   "2021.08.12",
] ),

Date := ~.Version{[ 1 .. 10 ]},
Date := Concatenation( ~.Date{[ 9, 10 ]}, "/", ~.Date{[ 6, 7 ]}, "/", ~.Date{[ 1 .. 4 ]} ),

License := "GPL-2.0-or-later",

Persons := [
rec(
    LastName      := "Bies",
    FirstNames    := "Martin",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email := "martin.bies@alumni.uni-heidelberg.de",
    WWWHome := "https://martinbies.github.io/",
    PostalAddress := Concatenation(
                 "Department of Mathematics \n",
                 "University of Pennsylvania \n",
                 "David Rittenhouse Laboratory \n",
                 "209 S 33rd St \n",
                 "Philadelphia \n",
                 "PA 19104" ),
    Place         := "Philadelphia",
    Institution   := "University of Pennsylvania"
  ),
],

Status := "dev",
PackageWWWHome := "https://github.com/homalg-project/ToricVarieties_project/tree/master/SheafCohomologyOnToricVarieties/",
ArchiveFormats := ".zip",
ArchiveURL     := "https://github.com/homalg-project/ToricVarieties_project/releases/download/2021-08-12/SheafCohomologyOnToricVarieties",
README_URL     := Concatenation( ~.PackageWWWHome, "README" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),

AbstractHTML := 
  Concatenation( "SheafCohomologyOnToricVarieties provides an extension of the ToricVarieties package",
                 "to compute sheaf cohomology" ),

PackageDoc := rec(
  BookName  := "SheafCohomologyOnToricVarieties",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "A package to compute sheaf cohomology on toric varieties",
),


Dependencies := rec(
  GAP := ">=4.7",
  NeededOtherPackages := [ [ "AutoDoc", ">=2016.02.16" ],
                           [ "TruncationsOfFPGradedModules", ">=2020.01.16" ],
                           [ "LinearAlgebraForCAP", ">= 2015.12.03 " ],
                           [ "SpasmInterface", ">2020.02.06" ],
                           ],
  SuggestedOtherPackages := [ [ "ToricIdeals", ">=2011.01.01" ] ],
  ExternalConditions := []

),

AvailabilityTest := ReturnTrue,

Keywords := [ "Sheaf cohomology" ],

AutoDoc := rec(
    TitlePage := rec(
        Copyright := """
This package may be distributed under the terms and conditions
of the GNU Public License Version 2 or (at your option) any later version.
"""
    ),
),

));
