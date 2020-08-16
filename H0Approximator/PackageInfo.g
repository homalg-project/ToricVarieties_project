#############################################################################
##
##  PackageInfo.g       H0Approximator package
##
##                      Martin Bies
##                      University of Oxford
##
##                      Muyang Liu
##                      University of Pennsylvania
##
##  Copyright 2020
##
##  A package to estimate global sections of a pullback line bundle on hypersurface curves in dP3 and H2
##
#############################################################################

SetPackageInfo( rec(

PackageName := "H0Approximator",

Subtitle := "A package to estimate global sections of a pullback line bundle on hypersurface curves in dP3 and H2",

Version :=  Maximum( [
  "2020.08.16", # Martins version  
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
                 "Mathematical Institute \n",
                 "University of Oxford \n",
                 "Andrew Wiles Building \n",
                 "Radcliffe Observatory Quarter \n",
                 "Woodstock Road \n",
                 "Oxford OX2 6GG \n",
                 "United Kingdom" ),
    Place         := "Oxford",
    Institution   := "University of Oxford"
    ),
rec(
    LastName := "Liu",
    FirstNames := "Muyang",
    IsAuthor := true,
    IsMaintainer := true,
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
PackageWWWHome := "https://github.com/homalg-project/ToricVarieties_project/tree/master/H0Approximator/",
ArchiveFormats := ".zip",
ArchiveURL     := "https://github.com/homalg-project/ToricVarieties_project/releases/download/2020-08-16/H0Approximator.zip",
README_URL     := Concatenation( ~.PackageWWWHome, "README" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),

AbstractHTML := "H0Approximator allows to estimate global sections of a line bundle on curves in dP3 and H2",

PackageDoc := rec(
  BookName  := "H0Approximator",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "A package to estimate global sections of a pullback line bundle on hypersurface curves in dP3 and H2",
  Autoload  := false
),


Dependencies := rec(
  GAP := ">=4.7",
  NeededOtherPackages := [ [ "AutoDoc", ">=2016.02.16" ],
                           [ "SheafCohomologyOnToricVarieties", ">=2020.02.06" ],
                           ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := []

),

AvailabilityTest := function()
  
    return true;
  end,



Autoload := false,


Keywords := [ "Coherent sheaves", "Line bundles", "delPezzo", "Hirzebruch", "sections" ],

AutoDoc := rec(
    TitlePage := rec(
        Copyright := """
This package may be distributed under the terms and conditions
of the GNU Public License Version 2 or (at your option) any later version.
"""
    ),
),

));
