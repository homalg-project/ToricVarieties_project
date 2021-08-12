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

install:
	(cd bin/; g++ -o counter main.cpp; g++ -o counterH2 mainH2.cpp)

uninstall:
	(cd bin/; rm -f counter; rm -f counterH2 )
	
test:	doc
	gap tst/testall.g

test-with-coverage:	doc
	/usr/bin/time --quiet --format="%U %S\n%e" --output=performance.out gap --quitonbreak --cover stats tst/testall.g
	echo 'LoadPackage("profiling"); OutputJsonCoverage("stats", "coverage.json");' | gap

ci-test:	test-with-coverage

.PHONY: all doc docclean test
