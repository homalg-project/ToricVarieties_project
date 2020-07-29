gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "ToolsForFPGradedModules", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "ToolsForFPGradedModules" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
