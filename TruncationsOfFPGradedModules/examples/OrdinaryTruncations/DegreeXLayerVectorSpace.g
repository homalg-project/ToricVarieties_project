#! @Chapter DegreeXLayerVectorSpaceMorphisms

#! @Section Examples

#! @Subsection DegreeXLayerVectorSpaces

#! @Example
HOMALG_IO.show_banners := false;;
HOMALG_IO.suppress_PID := true;;
mQ := HomalgFieldOfRationals();
#! Q
P1 := ProjectiveSpace( 1 );
#! <A projective toric variety of dimension 1>
cox_ring := CoxRing( P1 );
#! Q[x_1,x_2]
#! (weights: [ 1, 1 ])
mons := MonomsOfCoxRingOfDegreeByNormalizAsColumnMatrices
        ( P1, [1], 1, 1 );;
vector_space := VectorSpaceObject( Length( mons ), mQ );
#! <A vector space object over Q of dimension 2>
DXVS := DegreeXLayerVectorSpace( mons, cox_ring, vector_space, 1 );
#! <A vector space embedded into (Q[x_1,x_2] (with weights [ 1, 1 ]))^1>
EmbeddingDimension( DXVS );
#! 1
Generators( DXVS );
#! [ <A 1 x 1 matrix over a graded ring>, <A 1 x 1 matrix over a graded ring> ]
#! @EndExample

#! @Subsection Morphisms of DegreeXLayerVectorSpaces

#! @Example
mons2 := Concatenation(
         MonomsOfCoxRingOfDegreeByNormalizAsColumnMatrices
         ( P1, [1], 1, 2 ),
         MonomsOfCoxRingOfDegreeByNormalizAsColumnMatrices
         ( P1, [1], 2, 2 ) );;
vector_space2 := VectorSpaceObject( Length( mons2 ), mQ );
#! <A vector space object over Q of dimension 4>
DXVS2 := DegreeXLayerVectorSpace( mons2, cox_ring, vector_space2, 2 );
#! <A vector space embedded into (Q[x_1,x_2] (with weights [ 1, 1 ]))^2>
matrix := HomalgMatrix( [ [ 1, 0, 0, 0 ],
                          [ 0, 1, 0, 0 ] ], mQ );
#! <A matrix over an internal ring>
vector_space_morphism := VectorSpaceMorphism( vector_space,
                                              matrix,
                                              vector_space2 );;
IsWellDefined( vector_space_morphism );
#! true
morDXVS := DegreeXLayerVectorSpaceMorphism( 
           DXVS, vector_space_morphism, DXVS2 );
#! <A morphism of two vector spaces embedded into
#! (suitable powers of) Q[x_1,x_2] (with weights [ 1, 1 ])>
UnderlyingVectorSpaceMorphism( morDXVS );
#! <A morphism in Category of matrices over Q>
UnderlyingHomalgGradedRing( morDXVS );
#! Q[x_1,x_2]
#! (weights: [ 1, 1 ])
#! @EndExample


#! @Subsection DegreeXLayerVectorSpacePresentations

#! @Example
DXVSPresentation := DegreeXLayerVectorSpacePresentation( morDXVS );
#! <A vector space embedded into (a suitable power of)
#! Q[x_1,x_2] (with weights [ 1, 1 ]) given as the
#! cokernel of a vector space morphism>
UnderlyingVectorSpaceObject( DXVSPresentation );
#! <A vector space object over Q of dimension 2>
relation := RelationMorphism( 
            UnderlyingVectorSpacePresentation( DXVSPresentation ) );
#! <A morphism in Category of matrices over Q>
m := UnderlyingMatrix( relation );
#! <A 2 x 4 matrix over an internal ring>
m = matrix;
#! true
#! @EndExample


#! @Subsection Morphisms of DegreeXLayerVectorSpacePresentations

#! @Example
zero_space := ZeroObject( CapCategory( vector_space ) );;
source := DegreeXLayerVectorSpace( [], cox_ring, zero_space, 1 );;
vector_space_morphism := ZeroMorphism( zero_space, vector_space );;
morDXVS2 := DegreeXLayerVectorSpaceMorphism(
            source, vector_space_morphism, DXVS );;
DXVSPresentation2 := DegreeXLayerVectorSpacePresentation( morDXVS2 );
#! <A vector space embedded into (a suitable power of)
#! Q[x_1,x_2] (with weights [ 1, 1 ]) given as the
#! cokernel of a vector space morphism>
matrix := HomalgMatrix( [ [ 0, 0, 1, 0 ],
                          [ 0, 0, 0, 1 ] ], mQ );
#! <A matrix over an internal ring>
source := Range( UnderlyingVectorSpaceMorphism( DXVSPresentation2 ) );;
range := Range( UnderlyingVectorSpaceMorphism( DXVSPresentation ) );;
vector_space_morphism := VectorSpaceMorphism( source, matrix, range );;
IsWellDefined( vector_space_morphism );
#! true
DXVSPresentationMorphism := DegreeXLayerVectorSpacePresentationMorphism(
                                      DXVSPresentation2,
                                      vector_space_morphism,
                                      DXVSPresentation );
#! <A vector space presentation morphism of vector spaces embedded into
#! (a suitable power of) Q[x_1,x_2] (with weights [ 1, 1 ]) and given as
#! cokernels>
uVSMor := UnderlyingVectorSpacePresentationMorphism
                                      ( DXVSPresentationMorphism );
#! <A morphism in Freyd( Category of matrices over Q )>
IsWellDefined( uVSMor );
#! true
#! @EndExample
