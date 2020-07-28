gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "AdditionsForToricVarieties", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "AdditionsForToricVarieties" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
