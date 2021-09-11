###############################################################################################
##
##  WDiagrams.gi            QSMExplorer package
##
##                                    Martin Bies
##                                    University of Pennsylvania
##
##                                    Muyang Liu
##                                    University of Pennsylvania
##
##  Copyright 2021
##
##  A package to explore one Quadrillion F-theory Standard Models
##
##  Computation of minimal roots and their distribution for arbitrary nodal curves.
##

##############################################################################################
##
##  Computation of minimal roots
##
##############################################################################################


InstallMethod( CountMinimals, [ IsList, IsList, IsList, IsInt, IsInt ],
  function( genera, degrees, edges, total_genus, root )
        local min;

        # check for meaninful input
        if not IsInt( Sum( degrees ) / root ) then
            Error( "These roots do not exist. Check degrees and root.\n" );
            return -1;
        fi;
        
        # proceed
        if ( Sum( degrees ) / root - total_genus + 1 > 0 ) then
            min := Int( Sum( degrees ) / root - total_genus + 1 );
        else
            min := 0;
        fi;
        
        # count the minimal roots
        return CountDistributionWithExternalLegs( [ genera, degrees, edges, total_genus, root, min, min, [], [] ] );
        
end );


InstallMethod( CountSimpleMinimals,
               "",
               [ ],
  function( )
        
        return CountDistributionWithExternalLegs( [ [ 0,0,0 ], [ 16, 16, 16 ], [ [0,1], [1,2], [2,0] ], 1, 8, 6, 6, [], [] ] );
        
end );


##############################################################################################
##
##  Computation of distributions
##
##############################################################################################


InstallMethod( CountDistribution, [ IsList ],
  function( data )
        
        return CountDistributionWithExternalLegs( [ data[ 1 ], data[ 2 ], data[ 3 ], data[ 4 ], data[ 5 ], data[ 6 ], data[ 7 ], [], [] ] );
        
end );


InstallMethod( CountSimpleDistribution,
               "",
               [ ],
  function( )
        
        return CountDistributionWithExternalLegs( [ [ 0,0,0 ], [ 16, 16, 16 ], [ [0,1], [1,2], [2,0] ], 1, 8, 0, 8, [], [] ] );
        
end );

