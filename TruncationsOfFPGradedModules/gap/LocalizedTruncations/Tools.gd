################################################################################################
##
##  Tools.gd                           TruncationsOfFPGradedModules
##
##  Copyright 2020                     Martin Bies,       University of Oxford
##
#!  @Chapter Technical functions
##
################################################################################################


################################################################################################
#! @Section Functions to facilitate localized truncations
################################################################################################

#!
DeclareOperation( "Get_image_of_generator",
                  [ IsList, IsHomalgRingElement ] );
#!
DeclareOperation( "Result_of_generator",
                  [ IsList, IsHomalgRingElement, IsList, IsList ] );
#!
DeclareOperation( "Block_matrix_to_matrix",
                  [ IsList ] );
#!
DeclareOperation( "New_matrix_mapping_by_generator_lists",
                  [ IsList, IsList, IsList, IsList, IsHomalgRing ] );


################################################################################################
#! @Section Functions to convert rows and columns (and presentations thereof)
################################################################################################

#! @Description
#! Turn a row R into the corresponding column.
#! @Returns a column
#! @Arguments R
DeclareOperation( "TurnIntoColumn",
                  [ IsCategoryOfRowsObject ] );

#! @Description
#! Turn a column C into the corresponding row.
#! @Returns a row
#! @Arguments C
DeclareOperation( "TurnIntoRow",
                  [ IsCategoryOfColumnsObject ] );

#! @Description
#! Turn a morphism m of rows into the corresponding morphism of columns.
#! @Returns a morphism of columns
#! @Arguments m
DeclareOperation( "TurnIntoColumnMorphism",
                  [ IsCategoryOfRowsMorphism ] );

#! @Description
#! Turn a morphism m of columns into the corresponding morphism of row.
#! @Returns a morphism of rows
#! @Arguments m
DeclareOperation( "TurnIntoRowMorphism",
                  [ IsCategoryOfColumnsMorphism ] );

#! @Description
#! Turn a row presentation P into the corresponding column presentation.
#! @Returns a column presentation
#! @Arguments P
DeclareOperation( "TurnIntoColumnPresentation",
                  [ IsFreydCategoryObject ] );

#! @Description
#! Turn a column presentation P into the corresponding row presentation.
#! @Returns a row presentation
#! @Arguments P
DeclareOperation( "TurnIntoRowPresentation",
                  [ IsFreydCategoryObject ] );

#! @Description
#! Turn a row presentation morphism m into the corresponding column presentation morphism.
#! @Returns a column presentation morphism
#! @Arguments m
DeclareOperation( "TurnIntoColumnPresentationMorphism",
                  [ IsFreydCategoryMorphism ] );

#! @Description
#! Turn a column presentation morphism m into the corresponding row presentation morphism.
#! @Returns a row presentation morphism
#! @Arguments m
DeclareOperation( "TurnIntoRowPresentationMorphism",
                  [ IsFreydCategoryMorphism ] );
