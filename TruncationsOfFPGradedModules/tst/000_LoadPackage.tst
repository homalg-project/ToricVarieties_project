gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "TruncationsOfFPGradedModules", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "TruncationsOfFPGradedModules" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
