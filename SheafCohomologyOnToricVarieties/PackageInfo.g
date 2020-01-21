#############################################################################
##
##  PackageInfo.g       SheafCohomologyOnToricVarieties package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to compute sheaf cohomology on toric varieties
##
#############################################################################

SetPackageInfo( rec(

PackageName := "SheafCohomologyOnToricVarieties",

Subtitle := "A package to compute sheaf cohomology on toric varieties",

Version :=  Maximum( [
  "2020.01.20", ## Martins version
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
PackageWWWHome := "https://github.com/homalg-project/SheafCohomologyOnToricVarieties",
ArchiveFormats := ".tar.gz .zip",
ArchiveURL     := Concatenation( ~.PackageWWWHome, "SheafCohomologyOnToricVarieties-", ~.Version ),
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
  Autoload  := false
),


Dependencies := rec(
  GAP := ">=4.7",
  NeededOtherPackages := [ [ "AutoDoc", ">=2016.02.16" ],
                           [ "ToricVarieties", ">=2016.05.03" ],
                           [ "AdditionsForToricVarieties", ">=2019.01.16" ],
                           [ "LinearAlgebraForCAP", ">= 2015.12.03 " ],
                           [ "cohomCalgInterface", ">=2019.08.14" ],
                           [ "NormalizInterface", ">= 0.9.7" ],
                           [ "SpasmInterface", ">2020.01.20" ]
                           ],
  SuggestedOtherPackages := [ [ "ToricIdeals", ">=2011.01.01" ] ],
  ExternalConditions := []

),

AvailabilityTest := function()
  
    return true;
  end,



Autoload := false,


Keywords := [ "Sheaf cohomology" ]

));
