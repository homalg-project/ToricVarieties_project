################################################################################################
##
##  LocalizedDegree0OfGradedRowsAndColumns.gi       TruncationsOfFPGradedModules
##
##  Copyright 2020               Martin Bies,       University of Oxford
##
#!  @Chapter Localized truncations of graded rows or columns
##
################################################################################################


#######################################################################################
##
#! @Section Technical tools
##
#######################################################################################

#! @Description
#! This function accepts a graded ring R and a list of variables L as well as a twist T.
#! We can then consider the ring R localized at L and twisted by T. We can view this as
#! a R_L module, and this function computes a basis of this module (over R_L ).
#! @Returns a list
#! @Arguments R, L
DeclareOperation( "Degree_basis",
                  [ IsHomalgGradedRing, IsList, IsList ] );

#! @Description
#! This function computes relations among generators.
#! @Returns a list
#! @Arguments R, L
DeclareOperation( "Degree_part_relations",
                  [ IsList, IsList, IsHomalgRing ] );


#######################################################################################
##
#! @Section Localized degree-0-layer of graded rows and columns
##
#######################################################################################

#! @Description
#! First localize a graded row R at a list L of variables
#! and subsequently truncate this localization to degree 0.
#! @Returns a fp graded module
#! @Arguments R, L
DeclareOperation( "LocalizedDegreeZero",
                  [ IsGradedRow, IsList ] );
DeclareOperation( "LocalizedDegreeZero",
                  [ IsGradedRow, IsList, IsHomalgGradedRing, IsList, IsCapCategory ] );

#! @Description
#! First localize a graded column C at a list L of variables
#! and subsequently truncate this localization to degree 0.
#! @Returns a fp graded module
#! @Arguments C, L
DeclareOperation( "LocalizedDegreeZero",
                  [ IsGradedColumn, IsList ] );
DeclareOperation( "LocalizedDegreeZero",
                  [ IsGradedColumn, IsList, IsHomalgGradedRing, IsList, IsCapCategory ] );

#! @Description
#! Localize a graded row morphism m at a list L of variables
#! and subsequently truncate this localization to degree 0.
#! @Returns an fp graded module morphism
#! @Arguments m, L
DeclareOperation( "LocalizedDegreeZero",
                  [ IsGradedRowOrColumnMorphism, IsList ] );
DeclareOperation( "LocalizedDegreeZero",
                  [ IsGradedRowOrColumnMorphism, IsList, IsHomalgGradedRing, IsList, IsCapCategory ] );
