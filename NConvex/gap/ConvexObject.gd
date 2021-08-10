# SPDX-License-Identifier: GPL-2.0-or-later
# NConvex: A Gap package to perform polyhedral computations
#
# Declarations
#



# This field will be used whenever a rationals field is needed in the package.
DeclareGlobalVariable( "HOMALG_RATIONALS" );
InstallValue( HOMALG_RATIONALS, HomalgFieldOfRationals(  ) );

DeclareCategory( "IsConvexObject", 
                 IsAttributeStoringRep );


DeclareRepresentation( "IsExternalConvexObjectRep",
                      IsConvexObject and IsAttributeStoringRep,
                      [ ]
                     );

DeclareRepresentation( "IsInternalConvexObjectRep",
                      IsConvexObject and IsAttributeStoringRep,
                      [ ]
                     );

#! @Chapter Introduction
#! The $\textbf{NConvex}$ package is a GAP package. Its aim is to carry out polyhedral constructions and computations, namely computing properties and attributes of cones, polyhedrons, polytopes and fans.
#! Its has been written to provide the needed tools for the package \textbf{ToricVarieties}. All written as part of the homalg-project.
#! 
#! @Section Installation
#! @BeginLatexOnly
#! The package can easily be obtained by cloning the repository
#! \begin{center}
#!  \url{https://github.com/homalg-project/NConvex.git}
#! \end{center}
#! in the pkg directory of the Gap installation or your local directory for Gap packages.
#! @EndLatexOnly
#!
#! @Section Requirements
#! Here is a list of the required Gap packages:
#! @BeginLatexOnly
#! \begin{itemize}
#! \item The Gap package \textbf{AutoDoc} is required to create the documentation and to perform tests.
#! A fresh version can be installed from
#! \begin{center}
#!  \url{https://github.com/gap-packages/AutoDoc.git}
#! \end{center}
#! \item The Gap package \textbf{CddInterface} is required to convert between H-rep and V-rep of polyhedrons. 
#! It can be obtained at:
#! \begin{center}
#!  \url{https://github.com/homalg-project/CddInterface.git}
#! \end{center}
#! \item The Gap/homalg-project package \textbf{Modules}. 
#! You can install the package by cloning the \textbf{homalg\textunderscore project} repository from
#! \begin{center}
#!  \url{https://github.com/homalg-project/homalg_project.git}
#! \end{center}
#! \item The Gap package \textbf{NormalizInterface}. You can install it from
#! \begin{center}
#!  \url{https://github.com/gap-packages/NormalizInterface.git}
#! \end{center}
#! \item In case \textbf{NormalizInterface} is not available, 
#! then you can use the Gap/homalg package \textbf{4ti2Interface}.
#! It is already included in the \textbf{homalg\textunderscore project}.
#! Make sure to accordingly change the dependencies entry in PackageInfo.g
#! \end{itemize}
#! @EndLatexOnly

##############################
##
## Attributes
##
##############################

#! @Chapter Convex objects
#! @Section Attributes

##
#! @Arguments obj 
#! @Returns integer
#! @Description  
#! Returns the dimension of the ambient space, i.e., the space that contains the convex object.
DeclareAttribute( "AmbientSpaceDimension",
                  IsConvexObject );
                  
                  
DeclareAttribute( "ContainingGrid",
                  IsConvexObject );

#! @Arguments obj 
#! @Returns integer
#! @Description  
#! Returns the dimension of the covex object.
DeclareAttribute( "Dimension",
                  IsConvexObject );

#! @Arguments obj 
#! @Returns boolian
#! @Description  
#! Returns whether the convex object is full dimensional or not.
DeclareProperty( "IsFullDimensional",
                 IsConvexObject );

#! @Arguments obj
#! @Returns a point in the object
#! @Description  
#! Returns an interior point of the covex object.
DeclareAttribute( "InteriorPoint", IsConvexObject );
