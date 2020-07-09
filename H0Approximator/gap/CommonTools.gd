###############################################################################################
##
##  CommonTools.gd      H0Approximator package
##                      Muyang Liu
##
##  Copyright 2020      University of Pennsylvania
##
##  A package to estimate global sections of pullback line bundle on hypersurface curves in dP3 and H2
##
#! @Chapter Common functions applied generically to all toric surfaces
##

##############################################################################################
##
#! @Section Topological section counter
##
##############################################################################################

#! @Description
#! Based on degree d of a line bundle and the genus g of the curve,
#! this method tries to identify the number of sections of the line bundle.
#! @Returns Integer
#! @Arguments Integers d, g
DeclareOperation( "Sections",
                  [ IsInt, IsInt ] );
