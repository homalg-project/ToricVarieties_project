#############################################################################
##
##  PackageInfo.g       SheafCohomologyOnToricVarieties package
##                      Martin Bies
##
##  Copyright 2016      ITP Universität Heidelberg
##
##  A package to compute sheaf cohomology on toric varieties
##
#############################################################################

SetPackageInfo( rec(

PackageName := "SheafCohomologyOnToricVarieties",

Subtitle := "A package to compute sheaf cohomology on toric varieties",

Version :=  Maximum( [
  "2017.04.02", ## Martins version
] ),

Date := ~.Version{[ 1 .. 10 ]},
Date := Concatenation( ~.Date{[ 9, 10 ]}, "/", ~.Date{[ 6, 7 ]}, "/", ~.Date{[ 1 .. 4 ]} ),



Persons := [
rec(
    LastName      := "Bies",
    FirstNames    := "Martin",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "m.bies@thphys.uni-heidelberg.de",
    WWWHome       := "",
    PostalAddress := Concatenation( [
                       "Martin Bies\n",
                       "Philosophenweg 19\n",
                       "69120 Heidelberg\n",
                       "Germany" ] ),
    Place         := "Heidelberg",
    Institution   := "University of Heidelberg"
  ),
],

Status := "developement",
PackageWWWHome := "todo",
ArchiveFormats := ".tar.gz .zip",
ArchiveURL     := "todo",
README_URL     := "todo",
PackageInfoURL := "todo",

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
                           [ "TruncationsOfPresentationsByProjectiveGradedModules", ">= 2016.03.15" ],
                           [ "LinearAlgebraForCAP", ">= 2015.12.03 " ],
                           [ "NormalizInterface", ">= 0.9.7" ],
                           [ "ToricVarieties", ">=2016.05.03" ]
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
