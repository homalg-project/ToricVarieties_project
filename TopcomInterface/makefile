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

install: uninstall
	curl -sS http://www.rambau.wm.uni-bayreuth.de/Software/TOPCOM-0.17.8.tar.gz > Topcom.tar.gz
	tar -xf Topcom.tar.gz
	rm Topcom.tar.gz
	mv topcom* topcom
	( cd topcom; ./configure CFLAGS="-m64" CXXFLAGS="-m64"; make -j $$(nproc) )

uninstall:
	rm -r -f topcom

test:	doc
	gap tst/testall.g

test-with-coverage:	doc
	/usr/bin/time --quiet --format="%U %S\n%e" --output=performance.out gap --quitonbreak --cover stats tst/testall.g
	echo 'LoadPackage("profiling"); OutputJsonCoverage("stats", "coverage.json");' | gap

ci-test:	test-with-coverage

.PHONY: all doc docclean test
