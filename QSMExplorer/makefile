all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g \
		PackageInfo.g \
		doc/Doc.autodoc \
		gap/*.gd gap/*.gi examples/*.g
		(cd tst ; ./clean)
	        gap makedoc.g
	
clean: uninstall docclean
	(cd bin/RootCounterHiggs && rm -f d1.txt && rm -f d2.txt && rm -f f1.txt && rm -f f2.txt && rm -f outfluxes_H1.txt && rm -f outfluxes_H1.txt)
	        
docclean:
	(cd doc && ./clean)
	
uninstall:
	(cd bin/RootCounterHiggs/RootCounter && rm -f main.o && rm -f distributionCounter)
	(cd bin/RootCounterHiggs && rm -f HiggsMain.o && rm -f distributionCounterHiggsCurve)
	(cd bin/RootCounterHiggs && rm -f DivideStep.o && rm -f divideStep)
	(cd bin/RootCounterHiggs && rm -f ConquerStep.o && rm -f conquerStep)
	(cd bin/Speciality && rm -f main-speciality.o && rm -f specialityChecker)
	
uninstall-boost-from-source:
	(cd boost && rm -r -f boost_1_77_0 && rm -r -f library)

install-with-local-boost: install-boost-from-source \
	install-with-links-to-local-boost
	
install-boost-from-source: uninstall-boost-from-source
	(cd boost && wget -O boost_1_77_0.tar.gz https://sourceforge.net/projects/boost/files/boost/1.77.0/boost_1_77_0.tar.gz/download; tar xzvf boost_1_77_0.tar.gz; rm boost_1_77_0.tar.gz)
	(cd boost && mkdir -p library)
	(cd boost/boost_1_77_0 && ./bootstrap.sh --prefix=$$(realpath ../library) && ./b2 --prefix=$$(realpath ../library) --threading=multi install)

DIR := ${CURDIR}
P1 := ${DIR}/boost/library/lib
P2 := ${DIR}/boost/library/include

install-with-links-to-local-boost: uninstall
	(cd bin/Speciality && g++ -c main-speciality.cpp && g++ -o specialityChecker main-speciality.o)
	(cd bin/RootCounterHiggs/RootCounter && g++ -c -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread main.cpp && g++ -o distributionCounter main.o -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread)
	(cd bin/RootCounterHiggs && g++ -c -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread HiggsMain.cpp && g++ -o distributionCounterHiggsCurve HiggsMain.o -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread)
	(cd bin/RootCounterHiggs && g++ -c -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread ConquerStep.cpp && g++ -o conquerStep ConquerStep.o -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread)
	(cd bin/RootCounterHiggs && g++ -c -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread DivideStep.cpp && g++ -o divideStep DivideStep.o -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread)
	(cd bin/RootCounterHiggs && g++ -c -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread listOfOutfluxes.cpp && g++ -o listOfOutfluxes listOfOutfluxes.o -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread)	
	
install-with-links-to-local-boost-and-profiling: uninstall
	(cd bin/Speciality && g++ -pg -c main-speciality.cpp && g++ -pg -o specialityChecker main-speciality.o)
	(cd bin/RootCounterHiggs/RootCounter && g++ -pg -c -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread main.cpp && g++ -pg -o distributionCounter main.o -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread )
	(cd bin/RootCounterHiggs && g++ -pg -c -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread HiggsMain.cpp && g++ -pg -o distributionCounterHiggsCurve HiggsMain.o -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread)
	(cd bin/RootCounterHiggs && g++ -c -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread ConquerStep.cpp && g++ -o conquerStep ConquerStep.o -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread)
	(cd bin/RootCounterHiggs && g++ -c -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread DivideStep.cpp && g++ -o divideStep DivideStep.o -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread)
	(cd bin/RootCounterHiggs && g++ -pg -c -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread listOfOutfluxes.cpp && g++ -pg -o listOfOutfluxes listOfOutfluxes.o -Wl,-rpath=${P1} -I${P2} -L${P1} -lboost_thread -lboost_system -lpthread)
	
install: uninstall
	(cd bin/Speciality && g++ -c main-speciality.cpp && g++ -o specialityChecker main-speciality.o)
	(cd bin/RootCounterHiggs/RootCounter && g++ -c -lboost_thread main.cpp && g++ -o distributionCounter main.o -lboost_thread -lpthread)
	(cd bin/RootCounterHiggs && g++ -c -lboost_thread HiggsMain.cpp && g++ -o distributionCounterHiggsCurve HiggsMain.o -lboost_thread -lpthread)
	(cd bin/RootCounterHiggs && g++ -c -lboost_thread ConquerStep.cpp && g++ -o conquerStep ConquerStep.o -lboost_thread -lpthread)
	(cd bin/RootCounterHiggs && g++ -c -lboost_thread DivideStep.cpp && g++ -o divideStep DivideStep.o -lboost_thread -lpthread)
	(cd bin/RootCounterHiggs && g++ -c -lboost_thread listOfOutfluxes.cpp && g++ -o listOfOutfluxes listOfOutfluxes.o -lboost_thread -lpthread)
	
test:	doc
	gap tst/testall.g

test-with-coverage:	doc
	/usr/bin/time --quiet --format="%U %S\n%e" --output=performance.out gap --quitonbreak --cover stats tst/testall.g
	echo 'LoadPackage("profiling"); OutputJsonCoverage("stats", "coverage.json");' | gap

ci-test:	test-with-coverage

.PHONY: all doc docclean test


