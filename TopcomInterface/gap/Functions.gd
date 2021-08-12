#############################################################################
##
##  Functions.gd          TopcomInterface package
##                                Martin Bies
##
##  Copyright 2021      University of Pennsylvania
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
#! @Returns String
#! @Arguments List1, List2, List3
DeclareOperation( "points2chiro",
                  [ IsList, IsList, IsList ] );

#! @Description
#! Convenience method of the above with List2 = [], List3 = []
#! @Returns String
#! @Arguments List1
DeclareOperation( "points2chiro",
                  [ IsList ] );

#! @Description
#! The first argument is a string encoding the chiro and the
#! second a list encoding an (optional) sample triangulation. 
#! The third argument is a list of strings, consisting of the
#! options supported by topcom.
#! @Returns String
#! @Arguments String, List2, List3
DeclareOperation( "chiro2dual",
                  [ IsString, IsList, IsList ] );

#! @Description
#! Convenience method of the above with List2 = [], List3 = []
#! @Returns String
#! @Arguments String
DeclareOperation( "chiro2dual",
                  [ IsString ] );

#! @Description
#! The first argument is a string encoding the chiro and the
#! second a list encoding an (optional) sample triangulation. 
#! The third argument is a list of strings, consisting of the
#! options supported by topcom.
#! @Returns String
#! @Arguments String, List2, List3
DeclareOperation( "chiro2circuits",
                  [ IsString, IsList, IsList ] );

#! @Description
#! Convenience method of the above with List2 = [], List3 = []
#! @Returns String
#! @Arguments String
DeclareOperation( "chiro2circuits",
                  [ IsString ] );

#! @Description
#! The first argument is a string encoding the chiro and the
#! second a list encoding an (optional) sample triangulation. 
#! The third argument is a list of strings, consisting of the
#! options supported by topcom.
#! @Returns String
#! @Arguments String, List2, List3
DeclareOperation( "chiro2cocircuits",
                  [ IsString, IsList, IsList ] );

#! @Description
#! Convenience method of the above with List2 = [], List3 = []
#! @Returns String
#! @Arguments String
DeclareOperation( "chiro2cocircuits",
                  [ IsString ] );

#! @Description
#! The first argument is a string encoding the chiro and the
#! second a list encoding an (optional) sample triangulation. 
#! The third argument is a list of strings, consisting of the
#! options supported by topcom.
#! @Returns String
#! @Arguments String, List2, List3
DeclareOperation( "cocircuits2facets",
                  [ IsString, IsList, IsList ] );

