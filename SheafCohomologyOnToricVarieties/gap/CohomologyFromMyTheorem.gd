##########################################################################################
##
##  CohomologyFromMyTheorem.gd         SheafCohomologyOnToricVarieties package
##
##  Copyright 2020                     Martin Bies,       Un iversity of Oxford
##
#! @Chapter Sheaf cohomology by use of https://arxiv.org/abs/1802.08860
##
#########################################################################################


#############################################################
##
#! @Section Preliminaries
##
#############################################################

#! @Description
#! Given a toric variety $V$, we eventually wish to compute the i-th
#! sheaf cohomology of the sheafification of the f.p. graded S-module
#! $M_2$ (S being the Cox ring of vari). To this end we use modules $M_1$
#! which sheafify to the structure sheaf of vari. This method tests
#! if the truncation to degree zero of $Ext^i_S( M_1, M_2 )$ is
#! isomorphic to $H^i( V, \widetilde{M_2} )$.
#! @Returns true or false
#! @Arguments V, M1, M2, i
DeclareOperation( "ParameterCheck",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsInt ] );

#! @Description
#! Given a toric variety $V$ and an f.p. graded S-module
#! $M$ (S being the Cox ring of vari), we wish to compute the i-th
#! sheaf cohomology of $\tilde{M}$. To this end, this method identifies
#! an ideal $I$ of $S$ such that $\tilde{I}$ is the structure sheaf of $V$
#! and such that $Ext^i_S( I, M )$ is isomorphic to $H^i( V, \tilde{M} )$.
#! We identify $I$ by determining an ample degree $d \in \mathrm{Cl} ( V )$.
#! Then, for a suitable non-negative integer $e$, the generators of $I$
#! are the $e$-th power of all monomials of degree $d$ in the Cox ring of $S$.
#! We return the list [ e, d, I ].
#! @Returns a list
#! @Arguments V, M, i
DeclareOperation( "FindIdeal",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsInt ] );



#############################################################
##
#! @Section Computation of global sections
##
#############################################################

#! @Description
#! Given a variety $V$ and an f.p. graded $S$-module $M$ ($S$ being
#! the Cox ring of $V$), this method computes $H^0( V, \tilde{M} )$.
#! @Returns a vector space
#! @Arguments V, M
DeclareOperation( "H0",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject ] );

DeclareOperation( "H0",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsBool ] );
DeclareOperation( "H0",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsBool, IsBool ] );
DeclareOperation( "H0",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsBool, IsBool, IsBool ] );


#! @Description
#! Given a variety $V$ and an f.p. graded $S$-module $M$ ($S$ being
#! the Cox ring of $V$), this method computes $H^0( V, \tilde{M} )$.
#! This method is parallelized and is thus best suited for long and
#! complicated computations.
#! @Returns a vector space
#! @Arguments V, M
DeclareOperation( "H0Parallel",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject ] );

DeclareOperation( "H0Parallel",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsBool ] );
DeclareOperation( "H0Parallel",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsBool, IsBool ] );
DeclareOperation( "H0Parallel",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsBool, IsBool, IsBool ] );


#############################################################
##
#! @Section Computation of the i-th sheaf cohomologies
##
#############################################################

#! @Description
#! Given a variety $V$ and an f.p. graded $S$-module $M$ ($S$ being
#! the Cox ring of $V$), this method computes $H^i( V, \tilde{M} )$.
#! @Returns a vector space
#! @Arguments V, M, i
DeclareOperation( "Hi",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsInt ] );

DeclareOperation( "Hi",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsInt, IsBool ] );
DeclareOperation( "Hi",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsInt, IsBool, IsBool ] );
DeclareOperation( "Hi",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsInt, IsBool, IsBool, IsBool ] );

#! @Description
#! Given a variety $V$ and an f.p. graded $S$-module $M$ ($S$ being
#! the Cox ring of $V$), this method computes $H^i( V, \tilde{M} )$.
#! This method is parallelized and is thus best suited for long and
#! complicated computations.
#! @Returns a vector space
#! @Arguments V, M, i
DeclareOperation( "HiParallel",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsInt ] );

DeclareOperation( "HiParallel",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsInt, IsBool ] );
DeclareOperation( "HiParallel",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsInt, IsBool, IsBool ] );
DeclareOperation( "HiParallel",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsInt, IsBool, IsBool, IsBool ] );


###################################################################################
##
#! @Section Computation of all sheaf cohomologies
##
###################################################################################

#! @Description
#! Given a variety $V$ and an f.p. graded $S$-module $M$ ($S$ being
#! the Cox ring of $V$), this method computes all sheaf cohomologies
#! $H^\ast( V, \tilde{M} )$.
#! @Returns a list of vector spaces
#! @Arguments V, M
DeclareOperation( "AllHi",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject ] );

DeclareOperation( "AllHi",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsBool ] );
DeclareOperation( "AllHi",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsBool, IsBool ] );


#! @Description
#! Given a variety $V$ and an f.p. graded $S$-module $M$ ($S$ being
#! the Cox ring of $V$), this method computes all sheaf cohomologies
#! $H^\ast( V, \tilde{M} )$. This method is parallelized and is thus
#! best suited for long and complicated computations.
#! @Returns a list of vector spaces
#! @Arguments V, M
DeclareOperation( "AllHiParallel",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject ] );

DeclareOperation( "AllHiParallel",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsBool ] );
DeclareOperation( "AllHiParallel",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsBool, IsBool ] );
