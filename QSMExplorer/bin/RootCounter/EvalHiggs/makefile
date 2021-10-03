all: install

install:
	(g++ -c $$(realpath main.cpp) -lpthread; g++ -o evaler main.o -lpthread )
uninstall:
	(rm -f evaler)

.PHONY: all install uninstall
