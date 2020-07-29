gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "CoherentSheavesOnToricVarieties", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "CoherentSheavesOnToricVarieties" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
