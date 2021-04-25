#############################################################################
##
##  PackageInfo.g       ToricVarieties package
##                      Martin Bies
##
##  Copyright 2021      University of Pennsylvania
##
##  A package to compute properties of toric varieties
##
#############################################################################

SetPackageInfo( rec(

PackageName := "ToricVarieties",

Subtitle := "A package to handle toric varieties",

Version :=  Maximum( [
  "2018.10.12", ## Sebas' version
## this line prevents merge conflicts
  "2020.04.25", ## Mohamed's version
## this line prevents merge conflicts
  "2021.04.25", ## Martin's version
## this line prevents merge conflicts
  "2019.12.05", ## Kamal's version
## this line prevents merge conflicts
  "2015.11.06", ## Homepage update version, to be removed
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
  URL := "https://homalg-project.github.io/ToricVarieties_project/ToricVarieties"
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome := "https://homalg-project.github.io/ToricVarieties_project/ToricVarieties/",
ArchiveFormats := ".zip",
ArchiveURL     := "https://github.com/homalg-project/ToricVarieties_project/releases/download/2021-04-24/ToricVarieties",
README_URL     := Concatenation( ~.PackageWWWHome, "README" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),

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
  Autoload  := false
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

AvailabilityTest := function()
  
    return true;
  end,


Autoload := false,


Keywords := [ "Toric geometry", "Toric varieties", "Divisors", "Geometry"],

AutoDoc := rec(
    TitlePage := rec(
        Copyright := """
This package may be distributed under the terms and conditions
of the GNU Public License Version 2 or (at your option) any later version.
"""
    ),
),

));
