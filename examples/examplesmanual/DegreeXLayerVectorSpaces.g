#! @Chapter Truncations of Sfpgrmod to single degrees

#! @Section DegreeXLayerVectorSpaces: Examples 

#! @Subsection DegreeXLayerVectorSpaces of graded projective modules (and their morphisms) on P1xP1

LoadPackage( "ToricVarieties" );

#! @Example
P1 := ProjectiveSpace( 1 );
#! <A projective toric variety of dimension 1>
P1xP1 := P1*P1;
#! <A projective toric variety of dimension 2 which is a 
#! product of 2 toric varieties>
ByASmallerPresentation( ClassGroup( P1xP1 ) );
#! <A free left module of rank 2 on free generators>
S := CoxRing( P1xP1 );
#! Q[x_1,x_2,x_3,x_4]
#! (weights: [ ( 1, 0 ), ( 1, 0 ), ( 0, 1 ), ( 0, 1 ) ])
sourceL := CAPCategoryOfProjectiveGradedLeftModulesObject( 
           [[[0,0],1]], S );
#! <A projective graded left module of rank 1>
rangeL := CAPCategoryOfProjectiveGradedLeftModulesObject( 
          [[[-1,0],1]], S );
#! <A projective graded left module of rank 1>
rangeL2 := CAPCategoryOfProjectiveGradedLeftModulesObject( 
           [[[-1,0],2]], S );
#! <A projective graded left module of rank 2>
mappingL := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
            sourceL, HomalgMatrix( [[ "x_1" ]], S ), rangeL );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
mappingL2 := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
             sourceL, HomalgMatrix( [[ "x_1", "x_2" ]], S ), rangeL2 );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
res1L := DegreeXLayerOfProjectiveGradedLeftOrRightModule( P1xP1, sourceL, [0,0] );
#! <A vector space embedded into (Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]))^1>
Length( Generators( res1L ) );
#! 1
res2L := DegreeXLayerOfProjectiveGradedLeftOrRightModule( P1xP1, sourceL, [1,2] );
#! <A vector space embedded into (Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]))^1>
Length( Generators( res2L ) );
#! 6
res3L := DegreeXLayerOfProjectiveGradedLeftOrRightModule( P1xP1, rangeL, [0,0] );
#! <A vector space embedded into (Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]))^1>
Length( Generators( res3L ) );
#! 2
res4L := DegreeXLayerOfProjectiveGradedLeftOrRightModule( P1xP1, rangeL, [1,2] );
#! <A vector space embedded into (Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]))^1>
Length( Generators( res4L ) );
#! 9
res5L := DegreeXLayerOfProjectiveGradedLeftOrRightModule( P1xP1, rangeL2, [0,0] );
#! <A vector space embedded into (Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]))^2>
Length( Generators( res5L ) );
#! 4
res6L := DegreeXLayerOfProjectiveGradedLeftOrRightModule( P1xP1, rangeL2, [1,2] );
#! <A vector space embedded into (Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]))^2>
Length( Generators( res6L ) );
#! 18
mor1L := UnderlyingVectorSpaceMorphism( 
         DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism( P1xP1, mappingL, [ 0,0 ], true ) );
#! Starting the matrix computation now... 
#!
#! NrRows: 2
#! NrColumns: 1
#! Have to go until i = 1
#! 100% done...
#! matrix created... 
#! <A morphism in Category of matrices over Q>
CokernelObject( mor1L );
#! <A vector space object over Q of dimension 1>
mor2L := UnderlyingVectorSpaceMorphism( 
         DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism( P1xP1, mappingL, [ 1,0 ], true ) );
#! Starting the matrix computation now... 
#!
#! NrRows: 3
#! NrColumns: 2
#! Have to go until i = 2
#! 50% done...
#! 100% done...
#! matrix created...
#! <A morphism in Category of matrices over Q>
CokernelObject( mor2L );
#! <A vector space object over Q of dimension 1>
mor3L := UnderlyingVectorSpaceMorphism(
         DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism( P1xP1, mappingL, [ 1,2 ], true ) );
#! Starting the matrix computation now... 
#!
#! NrRows: 9
#! NrColumns: 6
#! Have to go until i = 6
#! 10% done...
#! 30% done...
#! 50% done...
#! 60% done...
#! 80% done...
#! 100% done...
#! matrix created... 
#! <A morphism in Category of matrices over Q>
CokernelObject( mor3L );
#! <A vector space object over Q of dimension 3>
mor4L := UnderlyingVectorSpaceMorphism( 
         DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism( P1xP1, mappingL2, [ 0,0 ], true ) );
