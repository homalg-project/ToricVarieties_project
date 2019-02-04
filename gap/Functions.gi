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
    result := ExecuteTopcomForPoints( topcomDirectory, 
                                    "points2chiro", 
                                    input1,
                                    input2,
                                    options_list );

    # finally evaluate the output
    return result;

end );


InstallMethod( points2chiro,
               "a list",
               [ IsList ],
  function( input1 )

    return points2chiro( input1, [], [] );

end );

  
InstallMethod( chiro2dual,
               "a string, a list and a list of strings encoding options of topcom",
               [ IsString, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcomForChiro( topcomDirectory, 
                                    "chiro2dual", 
                                    input1,
                                    input2,
                                    options_list );

    # finally evaluate the output
    return result;

end );


InstallMethod( chiro2dual,
               "a string",
               [ IsString ],
  function( input1 )

    return chiro2dual( input1, [], [] );

end );


InstallMethod( chiro2circuits,
               "a string, a list and a list of strings encoding options of topcom",
               [ IsString, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcomForChiro( topcomDirectory, 
                                    "chiro2circuits", 
                                    input1,
                                    input2,
                                    options_list );

    # finally evaluate the output
    return result;

end );


InstallMethod( chiro2circuits,
               "a string",
               [ IsString ],
  function( input1 )

    return chiro2circuits( input1, [], [] );

end );


InstallMethod( chiro2cocircuits,
               "a string, a list and a list of strings encoding options of topcom",
               [ IsString, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcomForChiro( topcomDirectory, 
                                    "chiro2cocircuits", 
                                    input1,
                                    input2,
                                    options_list );

    # finally evaluate the output
    return result;

end );


InstallMethod( chiro2cocircuits,
               "a string",
               [ IsString ],
  function( input1 )

    return chiro2cocircuits( input1, [], [] );

end );


InstallMethod( cocircuits2facets,
               "a string, a list and a list of strings encoding options of topcom",
               [ IsString, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcomForChiro( topcomDirectory, 
                                    "cocircuits2facets", 
                                    input1,
                                    input2,
                                    options_list );

    # finally evaluate the output
    return result;
    
end );


InstallMethod( cocircuits2facets,
               "a string",
               [ IsString ],
  function( input1 )

    return cocircuits2facets( input1, [], [] );

end );


InstallMethod( points2facets,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcomForPoints( topcomDirectory, 
                                    "points2facets", 
                                    input1,
                                    input2,
                                    options_list );

    # finally evaluate the output
    return result;

end );


InstallMethod( points2facets,
               "a list",
               [ IsList ],
  function( input1 )

    return points2facets( input1, [], [] );

end );


InstallMethod( points2nflips,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcomForPoints( topcomDirectory, 
                                    "points2nflips", 
                                    input1,
                                    input2,
                                    options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( points2nflips,
               "a list",
               [ IsList ],
  function( input1 )

    return points2nflips( input1, [], [] );

end );


InstallMethod( points2flips,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcomForPoints( topcomDirectory, 
                                    "points2flips", 
                                    input1,
                                    input2,
                                    options_list );

    # finally evaluate the output
    return result;

end );


InstallMethod( points2flips,
               "a list",
               [ IsList ],
  function( input1 )

    return points2flips( input1, [], [] );

end );


InstallMethod( chiro2placingtriang,
               "a string, a list and a list of strings encoding options of topcom",
               [ IsString, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcomForChiro( topcomDirectory, 
                                    "chiro2placingtriang", 
                                    input1,
                                    input2,
                                    options_list );

    # finally return the result
    return EvalString( Concatenation( "[", result, "]" ) );

end );


InstallMethod( chiro2placingtriang,
               "a string",
               [ IsString ],
  function( input1 )

    return chiro2placingtriang( input1, [], [] );

end );


InstallMethod( points2placingtriang,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcomForPoints( topcomDirectory, 
                                    "points2placingtriang", 
                                    input1,
                                    input2,
                                    options_list );

    # finally evaluate the output
    return EvalString( Concatenation( "[", result, "]" ) );

end );


InstallMethod( points2placingtriang,
               "a list",
               [ IsList ],
  function( input1 )

    return points2placingtriang( input1, [], [] );

end );


InstallMethod( chiro2finetriang,
               "a string, a list and a list of strings encoding options of topcom",
               [ IsString, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcomForChiro( topcomDirectory, 
                                    "chiro2finetriang", 
                                    input1,
                                    input2,
                                    options_list );

    # finally evaluate the output
    return EvalString( Concatenation( "[", result, "]" ) );

end );


InstallMethod( chiro2finetriang,
               "a string",
               [ IsString ],
  function( input1 )

    return chiro2finetriang( input1, [], [] );

end );


InstallMethod( points2finetriang,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcomForPoints( topcomDirectory, 
                                    "points2finetriang", 
                                    input1,
                                    input2,
                                    options_list );

    # finally evaluate the output
    return EvalString( Concatenation( "[", result, "]" ) );

end );


InstallMethod( points2finetriang,
               "a list",
               [ IsList ],
  function( input1 )

    return points2finetriang( input1, [], [] );

end );


InstallMethod( chiro2triangs,
               "a string, a list and a list of strings encoding options of topcom",
               [ IsString, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcomForChiro( topcomDirectory, 
                                    "chiro2triangs", 
                                    input1,
                                    input2,
                                    options_list );

    # finally evaluate the output
    return result;

end );


InstallMethod( chiro2triangs,
               "a string",
               [ IsString ],
  function( input1 )

    return chiro2triangs( input1, [], [] );

end );


InstallMethod( points2triangs,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcomForPoints( topcomDirectory, 
                                    "points2triangs", 
                                    input1,
                                    input2,
                                    options_list );

    # finally evaluate the output
    return result;

end );


InstallMethod( points2triangs,
               "a list",
               [ IsList ],
  function( input1 )

    return points2triangs( input1, [], [] );

end );


InstallMethod( chiro2ntriangs,
               "a string, a list and a list of strings encoding options of topcom",
               [ IsString, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcomForChiro( topcomDirectory, 
                                    "chiro2ntriangs", 
                                    input1,
                                    input2,
                                    options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( chiro2ntriangs,
               "a string",
               [ IsString ],
  function( input1 )

    return chiro2ntriangs( input1, [], [] );

end );


InstallMethod( points2ntriangs,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcomForPoints( topcomDirectory, 
                                    "points2ntriangs", 
                                    input1,
                                    input2,
                                    options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( points2ntriangs,
               "a list",
               [ IsList ],
  function( input1 )

    return points2ntriangs( input1, [], [] );

end );


InstallMethod( chiro2finetriangs,
               "a string, a list and a list of strings encoding options of topcom",
               [ IsString, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcomForChiro( topcomDirectory, 
                                    "chiro2finetriangs", 
                                    input1,
                                    input2,
                                    options_list );

    # finally evaluate the output
    return result;

end );


InstallMethod( chiro2finetriangs,
               "a string",
               [ IsString ],
  function( input1 )

    return chiro2finetriangs( input1, [], [] );

end );


InstallMethod( points2finetriangs,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcomForPoints( topcomDirectory, 
                                    "points2finetriangs", 
                                    input1,
                                    input2,
                                    options_list );

    # finally evaluate the output
    return EvalString( Concatenation( "[", result, "]" ) );

end );


InstallMethod( points2finetriangs,
               "a list",
               [ IsList ],
  function( input1 )

    return points2finetriangs( input1, [], [] );

end );


InstallMethod( chiro2nfinetriangs,
               "a string, a list and a list of strings encoding options of topcom",
               [ IsString, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcomForChiro( topcomDirectory, 
                                    "chiro2nfinetriangs", 
                                    input1,
                                    input2,
                                    options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( chiro2nfinetriangs,
               "a string",
               [ IsString ],
  function( input1 )

    return chiro2nfinetriangs( input1, [], [] );

end );


InstallMethod( points2nfinetriangs,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcomForPoints( topcomDirectory, 
                                    "points2nfinetriangs", 
                                    input1,
                                    input2,
                                    options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( points2nfinetriangs,
               "a list",
               [ IsList ],
  function( input1 )

    return points2nfinetriangs( input1, [], [] );

end );


InstallMethod( chiro2alltriangs,
               "a string, a list and a list of strings encoding options of topcom",
               [ IsString, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcomForChiro( topcomDirectory, 
                                    "chiro2alltriangs", 
                                    input1,
                                    input2,
                                    options_list );

    # finally evaluate the output
    return EvalString( Concatenation( "[", result, "]" ) );

end );


InstallMethod( chiro2alltriangs,
               "a string",
               [ IsString ],
  function( input1 )

    return chiro2alltriangs( input1, [], [] );

end );


InstallMethod( points2alltriangs,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcomForPoints( topcomDirectory, 
                                    "points2alltriangs", 
                                    input1,
                                    input2,
                                    options_list );

    # finally evaluate the output
    return EvalString( Concatenation( "[", result, "]" ) );

end );


InstallMethod( points2alltriangs,
               "a list",
               [ IsList ],
  function( input1 )

    return points2alltriangs( input1, [], [] );

end );


InstallMethod( chiro2nalltriangs,
               "a string, a list and a list of strings encoding options of topcom",
               [ IsString, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcomForChiro( topcomDirectory, 
                                    "chiro2nalltriangs", 
                                    input1,
                                    input2,
                                    options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( chiro2nalltriangs,
               "a string",
               [ IsString ],
  function( input1 )

    return chiro2nalltriangs( input1, [], [] );

end );


InstallMethod( points2nalltriangs,
               "a list, a list and a list of strings encoding options of topcom",
               [ IsList, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcomForPoints( topcomDirectory, 
                                    "points2nalltriangs", 
                                    input1,
                                    input2,
                                    options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( points2nalltriangs,
               "a list",
               [ IsList ],
  function( input1 )

    return points2nalltriangs( input1, [], [] );

end );


InstallMethod( chiro2allfinetriangs,
               "a string, a list and a list of strings encoding options of topcom",
               [ IsString, IsList, IsList ],
  function( input1, input2, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcomForChiro( topcomDirectory, 
                                    "chiro2allfinetriangs", 
                                    input1,
                                    input2,
                                    options_list );

    # finally evaluate the output
    return EvalString( Concatenation( "[", result, "]" ) );

end );


InstallMethod( chiro2allfinetriangs,
               "a string",
               [ IsString ],
  function( input1 )

    return chiro2allfinetriangs( input1, [], [] );

end );


InstallMethod( points2allfinetriangs,
               "a list of points, a reference triangulation and a list of options",
               [ IsList, IsList, IsList ],
  function( points, ref_triangulation, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcomForPoints( topcomDirectory, 
                                    "points2allfinetriangs", 
                                    points, 
                                    ref_triangulation, 
                                    options_list );

    # finally evaluate the output
    return EvalString( Concatenation( "[", result, "]" ) );

end );


InstallMethod( points2allfinetriangs,
               "a list",
               [ IsList ],
  function( input1 )

    return points2allfinetriangs( input1, [], [] );

end );


InstallMethod( chiro2nallfinetriangs,
               "a string, a reference triangulation and a list of options",
               [ IsString, IsList, IsList ],
  function( points, ref_triangulation, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcomForChiro( topcomDirectory, 
                                    "chiro2nallfinetriangs", 
                                    points, 
                                    ref_triangulation, 
                                    options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( chiro2nallfinetriangs,
               "a string",
               [ IsString ],
  function( input1 )

    return chiro2nallfinetriangs( input1, [], [] );

end );


InstallMethod( points2nallfinetriangs,
               "a list of points, a reference triangulation and a list of options",
               [ IsList, IsList, IsList ],
  function( points, ref_triangulation, options_list )

  local topcomDirectory, result;

    # find the topcom binary
    topcomDirectory := FindTopcomDirectory( );

    # execute topcom with this input
    result := ExecuteTopcomForPoints( topcomDirectory, 
                                    "points2nallfinetriangs", 
                                    points, 
                                    ref_triangulation, 
                                    options_list );

    # finally evaluate the output
    return EvalString( result );

end );


InstallMethod( points2nallfinetriangs,
               "a list",
               [ IsList ],
  function( input1 )

    return points2nallfinetriangs( input1, [], [] );

end );
