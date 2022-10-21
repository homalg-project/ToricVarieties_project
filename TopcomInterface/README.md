# TopcomInterface
A `Gap4`-package which provides an interface to the software `topcom` (http://www.rambau.wm.uni-bayreuth.de/TOPCOM/). This interface requires `topcom` version 1.1.2. It may or may not work with newer version. Communication with older version is most likely not possibly with this software.


## Installation

To get the latest version of this GAP 4 package pull the corresponding branch from github. Subsequently, issue `make install` inside the package folder.


## Details of build

The build step will download `topcom`  from http://www.rambau.wm.uni-bayreuth.de/TOPCOM/ and then install it in the subfolder `topcom` of the package folder of `TopcomInterface`.


## Functionality

Currently, some functionality of `topcom` is not yet supported. In particular, this include the command line options -d, -h, -v, cardinality[k], frequency[ k ] and the input-type "chiro".


## Documentation and test

You can create the documentation for this package by issuing `make doc`. Tests are executed upon `make test`.


## Contact

E-mail me if there are any questions, remarks, suggestions. Also, I would like to hear about applications of this package: `Martin Bies, martin.bies@alumni.uni-heidelberg.de`.


## Funding

The work of Martin Bies is supported by SFB-TRR 195 ``Symbolic Tools in Mathematics and their Application of the German Research Foundation (DFG)``.
