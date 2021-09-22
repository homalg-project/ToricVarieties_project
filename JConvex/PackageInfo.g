#############################################################################
##
##  PackageInfo.g       JConvex package
##                      Martin Bies
##
##  Copyright 2021      University of Pennsylvania
##
##  A Gap package for convex geometry via Polymake in Julia
##
#############################################################################

SetPackageInfo( rec(

PackageName := "JConvex",

Subtitle := "A Gap package for convex geometry via Polymake in Julia",

Version := Maximum( [
   "2021.09.21",
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
                 "Department of Mathematics\n",
                 "University of Pennsylvania\n",
                 "David Rittenhouse Laboratory\n",
                 "209 S 33rd St\n",
                 "Philadelphia\n",
                 "PA 19104\n",
                 "United States of America" ),
    Place         := "Pennsylvania",
    Institution   := "University of Pennsylvania"
  ),
],

Status := "dev",
PackageWWWHome := "https://github.com/homalg-project/ToricVarieties_project/tree/master/JConvex/",
ArchiveFormats := ".zip",
ArchiveURL     := "https://github.com/homalg-project/ToricVarieties_project/releases/download/2021-09-05/JConvex",
README_URL     := Concatenation( ~.PackageWWWHome, "README" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),

AbstractHTML := "JConvex provides functionality to perform convex geometry with Polymake in Julia.",

PackageDoc := rec(
  BookName  := "JConvex",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "A Gap package for convex geometry via Polymake in Julia",
),


Dependencies := rec(
  GAP := ">=4.9",
  NeededOtherPackages := [ [ "AutoDoc", ">= 2019.05.20" ],
                           [ "NConvex", ">= 2020.11-04" ],
                           [ "JuliaInterface", ">= 0.5.2" ],
                         ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

AvailabilityTest := ReturnTrue,

Keywords := [ "Convex geometry", "Polymake", "Julia" ],

AutoDoc := rec(
    TitlePage := rec(
        Copyright := """
This package may be distributed under the terms and conditions
of the GNU Public License Version 2 or (at your option) any later version.
"""
    ),
),

));
