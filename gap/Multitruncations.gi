#############################################################################
##
##  Multitruncations.gi     ToricVarieties       Martin Bies
##
##  Copyright 2015- 2016, Sebastian Gutsche, TU Kaiserslautern
##                        Martin Bies,       ITP Heidelberg
##
##  truncations of modules to arbitrary subsemigroups of the classgroup
##
#############################################################################



################################################################################################################
##
## truncations of modules over CoxRing( DirectProduct of PN's ) to the GS-cone (subsemigroup of classgroup)
##
################################################################################################################

# truncation object of a free left module
InstallMethod( TruncationOfFreeModuleOnDirectProductsOfProjectiveSpaces,
               " for toric varieties and a graded module",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep and IsFree and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
  function( variety, module )
    local degrees_of_generators, degrees_of_generators_in_GSCone, embeddingMatrix, i, row, embedding;
    
    # check validity of the input
    if not IsDirectProductOfPNs( variety ) then
    
      Error( "The variety must be a direct product of PN's. \n" );
      return false;
    
    elif not IsIdenticalObj( HomalgRing( module ), CoxRing( variety ) ) then

      Error( "The module is not defined over identically the same ring as the Coxring of the variety. \n" );
      return false;
    
    fi;
    
    # extract the degrees of the generators of the module and turn them into lists of the underlying ring
    degrees_of_generators := DegreesOfGenerators( module );
    degrees_of_generators := List( degrees_of_generators, j -> UnderlyingListOfRingElements( j ) );
    
    # now check which of them satisfy PointContainedInCone( GSCone( variety ), * );
    degrees_of_generators_in_GSCone := [];
    embeddingMatrix := [];
    for i in [ 1 .. Length( degrees_of_generators ) ] do
    
      # check if the degree lies in the GSCone
      if PointContainedInCone( GSCone( variety ), degrees_of_generators[ i ] ) then
      
        row := List( [ 1 .. Rank( module ) ], x -> 0 );
        row[ i ] := 1;
        Add( degrees_of_generators_in_GSCone, degrees_of_generators[ i ] );
        Add( embeddingMatrix, row );
        
      fi;
    
    od;

    # now check if anything has been added to the embeddingMatrix
    # if not, we need to embed the zero module
    if Length( degrees_of_generators_in_GSCone ) = 0 then
    
      embeddingMatrix := HomalgZeroMatrix( 0, Rank( module ), CoxRing( variety ) );
      embedding := GradedMap( embeddingMatrix, 
                              FreeLeftModuleWithDegrees( CoxRing( variety ), degrees_of_generators_in_GSCone ),
                              module
                             );
    
    else
    
      embedding := GradedMap( HomalgMatrix( embeddingMatrix, CoxRing( variety ) ), 
                              FreeLeftModuleWithDegrees( CoxRing( variety ), degrees_of_generators_in_GSCone ),
                              module
                             );

    fi;
                                
    # we know that this is a monomorphism, so
    SetIsMorphism( embedding, true );
    SetIsMonomorphism( embedding, true );
                            
    #return the embedding;
    return ImageObject( embedding );
    
end );

