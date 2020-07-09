#############################################################################
##
##  H0ApproxFromMaxSplits.gd        H0Approximator package
##                                  Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to estimate global sections of pullback line bundle on hypersurface curves in dP3 and H2
##
#! @Chapter Spectrum approximation from maximal curve splittings in H2
##
#############################################################################



##############################################################################################
##
#! @Section Install elementary topological functions
##
##############################################################################################

#! @Description
#! Compute the topological intersection number between two divisor classes d1, d2 in $\mathrm{H}_2$
#! @Returns Integer
#! @Arguments Lists d1, d2
DeclareOperation( "IntersectionNumberOnH2",
                  [ IsList, IsList ] );

#! @Description
#! Compute the genus of a curve of class c in $\mathrm{H}_2$
#! @Returns Integer
#! @Arguments List c
DeclareOperation( "GenusOnH2",
                  [ IsList ] );

#! @Description
#! Computes the degree of a pullback line bundle of class l on a curve of class c in $\mathrm{H}_2$
#! @Returns Integer
#! @Arguments Lists l, c
DeclareOperation( "LineBundleDegreeOnH2",
                  [ IsList, IsList ] );


##############################################################################################
##
#! @Section Check if a curve class if a power of a toric divisor
##
##############################################################################################

#! @Description
#! Checks if a curve class if a power of D1
#! @Returns True or false
#! @Arguments List c
DeclareOperation( "IsD1Power",
                  [ IsList ] );

#! @Description
#! Checks if a curve class if a power of D2
#! @Returns True or false
#! @Arguments List c
DeclareOperation( "IsD2Power",
                  [ IsList ] );

#! @Description
#! Checks if a curve class if a power of D3
#! @Returns True or false
#! @Arguments List c
DeclareOperation( "IsD3Power",
                  [ IsList ] );

#! @Description
#! Checks if a curve class if a power of D4
#! @Returns True or false
#! @Arguments List c
DeclareOperation( "IsD4Power",
                  [ IsList ] );

#! @Description
#! Checks if a curve class if a power of a toric divisor in $\mathrm{H}_2$.
#! @Returns True or false
#! @Arguments List c
DeclareOperation( "IsDiPowerOnH2",
                  [ IsList ] );


##############################################################################################
##
#! @Section Local section analyser
##
##############################################################################################

#! @Description
#! Identify the intersection matrix among all components of a curve in $\mathrm{H}_2$.
#! @Returns A list of lists of integers
#! @Arguments List of curve components
DeclareOperation( "IntersectionMatrixOnH2",
                  [ IsList ] );

#! @Description
#! Identify the intersection numbers among all components of a curve in $\mathrm{H}_2$.
#! @Returns A list of integers
#! @Arguments List of curve components.
DeclareOperation( "IntersectionsAmongCurveComponentsOnH2",
                  [ IsList ] );

#! @Description
#! This method checks whether the pair of curves in $\mathrm{H}_2$ with components with intersection numbers I
#! and local section counts n allow to easily estimate the number of global sections.
#! @Returns An integer
#! @Arguments Lists S, n
DeclareOperation( "IsSimpleSetupOnH2",
                  [ IsList, IsList ] );

#! @Description
#! This method displays details on the analysis of the pullback line
#! bundle of class l on a curve in $\mathrm{H}_2$ with components S.
#! @Returns An integer
#! @Arguments Lists S, l
DeclareOperation( "AnalyzeBundleOnCurveOnH2",
                  [ IsList, IsList ] );
DeclareOperation( "AnalyzeBundleOnCurveOnH2",
                  [ IsList, IsList, IsInt ] );


##############################################################################################
##
#! @Section Analyse bundle on maximally degenerate curves
##
##############################################################################################

#! @Description
#! This method identifies the maximal degenerations of a curve of class c in $\mathrm{H}_2$.
#! @Returns A list
#! @Arguments List c
DeclareOperation( "MaximallyDegenerateCurvesOnH2",
                  [ IsList ] );

#! @Description
#! This method analysis the local and global sections of a pullback
#! line bundle of class l on the maximally degenerate curves of class c in $\mathrm{H}_2$.
#! @Returns A list
#! @Arguments Lists c,l
DeclareOperation( "EstimateGlobalSectionsOfBundleOnMaximallyDegenerateCurvesOnH2",
                  [ IsList, IsList ] );
DeclareOperation( "EstimateGlobalSectionsOfBundleOnMaximallyDegenerateCurvesOnH2",
                  [ IsList, IsList, IsInt ] );
