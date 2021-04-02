#############################################################################
##
##  PackageInfo.g       QSMExplorer package
##
##                      Martin Bies
##                      University of Pennsylvania
##
##                      Muyang Liu
##                      University of Pennsylvania
##
##  Copyright 2021
##
##  A package to explor one Quadrillion F-theory Standard Models
##
#############################################################################

SetPackageInfo( rec(

PackageName := "QSMExplorer",

Subtitle := "A package to explor one Quadrillion F-theory Standard Models",

Version :=  Maximum( [
  "2021.04.01", # Martins version  
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
rec(
    LastName := "Liu",
    FirstNames := "Muyang",
    IsAuthor := true,
    IsMaintainer := false,
    Email := "muyang@sas.upenn.edu",
    WWWHome := "https://github.com/lmyreg2017",
    PostalAddress := Concatenation(
                "Department of Physics and Astronomy \n",
                "University of Pennsylvania \n",
                "209 South 33rd Street \n",
                "Philadelphia, PA 19104-6396 \n",
                "United States" ),
    Place := "Philadelphia",
    Institution := "University of Pennsylvania"
    ),
],

Status := "dev",
PackageWWWHome := "https://homalg-project.github.io/ToricVarieties_project/QSMExplorer",
ArchiveFormats := ".zip",
ArchiveURL     := "https://github.com/homalg-project/ToricVarieties_project/releases/download/2021-04-01/QSMExplorer",
README_URL     := Concatenation( ~.PackageWWWHome, "README" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),

AbstractHTML := "QSMExplorer allows to investigate one Quadrillion F-theory Standard Models quickly and efficiently",

PackageDoc := rec(
  BookName  := "QSMExplorer",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "A package to explor one Quadrillion F-theory Standard Models",
  Autoload  := false
),


Dependencies := rec(
  GAP := ">=4.7",
  NeededOtherPackages := [ [ "AutoDoc", ">=2016.02.16" ],
                           [ "ToricVarieties", ">=2021.03.14" ],
                           ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := []

),

AvailabilityTest := function()
  
    return true;
  end,



Autoload := false,


Keywords := [ "Polytopes", "root bundles", "limit roots", "nodal curves" ],

AutoDoc := rec(
    TitlePage := rec(
        Copyright := """
This package may be distributed under the terms and conditions
of the GNU Public License Version 2 or (at your option) any later version.
"""
    ),
),

));
