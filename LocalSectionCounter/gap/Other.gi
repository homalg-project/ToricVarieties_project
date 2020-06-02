#############################################################################
##
##  Other.gi            LocalSectionCounter package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to estimate global sections of a line bundle on curves in dP3
##
#############################################################################


##############################################################################################
##
## Install elementary topological functions on dP3
##
##############################################################################################

InstallMethod( RigidDivisors,
               "",
               [],
    function()
    local E1, E2, E3, E4, E5, E6;
    
    # initialize the rigid divisors
    E1 := [ 0,1,0,0 ];
    E2 := [ 0,0,1,0 ];
    E3 := [ 0,0,0,1 ];
    E4 := [ 1,-1,-1,0 ];
    E5 := [ 1,-1,0,-1 ];
    E6 := [ 1,0,-1,-1 ];
    
     # and return their list
    return [ E1, E2, E3, E4, E5, E6 ];
    
end );


InstallMethod( IsEffective,
               "a list",
               [ CurveClass ],
  function( class )
    local inequalities, eval_inequalities, result;
    
    # define inequalities
    inequalities := [ [1,0,0,0],[1,0,0,1],[1,0,1,0],[1,1,0,0],[2,1,1,1] ];
    
    # compute inequalities
    eval_inequalities := List( [ 1 .. Length( inequalities ) ], i -> class * inequalities[ i ] );
    
    # check if all inequalities are >= 0
    result := false;
    if PositionProperty( eval_inequalities, IsNegInt ) = fail then
        return true;
    fi;
    
    # return result
    return result;
    
end );


InstallMethod( CanDescend,
               "a list",
               [ CurveClass ],
  function( class )
    local pos_descendents, result;
    
    # compute the possible dec
    pos_descendents := List( [ 1 .. 6 ], i -> IsEffective( class - rigids[ i ] ) );
    
    # see if this curve can desend
    result := true;
    if Position( pos_descendents, true ) = fail then
        result := false;
    fi;
    
    # return result
    return result;
    
end );
