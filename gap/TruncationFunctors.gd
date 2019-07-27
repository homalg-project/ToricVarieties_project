##########################################################################################
##
##  TruncationsFunctors.gd             SheafCohomologyOnToricVarieties package
##
##  Copyright 2019                     Martin Bies,       ULB Brussels
##
#! @Chapter Truncation functors for f.p. graded modules
##
#########################################################################################


##################################################################################################
##
#! @Section Truncation functor of projective graded modules (as defined in CAP) to a single degree
##
##################################################################################################

# a function that computes the truncation functor to single degrees for both projective left and right modules
DeclareGlobalFunction( "DegreeXLayerOfProjectiveGradedModulesFunctor" );

#! @Description
#! The arguments are a toric variety $V$ and <A>degree_list</A> specifying an element of the degree group of the 
#! toric variety $V$. The latter can either be a list of integers or a HomalgModuleElement. 
#! Based on this input, the method returns the functor for the truncation of projective graded left-$S$-modules
#! to <A>degree_list</A>.
#! @Returns a functor
#! @Arguments V, degree_list
DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftModulesFunctor",
                  [ IsToricVariety, IsList ] );

DeclareOperation( "DegreeXLayerOfProjectiveGradedLeftModulesFunctor",
                  [ IsToricVariety, IsHomalgModuleElement ] );

#! @Description
#! The arguments are a toric variety $V$ and <A>degree_list</A> specifying an element of the degree group of the 
#! toric variety $V$. The latter can either be a list of integers or a HomalgModuleElement. 
#! Based on this input, the method returns the functor for the truncation of projective graded right-$S$-modules 
#! to <A>degree_list</A>.
#! @Returns a functor
#! @Arguments V, degree_list
DeclareOperation( "DegreeXLayerOfProjectiveGradedRightModulesFunctor",
                  [ IsToricVariety, IsList ] );

DeclareOperation( "DegreeXLayerOfProjectiveGradedRightModulesFunctor",
                  [ IsToricVariety, IsHomalgModuleElement ] );


##################################################################################################
##
#! @Section Truncation functor of projective graded modules (as defined in CAP) to a single degree
##
##################################################################################################

# a function that computes the truncation functor to single degrees for both left and right graded module presentations
DeclareGlobalFunction( "DegreeXLayerOfGradedModulePresentationFunctor" );

#! @Description
#! The arguments are a toric variety $V$ and <A>degree_list</A> specifying an element of the degree group of the 
#! toric variety $V$. 
#! The latter can either be a list of integers or a HomalgModuleElement.
#! Based on this input, the method returns the functor for the truncation of 
#! graded left-$S$-module presentations to <A>degree_list</A>.
#! Optionally, a boolean $b$ can be provided as fourth argument. It will display/suppress information on the status of the computation.
#! $b = true$ will print information on the status of the computation, which might be useful in case the calculation takes several hours
#! and the user wants to stay informed on the status of the computation. $b = false$ will suppress this output. The defaul value is false.
#! @Returns a functor
#! @Arguments V, degree_list
DeclareOperation( "DegreeXLayerOfGradedLeftModulePresentationFunctor",
                  [ IsToricVariety, IsList, IsBool ] );

DeclareOperation( "DegreeXLayerOfGradedLeftModulePresentationFunctor",
                  [ IsToricVariety, IsList ] );

DeclareOperation( "DegreeXLayerOfGradedLeftModulePresentationFunctor",
                  [ IsToricVariety, IsHomalgModuleElement, IsBool ] );

DeclareOperation( "DegreeXLayerOfGradedLeftModulePresentationFunctor",
                  [ IsToricVariety, IsHomalgModuleElement ] );

#! @Description
#! The arguments are a toric variety $V$ and <A>degree_list</A> specifying an element of the degree group of the 
#! toric variety $V$. 
#! The latter can either be a list of integers or a HomalgModuleElement.
#! Based on this input, the method returns the functor for the truncation of 
#! graded right-$S$-module presentations to <A>degree_list</A>.
#! @Returns a functor
#! @Arguments V, degree_list
DeclareOperation( "DegreeXLayerOfGradedRightModulePresentationFunctor",
                  [ IsToricVariety, IsList, IsBool ] );

DeclareOperation( "DegreeXLayerOfGradedRightModulePresentationFunctor",
                  [ IsToricVariety, IsList ] );

DeclareOperation( "DegreeXLayerOfGradedRightModulePresentationFunctor",
                  [ IsToricVariety, IsHomalgModuleElement, IsBool ] );

DeclareOperation( "DegreeXLayerOfGradedRightModulePresentationFunctor",
                  [ IsToricVariety, IsHomalgModuleElement ] );