# truncation object of a free right module
InstallMethod( TruncationOfFreeModuleOnDirectProductsOfProjectiveSpaces,
               " for toric varieties and a graded module",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep and IsFree and IsHomalgRightObjectOrMorphismOfRightObjects ],
  function( variety, module )
    local degrees_of_generators, degrees_of_generators_in_GSCone, embeddingMatrix, i, row, embedding;
    
    # check validity of the input
    if not IsDirectProductOfPNs( variety ) then
    
      Error( "The variety must be a direct product of PN's. \n" );
      return false;
    
    elif not IsIdenticalObj( HomalgRing( module ), CoxRing( variety ) ) then

      Error( "The module is not defined over identically the same ring as the Coxring of the variety. \n" );
      return false;
    
    fi;

    # extract the degrees of the generators of the module and turn them into lists of the underlying ring
    degrees_of_generators := DegreesOfGenerators( module );
    degrees_of_generators := List( degrees_of_generators, j -> UnderlyingListOfRingElements( j ) );
    
    # now check which of them satisfy PointContainedInCone( GSCone( variety ), * );
    degrees_of_generators_in_GSCone := [];
    embeddingMatrix := [];
    for i in [ 1 .. Length( degrees_of_generators ) ] do
    
      # check if the degree lies in the GSCone
      if PointContainedInCone( GSCone( variety ), degrees_of_generators[ i ] ) then
      
        row := List( [ 1 .. Rank( module ) ], x -> 0 );
        row[ i ] := 1;
        Add( degrees_of_generators_in_GSCone, degrees_of_generators[ i ] );
        Add( embeddingMatrix, row );
        
      fi;
    
    od;

    # now check if anything has been added to the embeddingMatrix
    # if not, we need to embed the zero module
    if Length( degrees_of_generators_in_GSCone ) = 0 then
    
      embeddingMatrix := HomalgZeroMatrix( Rank( module), 0, CoxRing( variety ) );
      embedding := GradedMap( embeddingMatrix, 
                              FreeRightModuleWithDegrees( CoxRing( variety ), degrees_of_generators_in_GSCone ),
                              module
                             );
    
    else
    
      embedding := GradedMap( HomalgMatrix( TransposedMat( embeddingMatrix ), CoxRing( variety ) ), 
                              FreeRightModuleWithDegrees( CoxRing( variety ), degrees_of_generators_in_GSCone ),
                              module
                             );

    fi;
    
    # we know that this is a monomorphism, so
    SetIsMorphism( embedding, true );
    SetIsMonomorphism( embedding, true );
                            
    #return the embedding;
    return ImageObject( embedding );
    
end );


# embedding of the truncated object of a free left module
InstallMethod( EmbeddingOfTruncationOfFreeModuleOnDirectProductsOfProjectiveSpaces,
               " for toric varieties and a graded module",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep and IsFree and IsHomalgLeftObjectOrMorphismOfLeftObjects],
  function( variety, module )
    local degrees_of_generators, degrees_of_generators_in_GSCone, embeddingMatrix, i, row, embedding;
    
    # check validity of the input
    if not IsDirectProductOfPNs( variety ) then
    
      Error( "The variety must be a direct product of PN's. \n" );
      return false;
    
    elif not IsIdenticalObj( HomalgRing( module ), CoxRing( variety ) ) then

      Error( "The module is not defined over identically the same ring as the Coxring of the variety. \n" );
      return false;
    
    fi;

    # extract the degrees of the generators of the module and turn them into lists of the underlying ring
    degrees_of_generators := DegreesOfGenerators( module );
    degrees_of_generators := List( degrees_of_generators, j -> UnderlyingListOfRingElements( j ) );
    
    # now check which of them satisfy PointContainedInCone( GSCone( variety ), * );
    degrees_of_generators_in_GSCone := [];
    embeddingMatrix := [];
    for i in [ 1 .. Length( degrees_of_generators ) ] do
    
      # check if the degree lies in the GSCone
      if PointContainedInCone( GSCone( variety ), degrees_of_generators[ i ] ) then
      
        row := List( [ 1 .. Rank( module ) ], x -> 0 );
        row[ i ] := 1;
        Add( degrees_of_generators_in_GSCone, degrees_of_generators[ i ] );
        Add( embeddingMatrix, row );
        
      fi;
    
    od;

    # now check if anything has been added to the embeddingMatrix
    # if not, we need to embed the zero module
    if Length( degrees_of_generators_in_GSCone ) = 0 then
    
      embeddingMatrix := HomalgZeroMatrix( 0, Rank( module ), CoxRing( variety ) );
      embedding := GradedMap( embeddingMatrix, 
                              FreeLeftModuleWithDegrees( CoxRing( variety ), degrees_of_generators_in_GSCone ),
                              module
                             );
    
    else
    
      embedding := GradedMap( HomalgMatrix( embeddingMatrix, CoxRing( variety ) ), 
                              FreeLeftModuleWithDegrees( CoxRing( variety ), degrees_of_generators_in_GSCone ),
                              module
                             );

    fi;
                                
    # we know that this is a monomorphism, so
    SetIsMorphism( embedding, true );
    SetIsMonomorphism( embedding, true );
                            
    #return the embedding;
    return embedding;
    
