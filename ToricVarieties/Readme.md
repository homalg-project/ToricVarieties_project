# ToricVarieties

*ToricVarieties* is a gap4 package, which allows to compute properties of toric varieties. It is central to the *ToricVarieties_project*, which extends its functionality to computations with coherent sheaves on toric varieties.


## Installation

To get the latest version of this GAP 4 package, clone ToricVarieties_project from github (https://github.com/homalg-project/ToricVarieties_project). This completes the installation process.


## Documentation and test

You can create the documentation for this package by issuing the following command inside the folder of the ToricVarieties package

```
make doc
```

If a running LaTeX installation is available, the documentation will subsequently be available as *manual.pdf*. In case, that you later want to delete the existing documentation and create it anew (e.g. after updating to a new version of this package), issue the following

```
make docclean
make doc
```

You can test the installation by issuing

```
make test
```

## Contact

E-mail me if there are any questions, remarks, suggestions. Also, I would like to hear about applications of this package.

Martin Bies, martin.bies@alumni.uni-heidelberg.de


## Funding

The work of Martin Bies is supported by the [Wiener-Anspach foundation](http://fwa.ulb.ac.be/).
