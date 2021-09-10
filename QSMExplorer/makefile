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
	(cd bin/RootCounter; g++ -c WDiagram.cpp; g++ -c $$(realpath main-MinimalRootCounter.cpp) -lpthread; g++ -o min-counter WDiagram.o main-MinimalRootCounter.o -lpthread )
	(cd bin/RootCounter; g++ -c WDiagram.cpp; g++ -c $$(realpath main-DistributionCounter.cpp) -lpthread; g++ -o distribution-counter WDiagram.o main-DistributionCounter.o -lpthread )
	(cd bin/RootCounter; g++ -c WDiagramWithExternalLegs.cpp; g++ -c $$(realpath main-DistributionWithExternalLegsCounter.cpp) -lpthread; g++ -o distribution-with-external-legs-counter WDiagramWithExternalLegs.o main-DistributionWithExternalLegsCounter.o -lpthread )
	
uninstall:
	( cd bin/RootCounter; rm -f main.o; rm -f WDiagram.o; rm -f main-DistributionWithExternalLegsCounter.o; rm -f main-MinimalRootCounter.o; rm -f WDiagramWithExternalLegs.o; rm -f min-counter; rm -f distribution-counter; rm -f distribution-with-external-legs-counter )
	
test:	doc
	gap tst/testall.g

test-with-coverage:	doc
	/usr/bin/time --quiet --format="%U %S\n%e" --output=performance.out gap --quitonbreak --cover stats tst/testall.g
	echo 'LoadPackage("profiling"); OutputJsonCoverage("stats", "coverage.json");' | gap

ci-test:	test-with-coverage

.PHONY: all doc docclean test
