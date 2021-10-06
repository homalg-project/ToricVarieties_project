# QSMExplorer
A package to explor one Quadrillion F-theory Standard Models.

## Acknowledgements

This algorithm is the result of ongoing collaboration with
* Martin Bies (https://martinbies.github.io/)
* Mirjam Cvetič (https://live-sas-physics.pantheon.sas.upenn.edu/people/standing-faculty/mirjam-cvetic)
* Muyang Liu (https://www.sas.upenn.edu/heptheory/node/392)

The corresponding preprint is available at [2104.08297](https://arxiv.org/pdf/2104.08297.pdf).


## Installation

To get the latest version of this GAP 4 package pull the corresponding repository from github. Subsequently issue `make install` inside the package folder. It will compile `C++`-code and place the resutling binary `counter` in the subfolder `/bin/RootCounter`. This completes the installation of this package.

To handle large integers (10^20 and higher), we use the [boost library](https://www.boost.org/).

## Documentation and tests

You can create the documentation for this package by issuing `make doc`. Tests are issued by `make test`.


## Contact

E-mail us if there are any questions, remarks, suggestions. Also, we would like to hear about applications of this package:
- `Martin Bies, martin.bies@alumni.uni-heidelberg.de`
- `Muyang Liu, lmyreg2017@gmail.com`


## Funding

This work is partially supported by:
- DOE Award DE-SC0013528Y,
- NSF grant DMS 2001673,
- Simons Foundation Collaboration grant #390287 on ``Homological Mirror Symmetry'',
- Simons Foundation Collaboration grant #724069 on ``Special Holonomy in Geometry, Analysis and Physics'',
- Slovenian Research Agency No.~P1-0306,
- Fay R.~and Eugene L.~Langberg Chair.
