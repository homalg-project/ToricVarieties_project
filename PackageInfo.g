#############################################################################
##
##  PackageInfo.g       SheafCohomologyOnToricVarieties package
##                      Martin Bies
##
##  Copyright 2019      ULB Brussels
##
##  A package to compute sheaf cohomology on toric varieties
##
#############################################################################

SetPackageInfo( rec(

PackageName := "SheafCohomologyOnToricVarieties",

Subtitle := "A package to compute sheaf cohomology on toric varieties",

Version :=  Maximum( [
  "2017.04.02", ## Martins version
  "2019.01.11", ## Martins new version  
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
    WWWHome := "https://www.ulb.ac.be/sciences/ptm/pmif/people.html",
    PostalAddress := Concatenation(
                 "Physique Théorique et Mathématique \n",
                 "Université Libre de Bruxelles \n",
                 "Campus Plaine - CP 231 \n",
                 "Building NO - Level 6 - Office O.6.111 \n",
                 "1050 Brussels \n",
                 "Belgium" ), 
    Place         := "Brussels",
    Institution   := "ULB Brussels"
  ),
],

Status := "dev",
PackageWWWHome := "https://github.com/HereAround/SheafCohomologyOnToricVarieties",
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
                           [ "FreydCategoriesForCAP", ">= 2019.03.04" ],
                           [ "ComplexesAndFilteredObjectsForCAP", ">=2015.10.20" ],
                           [ "cohomCalgInterface", ">=2019.08.14" ],
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
