#############################################################################
##
##  PackageInfo.g        ToricVarieties package
##                                Martin Bies
##
##  Copyright 2021      University of Pennsylvania
##
##  A package to compute properties of toric varieties
##
#############################################################################

SetPackageInfo( rec(

PackageName := "ToricVarieties",

Subtitle := "A package to handle toric varieties",

Version := Maximum( [
   "2022.07.13",
] ),

Date := ~.Version{[ 1 .. 10 ]},
Date := Concatenation( ~.Date{[ 9, 10 ]}, "/", ~.Date{[ 6, 7 ]}, "/", ~.Date{[ 1 .. 4 ]} ),

License := "GPL-2.0-or-later",

Persons := [
  rec(
    FirstNames := "Sebastian",
    LastName := "Gutsche",
    IsAuthor := true,
    IsMaintainer := true,
    WWWHome := "https://sebasguts.github.io",
    Email := "gutsche@mathematik.uni-siegen.de",
    PostalAddress := Concatenation(
               "Department Mathematik\n",
               "Universität Siegen\n",
               "Walter-Flex-Straße 3\n",
               "57072 Siegen\n",
               "Germany" ),
    Place := "Siegen",
    Institution := "University of Siegen",
  ),
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

Status := "deposited",

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

AbstractHTML := 
  Concatenation( "ToricVarieties provides data structures to handle toric varieties by their commutative algebra ",
                 "structure and by their combinatorics. For combinatorics, it uses the Convex package.",
                 " Its goal is to provide a suitable framework to work with toric varieties." ),


PackageDoc := rec(
  BookName  := "ToricVarieties",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "A package to compute properties of toric varieties",
),


Dependencies := rec(
  GAP := ">=4.7",
  NeededOtherPackages := [ [ "GradedRingForHomalg", ">=2020.04.25" ],
                           [ "Modules", ">=2016.01.20" ],
                           [ "GradedModules", ">=2015.12.04" ],
                           [ "ToolsForHomalg", ">=2016.02.17" ],
                           [ "AutoDoc", ">=2016.02.16" ],
                           [ "NConvex", ">=2020.11-04" ] ],
  SuggestedOtherPackages := [ [ "4ti2Interface", ">=2020.04.25" ],
                              [ "TopcomInterface", ">=2019.06.15" ], 
                              [ "Convex", ">= 2021.04.24" ] ],
  ExternalConditions := []
  
),

AvailabilityTest := ReturnTrue,

Keywords := [ "Toric geometry", "Toric varieties", "Divisors", "Geometry"],

TestFile := "tst/testall.g",

AutoDoc := rec(
    TitlePage := rec(
        Copyright := """
This package may be distributed under the terms and conditions
of the GNU Public License Version 2 or (at your option) any later version.
"""
    ),
),

));
