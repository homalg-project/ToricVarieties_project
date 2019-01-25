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


InstallMethod( points2chiro,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "points2chiro", 
                             input1,
                             input2,
                             options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( chiro2dual,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "chiro2dual", 
                             input1,
                             input2,
                             options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( chiro2circuits,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "chiro2circuits", 
                             input1,
                             input2,
                             options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( chiro2cocircuits,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "chiro2cocircuits", 
                             input1,
                             input2,
                             options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( cocircuits2facets,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "cocircuits2facets", 
                             input1,
                             input2,
                             options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( points2facets,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "points2facets", 
                             input1,
                             input2,
                             options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( points2nflips,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "points2nflips", 
                             input1,
                             input2,
                             options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( points2flips,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "points2flips", 
                             input1,
                             input2,
                             options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( chiro2placingtriang,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "chiro2placingtriang", 
                             input1,
                             input2,
                             options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( points2placingtriang,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "points2placingtriang", 
                             input1,
                             input2,
                             options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( chiro2finetriang,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "chiro2finetriang", 
                             input1,
                             input2,
                             options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( points2finetriang,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "points2finetriang", 
                             input1,
                             input2,
                             options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( chiro2triangs,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "chiro2triangs", 
                             input1,
                             input2,
                             options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( points2triangs,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "points2triangs", 
                             input1,
                             input2,
                             options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( chiro2ntriangs,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "chiro2ntriangs", 
                             input1,
                             input2,
                             options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( points2ntriangs,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "points2ntriangs", 
                             input1,
                             input2,
                             options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( chiro2finetriangs,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "chiro2finetriangs", 
                             input1,
                             input2,
                             options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( points2finetriangs,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "points2finetriangs", 
                             input1,
                             input2,
                             options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( chiro2nfinetriangs,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "chiro2nfinetriangs", 
                             input1,
                             input2,
                             options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( points2nfinetriangs,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "points2nfinetriangs", 
                             input1,
                             input2,
                             options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( chiro2alltriangs,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "chiro2alltriangs", 
                             input1,
                             input2,
                             options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( points2alltriangs,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "points2alltriangs", 
                             input1,
                             input2,
                             options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( chiro2nalltriangs,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "chiro2nalltriangs", 
                             input1,
                             input2,
                             options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( points2nalltriangs,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "points2nalltriangs", 
                             input1,
                             input2,
                             options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( chiro2allfinetriangs,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "chiro2allfinetriangs", 
                             input1,
                             input2,
                             options_list );

    # finally evaluate the output
    return EvalString( result );

end );


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
    return EvalString( result ); # fails if result = "" -> special catch needed

end );


InstallMethod( chiro2nallfinetriangs,
               "a list of points, a reference triangulation and a list of options",
               [ IsList, IsList, IsList ],
  function( points, ref_triangulation, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "chiro2nallfinetriangs", 
                             points, 
                             ref_triangulation, 
                             options_list );

    # finally evaluate the output
    return EvalString( result ); # fails if result = "" -> special catch needed

end );


InstallMethod( points2nallfinetriangs,
               "a list of points, a reference triangulation and a list of options",
               [ IsList, IsList, IsList ],
  function( points, ref_triangulation, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "points2nallfinetriangs", 
                             points, 
                             ref_triangulation, 
                             options_list );

    # finally evaluate the output
    return EvalString( result ); # fails if result = "" -> special catch needed

end );


InstallMethod( cube,
               "a list of points, a reference triangulation and a list of options",
               [ IsList, IsList, IsList ],
  function( points, ref_triangulation, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "cube", 
                             points, 
                             ref_triangulation, 
                             options_list );

    # finally evaluate the output
    return EvalString( result ); # fails if result = "" -> special catch needed

end );


InstallMethod( cyclic,
               "a list of points, a reference triangulation and a list of options",
               [ IsList, IsList, IsList ],
  function( points, ref_triangulation, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "cyclic", 
                             points, 
                             ref_triangulation, 
                             options_list );

    # finally evaluate the output
    return EvalString( result ); # fails if result = "" -> special catch needed

end );


InstallMethod( cross,
               "a list of points, a reference triangulation and a list of options",
               [ IsList, IsList, IsList ],
  function( points, ref_triangulation, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "cross", 
                             points, 
                             ref_triangulation, 
                             options_list );

    # finally evaluate the output
    return EvalString( result ); # fails if result = "" -> special catch needed

end );


InstallMethod( hypersimplex,
               "a list of points, a reference triangulation and a list of options",
               [ IsList, IsList, IsList ],
  function( points, ref_triangulation, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "hypersimplex", 
                             points, 
                             ref_triangulation, 
                             options_list );

    # finally evaluate the output
    return EvalString( result ); # fails if result = "" -> special catch needed

end );


InstallMethod( santos_triang,
               "a list of points, a reference triangulation and a list of options",
               [ IsList, IsList, IsList ],
  function( points, ref_triangulation, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcom( topcomDirectory, 
                             "santos_triang", 
                             points, 
                             ref_triangulation, 
                             options_list );

    # finally evaluate the output
    return EvalString( result ); # fails if result = "" -> special catch needed

end );
