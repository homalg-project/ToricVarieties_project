###############################################################################################
##
##  Other.gd            H0Approximator package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to estimate global sections of pullback line bundle on hypersurface curves in dP3
##
#! @Chapter Stuff
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


##############################################################################################
##
#! @Section Finding the CounterDirectory
##
##############################################################################################

#! @Description
#! This operation identifies the location of the counter binary.
#! @Returns the corresponding filename
#! @Arguments none
DeclareOperation( "FindCounterBinary", [ ] );


##############################################################################################
##
#! @Section Determine descendant level
##
##############################################################################################

#! @Description
#! Estimates the maximal power to which a rigid divisor can be peeled-off the given curve.
#! @Returns An integer
#! @Arguments List c
DeclareOperation( "DescendantLevel",
                  [ IsList ] );


##############################################################################################
##
#! @Section Approx spectrum
##
##############################################################################################

#! @Description
#! Given a curve class c and a line bundle class l, this method approximates the h0-spectrum
#! by use of topological methods only. In particular, irreducibility of curves is not checked.
#! Consequently, this method performs faster than FineApproximation, but produces less accurate results.
#! @Returns A list
#! @Arguments Lists c l
DeclareOperation( "RoughApproximationWithSetups",
                  [ IsList, IsList ] );
DeclareOperation( "RoughApproximation",
                  [ IsList, IsList ] );

#! @Description
#! Given a curve class c and a line bundle class l, this method approximates the h0-spectrum
#! by use of topological methods and checks irreducibility of curves. It performs slower than
#! RoughApproximation, but produces more accurate results.
#! @Returns A list
#! @Arguments Lists c l
DeclareOperation( "FineApproximationWithSetups",
                  [ IsList, IsList ] );
DeclareOperation( "FineApproximation",
                  [ IsList, IsList ] );
