################################################################################################
##
##  MonomsOfDegree.gd        TruncationsOfFPGradedModules package
##
##  Copyright 2020           Martin Bies,       University of Oxford
##
#! @Chapter Monoms of Coxring of given degree
##
################################################################################################


##########################################################
##
#! @Section Monoms of given degree in the Cox ring
##
##########################################################

#! @Description
#! Given a smooth and complete toric variety and a list of integers (= degree) corresponding to an element of 
#! the class group of the variety, this method return a list of integer valued lists. These lists correspond 
#! to the exponents of the monomials of degree in the Cox ring of this toric variety.
#! @Returns a list of lists of integers
#! @Arguments vari, degree
DeclareOperation( "Exponents",
               [ IsToricVariety, IsList ] );

#! @Description
#! Given a smooth and complete toric variety and a list of integers (= degree) corresponding to an element
#! of the class group of the variety, this method returns the list of all monomials in the Cox ring of the
#! given degree. This method uses NormalizInterface. 
#! @Returns a list
#! @Arguments vari, degree
DeclareOperation( "MonomsOfCoxRingOfDegreeByNormaliz",
               [ IsToricVariety, IsList ] );

#! @Description
#! Given a smooth and complete toric variety, a list of integers (= degree) corresponding to an element
#! of the class group of the variety and two non-negative integers i and l, this method returns a list
#! of column matrices. The columns are of length l and have at position i the monoms of the Coxring of degree 'degree'.
#! @Returns a list of matrices
#! @Arguments vari, degree, i, l
DeclareOperation( "MonomsOfCoxRingOfDegreeByNormalizAsColumnMatrices",
                 [ IsToricVariety, IsList, IsPosInt, IsPosInt ] );