end );


# embedding of the truncated object of a free right module
InstallMethod( EmbeddingOfTruncationOfFreeModuleOnDirectProductsOfProjectiveSpaces,
               " for toric varieties and a graded module",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep and IsFree and IsHomalgRightObjectOrMorphismOfRightObjects],
  function( variety, module )
    local degrees_of_generators, degrees_of_generators_in_GSCone, embeddingMatrix, i, row, embedding;
    
    # check validity of the input
    if not IsDirectProductOfPNs( variety ) then
    
      Error( "The variety must be a direct product of PN's. \n" );
      return false;
    
    elif not IsIdenticalObj( HomalgRing( module ), CoxRing( variety ) ) then

      Error( "The module is not defined over identically the same ring as the Coxring of the variety. \n" );
      return false;
    
    fi;

    # extract the degrees of the generators of the module and turn them into lists of the underlying ring
    degrees_of_generators := DegreesOfGenerators( module );
    degrees_of_generators := List( degrees_of_generators, j -> UnderlyingListOfRingElements( j ) );
    
    # now check which of them satisfy PointContainedInCone( GSCone( variety ), * );
    degrees_of_generators_in_GSCone := [];    
    embeddingMatrix := [ ];
    for i in [ 1 .. Length( degrees_of_generators ) ] do
    
      # check if the degree lies in the GSCone
      if PointContainedInCone( GSCone( variety ), degrees_of_generators[ i ] ) then
      
        row := List( [ 1 .. Rank( module ) ], x -> 0 );
        row[ i ] := 1;
        Add( degrees_of_generators_in_GSCone, degrees_of_generators[ i ] );
        Add( embeddingMatrix, row );
        
      fi;
    
    od;
    
    # now check if anything has been added to the embeddingMatrix
    # if not, we need to embed the zero module
    if Length( degrees_of_generators_in_GSCone ) = 0 then
    
      embeddingMatrix := HomalgZeroMatrix( Rank( module ), 0, CoxRing( variety ) );
      embedding := GradedMap( embeddingMatrix, 
                              FreeRightModuleWithDegrees( CoxRing( variety ), degrees_of_generators_in_GSCone ),
                              module
                             );
    
    else
    
      embedding := GradedMap( HomalgMatrix( TransposedMat( embeddingMatrix ), CoxRing( variety ) ), 
                              FreeRightModuleWithDegrees( CoxRing( variety ), degrees_of_generators_in_GSCone ),
                              module
                             );

    fi;
                            
    # we know that this is a monomorphism, so
    SetIsMorphism( embedding, true );
    SetIsMonomorphism( embedding, true );
                            
    #return the embedding;
    return embedding;
    
end );


