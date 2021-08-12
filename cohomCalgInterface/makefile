all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g \
		PackageInfo.g \
		doc/Doc.autodoc \
		gap/*.gd gap/*.gi examples/*.g
		(cd tst ; ./clean)
	        gap makedoc.g

docclean:
	(cd doc ; ./clean)

test:	doc
	gap tst/testall.g

install: uninstall
	git clone https://github.com/HereAround/cohomCalg
	cd cohomCalg;	git fetch origin prepared:prepared && git checkout prepared; make -j$$(nproc)
	cp cohomCalg/bin/cohomcalg binAndMonomialFiles

uninstall: 
	rm -r -f cohomCalg
	rm -f binAndMonomialFiles/cohomcalg 

test-with-coverage:	doc
	/usr/bin/time --quiet --format="%U %S\n%e" --output=performance.out gap --quitonbreak --cover stats tst/testall.g
	echo 'LoadPackage("profiling"); OutputJsonCoverage("stats", "coverage.json");' | gap

ci-test:	test-with-coverage

.PHONY: all doc docclean test
