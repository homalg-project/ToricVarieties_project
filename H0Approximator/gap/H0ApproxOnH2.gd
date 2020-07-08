###############################################################################################
##
##  H0Approx.gd         H0Approximator package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to estimate global sections of pullback line bundle on hypersurface curves in dP3
##
#! @Chapter Spectrum approximation from curve splittings in H2
##
###############################################################################################



##############################################################################################
##
#! @Section Compute if a curve of given class is irreducible
##
##############################################################################################

#! @Description
#! This operation identifies if a curve class defines an irreducible curve or not in $\mathrm{H}_2$.
#! @Returns True or false
#! @Arguments List
DeclareOperation( "IsIrreducibleOnH2",
                  [ IsList, IsToricVariety ] );

#! @Description
#! This operation performs a primary decomposition of a hypersurface curve in $\mathrm{H}_2$.
#! If all components are principal, it returns the degrees of the generators.
#! Otherwise it returns fail.
#! @Returns A list of fail
#! @Arguments List
DeclareOperation( "DegreesOfComponentsOnH2",
                  [ IsList, IsToricVariety ] );


##############################################################################################
##
#! @Section Finding the CounterDirectory
##
##############################################################################################

#! @Description
#! This operation identifies the location of the counter binary when applied in $\mathrm{H}_2$.
#! @Returns the corresponding filename
#! @Arguments none
DeclareOperation( "FindCounterBinaryOnH2", [ ] );


##############################################################################################
##
#! @Section Determine descendant level
##
##############################################################################################

#! @Description
#! Estimates the maximal power to which a rigid divisor can be peeled-off the given curve in $\mathrm{H}_2$.
#! @Returns An integer
#! @Arguments List c
DeclareOperation( "DescendantLevelOnH2",
                  [ IsList ] );


##############################################################################################
##
#! @Section Approximate h0-spectrum
##
##############################################################################################

#! @Description
#! Given a curve class c and a line bundle class l in $\mathrm{H}_2$, this method approximates the h0-spectrum
#! by use of topological methods only. In particular, irreducibility of curves is not checked.
#! Consequently, this method performs faster than FineApproximation, but produces less accurate results.
#! @Returns A list
#! @Arguments Lists c l
DeclareOperation( "RoughApproximationWithSetupsOnH2",
                  [ IsList, IsList ] );

#! @Description
#! The same as RoughApproximationWithSetups, but returns only the spectrum estimate.
#! @Returns A list
#! @Arguments Lists c l
DeclareOperation( "RoughApproximationOnH2",
                  [ IsList, IsList ] );

#! @Description
#! Given a curve class c and a line bundle class l in $\mathrm{H}_2$, this method approximates the h0-spectrum
#! by use of topological methods and checks irreducibility of curves. It performs slower than
#! RoughApproximation, but produces more accurate results.
#! @Returns A list
#! @Arguments Lists c l
DeclareOperation( "FineApproximationWithSetupsOnH2",
                  [ IsList, IsList ] );

#! @Description
#! The same as FineApproximationWithSetups, but returns only the spectrum estimate.
#! @Returns A list
#! @Arguments Lists c l
DeclareOperation( "FineApproximationOnH2",
                  [ IsList, IsList ] );