# truncated object of a f.p. left or right module
InstallMethod( TruncationOfFPModuleOnDirectProductsOfProjectiveSpaces,
               " for toric varieties and a graded module",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep ],
  function( variety, module )
    local h, range, truncated_range_embedding, embedding_matrix, embedding_map;
    
    # check validity of the input
    if not IsDirectProductOfPNs( variety ) then
    
      Error( "The variety must be a direct product of PN's. \n" );
      return false;
    
    elif not IsIdenticalObj( HomalgRing( module ), CoxRing( variety ) ) then

      Error( "The module is not defined over identically the same ring as the Coxring of the variety. \n" );
      return false;
    
    fi;

    # reduce the module if possible
    ByASmallerPresentation( module );
    
    # check if the module if free and if so, then hand it to the specialised method above
    if IsFree( module ) then
    
      return TruncationOfFreeModuleOnDirectProductsOfProjectiveSpaces( variety, module );
    
    fi;
    
    # we now are now facing the situation of a f.p. module, so first extract a presentation morphism
    if HasSuperObject( module ) then
      
      h := ByASmallerPresentation( PresentationMorphism( Source( EmbeddingInSuperObject( module ) ) ) );

    else

      h := ByASmallerPresentation( PresentationMorphism( module ) );
      
    fi;

    # then truncate the range
    range := Range( h );
    truncated_range_embedding := EmbeddingOfTruncationOfFreeModuleOnDirectProductsOfProjectiveSpaces( variety, range );
    
    # now compute the presentation matrix of the truncation
    embedding_matrix := MatrixOfMap( truncated_range_embedding ) * MatrixOfMap( CokernelEpi( h ) );
    
    # and construct the presentation morphism (differing left and right modules)
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( module ) then
    
      embedding_map := GradedMap( embedding_matrix, Source( truncated_range_embedding ), Cokernel( h ) );

    elif IsHomalgRightObjectOrMorphismOfRightObjects( module ) then
    
      embedding_map := GradedMap( HomalgMatrix( 
                                  TransposedMat( EntriesOfHomalgMatrixAsListList( embedding_matrix ) ), CoxRing( variety ) ), 
                                  Source( truncated_range_embedding ), 
                                  Cokernel( h ) 
                                 );
    
    fi;
    
    # check that the map is well-defined
    if not IsMorphism( embedding_map ) then
    
      Error( "Something went wrong. \n" );
      return false;
    
    fi;
    
    # and return the cokernel
    return ImageObject( embedding_map );

end );


# embedding of truncated object of a f.p. (left or right) module
InstallMethod( EmbeddingOfTruncationOfFPModuleOnDirectProductsOfProjectiveSpaces,
               " for toric varieties and a graded module",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep ],

  function( variety, module )
    local h, range, truncated_range_embedding, embedding_matrix, embedding_map;
    
    # check validity of the input
    if not IsDirectProductOfPNs( variety ) then
    
      Error( "The variety must be a direct product of PN's. \n" );
      return false;
    
    elif not IsIdenticalObj( HomalgRing( module ), CoxRing( variety ) ) then

      Error( "The module is not defined over identically the same ring as the Coxring of the variety. \n" );
      return false;
    
    fi;

    # reduce the module if possible
    ByASmallerPresentation( module );
    
    # check if the module if free and if so, then hand it to the specialised method above
    if IsFree( module ) then
    
      return EmbeddingOfTruncationOfFreeModuleOnDirectProductsOfProjectiveSpaces( variety, module );
    
    fi;
    
    # we now are now facing the situation of a f.p. module, so first extract a presentation morphism
    if HasSuperObject( module ) then
      
      h := ByASmallerPresentation( PresentationMorphism( Source( EmbeddingInSuperObject( module ) ) ) );

    else

      h := ByASmallerPresentation( PresentationMorphism( module ) );
      
    fi;

    # then truncate the range
    range := Range( h );
    truncated_range_embedding := EmbeddingOfTruncationOfFreeModuleOnDirectProductsOfProjectiveSpaces( variety, range );
    
    # now compute the presentation matrix of the truncation
    embedding_matrix := MatrixOfMap( truncated_range_embedding ) * MatrixOfMap( CokernelEpi( h ) );
    
    # and construct the presentation morphism (differing left and right modules)
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( module ) then
    
      embedding_map := GradedMap( embedding_matrix, Source( truncated_range_embedding ), Cokernel( h ) );

    elif IsHomalgRightObjectOrMorphismOfRightObjects( module ) then
    
      embedding_map := GradedMap( HomalgMatrix( 
                                  TransposedMat( EntriesOfHomalgMatrixAsListList( embedding_matrix ) ), CoxRing( variety ) ), 
                                  Source( truncated_range_embedding ), 
                                  Cokernel( h ) 
                                 );
        
    fi;
    
    # check that the map is well-defined
    if not IsMorphism( embedding_map ) then
    
      Error( "Something went wrong. \n" );
      return false;
    
    fi;
    
    # and return the cokernel
    return ImageObjectEmb( embedding_map );
    
end );


