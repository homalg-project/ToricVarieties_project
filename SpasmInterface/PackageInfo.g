#############################################################################
##
##  PackageInfo.g       SpasmInterface package
##                                Martin Bies
##
##  Copyright 2021      University of Pennsylvania
##
##  A package to communicate with the software Spasm
##
#############################################################################

SetPackageInfo( rec(

PackageName := "SpasmInterface",

Subtitle := "A package to communicate with the software Spasm",

Version := Maximum( [
   "2022.03.04",
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
PackageWWWHome := "https://github.com/homalg-project/ToricVarieties_project/tree/master/SpasmInterface/",
ArchiveFormats := ".tar.gz .zip",
ArchiveURL     := "https://github.com/homalg-project/ToricVarieties_project/releases/download/2022-03-04/SpasmInterface",
README_URL     := Concatenation( ~.PackageWWWHome, "README" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),

AbstractHTML := "SpasmInterface enables to communicate with software Spasm via gap",

PackageDoc := rec(
  BookName  := "SpasmInterface",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "A package to communicate with the software Spasm",
),


Dependencies := rec(
  GAP := ">=4.7",
  NeededOtherPackages := [ [ "AutoDoc", ">=2016.02.16" ],
                           [ "SparseMatrices", ">=2020.02.06" ]
                           ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := []

),

AvailabilityTest := ReturnTrue,

Keywords := [ "Sparse matrices", "Linear Algebra" ],

AutoDoc := rec(
    TitlePage := rec(
        Copyright := """
This package may be distributed under the terms and conditions
of the GNU Public License Version 2 or (at your option) any later version.
"""
    ),
),

));
