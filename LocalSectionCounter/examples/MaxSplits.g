#! @Chapter Functionality

#! @Section Examples

LoadPackage( "LocalSectionCounter" );

#! We can consider the maximal degenerations of a given curve class and then estimate the number of global sections for a line bundle from the number of local sections.
#! Here is a simple example:

#! @Example
EstimateGlobalSectionsOfBundleOnMaximallyDegenerateCurves(
                                        [ 3,-1,-1,-1 ], [1,-1,-3,-1] );;
#! @EndExample

#! For convenience, we allow the user to specify the level of detail from a verbose-integer as third argument. For example

#! @Example
EstimateGlobalSectionsOfBundleOnMaximallyDegenerateCurves(
                                        [ 3,-1,-1,-1 ], [1,-1,-3,-1], 1 );;
#! Analyse bundle on 7 degenerate curves...
#! Spectrum: [ 2, 3, "NA" ]
#! @EndExample

#! The most details are provided for verbose level 2.

#! Note that our counter assumes that neighbouring curve components do not support non-trivial sections simultaneously. This simplifies the estimate, but is
#! a restrictive assumption at the same time. For example, in the following example, we cannot estimate a global section value at all:

#! @Example
EstimateGlobalSectionsOfBundleOnMaximallyDegenerateCurves(
                                        [4,-1,-2,-1], [ 3,-3,-1,-2 ], 1 );;
#! Analyse bundle on 10 degenerate curves...
#! Spectrum: [ "NA" ]
#! @EndExample

#! However, in other cases, we can estimate the number of global sections for all maximally degenerate curves:
#! @Example
EstimateGlobalSectionsOfBundleOnMaximallyDegenerateCurves(
                                        [ 5,-2,-2,-1 ], [2, -2, -4, -2] );
#! [ 0, 1, 2, 3, 4 ]
#! @EndExample