# truncation of  a graded module map of f.p. (left or right) modules
InstallMethod( TruncationOfGradedModuleMorphismOnDirectProductsOfProjectiveSpaces,
               " for toric varieties and a graded module",
               [ IsToricVariety, IsHomalgGradedMap ],
  function( variety, map )
    local truncated_source_embedding, truncated_range_embedding;
    
    # check validity of the input
    if not IsDirectProductOfPNs( variety ) then
    
      Error( "The variety must be a direct product of PN's. \n" );
      return false;
    
    fi;
    
    # compute the truncation of source and range of the map
    truncated_source_embedding := EmbeddingOfTruncationOfFPModuleOnDirectProductsOfProjectiveSpaces( variety, Source( map ) );
    # the above line causes problems...
    truncated_range_embedding := EmbeddingOfTruncationOfFPModuleOnDirectProductsOfProjectiveSpaces( variety, Range( map ) );

    # and complete the image square
    return CompleteImageSquare( truncated_source_embedding, map, truncated_range_embedding );
        
end );



################################################################################################################
##
## truncations of modules over CoxRing( toric variety ) to the GS-cone (subsemigroup of classgroup)
##
################################################################################################################

# truncation object of a free left module
InstallMethod( TruncationOfFreeModuleToGSCone,
               " for toric varieties and a graded module",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep and IsFree and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
  function( variety, module )
    local degrees_of_generators, degrees_of_generators_in_GSCone, embeddingMatrix, i, row, embedding;
    
    if not IsIdenticalObj( HomalgRing( module ), CoxRing( variety ) ) then

      Error( "The module is not defined over identically the same ring as the Coxring of the variety. \n" );
      return false;
    
    fi;

    # extract the degrees of the generators of the module and turn them into lists of the underlying ring
    degrees_of_generators := DegreesOfGenerators( module );
    degrees_of_generators := List( degrees_of_generators, j -> UnderlyingListOfRingElements( j ) );
    
    # now check which of them satisfy PointContainedInCone( GSCone( variety ), * );
    degrees_of_generators_in_GSCone := [];
    embeddingMatrix := [];
    for i in [ 1 .. Length( degrees_of_generators ) ] do
    
      # check if the degree lies in the GSCone
      if PointContainedInCone( GSCone( variety ), degrees_of_generators[ i ] ) then
      
        row := List( [ 1 .. Rank( module ) ], x -> 0 );
        row[ i ] := 1;
        Add( degrees_of_generators_in_GSCone, degrees_of_generators[ i ] );
        Add( embeddingMatrix, row );
        
      fi;
    
    od;

    # now check if anything has been added to the embeddingMatrix
    # if not, we need to embed the zero module
    if Length( degrees_of_generators_in_GSCone ) = 0 then
    
      embeddingMatrix := HomalgZeroMatrix( 0, Rank( module ), CoxRing( variety ) );
      embedding := GradedMap( embeddingMatrix, 
                              FreeLeftModuleWithDegrees( CoxRing( variety ), degrees_of_generators_in_GSCone ),
                              module
                             );
    
    else
    
      embedding := GradedMap( HomalgMatrix( embeddingMatrix, CoxRing( variety ) ), 
                              FreeLeftModuleWithDegrees( CoxRing( variety ), degrees_of_generators_in_GSCone ),
                              module
                             );

    fi;
                                
    # we know that this is a monomorphism, so
    SetIsMorphism( embedding, true );
    SetIsMonomorphism( embedding, true );
                            
    #return the embedding;
    return ImageObject( embedding );
    
end );

