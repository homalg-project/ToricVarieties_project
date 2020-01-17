##########################################################################################
##
##  TruncationFunctor.gd               TruncationsOfFPGradedModules package
##
##  Copyright 2020                     Martin Bies,    University of Oxford
##
#! @Chapter Truncation functors for f.p. graded modules
##
#########################################################################################


##################################################################################################
##
#! @Section Truncation functor for graded rows and columns
##
##################################################################################################

# a function that computes the truncation functor to single degrees for both projective left and right modules
DeclareOperation( "TruncationFunctorForGradedRowsAndColumns",
                  [ IsToricVariety, IsList, IsBool ] );

#! @Description
#! The arguments are a toric variety $V$ and degree_list $d$ specifying an element of the
#! degree group of the toric variety $V$. The latter can either be a list of integers or
#! a HomalgModuleElement. Based on this input, this method returns the functor for the
#! truncation of graded rows over the Cox ring of $V$ to degree $d$.
#! @Returns a functor
#! @Arguments V, d
DeclareOperation( "TruncationFunctorForGradedRows",
                  [ IsToricVariety, IsList ] );

DeclareOperation( "TruncationFunctorForGradedRows",
                  [ IsToricVariety, IsHomalgModuleElement ] );

#! @Description
#! The arguments are a toric variety $V$ and degree_list $d$ specifying an element of the
#! degree group of the toric variety $V$. The latter can either be a list of integers or
#! a HomalgModuleElement. Based on this input, this method returns the functor for the
#! truncation of graded columns over the Cox ring of $V$ to degree $d$.
#! @Returns a functor
#! @Arguments V, d
DeclareOperation( "TruncationFunctorForGradedColumns",
                  [ IsToricVariety, IsList ] );

DeclareOperation( "TruncationFunctorForGradedColumns",
                  [ IsToricVariety, IsHomalgModuleElement ] );


##################################################################################################
##
#! @Section Truncation functor for f.p. graded modules
##
##################################################################################################

# a function that computes the truncation functor for f.p. graded modules
DeclareOperation( "TruncationFunctorForFPGradedModules",
                  [ IsToricVariety, IsList, IsBool ] );

#! @Description
#! The arguments are a toric variety $V$ and degree list $d$, which 
#! specifies an element of the degree group of the toric variety $V$.
#! $d$ can either be a list of integers or a HomalgModuleElement.
#! Based on this input, this method returns the functor for the
#! truncation of f.p. graded right modules to degree $d$.
#! @Returns a functor
#! @Arguments V, d
DeclareOperation( "TruncationFunctorForFpGradedLeftModules",
                  [ IsToricVariety, IsList ] );

DeclareOperation( "TruncationFunctorForFpGradedLeftModules",
                  [ IsToricVariety, IsHomalgModuleElement ] );

#! @Description
#! The arguments are a toric variety $V$ and degree list $d$, which 
#! specifies an element of the degree group of the toric variety $V$.
#! $d$ can either be a list of integers or a HomalgModuleElement.
#! Based on this input, this method returns the functor for the
#! truncation of f.p. graded right modules to degree $d$.
#! @Returns a functor
#! @Arguments V, d
DeclareOperation( "TruncationFunctorForFpGradedRightModules",
                  [ IsToricVariety, IsList ] );

DeclareOperation( "TruncationFunctorForFpGradedRightModules",
                  [ IsToricVariety, IsHomalgModuleElement ] );
