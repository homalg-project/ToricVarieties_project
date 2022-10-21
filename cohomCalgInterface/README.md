# cohomCalgInterface
A gap package to communicate with the software `cohomCalg` (https://github.com/BenjaminJurke/cohomCalg).


## Installation

To get the latest version of this GAP 4 package pull the corresponding branch from github. Subsequently, execute `make install` in the folder of this package. This completes the installation.


## Dependency

This package requires a working installation of `cohomCalg` on your computer. The latest version can be found on https://github.com/BenjaminJurke/cohomCalg. The command `make install` will download a slightly modified version (to fit the needs of this `Gap`-package better) from the branch martindevel of https://github.com/HereAround/cohomCalg. Explicitly, this prepared version will output less to the terminal and hence leads to a more integrated experience in `Gap`.

Once `cohomCalg` is sucessfully installed, you should find a binary file in the folder `binAndMonomialFiles`.


## Documentation and test

You can create the documentation for this package by issuing `make doc`. Tests are triggered by `make test`.


## Contact

E-mail me if there are any questions, remarks, suggestions. Also, I would like to hear about applications of this package.

`Martin Bies, martin.bies@alumni.uni-heidelberg.de`


## Funding

The work of Martin Bies is supported by SFB-TRR 195 ``Symbolic Tools in Mathematics and their Application of the German Research Foundation (DFG)``.
