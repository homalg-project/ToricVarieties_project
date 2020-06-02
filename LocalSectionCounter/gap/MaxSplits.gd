#############################################################################
##
##  MaxSplits.gd        LocalSectionCounter package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to estimate global sections of a line bundle on curves in dP3
##
#! @Chapter Functionality
##
#############################################################################



##############################################################################################
##
#! @Section Install elementary topological functions on dP3
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


##############################################################################################
##
#! @Section Local section analyser
##
##############################################################################################

#! @Description
#! Identify the intersection matrix among all components of a curve.
#! @Returns A list of lists of integers
#! @Arguments List of curve components
DeclareOperation( "IntersectionMatrix",
                  [ IsList ] );

#! @Description
#! Identify the intersection numbers among all components of a curve.
#! @Returns A list of integers
#! @Arguments List of curve components.
DeclareOperation( "IntersectionsAmongCurveComponents",
                  [ IsList ] );

#! @Description
#! This method estimates the number of global sections based on the list L1 of local
#! sections and the list L2 of intersection numbers among the split components of the curve.
#! @Returns An integer
#! @Arguments Lists L1, L2
DeclareOperation( "EstimateGlobalSections",
                  [ IsList, IsList ] );

#! @Description
#! This method checks whether the pair of curve with components with intersection numbers I
#! and local section counts n allow to easily estimate the number of global sections.
#! @Returns An integer
#! @Arguments Lists S, n
DeclareOperation( "IsSimpleSetup",
                  [ IsList, IsList ] );

#! @Description
#! This method displays details on the analysis of the pullback line
#! bundle of class l on a curve with components S.
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
#! This method identifies the maximal degenerations of a curve of class c in dP3.
#! @Returns A list
#! @Arguments List c
DeclareOperation( "MaximallyDegenerateCurves",
                  [ IsList ] );

#! @Description
#! This method analysis the local and global sections of a pullback
#! line bundle of class l on the maximally degenerate curves of class c.
#! @Returns A list
#! @Arguments Lists c,l
DeclareOperation( "EstimateGlobalSectionsOfBundleOnMaximallyDegenerateCurves",
                  [ IsList, IsList ] );
DeclareOperation( "EstimateGlobalSectionsOfBundleOnMaximallyDegenerateCurves",
                  [ IsList, IsList, IsInt ] );