#! Starting the matrix computation now... 
#!
#! NrRows: 4
#! NrColumns: 1
#! Have to go until i = 1
#! 100% done...
#! matrix created... 
#! <A morphism in Category of matrices over Q>
CokernelObject( mor4L );
#! <A vector space object over Q of dimension 3>
mor5L := UnderlyingVectorSpaceMorphism( 
         DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism( P1xP1, mappingL2, [ 1,0 ], true ) );
#! Starting the matrix computation now... 
#!
#! NrRows: 6
#! NrColumns: 2
#! Have to go until i = 2
#! 50% done...
#! 100% done...
#! matrix created... 
#! <A morphism in Category of matrices over Q>
CokernelObject( mor5L );
#! <A vector space object over Q of dimension 4>
mor6L := UnderlyingVectorSpaceMorphism( 
         DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism( P1xP1, mappingL2, [ 1,2 ], true ) );
#! Starting the matrix computation now... 
#!
#! NrRows: 18
#! NrColumns: 6
#! Have to go until i = 6
#! 10% done...
#! 30% done...
#! 50% done...
#! 60% done...
#! 80% done...
#! 100% done...
#! matrix created... 
#! <A morphism in Category of matrices over Q>
CokernelObject( mor6L );
#! <A vector space object over Q of dimension 12>
sourceR := CAPCategoryOfProjectiveGradedRightModulesObject( [[[0,0],1]], S );
#! <A projective graded right module of rank 1>
rangeR := CAPCategoryOfProjectiveGradedRightModulesObject( [[[-1,0],1]], S );
#! <A projective graded right module of rank 1>
rangeR2 := CAPCategoryOfProjectiveGradedRightModulesObject( [[[-1,0],2]], S );
#! <A projective graded right module of rank 2>
mappingR := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( sourceR, HomalgMatrix( [[ "x_1" ]], S ), rangeR );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
mappingR2 := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( sourceR, HomalgMatrix( [[ "x_1"],[ "x_2" ]], S ), rangeR2 );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
res1R := DegreeXLayerOfProjectiveGradedLeftOrRightModule( P1xP1, sourceL, [0,0] );
#! <A vector space embedded into (Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]))^1>
Length( Generators( res1R ) );
#! 1
res2R := DegreeXLayerOfProjectiveGradedLeftOrRightModule( P1xP1, sourceL, [1,2] );
#! <A vector space embedded into (Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]))^1>
Length( Generators( res2R ) );
#! 6
res3R := DegreeXLayerOfProjectiveGradedLeftOrRightModule( P1xP1, rangeL, [0,0] );
#! <A vector space embedded into (Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]))^1>
Length( Generators( res3R ) );
#! 2
res4R := DegreeXLayerOfProjectiveGradedLeftOrRightModule( P1xP1, rangeL, [1,2] );
#! <A vector space embedded into (Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]))^1>
Length( Generators( res4R ) );
#! 9
res5R := DegreeXLayerOfProjectiveGradedLeftOrRightModule( P1xP1, rangeL2, [0,0] );
#! <A vector space embedded into (Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]))^2>
Length( Generators( res5R ) );
#! 4
res6R := DegreeXLayerOfProjectiveGradedLeftOrRightModule( P1xP1, rangeL2, [1,2] );
#! <A vector space embedded into (Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]))^2>
Length( Generators( res6R ) );
#! 18
mor1R := UnderlyingVectorSpaceMorphism( 
         DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism( P1xP1, mappingL, [ 0,0 ], true ) );
#! Starting the matrix computation now... 
#!
#! NrRows: 2
#! NrColumns: 1
#! Have to go until i = 1
#! 100% done...
#! matrix created... 
#! <A morphism in Category of matrices over Q>
CokernelObject( mor1R );
#! <A vector space object over Q of dimension 1>
mor2R := UnderlyingVectorSpaceMorphism( 
         DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism( P1xP1, mappingL, [ 1,0 ], true ) );
#! Starting the matrix computation now... 
#!
#! NrRows: 3
#! NrColumns: 2
#! Have to go until i = 2
#! 50% done...
#! 100% done...
#! matrix created... 
#! <A morphism in Category of matrices over Q>
CokernelObject( mor2R );
#! <A vector space object over Q of dimension 1>
mor3R := UnderlyingVectorSpaceMorphism( 
         DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism( P1xP1, mappingL, [ 1,2 ], true ) );