# truncation object of a free right module
InstallMethod( TruncationOfFreeModuleToGSCone,
               " for toric varieties and a graded module",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep and IsFree and IsHomalgRightObjectOrMorphismOfRightObjects ],
  function( variety, module )
    local degrees_of_generators, degrees_of_generators_in_GSCone, embeddingMatrix, i, row, embedding;
    
    if not IsIdenticalObj( HomalgRing( module ), CoxRing( variety ) ) then

      Error( "The module is not defined over identically the same ring as the Coxring of the variety. \n" );
      return false;
    
    fi;

    # extract the degrees of the generators of the module and turn them into lists of the underlying ring
    degrees_of_generators := DegreesOfGenerators( module );
    degrees_of_generators := List( degrees_of_generators, j -> UnderlyingListOfRingElements( j ) );
    
    # now check which of them satisfy PointContainedInCone( GSCone( variety ), * );
    degrees_of_generators_in_GSCone := [];
    embeddingMatrix := [];
    for i in [ 1 .. Length( degrees_of_generators ) ] do
    
      # check if the degree lies in the GSCone
      if PointContainedInCone( GSCone( variety ), degrees_of_generators[ i ] ) then
      
        row := List( [ 1 .. Rank( module ) ], x -> 0 );
        row[ i ] := 1;
        Add( degrees_of_generators_in_GSCone, degrees_of_generators[ i ] );
        Add( embeddingMatrix, row );
        
      fi;
    
    od;

    # now check if anything has been added to the embeddingMatrix
    # if not, we need to embed the zero module
    if Length( degrees_of_generators_in_GSCone ) = 0 then
    
      embeddingMatrix := HomalgZeroMatrix( Rank( module), 0, CoxRing( variety ) );
      embedding := GradedMap( embeddingMatrix, 
                              FreeRightModuleWithDegrees( CoxRing( variety ), degrees_of_generators_in_GSCone ),
                              module
                             );
    
    else
    
      embedding := GradedMap( HomalgMatrix( TransposedMat( embeddingMatrix ), CoxRing( variety ) ), 
                              FreeRightModuleWithDegrees( CoxRing( variety ), degrees_of_generators_in_GSCone ),
                              module
                             );

    fi;
    
    # we know that this is a monomorphism, so
    SetIsMorphism( embedding, true );
    SetIsMonomorphism( embedding, true );
                            
    #return the embedding;
    return ImageObject( embedding );
    
end );


# embedding of the truncated object of a free left module
InstallMethod( EmbeddingOfTruncationOfFreeModuleToGSCone,
               " for toric varieties and a graded module",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep and IsFree and IsHomalgLeftObjectOrMorphismOfLeftObjects],
  function( variety, module )
    local degrees_of_generators, degrees_of_generators_in_GSCone, embeddingMatrix, i, row, embedding;
    
    # check validity of the input
    if not IsIdenticalObj( HomalgRing( module ), CoxRing( variety ) ) then

      Error( "The module is not defined over identically the same ring as the Coxring of the variety. \n" );
      return false;
    
    fi;

    # extract the degrees of the generators of the module and turn them into lists of the underlying ring
    degrees_of_generators := DegreesOfGenerators( module );
    degrees_of_generators := List( degrees_of_generators, j -> UnderlyingListOfRingElements( j ) );
    
    # now check which of them satisfy PointContainedInCone( GSCone( variety ), * );
    degrees_of_generators_in_GSCone := [];
    embeddingMatrix := [];
    for i in [ 1 .. Length( degrees_of_generators ) ] do
    
      # check if the degree lies in the GSCone
      if PointContainedInCone( GSCone( variety ), degrees_of_generators[ i ] ) then
      
        row := List( [ 1 .. Rank( module ) ], x -> 0 );
        row[ i ] := 1;
        Add( degrees_of_generators_in_GSCone, degrees_of_generators[ i ] );
        Add( embeddingMatrix, row );
        
      fi;
    
    od;

    # now check if anything has been added to the embeddingMatrix
    # if not, we need to embed the zero module
    if Length( degrees_of_generators_in_GSCone ) = 0 then
    
      embeddingMatrix := HomalgZeroMatrix( 0, Rank( module ), CoxRing( variety ) );
      embedding := GradedMap( embeddingMatrix, 
                              FreeLeftModuleWithDegrees( CoxRing( variety ), degrees_of_generators_in_GSCone ),
                              module
                             );
    
    else
    
      embedding := GradedMap( HomalgMatrix( embeddingMatrix, CoxRing( variety ) ), 
                              FreeLeftModuleWithDegrees( CoxRing( variety ), degrees_of_generators_in_GSCone ),
                              module
                             );

    fi;
                                
    # we know that this is a monomorphism, so
    SetIsMorphism( embedding, true );
    SetIsMonomorphism( embedding, true );
                            
    #return the embedding;
    return embedding;
    
