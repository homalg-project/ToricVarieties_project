# ToricVarieties_project

[![CI](https://github.com/homalg-project/ToricVarieties_project/actions/workflows/test.yml/badge.svg)](https://github.com/homalg-project/ToricVarieties_project/actions/workflows/test.yml)
[![codecov](https://codecov.io/gh/homalg-project/ToricVarieties_project/branch/master/graph/badge.svg?token=u1sCmn53Sg)](https://codecov.io/gh/homalg-project/ToricVarieties_project)

The *ToricVarieties_project* aims for high performance algorithms to compute sheaf cohomologies of coherent (toric) sheaves.


## Package list

Package|Description
------|-----------
[ToricVarieties](ToricVarieties)|Support for toric varieties in gap.
[AdditionsForToricVarieties](AdditionsForToricVarieties)|Additional algorithms for toric varieties (soon to be joined with the toric varieties package)
[cohomCalgInterface](cohomCalgInterface)|An interface to [cohomcalg](https://github.com/BenjaminJurke/cohomCalg)
[TopcomInterface](TopcomInterface)|An interface to [topcom](http://www.rambau.wm.uni-bayreuth.de/TOPCOM/)
[SpasmInterface](SpasmInterface)|An interface to [spasm](https://github.com/cbouilla/spasm)
[SparseMatrices](SparseMatrices)|Elementary support for sparse matrices. This packages uses [SpasmInterface](SpasmInterface)
[TruncationsOfFPGradedModules](TruncationsOfFPGradedModules)|We model coherent sheaves a f.p. graded modules via [FreydCategories](https://github.com/homalg-project/CAP_project/tree/master/FreydCategoriesForCAP). This package installs truncations for these modules.
[ToolsForFPGradedModules](ToolsForFPGradedModules)|This package installs constructors for ideals, minimal free resolutions, Betti tables but also conversion of our f.p. graded modules into other module formats employed throughout the [homalg_project](https://github.com/homalg-project).
[CoherentSheavesOnToricVarieties](CoherentSheavesOnToricVarieties)|This package models coherent sheaves as objects in a Serre quotient category of f.p. graded modules.
[SheafCohomologyOnToricVarieties](SheafCohomologyOnToricVarieties)|Implementation of fast algorithms for the computation of sheaf cohomologies of coherent (toric) sheaves. The algorithms are described in my [PhD thesis](https://arxiv.org/abs/1802.08860). These algorithms have been used in the context of [F-theory](https://en.wikipedia.org/wiki/F-theory) in the article [1706.04616](https://arxiv.org/abs/1706.04616).
[H0Approximator](H0Approximator)|This package is the result of recent collaboration with [Mirjam Cvetič](https://live-sas-physics.pantheon.sas.upenn.edu/people/standing-faculty/mirjam-cvetic), [Ron Donagi](https://www.math.upenn.edu/~donagi/), [Ling Lin](https://theory.cern/roster/lin-ling), [Muyang Liu](https://github.com/lmyreg2017) and [Fabian Rühle](https://github.com/ruehlef). The preprint is available [here](https://arxiv.org/abs/2007.00009).
[QSMExporer](QSMExporer)|This package is the result of recent collaboration with [Mirjam Cvetič](https://live-sas-physics.pantheon.sas.upenn.edu/people/standing-faculty/mirjam-cvetic) and [Muyang Liu](https://github.com/lmyreg2017). The preprint is be available on the arxiv [2104.08297](https://arxiv.org/abs/2104.08297).


## Installation

Detailed instructions for the installation can be found [here](https://martinbies.github.io/software/). For Ubuntu and Debian systems, I provide an installation script, with attempts to set up all of the above packages. This script is available [here](https://martinbies.github.io/Install.sh).


## Funding

The work of Martin Bies is supported by SFB-TRR 195 ``Symbolic Tools in Mathematics and their Application of the German Research Foundation (DFG)``.
