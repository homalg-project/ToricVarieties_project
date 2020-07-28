#############################################################################
##
##  PackageInfo.g       AdditionsForToricVarieties package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to provide additional structures for toric varieties
##
#############################################################################

SetPackageInfo( rec(

PackageName := "AdditionsForToricVarieties",

Subtitle := "A package to provide additional structures for toric varieties",

Version :=  Maximum( [
  "2020.07.28", ## Martins version
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
],

Status := "dev",
PackageWWWHome := "https://github.com/homalg-project/ToricVarieties_project",
ArchiveFormats := ".tar.gz .zip",
ArchiveURL     := Concatenation( ~.PackageWWWHome, "AdditionsForToricVarieties-", ~.Version ),
README_URL     := Concatenation( ~.PackageWWWHome, "README" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),

AbstractHTML := "AdditionsForToricVarieties provides additional structures for toric varieties required to compute sheaf cohomologies",

PackageDoc := rec(
  BookName  := "AdditionsForToricVarieties",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "A package to provide additional structures for toric varieties which are required to compute sheaf cohomologies",
  Autoload  := false
),


Dependencies := rec(
  GAP := ">=4.7",
  NeededOtherPackages := [ [ "AutoDoc", ">=2016.02.16" ],
                           [ "NormalizInterface", ">= 0.9.7" ],
                           [ "ToricVarieties", ">=2016.05.03" ],
                           [ "ToolsForFPGradedModules", ">=2020.01.16" ],
                           [ "cohomCalgInterface", ">= 2019.09.10" ]
                           ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := []

),

AvailabilityTest := function()
    return true;
  end,



Autoload := false,


Keywords := [ "Toric Varieties, Sheaf cohomology" ]

));
