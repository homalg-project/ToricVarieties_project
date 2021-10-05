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
	(cd bin/RootCounter; g++ -c WDiagram.cpp; g++ -c $$(realpath main.cpp) -lpthread; g++ -o distributionCounter WDiagram.o main.o -lpthread )
	(cd bin/RootCounter; g++ -c $$(realpath main-speciality.cpp) -lpthread; g++ -o specialityChecker WDiagram.o main-speciality.o -lpthread )
	(cd bin/RootCounter; g++ -c WDiagram.cpp; g++ -c $$(realpath HiggsMain.cpp) -lpthread; g++ -o distributionCounterHiggsCurve WDiagram.o HiggsMain.o -lpthread )
	
uninstall:
	( cd bin/RootCounter; rm -f main.o; rm -f WDiagram.o; rm -f distributionCounter; rm -f specialityChecker; rm -f distributionCounterHiggsCurve )
	
test:	doc
	gap tst/testall.g

test-with-coverage:	doc
	/usr/bin/time --quiet --format="%U %S\n%e" --output=performance.out gap --quitonbreak --cover stats tst/testall.g
	echo 'LoadPackage("profiling"); OutputJsonCoverage("stats", "coverage.json");' | gap

ci-test:	test-with-coverage

.PHONY: all doc docclean test
