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
	git clone https://github.com/cbouilla/spasm.git
	( cd spasm; git remote add MartinBies https://github.com/HereAround/spasm; git fetch MartinBies martin_devel:martin_devel; git checkout martin_devel; aclocal; autoconf; autoreconf --install; ./configure; make -j$$(nproc) )
	
uninstall:
	rm -f -r spasm
	
test:	doc
	gap tst/testall.g

test-with-coverage:	doc
	/usr/bin/time --quiet --format="%U %S\n%e" --output=performance.out gap --quitonbreak --cover stats tst/testall.g
	echo 'LoadPackage("profiling"); OutputJsonCoverage("stats", "coverage.json");' | gap

ci-test:	test-with-coverage

.PHONY: all doc docclean test
