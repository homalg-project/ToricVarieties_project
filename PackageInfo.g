#############################################################################
##
##  PackageInfo.g       TopcomInterface package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to communicate with the software Topcom
##
#############################################################################

SetPackageInfo( rec(

PackageName := "TopcomInterface",

Subtitle := "A package to communicate with the software Topcom",

Version :=  Maximum( [
  "2020.01.31", # Martins version  
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
PackageWWWHome := "https://github.com/HereAround/TopcomInterface",
ArchiveFormats := ".tar.gz .zip",
ArchiveURL     := Concatenation( ~.PackageWWWHome, "TopcomInterface-", ~.Version ),
README_URL     := Concatenation( ~.PackageWWWHome, "README" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),

AbstractHTML := "TopcomInterface enables to communicate with software Topcom via gap",

PackageDoc := rec(
  BookName  := "TopcomInterface",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "A package to communicate with the software Topcom",
  Autoload  := false
),


Dependencies := rec(
  GAP := ">=4.7",
  NeededOtherPackages := [ [ "AutoDoc", ">=2016.02.16" ],                           
                           ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := []

),

AvailabilityTest := function()
  
    return true;
  end,



Autoload := false,


Keywords := [ "Topcom", "Triangulations" ]

));