#! @Description
#! Convenience method of the above with List2 = [], List3 = []
#! @Returns String
#! @Arguments String
DeclareOperation( "cocircuits2facets",
                  [ IsString ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns String
#! @Arguments List1, List2, List3
DeclareOperation( "points2facets",
                  [ IsList, IsList, IsList ] );

#! @Description
#! Convenience method of the above with List2 = [], List3 = []
#! @Returns String
#! @Arguments List1
DeclareOperation( "points2facets",
                  [ IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns Integer
#! @Arguments List1, List2, List3
DeclareOperation( "points2nflips",
                  [ IsList, IsList, IsList ] );

#! @Description
#! Convenience method of the above with List2 = [], List3 = []
#! @Returns Integer
#! @Arguments List1
DeclareOperation( "points2nflips",
                  [ IsList ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns String
#! @Arguments List1, List2, List3
DeclareOperation( "points2flips",
                  [ IsList, IsList, IsList ] );

#! @Description
#! Convenience method of the above with List2 = [], List3 = []
#! @Returns String
#! @Arguments List1
DeclareOperation( "points2flips",
                  [ IsList ] );

#! @Description
#! The first argument is a string encoding the chiro and the
#! second a list encoding an (optional) sample triangulation. 
#! The third argument is a list of strings, consisting of the
#! options supported by topcom.
#! @Returns String
#! @Arguments String, List2, List3
DeclareOperation( "chiro2placingtriang",
                  [ IsString, IsList, IsList ] );

#! @Description
#! Convenience method of the above with List2 = [], List3 = []
#! @Returns String
#! @Arguments String
DeclareOperation( "chiro2placingtriang",
                  [ IsString ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "points2placingtriang",
                  [ IsList, IsList, IsList ] );

#! @Description
#! Convenience method of the above with List2 = [], List3 = []
#! @Returns List
#! @Arguments List1
DeclareOperation( "points2placingtriang",
                  [ IsList ] );

#! @Description
#! The first argument is a string encoding the chiro and the
#! second a list encoding an (optional) sample triangulation. 
#! The third argument is a list of strings, consisting of the
#! options supported by topcom.
#! @Returns String
#! @Arguments String, List2, List3
DeclareOperation( "chiro2finetriang",
                  [ IsString, IsList, IsList ] );

#! @Description
#! Convenience method of the above with List2 = [], List3 = []
#! @Returns String
#! @Arguments String
DeclareOperation( "chiro2finetriang",
                  [ IsString ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "points2finetriang",
                  [ IsList, IsList, IsList ] );

#! @Description
#! Convenience method of the above with List2 = [], List3 = []
#! @Returns List
#! @Arguments List1
DeclareOperation( "points2finetriang",
                  [ IsList ] );

#! @Description
#! The first argument is a string encoding the chiro and the
#! second a list encoding an (optional) sample triangulation. 
#! The third argument is a list of strings, consisting of the
#! options supported by topcom.
#! @Returns String
#! @Arguments String, List2, List3
DeclareOperation( "chiro2triangs",
                  [ IsString, IsList, IsList ] );

#! @Description
#! Convenience method of the above with List2 = [], List3 = []
#! @Returns String
#! @Arguments String
DeclareOperation( "chiro2triangs",
                  [ IsString ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns String
#! @Arguments List1, List2, List3
DeclareOperation( "points2triangs",
                  [ IsList, IsList, IsList ] );

#! @Description
#! Convenience method of the above with List2 = [], List3 = []
#! @Returns String
#! @Arguments List1
DeclareOperation( "points2triangs",
                  [ IsList ] );

#! @Description
#! The first argument is a string encoding the chiro and the
#! second a list encoding an (optional) sample triangulation. 
#! The third argument is a list of strings, consisting of the
#! options supported by topcom.
#! @Returns String
#! @Arguments String, List2, List3
DeclareOperation( "chiro2ntriangs",
                  [ IsString, IsList, IsList ] );

#! @Description
#! Convenience method of the above with List2 = [], List3 = []
#! @Returns String
#! @Arguments String
DeclareOperation( "chiro2ntriangs",
                  [ IsString ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "points2ntriangs",
                  [ IsList, IsList, IsList ] );

#! @Description
#! Convenience method of the above with List2 = [], List3 = []
#! @Returns List
#! @Arguments List1
DeclareOperation( "points2ntriangs",
                  [ IsList ] );

#! @Description
#! The first argument is a string encoding the chiro and the
#! second a list encoding an (optional) sample triangulation. 
#! The third argument is a list of strings, consisting of the
#! options supported by topcom.
#! @Returns String
#! @Arguments String, List2, List3
DeclareOperation( "chiro2finetriangs",
                  [ IsString, IsList, IsList ] );

#! @Description
#! Convenience method of the above with List2 = [], List3 = []
#! @Returns String
#! @Arguments String
DeclareOperation( "chiro2finetriangs",
                  [ IsString ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "points2finetriangs",
                  [ IsList, IsList, IsList ] );

#! @Description
#! Convenience method of the above with List2 = [], List3 = []
#! @Returns List
#! @Arguments List1
DeclareOperation( "points2finetriangs",
                  [ IsList ] );

#! @Description
#! The first argument is a string encoding the chiro and the
#! second a list encoding an (optional) sample triangulation. 
#! The third argument is a list of strings, consisting of the
#! options supported by topcom.
#! @Returns String
#! @Arguments String, List2, List3
DeclareOperation( "chiro2nfinetriangs",
                  [ IsString, IsList, IsList ] );

#! @Description
#! Convenience method of the above with List2 = [], List3 = []
#! @Returns String
#! @Arguments String
DeclareOperation( "chiro2nfinetriangs",
                  [ IsString ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "points2nfinetriangs",
                  [ IsList, IsList, IsList ] );

#! @Description
#! Convenience method of the above with List2 = [], List3 = []
#! @Returns List
#! @Arguments List1
DeclareOperation( "points2nfinetriangs",
                  [ IsList ] );

#! @Description
#! The first argument is a string encoding the chiro and the
#! second a list encoding an (optional) sample triangulation. 
#! The third argument is a list of strings, consisting of the
#! options supported by topcom.
#! @Returns String
#! @Arguments String, List2, List3
DeclareOperation( "chiro2alltriangs",
                  [ IsString, IsList, IsList ] );

#! @Description
#! Convenience method of the above with List2 = [], List3 = []
#! @Returns String
#! @Arguments String
DeclareOperation( "chiro2alltriangs",
                  [ IsString ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "points2alltriangs",
                  [ IsList, IsList, IsList ] );

#! @Description
#! Convenience method of the above with List2 = [], List3 = []
#! @Returns List
#! @Arguments List1
DeclareOperation( "points2alltriangs",
                  [ IsList ] );

#! @Description
#! The first argument is a string encoding the chiro and the
#! second a list encoding an (optional) sample triangulation. 
#! The third argument is a list of strings, consisting of the
#! options supported by topcom.
#! @Returns String
#! @Arguments String, List2, List3
DeclareOperation( "chiro2nalltriangs",
                  [ IsString, IsList, IsList ] );

#! @Description
#! Convenience method of the above with List2 = [], List3 = []
#! @Returns String
#! @Arguments String
DeclareOperation( "chiro2nalltriangs",
                  [ IsString ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "points2nalltriangs",
                  [ IsList, IsList, IsList ] );

#! @Description
#! Convenience method of the above with List2 = [], List3 = []
#! @Returns List
#! @Arguments List1
DeclareOperation( "points2nalltriangs",
                  [ IsList ] );

#! @Description
#! The first argument is a string encoding the chiro and the
#! second a list encoding an (optional) sample triangulation. 
#! The third argument is a list of strings, consisting of the
#! options supported by topcom.
#! @Returns String
#! @Arguments String, List2, List3
DeclareOperation( "chiro2allfinetriangs",
                  [ IsString, IsList, IsList ] );

#! @Description
#! Convenience method of the above with List2 = [], List3 = []
#! @Returns String
#! @Arguments String
DeclareOperation( "chiro2allfinetriangs",
                  [ IsString ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "points2allfinetriangs",
                  [ IsList, IsList, IsList ] );

#! @Description
#! Convenience method of the above with List2 = [], List3 = []
#! @Returns List
#! @Arguments List1
DeclareOperation( "points2allfinetriangs",
                  [ IsList ] );

#! @Description
#! The first argument is a string encoding the chiro and the
#! second a list encoding an (optional) sample triangulation. 
#! The third argument is a list of strings, consisting of the
#! options supported by topcom.
#! @Returns String
#! @Arguments String, List2, List3
DeclareOperation( "chiro2nallfinetriangs",
                  [ IsString, IsList, IsList ] );

#! @Description
#! Convenience method of the above with List2 = [], List3 = []
#! @Returns String
#! @Arguments String
DeclareOperation( "chiro2nallfinetriangs",
                  [ IsString ] );

#! @Description
#! The first two lists are the input required by topcom. The third is a list of strings, consisting
#! of the options supported by topcom.
#! @Returns List
#! @Arguments List1, List2, List3
DeclareOperation( "points2nallfinetriangs",
                  [ IsList, IsList, IsList ] );

#! @Description
#! Convenience method of the above with List2 = [], List3 = []
#! @Returns List
#! @Arguments List1
DeclareOperation( "points2nallfinetriangs",
                  [ IsList ] );
