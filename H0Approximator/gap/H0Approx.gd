###############################################################################################
##
##  H0Approx.gd         H0Approximator package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to estimate global sections of pullback line bundle on hypersurface curves in $\mathrm{dP}_3$ and H2
##
#! @Chapter Spectrum approximation from curve splittings in dP3
##
###############################################################################################



##############################################################################################
##
#! @Section Compute if a curve of given class is irreducible
##
##############################################################################################

#! @Description
#! This operation identifies if a curve class defines an irreducible curve or not.
#! @Returns True or false
#! @Arguments List
DeclareOperation( "IsIrreducible",
                  [ IsList, IsToricVariety ] );

#! @Description
#! This operation performs a primary decomposition of a hypersurface curve in $\mathrm{dP}_3$.
#! If all components are principal, it returns the degrees of the generators.
#! Otherwise it returns fail.
#! @Returns A list of fail
#! @Arguments List
DeclareOperation( "DegreesOfComponents",
                  [ IsList, IsToricVariety ] );


##############################################################################################
##
#! @Section Finding the CounterDirectory
##
##############################################################################################

#! @Description
#! This operation identifies the location of the counter binary when applied in $\mathrm{dP}_3$.
#! @Returns the corresponding filename
#! @Arguments none
DeclareOperation( "FindCounterBinary", [ ] );


##############################################################################################
##
#! @Section Determine descendant level
##
##############################################################################################

#! @Description
#! Estimates the maximal power to which a rigid divisor can be peeled-off in $\mathrm{dP}_3$ with the given curve.
#! @Returns An integer
#! @Arguments List c
DeclareOperation( "DescendantLevel",
                  [ IsList ] );


##############################################################################################
##
#! @Section Approximate h0-spectrum
##
##############################################################################################

#! @Description
#! Given a curve class c and a line bundle class l in $\mathrm{dP}_3$, this method approximates the h0-spectrum
#! by use of topological methods only. In particular, irreducibility of curves is not checked.
#! Consequently, this method performs faster than FineApproximation, but produces less accurate results.
#! @Returns A list
#! @Arguments Lists c l
DeclareOperation( "RoughApproximationWithSetups",
                  [ IsList, IsList ] );

#! @Description
#! The same as RoughApproximationWithSetups, but returns only the spectrum estimate.
#! @Returns A list
#! @Arguments Lists c l
DeclareOperation( "RoughApproximation",
                  [ IsList, IsList ] );

#! @Description
#! Given a curve class c and a line bundle class l in $\mathrm{dP}_3$, this method approximates the h0-spectrum
#! by use of topological methods and checks irreducibility of curves. It performs slower than
#! RoughApproximation, but produces more accurate results.
#! @Returns A list
#! @Arguments Lists c l
DeclareOperation( "FineApproximationWithSetups",
                  [ IsList, IsList ] );

#! @Description
#! The same as FineApproximationWithSetups, but returns only the spectrum estimate.
#! @Returns A list
#! @Arguments Lists c l
DeclareOperation( "FineApproximation",
                  [ IsList, IsList ] );
