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
	( cd bin/RootCounter && rm -f main.o && rm -f WDiagram.o && rm -f distributionCounter && rm -f specialityChecker && rm -f distributionCounterHiggsCurve && rm -f conquerStep; )
	
uninstall-boost-from-source:
	( cd boost && rm -r -f boost_1_77_0 && rm -r -f library )

install-with-local-boost: install-boost-from-source \
	install-with-links-to-local-boost
	
install-boost-from-source: uninstall-boost-from-source
	( cd boost && wget -O boost_1_77_0.tar.gz https://sourceforge.net/projects/boost/files/boost/1.77.0/boost_1_77_0.tar.gz/download; tar xzvf boost_1_77_0.tar.gz; rm boost_1_77_0.tar.gz )
	( cd boost && mkdir -p library )
	( cd boost/boost_1_77_0 && ./bootstrap.sh --prefix=$$(realpath ../library) && ./b2 --prefix=$$(realpath ../library) --threading=multi install )

DIR := ${CURDIR}
P1 := ${DIR}/boost/library/lib
P2 := ${DIR}/boost/library/include

install-with-links-to-local-boost: uninstall
	( cd bin/RootCounter && g++ -c main-speciality.cpp && g++ -o specialityChecker main-speciality.o )
	( cd bin/RootCounter && g++ -c -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread WDiagram.cpp; )
	( cd bin/RootCounter && g++ -c -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread main.cpp && g++ -o distributionCounter WDiagram.o main.o -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread )
	( cd bin/RootCounter && g++ -c -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread HiggsMain.cpp && g++ -o distributionCounterHiggsCurve WDiagram.o HiggsMain.o -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread )
	( cd bin/RootCounter && g++ -c -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread ConquerStep.cpp && g++ -o conquerStep WDiagram.o ConquerStep.o -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread )
    
install-with-links-to-local-boost-and-profiling: uninstall
	( cd bin/RootCounter && g++ -pg -c main-speciality.cpp && g++ -pg -o specialityChecker main-speciality.o )
	( cd bin/RootCounter && g++ -pg -c -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread WDiagram.cpp; )
	( cd bin/RootCounter && g++ -pg -c -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread main.cpp && g++ -pg -o distributionCounter WDiagram.o main.o -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread )
	( cd bin/RootCounter && g++ -pg -c -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread HiggsMain.cpp && g++ -pg -o distributionCounterHiggsCurve WDiagram.o HiggsMain.o -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread )
	( cd bin/RootCounter && g++ -c -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread ConquerStep.cpp && g++ -o conquerStep WDiagram.o ConquerStep.o -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread )
	
install: uninstall
	( cd bin/RootCounter && g++ -c -lboost_thread WDiagram.cpp )
	( cd bin/RootCounter && g++ -c main-speciality.cpp && g++ -o specialityChecker main-speciality.o )
	( cd bin/RootCounter && g++ -c -lboost_thread main.cpp && g++ -o distributionCounter WDiagram.o main.o -lboost_thread -lpthread )
	( cd bin/RootCounter && g++ -c -lboost_thread HiggsMain.cpp && g++ -o distributionCounterHiggsCurve WDiagram.o HiggsMain.o -lboost_thread -lpthread )
	( cd bin/RootCounter && g++ -c -lboost_thread ConquerStep.cpp && g++ -o conquerStep WDiagram.o ConquerStep.o -lboost_thread -lpthread )
	
test:	doc
	gap tst/testall.g

test-with-coverage:	doc
	/usr/bin/time --quiet --format="%U %S\n%e" --output=performance.out gap --quitonbreak --cover stats tst/testall.g
	echo 'LoadPackage("profiling"); OutputJsonCoverage("stats", "coverage.json");' | gap

ci-test:	test-with-coverage

.PHONY: all doc docclean test


