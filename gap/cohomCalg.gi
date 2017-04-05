InstallGlobalFunction( cohomCalgBinary,
  function( )
    local arch, linux, apple, dir, cohomcalg;
    
    arch := GAPInfo.ArchitectureBase;
    
    linux := "x86_64-pc-linux";
    apple := "x86_64-apple-darwin";
    
    if arch{[ 1 .. 15 ]} = linux then
        arch := linux;
    elif arch{[ 1 .. 19 ]} = apple then
        arch := apple;
    fi;
    
    arch := Concatenation( "cohomCalg/", arch );
    
    dir := DirectoriesPackageLibrary( "SheafCohomologyOnToricVarieties", arch )[ 1 ];
    
    cohomcalg := Filename( dir, "cohomcalg" );
    
    if not IsExistingFile( cohomcalg ) then
        Error( "no cohomcalg binary found in the subdirectory ", arch );
    fi;
    
    return [ dir, cohomcalg ];
    
end );
