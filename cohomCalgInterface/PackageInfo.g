#############################################################################
##
##  PackageInfo.g       cohomCalgInterface package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to communicate with the software Topcom
##
#############################################################################

SetPackageInfo( rec(

PackageName := "cohomCalgInterface",

Subtitle := "A package to communicate with the software cohomCalg",

Version :=  Maximum( [
  "2020.08.16" # Martins version
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
PackageWWWHome := "https://github.com/homalg-project/ToricVarieties_project/tree/master/cohomCalgInterface/",
ArchiveFormats := ".zip",
ArchiveURL     := "https://github.com/homalg-project/ToricVarieties_project/releases/download/2020-08-16/cohomCalgInterface.zip",
README_URL     := Concatenation( ~.PackageWWWHome, "README" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),

AbstractHTML := "cohomCalgInterface enables to communicate with software cohomCalg via gap",

PackageDoc := rec(
  BookName  := "cohomCalgInterface",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "A package to communicate with the software cohomCalg",
  Autoload  := false
),


Dependencies := rec(
  GAP := ">=4.7",
  NeededOtherPackages := [ [ "AutoDoc", ">=2016.02.16" ],
                           [ "ToricVarieties", ">=2016.05.03" ]
                           ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := []

),

AvailabilityTest := function()
  
    return true;
  end,



Autoload := false,


Keywords := [ "cohomCalg", "line bundle cohomology" ],

AutoDoc := rec(
    TitlePage := rec(
        Copyright := """
This package may be distributed under the terms and conditions
of the GNU Public License Version 2 or (at your option) any later version.
"""
    ),
),

));