#! Starting the matrix computation now... 
#!
#! NrRows: 9
#! NrColumns: 6
#! Have to go until i = 6
#! 10% done...
#! 30% done...
#! 50% done...
#! 60% done...
#! 80% done...
#! 100% done...
#! matrix created... 
#! <A morphism in Category of matrices over Q>
CokernelObject( mor3R );
#! <A vector space object over Q of dimension 3>
mor4R := UnderlyingVectorSpaceMorphism( 
         DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism( P1xP1, mappingL2, [ 0,0 ], true ) );
#! Starting the matrix computation now... 
#!
#! NrRows: 4
#! NrColumns: 1
#! Have to go until i = 1
#! 100% done...
#! matrix created... 
#! <A morphism in Category of matrices over Q>
CokernelObject( mor4R );
#! <A vector space object over Q of dimension 3>
mor5R := UnderlyingVectorSpaceMorphism( 
         DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism( P1xP1, mappingL2, [ 1,0 ], true ) );
#! Starting the matrix computation now... 
#!
#! NrRows: 6
#! NrColumns: 2
#! Have to go until i = 2
#! 50% done...
#! 100% done...
#! matrix created... 
#! <A morphism in Category of matrices over Q>
CokernelObject( mor5R );
#! <A vector space object over Q of dimension 4>
mor6R := UnderlyingVectorSpaceMorphism( 
         DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism( P1xP1, mappingL2, [ 1,2 ], true ) );
#! Starting the matrix computation now... 
#!
#! NrRows: 18
#! NrColumns: 6
#! Have to go until i = 6
#! 10% done...
#! 30% done...
#! 50% done...
#! 60% done...
#! 80% done...
#! 100% done...
#! matrix created... 
#! <A morphism in Category of matrices over Q>
CokernelObject( mor6R );
#! <A vector space object over Q of dimension 12>

#! @EndExample



#! @Subsection DegreeXLayerVectorSpaces of f.p. graded modules (and their morphisms) on P1xP1

#! @Example
obj1L := CAPPresentationCategoryObject( mappingL );
#! <A graded left module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
deg1L := DegreeXLayerOfGradedLeftOrRightModulePresentation( P1xP1, obj1L, [ 0,0 ], true );
#! Starting the matrix computation now... 
#!
#! NrRows: 2
#! NrColumns: 1
#! Have to go until i = 1
#! 100% done...
#! matrix created... 
#! <A vector space embedded into (a suitable power of) Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) given as the 
#! cokernel of a vector space morphism>
IsEqualForMorphisms( UnderlyingVectorSpaceMorphism( deg1L ), mor1L );
#! true
UnderlyingVectorSpaceObject( deg1L );
#! <A vector space object over Q of dimension 1>
obj2L := CAPPresentationCategoryObject( mappingL2 );
#! <A graded left module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
deg2L := DegreeXLayerOfGradedLeftOrRightModulePresentation( P1xP1, obj2L, [ 3,4 ], true );
#! Starting the matrix computation now... 
#!
#! NrRows: 50
#! NrColumns: 20
#! Have to go until i = 20
#! 0% done...
#! 10% done...
#! 20% done...
#! 30% done...
#! 40% done...
#! 50% done...
#! 60% done...
#! 70% done...
#! 80% done...
#! 90% done...
#! 100% done...
#! matrix created... 
#! <A vector space embedded into (a suitable power of) Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) given as the
#! cokernel of a vector space morphism>
IsMonomorphism( UnderlyingVectorSpaceMorphism( deg2L ) );
#! true
IsEpimorphism( UnderlyingVectorSpaceMorphism( deg2L ) );
#! false
UnderlyingVectorSpaceObject( deg2L );
#! <A vector space object over Q of dimension 30>
mappingL3 := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
             rangeL, HomalgMatrix( [ [ 1,1 ]], S ), rangeL2 );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
mappingL4 := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
             sourceL, HomalgMatrix( [ [ "x_1", "x_1" ]], S ), rangeL2 );
#! <A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
presentation_morphismL := CAPPresentationCategoryMorphism( 
                          CAPPresentationCategoryObject( mappingL ), mappingL3, 
                          CAPPresentationCategoryObject( mappingL4 ) );
#! <A morphism of graded left module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
deg3L := DegreeXLayerOfGradedLeftOrRightModulePresentationMorphism( 
         P1xP1, presentation_morphismL, [ 0,0 ], true );
