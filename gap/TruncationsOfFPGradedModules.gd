##########################################################################################
##
##  TruncationsOfFPGradedModules.gd        SheafCohomologyOnToricVarieties package
##
##  Copyright 2019                         Martin Bies,       ULB Brussels
##
#! @Chapter Truncations of f.p. graded modules
##
#########################################################################################


##############################################################################################
##
#! @Section Truncations of fp graded modules
##
##############################################################################################

#! @Description
#! The arguments are a toric variety $V$, an f.p. graded module $M$, a list
#! $d$ (specifying a element of the class group of $V$) a boolean $B$ and a
#! field $F$. We then compute the truncation of $M$ to the degree $d$ and
#! return the corresponding vector space presentation as a FreydCategoryObject.
#! If $B$ is true, we display additional information during the computation.
#! The latter may be useful for longer computations.
#! @Returns a FreydCategoryObject
#! @Arguments V, M, d, B, F
DeclareOperation( "TruncateFPGradedModule",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsList, IsBool, IsFieldForHomalg ] );

DeclareOperation( "TruncateFPGradedModule",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsHomalgModuleElement, IsBool, IsFieldForHomalg ] );

DeclareOperation( "TruncateFPGradedModule",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsList, IsBool ] );

DeclareOperation( "TruncateFPGradedModule",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsHomalgModuleElement, IsBool ] );

DeclareOperation( "TruncateFPGradedModule",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsList ] );

DeclareOperation( "TruncateFPGradedModule",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsHomalgModuleElement ] );



##############################################################################################
##
#! @Section Truncations of fp graded modules in parallel
##
##############################################################################################

#! @Description
#! The arguments are a toric variety $V$, an f.p. graded module $M$, a list
#! $d$ (specifying a element of the class group of $V$), an integer $N$, a
#! boolean $B$ and a field $F$. We then compute the truncation of $M$ to
#! the degree $d$ and return the corresponding vector space presentation
#! encoded as a FreydCategoryObject. This is performed in $N$ child processes
#! in parallel. If $B$ is true, we display additional information during the
#! computation. The latter may be useful for longer computations.
#! @Returns a FreydCategoryObject
#! @Arguments V, M, d, N, B. F
DeclareOperation( "TruncateFPGradedModuleInParallel",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsList, IsInt, IsBool, IsFieldForHomalg ] );

DeclareOperation( "TruncateFPGradedModuleInParallel",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsHomalgModuleElement, IsInt, IsBool, IsFieldForHomalg ] );

DeclareOperation( "TruncateFPGradedModuleInParallel",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsList, IsInt, IsBool ] );

DeclareOperation( "TruncateFPGradedModuleInParallel",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsHomalgModuleElement, IsInt, IsBool ] );

DeclareOperation( "TruncateFPGradedModuleInParallel",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsList, IsInt ] );

DeclareOperation( "TruncateFPGradedModuleInParallel",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsHomalgModuleElement, IsInt ] );


##############################################################################################
##
#! @Section Truncations of fp graded modules morphisms
##
##############################################################################################

#! @Description
#! The arguments are a toric variety $V$, an f.p. graded module morphism $M$,
#! a list $d$ (specifying a element of the class group of $V$), a boolean $B$ and
#! a field F. We then compute the truncation of $M$ to the degree $d$ and return
#! the corresponding morphism of vector space presentations encoded as a
#! FreydCategoryMorphism. If $B$ is true, we display additional information
#! during the computation. The latter may be useful for longer computations.
#! @Returns a FreydCategoryMorphism
#! @Arguments V, M, d, B, F
DeclareOperation( "TruncateFPGradedModuleMorphism",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsList, IsBool, IsFieldForHomalg ] );

DeclareOperation( "TruncateFPGradedModuleMorphism",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsHomalgModuleElement, IsBool, IsFieldForHomalg ] );

DeclareOperation( "TruncateFPGradedModuleMorphism",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsList, IsBool ] );

DeclareOperation( "TruncateFPGradedModuleMorphism",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsHomalgModuleElement, IsBool ] );

DeclareOperation( "TruncateFPGradedModuleMorphism",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsList ] );

DeclareOperation( "TruncateFPGradedModuleMorphism",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsHomalgModuleElement ] );


##############################################################################################
##
#! @Section Truncations of fp graded modules morphisms in parallel
##
##############################################################################################

#! @Description
#! The arguments are a toric variety $V$, an f.p. graded module morphism $M$,
#! a list $d$ (specifying a element of the class group of $V$), a list of 3
#! non-negative integers [ $N_1$, $N_2$, $N_3$ ], a boolean $B$ and
#! a field F. We then compute the truncation of $M$ to the degree $d$ and return
#! the corresponding morphism of vector space presentations encoded as a
#! FreydCategoryMorphism. This is done in parallel: the truncation of the
#! source is done by $N_1$ child processes in parallel, the truncation of the
#! morphism datum is done by $N_2$ child processes and the truncation of the
#! range of $M$ by $N_3$ processes. If the boolean $B$ is set to true,
#! we display additional information during the computation. The latter may
#! be useful for longer computations.
#! @Returns a FreydCategoryMorphism
#! @Arguments V, M, d, [ N1, N2, N3 ], B, F
DeclareOperation( "TruncateFPGradedModuleMorphism",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsList, IsList, IsBool, IsFieldForHomalg ] );

DeclareOperation( "TruncateFPGradedModuleMorphism",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsHomalgModuleElement, IsList, IsBool, IsFieldForHomalg ] );

DeclareOperation( "TruncateFPGradedModuleMorphism",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsList, IsList, IsBool ] );

DeclareOperation( "TruncateFPGradedModuleMorphism",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsHomalgModuleElement, IsList, IsBool ] );

DeclareOperation( "TruncateFPGradedModuleMorphism",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsList, IsList ] );

DeclareOperation( "TruncateFPGradedModuleMorphism",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsHomalgModuleElement, IsList ] );
