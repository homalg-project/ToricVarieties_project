# SpasmInterface
A `Gap4`-package to provide an interface to the software Spasm (https://github.com/cbouilla/spasm).


## Installation

To get the latest version of this package, clone the corresponding repository at github. Subsequently, execute `make install` inside the package folder. This completes the installation.


## Details of build step

`make install`will first clone the `Spasm` repository from https://github.com/cbouilla/spasm. However, please note that by default Spasm will ignore empty rows when computing left kernels. At times this is not desired. Indeed, for the purposes of this `Gap4`-package, it is indeed expected, required and desired to take empty rows (and columns) into account when computing left (or right) kernels of matrices.

To circumvent this issue, we download a development version of Spasm from the branch `martin_devel` at https://github.com/HereAround/spasm. This version modifies this behaviour as follows:
1. It extends the .gitignore file such that even after the following installation process, all newly created files are being ignored by git.
2. It modifies /bench/kernel.c such that zero rows are taken into account when computing kernels.
3. It modifies /bench/rank_dense.c such that its output is recognized by gap.

To obtain this version, the build step proceeds as follows:
- `git clone https://github.com/HereAround/spasm`
- `git checkout -b martin_devel`
- `git pull origin martin_devel`

In order to install `Spasm`, we have to create a configure-file. In Debian system, this file is created by the following commands:
- `aclocal`
- `autoconf`
- `autoreconf --install`

Finally, the installation proceeds by issuing:
- `./configure`
- `make -j $(nproc)`


## Documentation and tests

You can create the documentation by issuing `make doc`. The tests are run by issuing `make test`.


## Contact

E-mail me if there are any questions, remarks, suggestions. Also, I would like to hear about applications of this package: `Martin Bies, martin.bies@alumni.uni-heidelberg.de`.


## Funding

The work of Martin Bies is supported by SFB-TRR 195 ``Symbolic Tools in Mathematics and their Application of the German Research Foundation (DFG)``.
