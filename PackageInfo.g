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
    local topcom_binaries, bool;
    
    topcom_binaries := [ "points2chiro",
                         "chiro2dual",
                         "chiro2circuits",
                         "chiro2cocircuits",
                         "cocircuits2facets",
                         "points2facets",
                         "points2nflips",
                         "points2flips",
                         "chiro2placingtriang",
                         "points2placingtriang",
                         "chiro2finetriang",
                         "points2finetriang",
                         "chiro2triangs",
                         "points2triangs",
                         "chiro2ntriangs",
                         "points2ntriangs",
                         "chiro2finetriangs",
                         "points2finetriangs",
                         "chiro2nfinetriangs",
                         "points2nfinetriangs",
                         "chiro2alltriangs",
                         "points2alltriangs",
                         "chiro2nalltriangs",
                         "points2nalltriangs",
                         "chiro2allfinetriangs",
                         "points2allfinetriangs",
                         "chiro2nallfinetriangs",
                         "points2nallfinetriangs"
                        ];
    
    bool := ForAll( topcom_binaries, name -> ( not Filename(DirectoriesSystemPrograms(), name ) = fail ) );
    
    if not bool then
        LogPackageLoadingMessage( PACKAGE_WARNING,
                [ "At least one of the topcom binaries",
                  JoinStringsWithSeparator( topcom_binaries, ", " ),
                  "is not installed on your system.",
                  "topcom can be downloaded from http://www.rambau.wm.uni-bayreuth.de/TOPCOM/" ] );
    fi;
    
    return bool;
    
end,


Autoload := false,


Keywords := [ "Topcom", "Triangulations" ]

));
