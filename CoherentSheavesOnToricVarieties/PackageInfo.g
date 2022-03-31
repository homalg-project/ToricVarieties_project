#######################################################################################
##
##  PackageInfo.g       CoherentSheavesOnToricVarieties package
##                      Martin Bies
##
##  Copyright 2021      University of Pennsylvania
##
##  A package to model coherent toric sheaves as elements in a Serre quotient category.
##
#######################################################################################

SetPackageInfo( rec(

PackageName := "CoherentSheavesOnToricVarieties",

Subtitle := "A package to model coherent toric sheaves as elements in a Serre quotient category.",

Version := Maximum( [
   "2022.03.23",
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

SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/homalg-project/ToricVarieties_project",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := Concatenation( "https://homalg-project.github.io/ToricVarieties_project/", ~.PackageName ),
ArchiveFormats  := ".tar.gz",
ArchiveURL      := Concatenation( ~.SourceRepository.URL,
                                 "/releases/download/", ReplacedString( ~.Version, ".", "-"),
                                 "/", ~.PackageName, "-", ~.Version ),
README_URL      := Concatenation( ~.PackageWWWHome, "/README.md" ),
PackageInfoURL  := Concatenation( ~.PackageWWWHome, "/PackageInfo.g" ),

AbstractHTML := "CoherentSheavesOnToricVarieties models coherent toric sheaves as elements in a Serre quotient category",

PackageDoc := rec(
  BookName  := "CoherentSheavesOnToricVarieties",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "A package to model coherent toric sheaves as elements in a Serre quotient category.",
),


Dependencies := rec(
  GAP := ">=4.7",
  NeededOtherPackages := [ [ "AutoDoc", ">=2016.02.16" ],
                           [ "TruncationsOfFPGradedModules", ">=2020.01.16" ],
                           [ "GeneralizedMorphismsForCAP", ">=2019.01.16" ],
                           ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := []

),

AvailabilityTest := ReturnTrue,

Keywords := [ "coherent sheaves", "toric varieties" ],

AutoDoc := rec(
    TitlePage := rec(
        Copyright := """
This package may be distributed under the terms and conditions
of the GNU Public License Version 2 or (at your option) any later version.
"""
    ),
),

));
