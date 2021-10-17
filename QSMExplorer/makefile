all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g \
		PackageInfo.g \
		doc/Doc.autodoc \
		gap/*.gd gap/*.gi examples/*.g
		(cd tst ; ./clean)
	        gap makedoc.g

docclean:
	(cd doc && ./clean)

uninstall:
	( cd bin/RootCounter && rm -f main.o && rm -f WDiagram.o && rm -f distributionCounter && rm -f specialityChecker && rm -f distributionCounterHiggsCurve; )
	
uninstall-boost-from-source:
	( cd boost && rm -r -f boost_1_77_0 && rm -r -f library )

install-boost-from-source: uninstall-boost-from-source
	( cd boost && wget -O boost_1_77_0.tar.gz https://sourceforge.net/projects/boost/files/boost/1.77.0/boost_1_77_0.tar.gz/download; tar xzvf boost_1_77_0.tar.gz; rm boost_1_77_0.tar.gz )
	( cd boost && mkdir -p library )
	( cd boost/boost_1_77_0 && ./bootstrap.sh --prefix=$$(realpath ../library) && ./b2 --prefix=$$(realpath ../library) --threading=multi install )
	
install-with-boost-from-source: install-boost-from-source
	( cd bin/RootCounter && g++ -c -I ../boost/library/include -L ../../boost/library/lib -lboost_thread -lboost_system -lpthread WDiagram.cpp; )
	( cd bin/RootCounter && g++ -c main-speciality.cpp && g++ -o specialityChecker main-speciality.o )
	( cd bin/RootCounter && g++ -c -I ../boost/library/include -L ../../boost/library/lib -lboost_thread -lboost_system -lpthread main.cpp && g++ -o distributionCounter WDiagram.o main.o -I ../boost/library/include -L ../../boost/library/lib -lboost_thread -lboost_system -lpthread )
	( cd bin/RootCounter && g++ -c -I ../boost/library/include -L ../../boost/library/lib -lboost_thread -lboost_system -lpthread HiggsMain.cpp && g++ -o distributionCounterHiggsCurve WDiagram.o HiggsMain.o -I ../boost/library/include -L ../../boost/library/lib -lboost_thread -lboost_system -lpthread )

install: uninstall
	( cd bin/RootCounter && g++ -c -lboost_thread WDiagram.cpp )
	( cd bin/RootCounter && g++ -c main-speciality.cpp && g++ -o specialityChecker main-speciality.o )
	( cd bin/RootCounter && g++ -c -lboost_thread main.cpp && g++ -o distributionCounter WDiagram.o main.o -lboost_thread -lpthread )
	( cd bin/RootCounter && g++ -c -lboost_thread HiggsMain.cpp && g++ -o distributionCounterHiggsCurve WDiagram.o HiggsMain.o -lboost_thread -lpthread )
	
test:	doc
	gap tst/testall.g

test-with-coverage:	doc
	/usr/bin/time --quiet --format="%U %S\n%e" --output=performance.out gap --quitonbreak --cover stats tst/testall.g
	echo 'LoadPackage("profiling"); OutputJsonCoverage("stats", "coverage.json");' | gap

ci-test:	test-with-coverage

.PHONY: all doc docclean test


