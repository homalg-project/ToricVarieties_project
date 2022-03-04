#############################################################################
##
##  PackageInfo.g        TopcomInterface package
##                                Martin Bies
##
##  Copyright 2021      University of Pennsylvania
##
##  A package to communicate with the software Topcom
##
#############################################################################

SetPackageInfo( rec(

PackageName := "TopcomInterface",

Subtitle := "A package to communicate with the software Topcom",

Version :=  Maximum( [
  "2021.08.12", # Martins version  
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
ArchiveURL     := "https://github.com/homalg-project/ToricVarieties_project/releases/download/2022-03-04/TopcomInterface",
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
),


Dependencies := rec(
  GAP := ">=4.7",
  NeededOtherPackages := [ [ "AutoDoc", ">=2016.02.16" ],
                           ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := []

),

AvailabilityTest := function()
    local topcom_binaries, dir, file, bool;
    
    # the binaries that should be available
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
    
    # by default, check if we have locally installed topcom
    # if we cannot find it, look for a global installation
    
    dir := DirectoriesPackageLibrary( "TopcomInterface",  ""  )[ 1 ];
    dir := Directory( Concatenation( Filename( dir, "" ), "topcom/src" ) );    
    file := Filename( dir, "points2chiro" );
    if not IsExistingFile( file ) then
        LogPackageLoadingMessage( PACKAGE_WARNING, [ "Need to look for global installation" ] );
        dir := DirectoriesSystemPrograms();
    fi;

    # check if all binaries are available
    bool := ForAll( topcom_binaries, name -> ( not Filename(dir, name ) = fail ) );
    
    # inform about the result
    if not bool then
        LogPackageLoadingMessage( PACKAGE_WARNING,
                [ "At least one of the topcom binaries",
                  JoinStringsWithSeparator( topcom_binaries, ", " ),
                  "is not installed on your system.",
                  "topcom can be downloaded from http://www.rambau.wm.uni-bayreuth.de/TOPCOM/" ] );
    fi;
    
    # and return availability
    return bool;
    
end,

Keywords := [ "Topcom", "Triangulations" ]

));
