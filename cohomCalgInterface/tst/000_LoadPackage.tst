gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "IO_ForHomalg", false );
true
gap> LoadPackage( "cohomCalgInterface", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "IO_ForHomalg", false );
true
gap> LoadPackage( "cohomCalgInterface" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
gap> HOMALG_IO.show_banners := false;;
gap> HOMALG_IO.suppress_PID := true;;
gap> HOMALG_IO.use_common_stream := true;;
