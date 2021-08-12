#############################################################################
##
##  H0ApproxFromMaxSplits.gd        H0Approximator package
##
##                                  Martin Bies
##                                  University of Pennsylvania
##
##                                  Muyang Liu
##                                  University of Pennsylvania
##
##  Copyright 2021
##
##  A package to estimate global sections of pullback line bundle on hypersurface curves in dP3 and H2
##
#! @Chapter Spectrum approximation from maximal curve splittings in dP3
##
#############################################################################



##############################################################################################
##
#! @Section Install elementary topological functions
##
##############################################################################################

#! @Description
#! Compute the topological intersection number between two divisor classes d1, d2 in dP3
#! @Returns Integer
#! @Arguments Lists d1, d2
DeclareOperation( "IntersectionNumber",
                  [ IsList, IsList ] );

#! @Description
#! Compute the genus of a curve of class c in dP3
#! @Returns Integer
#! @Arguments List c
DeclareOperation( "Genus",
                  [ IsList ] );

#! @Description
#! Computes the degree of a pullback line bundle of class l on a curve of class c in dP3
#! @Returns Integer
#! @Arguments Lists l, c
DeclareOperation( "LineBundleDegree",
                  [ IsList, IsList ] );


##############################################################################################
##
#! @Section Check if a curve class if a power of a rigid divisor
##
##############################################################################################

#! @Description
#! Checks if a curve class if a power of E1
#! @Returns True or false
#! @Arguments List c
DeclareOperation( "IsE1Power",
                  [ IsList ] );

#! @Description
#! Checks if a curve class if a power of E2
#! @Returns True or false
#! @Arguments List c
DeclareOperation( "IsE2Power",
                  [ IsList ] );

#! @Description
#! Checks if a curve class if a power of E3
#! @Returns True or false
#! @Arguments List c
DeclareOperation( "IsE3Power",
                  [ IsList ] );

#! @Description
#! Checks if a curve class if a power of E4
#! @Returns True or false
#! @Arguments List c
DeclareOperation( "IsE4Power",
                  [ IsList ] );

#! @Description
#! Checks if a curve class if a power of E5
#! @Returns True or false
#! @Arguments List c
DeclareOperation( "IsE5Power",
                  [ IsList ] );

#! @Description
#! Checks if a curve class if a power of E6
#! @Returns True or false
#! @Arguments List c
DeclareOperation( "IsE6Power",
                  [ IsList ] );

#! @Description
#! Checks if a curve class in $\mathrm{dP}_3$ is a power of a rigid divisor.
#! @Returns True or false
#! @Arguments List c
DeclareOperation( "IsRigidPower",
                  [ IsList ] );


##############################################################################################
##
#! @Section Local section analyser
##
##############################################################################################

#! @Description
#! Identify the intersection matrix among all components of a curve in $\mathrm{dP}_3$.
#! @Returns A list of lists of integers
#! @Arguments List of curve components
DeclareOperation( "IntersectionMatrix",
                  [ IsList ] );

#! @Description
#! Identify the intersection numbers among all components of a curve in $\mathrm{dP}_3$.
#! @Returns A list of integers
#! @Arguments List of curve components.
DeclareOperation( "IntersectionsAmongCurveComponents",
                  [ IsList ] );

#! @Description
#! This method estimates the number of global sections based on the list L1 of local
#! sections and the list L2 of intersection numbers among the split components of the curve in $\mathrm{dP}_3$.
#! @Returns An integer
#! @Arguments Lists L1, L2
DeclareOperation( "EstimateGlobalSections",
                  [ IsList, IsList ] );

#! @Description
#! This method checks whether the pair of curve in $\mathrm{dP}_3$ with components with intersection numbers I
#! and local section counts n allow to easily estimate the number of global sections.
#! @Returns An integer
#! @Arguments Lists S, n
DeclareOperation( "IsSimpleSetup",
                  [ IsList, IsList ] );

#! @Description
#! This method displays details on the analysis of the pullback line
#! bundle of class l on a curve in $\mathrm{dP}_3$ with components S.
#! @Returns An integer
#! @Arguments Lists S, l
DeclareOperation( "AnalyzeBundleOnCurve",
                  [ IsList, IsList ] );
DeclareOperation( "AnalyzeBundleOnCurve",
                  [ IsList, IsList, IsInt ] );


##############################################################################################
##
#! @Section Analyse bundle on maximally degenerate curves
##
##############################################################################################

#! @Description
#! This method identifies the maximal degenerations of a curve of class c in $\mathrm{dP}_3$.
#! @Returns A list
#! @Arguments List c
DeclareOperation( "MaximallyDegenerateCurves",
                  [ IsList ] );

#! @Description
#! This method analysis the local and global sections of a pullback
#! line bundle of class l on the maximally degenerate curves of class c in $\mathrm{dP}_3$.
#! @Returns A list
#! @Arguments Lists c,l
DeclareOperation( "EstimateGlobalSectionsOfBundleOnMaximallyDegenerateCurves",
                  [ IsList, IsList ] );
DeclareOperation( "EstimateGlobalSectionsOfBundleOnMaximallyDegenerateCurves",
                  [ IsList, IsList, IsInt ] );
