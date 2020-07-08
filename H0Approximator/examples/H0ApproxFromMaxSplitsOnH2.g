#! @Chapter Spectrum approximation from maximal curve splittings in H2

#! @Section Examples

LoadPackage( "H0Approximator" );

#! We can consider maximal degenerations of a given curve class in $\mathrm{H}_2$ and use these to estimate the number of global sections for a line bundle on this curve. This estimate is derived from counts of the local sections. Here is a simple example:

#! @Example
EstimateGlobalSectionsOfBundleOnMaximallyDegenerateCurvesOnH2(
                                        [ 3, 1 ], [1, 1] );;
#! @EndExample

#! For convenience, we allow the user to specify the level of detail from a verbose-integer as third argument. For example

#! @Example
EstimateGlobalSectionsOfBundleOnMaximallyDegenerateCurvesOnH2(
                                        [ 3, 1 ], [1, 1], 1 );;
#!
#! Analyse bundle on 10 degenerate curves...
#! Estimated spectrum on 10 curves
#! Spectrum estimate: [ 3, 5 ]
#!
#! @EndExample

#! The most details are provided for verbose level 2.

#! Note that our counter assumes that neighbouring curve components do not support non-trivial sections simultaneously. This simplifies the estimate, but is
#! a restrictive assumption at the same time. For example, in the following example, we cannot estimate a global section value at all from the maximal curve splits:

#! @Example
EstimateGlobalSectionsOfBundleOnMaximallyDegenerateCurvesOnH2(
                                        [ 5, 2], [ 1, 4 ], 1 );;
#!
#! Analyse bundle on 24 degenerate curves...
#! Estimated spectrum on 24 curves
#! Spectrum estimate: [ 15, 21, 27 ]
#!
#! @EndExample

#! However, in other cases, we can estimate the number of global sections for all maximally degenerate curves:
#! @Example
EstimateGlobalSectionsOfBundleOnMaximallyDegenerateCurvesOnH2(
                                        [ 5, 2 ], [ 1, 4 ] );
#! [ 15, 21, 27 ]
#! @EndExample
