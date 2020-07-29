################################################################################################
##
##  Subvarieties.gd                    CoherentSheavesOnToricVarieties package
##
##  Copyright 2020                     Martin Bies,       University of Oxford
##
#! @Chapter Subvarieties of toric varieties
##
################################################################################################


##############################################################################################
##
#! @Section GAP category for subvarieties of toric varieties
##
##############################################################################################

#! @Description
#! The GAP category for subvarieties of toric varieties
#! @Returns true or false
#! @Arguments object
DeclareCategory( "IsSubvarietyOfToricVariety",
                 IsObject );


##############################################################################################
##
#! @Section Constructors for subvarieties of toric varieties
##
##############################################################################################

#! @Description
#! The arguments are a toric variety tor and a list L of polynomials. The
#! common zeros of the polynomials in L define a subvariety V of tor.
#! @Returns a subvariety of a toric variety
#! @Arguments tor, L
DeclareOperation( "SubvarietyOfToricVariety",
                  [ IsToricVariety, IsList ] );


##############################################################################################
##
#! @Section Attributes for subvarieties of toric varieties
##
##############################################################################################

#! @Description
#! The argument is a subvarieties S of toric varieties.
#! The output is the ambient toric variety.
#! @Returns a toric variety
#! @Arguments S
DeclareAttribute( "AmbientToricVariety",
                  IsSubvarietyOfToricVariety );

#! @Description
#! The argument is a subvarieties S of toric varieties.
#! The output is the list of its defining equations.
#! @Returns a list
#! @Arguments S
DeclareAttribute( "DefiningEquations",
                  IsSubvarietyOfToricVariety );

#! @Description
#! The argument is a subvarieties S of toric varieties.
#! The output is the left coordinate ring of S.
#! @Returns a ring
#! @Arguments S
DeclareAttribute( "CoordinateRing",
                  IsSubvarietyOfToricVariety );
DeclareAttribute( "CoordinateRing",
                  IsToricVariety );

#! @Description
#! The argument is a subvarieties S of toric varieties.
#! The output is a f.p. graded left module M which sheafifies
#! to the structure sheaf of S.
#! @Returns a coherent sheaf
#! @Arguments S
DeclareAttribute( "StructureSheaf",
                  IsSubvarietyOfToricVariety );
DeclareAttribute( "StructureSheaf",
                  IsToricVariety );


##############################################################################################
##
#! @Section Operations on subvarieties of toric varieties
##
##############################################################################################

#! @Description
#! The argument is a subvarieties S of toric varieties
#! and a list of equations L. We then construct an f.p.
#! graded module over the Cox ring of the toric ambient space
#! of S, which sheafifes to the ideal sheaf on S defined by 
#! the simulatenous vanishing of all polynomials in L.
#! @Returns a coherent sheaf
#! @Arguments S, L
DeclareOperation( "IdealSheafOnSubvariety",
                  [ IsSubvarietyOfToricVariety, IsList ] );
DeclareOperation( "IdealSheafOnSubvariety",
                  [ IsToricVariety, IsList ] );

#! @Description
#! The argument is a subvarieties S of toric varieties
#! and a list of equations L. Let V denote the locus on which
#! all polynomials in L vanish simultaneously. Provided that V
#! is a divisor of S, the inverse of the ideal associated to V
#! does exist. We then construct an f.p. graded module over the Cox ring
#! of the toric ambient space of S, which indeed sheafifes to
#! the inverse of the ideal sheaf associated to V in S.
#! Warning: We do not perform a test to check if V is a divisor of S.
#! @Returns a coherent sheaf
#! @Arguments S, L
DeclareOperation( "InverseOfIdealSheafOnSubvariety",
                  [ IsSubvarietyOfToricVariety, IsList ] );
DeclareOperation( "InverseOfIdealSheafOnSubvariety",
                  [ IsToricVariety, IsList ] );
