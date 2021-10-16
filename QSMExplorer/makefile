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
	( cd boost && rm -r -f boost_1_77_0 && rm -r -f library )
	
install: uninstall
	( cd boost && wget -O boost_1_77_0.tar.gz https://sourceforge.net/projects/boost/files/boost/1.77.0/boost_1_77_0.tar.gz/download; tar xzvf boost_1_77_0.tar.gz; rm boost_1_77_0.tar.gz )
	( cd boost && mkdir -p library )
	( cd boost/boost_1_77_0 && ./bootstrap.sh --prefix=$$(realpath ../library) && ./b2 --prefix=$$(realpath ../library) --threading=multi install )
	( cd bin/RootCounter; g++ -c -I ../Boost/library/include -L ../../Boost/library/lib -lboost_thread -lpthread WDiagram.cpp; )
	( cd bin/RootCounter; g++ -c -I ../Boost/library/include -L ../../Boost/library/lib -lboost_thread -lpthread main-speciality.cpp && g++ -o specialityChecker main-speciality.o -I ../Boost/library/include -L ../../Boost/library/lib -lboost_thread -lpthread )
	( cd bin/RootCounter; g++ -c -I ../Boost/library/include -L ../../Boost/library/lib -lboost_thread -lpthread main.cpp && g++ -o distributionCounter WDiagram.o main.o -I ../Boost/library/include -L ../../Boost/library/lib -lboost_thread -lpthread )
	( cd bin/RootCounter; g++ -c -I ../Boost/library/include -L ../../Boost/library/lib -lboost_thread -lpthread HiggsMain.cpp && g++ -o distributionCounterHiggsCurve WDiagram.o HiggsMain.o -I ../Boost/library/include -L ../../Boost/library/lib -lboost_thread -lpthread )
	
install-without-boost-download:
	( cd bin/RootCounter && rm -f main.o && rm -f WDiagram.o && rm -f distributionCounter && rm -f specialityChecker && rm -f distributionCounterHiggsCurve; )
	( cd boost && rm -r -f library )
	( cd boost && mkdir -p library )
	( cd boost/boost_1_77_0 && ./bootstrap.sh --prefix=$$(realpath ../library) && ./b2 --prefix=$$(realpath ../library) --threading=multi install )
	( cd bin/RootCounter; g++ -c -I ../Boost/library/include -L ../../Boost/library/lib -lboost_thread -lpthread WDiagram.cpp; )
	( cd bin/RootCounter; g++ -c -I ../Boost/library/include -L ../../Boost/library/lib -lboost_thread -lpthread main-speciality.cpp && g++ -o specialityChecker main-speciality.o -I ../Boost/library/include -L ../../Boost/library/lib -lboost_thread -lpthread )
	( cd bin/RootCounter; g++ -c -I ../Boost/library/include -L ../../Boost/library/lib -lboost_thread -lpthread main.cpp && g++ -o distributionCounter WDiagram.o main.o -I ../Boost/library/include -L ../../Boost/library/lib -lboost_thread -lpthread )
	( cd bin/RootCounter; g++ -c -I ../Boost/library/include -L ../../Boost/library/lib -lboost_thread -lpthread HiggsMain.cpp && g++ -o distributionCounterHiggsCurve WDiagram.o HiggsMain.o -I ../Boost/library/include -L ../../Boost/library/lib -lboost_thread -lpthread )
	
install-without-boost:
	( cd bin/RootCounter && rm -f main.o && rm -f WDiagram.o && rm -f distributionCounter && rm -f specialityChecker && rm -f distributionCounterHiggsCurve; )
	( cd bin/RootCounter; g++ -c -I ../Boost/library/include -L ../../Boost/library/lib -lboost_thread -lpthread WDiagram.cpp; )
	( cd bin/RootCounter; g++ -c -I ../Boost/library/include -L ../../Boost/library/lib -lboost_thread -lpthread main-speciality.cpp && g++ -o specialityChecker main-speciality.o -I ../Boost/library/include -L ../../Boost/library/lib -lboost_thread -lpthread )
	( cd bin/RootCounter; g++ -c -I ../Boost/library/include -L ../../Boost/library/lib -lboost_thread -lpthread main.cpp && g++ -o distributionCounter WDiagram.o main.o -I ../Boost/library/include -L ../../Boost/library/lib -lboost_thread -lpthread )
	( cd bin/RootCounter; g++ -c -I ../Boost/library/include -L ../../Boost/library/lib -lboost_thread -lpthread HiggsMain.cpp && g++ -o distributionCounterHiggsCurve WDiagram.o HiggsMain.o -I ../Boost/library/include -L ../../Boost/library/lib -lboost_thread -lpthread )
	
test:	doc
	gap tst/testall.g

test-with-coverage:	doc
	/usr/bin/time --quiet --format="%U %S\n%e" --output=performance.out gap --quitonbreak --cover stats tst/testall.g
	echo 'LoadPackage("profiling"); OutputJsonCoverage("stats", "coverage.json");' | gap

ci-test:	test-with-coverage

.PHONY: all doc docclean test