end );


# embedding of the truncated object of a free right module
InstallMethod( EmbeddingOfTruncationOfFreeModuleToGSCone,
               " for toric varieties and a graded module",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep and IsFree and IsHomalgRightObjectOrMorphismOfRightObjects],
  function( variety, module )
    local degrees_of_generators, degrees_of_generators_in_GSCone, embeddingMatrix, i, row, embedding;
    
    # check validity of the input
    if not IsIdenticalObj( HomalgRing( module ), CoxRing( variety ) ) then

      Error( "The module is not defined over identically the same ring as the Coxring of the variety. \n" );
      return false;
    
    fi;

    # extract the degrees of the generators of the module and turn them into lists of the underlying ring
    degrees_of_generators := DegreesOfGenerators( module );
    degrees_of_generators := List( degrees_of_generators, j -> UnderlyingListOfRingElements( j ) );
    
    # now check which of them satisfy PointContainedInCone( GSCone( variety ), * );
    degrees_of_generators_in_GSCone := [];    
    embeddingMatrix := [ ];
    for i in [ 1 .. Length( degrees_of_generators ) ] do
    
      # check if the degree lies in the GSCone
      if PointContainedInCone( GSCone( variety ), degrees_of_generators[ i ] ) then
      
        row := List( [ 1 .. Rank( module ) ], x -> 0 );
        row[ i ] := 1;
        Add( degrees_of_generators_in_GSCone, degrees_of_generators[ i ] );
        Add( embeddingMatrix, row );
        
      fi;
    
    od;
    
    # now check if anything has been added to the embeddingMatrix
    # if not, we need to embed the zero module
    if Length( degrees_of_generators_in_GSCone ) = 0 then
    
      embeddingMatrix := HomalgZeroMatrix( Rank( module ), 0, CoxRing( variety ) );
      embedding := GradedMap( embeddingMatrix, 
                              FreeRightModuleWithDegrees( CoxRing( variety ), degrees_of_generators_in_GSCone ),
                              module
                             );
    
    else
    
      embedding := GradedMap( HomalgMatrix( TransposedMat( embeddingMatrix ), CoxRing( variety ) ), 
                              FreeRightModuleWithDegrees( CoxRing( variety ), degrees_of_generators_in_GSCone ),
                              module
                             );

    fi;
                            
    # we know that this is a monomorphism, so
    SetIsMorphism( embedding, true );
    SetIsMonomorphism( embedding, true );
                            
    #return the embedding;
    return embedding;
    
end );


# truncated object of a f.p. left or right module
InstallMethod( TruncationOfFPModuleToGSCone,
               " for toric varieties and a graded module",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep ],
  function( variety, module )
    local h, range, truncated_range_embedding, embedding_matrix, embedding_map;
    
    # check validity of the input
    if not IsIdenticalObj( HomalgRing( module ), CoxRing( variety ) ) then

      Error( "The module is not defined over identically the same ring as the Coxring of the variety. \n" );
      return false;
    
    fi;

    # reduce the module if possible
    ByASmallerPresentation( module );
    
    # check if the module if free and if so, then hand it to the specialised method above
    if IsFree( module ) then
    
      return TruncationOfFreeModuleOnDirectProductsOfProjectiveSpaces( variety, module );
    
    fi;
    
    # we now are now facing the situation of a f.p. module, so first extract a presentation morphism
    if HasSuperObject( module ) then
      
      h := ByASmallerPresentation( PresentationMorphism( Source( EmbeddingInSuperObject( module ) ) ) );

    else

      h := ByASmallerPresentation( PresentationMorphism( module ) );
      
    fi;

    # then truncate the range
    range := Range( h );
    truncated_range_embedding := EmbeddingOfTruncationOfFreeModuleOnDirectProductsOfProjectiveSpaces( variety, range );
    
    # now compute the presentation matrix of the truncation
    embedding_matrix := MatrixOfMap( truncated_range_embedding ) * MatrixOfMap( CokernelEpi( h ) );
    
    # and construct the presentation morphism (differing left and right modules)
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( module ) then
    
      embedding_map := GradedMap( embedding_matrix, Source( truncated_range_embedding ), Cokernel( h ) );

    elif IsHomalgRightObjectOrMorphismOfRightObjects( module ) then
    
      embedding_map := GradedMap( HomalgMatrix( 
                                  TransposedMat( EntriesOfHomalgMatrixAsListList( embedding_matrix ) ), CoxRing( variety ) ), 
                                  Source( truncated_range_embedding ), 
                                  Cokernel( h ) 
                                 );
    
    fi;
    
    # check that the map is well-defined
    if not IsMorphism( embedding_map ) then
    
      Error( "Something went wrong. \n" );
      return false;
    
    fi;
    
    # and return the cokernel
    return ImageObject( embedding_map );