#! Starting the matrix computation now... 
#!
#! NrRows: 2
#! NrColumns: 1
#! Have to go until i = 1
#! 100% done...
#! matrix created... 
#! Starting the matrix computation now... 
#!
#! NrRows: 4
#! NrColumns: 2
#! Have to go until i = 2
#! 50% done...
#! 100% done...
#! matrix created... 
#! Starting the matrix computation now... 
#!
#! NrRows: 4
#! NrColumns: 1
#! Have to go until i = 1
#! 100% done...
#! matrix created... 
#! <A vector space presentation morphism of vector spaces embedded into (
#! a suitable power of) Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1,0 ], [ 0, 1 ], [ 0, 1 ] ]) and given as cokernels>
vec3L := UnderlyingVectorSpacePresentationMorphism( deg3L );
#! <A morphism of the presentation category over the Category of matrices 
#! over Q>
IsMonomorphism( vec3L );
#! true
IsEpimorphism( vec3L );
#! false
ckL := CokernelObject( vec3L );
#! <An object of the presentation category over the Category of matrices over Q>
CokernelObject( UnderlyingMorphism( ckL ) );
#! <A vector space object over Q of dimension 2>
obj1R := CAPPresentationCategoryObject( mappingR );
#! <A graded right module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
deg1R := DegreeXLayerOfGradedLeftOrRightModulePresentation( P1xP1, obj1R, [ 0,0 ], true );
#! Starting the matrix computation now... 
#!
#! NrRows: 2
#! NrColumns: 1
#! Have to go until i = 1
#! 100% done...
#! matrix created... 
#! <A vector space embedded into (a suitable power of) Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) given as the
#! cokernel of a vector space morphism>
IsEqualForMorphisms( UnderlyingVectorSpaceMorphism( deg1R ), mor1R );
#! true
UnderlyingVectorSpaceObject( deg1R );
#! <A vector space object over Q of dimension 1>
obj2R := CAPPresentationCategoryObject( mappingR2 );
#! <A graded right module presentation over the ring Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
deg2R := DegreeXLayerOfGradedLeftOrRightModulePresentation( P1xP1, obj2R, [ 3,4 ], true );
#! Starting the matrix computation now... 
#!
#! NrRows: 50
#! NrColumns: 20
#! Have to go until i = 20
#! 0% done...
#! 10% done...
#! 20% done...
#! 30% done...
#! 40% done...
#! 50% done...
#! 60% done...
#! 70% done...
#! 80% done...
#! 90% done...
#! 100% done...
#! matrix created... 
#! <A vector space embedded into (a suitable power of) Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) given as the 
#! cokernel of a vector space morphism>
IsMonomorphism( UnderlyingVectorSpaceMorphism( deg2R ) );
#! true
IsEpimorphism( UnderlyingVectorSpaceMorphism( deg2R ) );
#! false
UnderlyingVectorSpaceObject( deg2R );
#! <A vector space object over Q of dimension 30>
mappingR3 := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
             rangeR, HomalgMatrix( [ [ 1 ], [ 1 ]], S ), rangeR2 );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
mappingR4 := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
             sourceR, HomalgMatrix( [ [ "x_1" ], [ "x_1" ]], S ), rangeR2 );
#! <A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
presentation_morphismR := CAPPresentationCategoryMorphism( 
                          CAPPresentationCategoryObject( mappingR ), mappingR3, 
                          CAPPresentationCategoryObject( mappingR4 ) );
#! <A morphism of graded right module presentations over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
deg3R := DegreeXLayerOfGradedLeftOrRightModulePresentationMorphism( 
         P1xP1, presentation_morphismR, [ 0,0 ], true );
#! Starting the matrix computation now... 
#!
#! NrRows: 2
#! NrColumns: 1
#! Have to go until i = 1
#! 100% done...
#! matrix created... 
#! Starting the matrix computation now... 
#!
#! NrRows: 4
#! NrColumns: 2
#! Have to go until i = 2
#! 50% done...
#! 100% done...
#! matrix created... 
#! Starting the matrix computation now... 
#!
#! NrRows: 4
#! NrColumns: 1
#! Have to go until i = 1
#! 100% done...
#! matrix created... 
#! <A vector space presentation morphism of vector spaces embedded into (
#! a suitable power of) Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1,0 ], [ 0, 1 ], [ 0, 1 ] ]) and given as cokernels>
vec3R := UnderlyingVectorSpacePresentationMorphism( deg3R );
#! <A morphism of the presentation category over the Category of matrices 
#!  over Q>
IsMonomorphism( vec3R );
#! true
IsEpimorphism( vec3R );
#! false
ckR := CokernelObject( vec3R );
#! <An object of the presentation category over the Category of matrices over Q>
CokernelObject( UnderlyingMorphism( ckR ) );
#! <A vector space object over Q of dimension 2>

#! @EndExample
