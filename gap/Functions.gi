#############################################################################
##
##  Functions.gi        TopcomInterface package
##                      Martin Bies
##
##  Copyright 2019      ULB Brussels
##
##  A package to communicate with the software Topcom
##
#############################################################################


##############################################################################################
##
## Install functions to communicate with Topcom
##
##############################################################################################

# compute the maps in a minimal free resolution of a f.p. graded module presentation
InstallMethod( points2allfinetriangs,
               "a list of points, a reference triangulation and a list of options",
               [ IsList, IsList, IsList ],
  function( points, ref_triangulation, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "points2allfinetriangs", 
                             points, 
                             ref_triangulation, 
                             options_list );

    # finally evaluate the output
    result := EvalString( result );
    # fails if result = "" -> special catch needed

    # return the result
    return result;

end );