end );


# embedding of truncated object of a f.p. (left or right) module
InstallMethod( EmbeddingOfTruncationOfFPModuleToGSCone,
               " for toric varieties and a graded module",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep ],

  function( variety, module )
    local h, range, truncated_range_embedding, embedding_matrix, embedding_map;
    
    # check validity of the input
    if not IsIdenticalObj( HomalgRing( module ), CoxRing( variety ) ) then

      Error( "The module is not defined over identically the same ring as the Coxring of the variety. \n" );
      return false;
    
    fi;

    # reduce the module if possible
    ByASmallerPresentation( module );
    
    # check if the module if free and if so, then hand it to the specialised method above
    if IsFree( module ) then
    
      return EmbeddingOfTruncationOfFreeModuleOnDirectProductsOfProjectiveSpaces( variety, module );
    
    fi;
    
    # we now are now facing the situation of a f.p. module, so first extract a presentation morphism
    if HasSuperObject( module ) then
      
      h := ByASmallerPresentation( PresentationMorphism( Source( EmbeddingInSuperObject( module ) ) ) );

    else

      h := ByASmallerPresentation( PresentationMorphism( module ) );
      
    fi;

    # then truncate the range
    range := Range( h );
    truncated_range_embedding := EmbeddingOfTruncationOfFreeModuleOnDirectProductsOfProjectiveSpaces( variety, range );
    
    # now compute the presentation matrix of the truncation
    embedding_matrix := MatrixOfMap( truncated_range_embedding ) * MatrixOfMap( CokernelEpi( h ) );
    
    # and construct the presentation morphism (differing left and right modules)
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( module ) then
    
      embedding_map := GradedMap( embedding_matrix, Source( truncated_range_embedding ), Cokernel( h ) );

    elif IsHomalgRightObjectOrMorphismOfRightObjects( module ) then
    
      embedding_map := GradedMap( HomalgMatrix( 
                                  TransposedMat( EntriesOfHomalgMatrixAsListList( embedding_matrix ) ), CoxRing( variety ) ), 
                                  Source( truncated_range_embedding ), 
                                  Cokernel( h ) 
                                 );
        
    fi;
    
    # check that the map is well-defined
    if not IsMorphism( embedding_map ) then
    
      Error( "Something went wrong. \n" );
      return false;
    
    fi;
    
    # and return the cokernel
    return ImageObjectEmb( embedding_map );
    
end );


# truncation of  a graded module map of f.p. (left or right) modules
InstallMethod( TruncationOfGradedModuleMorphismToGSCone,
               " for toric varieties and a graded module",
               [ IsToricVariety, IsHomalgGradedMap ],
  function( variety, map )
    local truncated_source_embedding, truncated_range_embedding;
    
    # compute the truncation of source and range of the map
    truncated_source_embedding := EmbeddingOfTruncationOfFPModuleOnDirectProductsOfProjectiveSpaces( variety, Source( map ) );
    # the above line causes problems...
    truncated_range_embedding := EmbeddingOfTruncationOfFPModuleOnDirectProductsOfProjectiveSpaces( variety, Range( map ) );

    # and complete the image square
    return CompleteImageSquare( truncated_source_embedding, map, truncated_range_embedding );
        
end );