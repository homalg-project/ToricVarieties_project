# SPDX-License-Identifier: GPL-2.0-or-later
# NConvex: A Gap package to perform polyhedral computations
#
# This file runs package tests. It is also referenced in the package
# metadata in PackageInfo.g.
#
LoadPackage( "NConvex" );
dirs := DirectoriesPackageLibrary( "NConvex", "tst" );

# Until the issue https://github.com/homalg-project/NConvex/issues/5 has been solved
ex := [];
if IsBound( IsPackageLoaded ) and IsPackageLoaded( "majoranaalgebras" ) then
  ex := [ "nconvex02.tst" ];
fi;

TestDirectory( dirs, rec( exitGAP := true, testOptions:= rec(compareFunction:="uptowhitespace" ), exclude := ex ) );
FORCE_QUIT_GAP(1);
