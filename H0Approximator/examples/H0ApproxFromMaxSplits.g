#! @Chapter Spectrum approximation from maximal curve splittings in dP3

#! @Section Examples

LoadPackage( "H0Approximator" );

#! We can consider maximal degenerations of a given curve class in $\mathrm{dP}_3$ and use these to estimate the number of global sections for a line bundle on this curve. This estimate is derived from counts of the local sections. Here is a simple example:

#! @Example
EstimateGlobalSectionsOfBundleOnMaximallyDegenerateCurves(
                                        [ 3,-1,-1,-1 ], [1,-1,-3,-1] );;
#! @EndExample

#! For convenience, we allow the user to specify the level of detail from a verbose-integer as third argument. For example

#! @Example
EstimateGlobalSectionsOfBundleOnMaximallyDegenerateCurves(
                                        [ 3,-1,-1,-1 ], [1,-1,-3,-1], 1 );;
#!
#! Analyse bundle on 7 degenerate curves...
#! Estimated spectrum on 5 curves
#! Spectrum estimate: [ 2, 3 ]
#!
#! @EndExample

#! The most details are provided for verbose level 2.

#! Note that our counter assumes that neighbouring curve components do not support non-trivial sections simultaneously. This simplifies the estimate, but is
#! a restrictive assumption at the same time. For example, in the following example, we cannot estimate a global section value at all from the maximal curve splits:

#! @Example
EstimateGlobalSectionsOfBundleOnMaximallyDegenerateCurves(
                                        [4,-1,-2,-1], [ 3,-3,-1,-2 ], 1 );;
#!
#! Analyse bundle on 10 degenerate curves...
#! Estimated spectrum on 0 curves
#! Spectrum estimate: [ ]
#!
#! @EndExample

#! However, in other cases, we can estimate the number of global sections for all maximally degenerate curves:
#! @Example
EstimateGlobalSectionsOfBundleOnMaximallyDegenerateCurves(
                                        [ 5,-2,-2,-1 ], [2, -2, -4, -2] );
#! [ 0, 1, 2, 3, 4 ]
#! @EndExample
