#############################################################################
##
##  Tools.gi            SparseMatrices package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to handle sparse matrices in gap
##
#############################################################################



##############################################################################################
##
## Section Find the SmastoDirectory
##
##############################################################################################


InstallMethod( FindSmastoDirectory,
               "",
               [ ],
  function( )
  local smasto_directory, package_directory;
    
    # Initialse spasm_directory with fail and try in the following to do better
    smasto_directory := fail;
    
    # There might be a file in the PackageFolder in which the path to Spasm is noted down
    # So try to set up a stream to that file
    package_directory := DirectoriesPackageLibrary( "SparseMatrices", "gap" );
    if Length( package_directory ) > 1 then
        # If there are at least two versions, then we cannot find the SpasmDirectory uniquely
        Error( "Found at least two versions of SparseMatrices - unable to determine SmastoDirectory" );
        return;
    fi;
    package_directory := package_directory[ 1 ];
    smasto_directory := Directory( ReplacedString( Filename( package_directory, "" ), "gap/", "bin/" ) );
    
    # return the result
    return smasto_directory;
    
end );
