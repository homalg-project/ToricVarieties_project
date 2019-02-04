#############################################################################
##
##  Functions.gd        TopcomInterface package
##                      Martin Bies
##
##  Copyright 2019      ULB Brussels
##
##  A package to communicate with the software Topcom
##
#! @Chapter Functionality of Topcom
##
#############################################################################



##############################################################################################
##
#! @Section Functions to communicate with Topcom
##
##############################################################################################

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "points2chiro",
                  [ IsList, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "chiro2dual",
                  [ IsString, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "chiro2circuits",
                  [ IsString, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "chiro2cocircuits",
                  [ IsString, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "cocircuits2facets",
                  [ IsList, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "points2facets",
                  [ IsList, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "points2nflips",
                  [ IsList, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "points2flips",
                  [ IsList, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "chiro2placingtriang",
                  [ IsString, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "points2placingtriang",
                  [ IsList, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "chiro2finetriang",
                  [ IsString, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "points2finetriang",
                  [ IsList, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "chiro2triangs",
                  [ IsString, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "points2triangs",
                  [ IsList, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "chiro2ntriangs",
                  [ IsString, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "points2ntriangs",
                  [ IsList, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "chiro2finetriangs",
                  [ IsString, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "points2finetriangs",
                  [ IsList, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "chiro2nfinetriangs",
                  [ IsString, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "points2nfinetriangs",
                  [ IsList, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "chiro2alltriangs",
                  [ IsString, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "points2alltriangs",
                  [ IsList, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "chiro2nalltriangs",
                  [ IsString, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "points2nalltriangs",
                  [ IsList, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "chiro2allfinetriangs",
                  [ IsString, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "points2allfinetriangs",
                  [ IsList, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "chiro2nallfinetriangs",
                  [ IsString, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "points2nallfinetriangs",
                  [ IsList, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "cube",
                  [ IsList, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "cyclic",
                  [ IsList, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "cross",
                  [ IsList, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "hypersimplex",
                  [ IsList, IsList, IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "santos_triang",
                  [ IsList, IsList, IsList ] );
