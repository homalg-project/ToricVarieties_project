###############################################################################################
##
##  CommonTools.gi      H0Approximator package
##                      Muyang Liu
##
##  Copyright 2020      University of Pennsylvania
##
##  A package to estimate global sections of pullback line bundle on hypersurface curves in dP3 and H2
##
###############################################################################################


##############################################################################################
##
## Topological section counter
##
##############################################################################################

# return generic number of sections based on genus g and degree d
InstallMethod( LowerBoundOnSections,
               "an integer, an integer",
               [ IsInt, IsInt ],
    function( genus, degree )
        local chi, h0;
        
        # compute the chiral index
        chi := degree - genus + 1;
        
        # return generic number of sections
        if chi < 0 then
            h0 := 0;
        else
            h0 := chi;
        fi;
        
        # return result
        return h0;
        
end );
