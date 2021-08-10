# SPDX-License-Identifier: GPL-2.0-or-later
# NConvex: A Gap package to perform polyhedral computations
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#

# DEVELOPMENT VERSION TO ESTABLISH STABLE CONNECTION OF TORICVARIETIES_PROJECT TO JULIA!

SetPackageInfo( rec(

PackageName := "NConvex",
Subtitle := "A Gap package to perform polyhedral computations",
Version := "2021.08-10",
Date := ~.Version{[ 1 .. 10 ]},
Date := Concatenation( "01/", ~.Version{[ 6, 7 ]}, "/", ~.Version{[ 1 .. 4 ]} ),
License := "GPL-2.0-or-later",

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Kamal",
    LastName := "Saleh",
    WWWHome := "https://github.com/kamalsaleh",
    Email := "kamal.saleh@uni-siegen.de",
    PostalAddress := Concatenation(
               "Department Mathematik\n",
               "Universität Siegen\n",
               "Walter-Flex-Straße 3\n",
               "57068 Siegen\n",
               "Germany" ),
    Place := "Siegen",
    Institution := "University of Siegen",
  ),
  
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Sebastian",
    LastName := "Gutsche",
    WWWHome := "https://sebasguts.github.io/",
    Email := "gutsche@mathematik.uni-siegen.de",
    PostalAddress := Concatenation(
               "Department Mathematik\n",
               "Universität Siegen\n",
               "Walter-Flex-Straße 3\n",
               "57068 Siegen\n",
               "Germany" ),
    Place := "Siegen",
    Institution := "University of Siegen",
  )
],

# BEGIN URLS
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/homalg-project/NConvex",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://homalg-project.github.io/NConvex",
PackageInfoURL  := "https://homalg-project.github.io/NConvex/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/NConvex/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/NConvex/releases/download/v", ~.Version, "/NConvex-", ~.Version ),
# END URLS

ArchiveFormats := ".tar.gz .zip",

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "submitted"     for packages submitted for the refereeing
##    "deposited"     for packages for which the GAP developers agreed
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages
##    "other"         for all other packages
##
Status := "deposited",

AbstractHTML :=
  "The <span class='pkgname'>NConvex</span> package is a GAP package. \
  Its aim is to carry out polyhedral constructions and computations,\
  namely computing properties and attributes of cones, polyhedrons, polytopes and fans.",

PackageDoc := rec(
  BookName  := "NConvex",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "A Gap package to perform polyhedral computations",
),

Dependencies := rec(
  GAP := ">= 4.9",
  NeededOtherPackages := [ [ "AutoDoc", ">= 2018.02.14" ],
                           [ "Modules", ">= 0.5" ], 
                         ],
  SuggestedOtherPackages := [ [ "4ti2Interface", ">= 2018.07.06" ],
                              [ "TopcomInterface", ">=2019.06.15" ],
                              [ "CddInterface", ">= 2020.06.24" ],
                              [ "NormalizInterface", ">= 1.1.0"  ]
                              ],
  ExternalConditions := [ ],
),

AvailabilityTest := function()
  
  return true;

end,

TestFile := "tst/testall.g",

Keywords := [ "Cone", "Fan", "Polytope", "Polyhedron", "ToricVarieties", "homalg" ],

));
