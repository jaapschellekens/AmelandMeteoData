#makefile for tide


all: tide scanpeaks

install: all
	cp scanpeaks ../../bin/scanpeaks
	cp tide ../../bin/tide
	rehash

tide: tide.o
	cc  tide.o -o tide -lm

tide.o: tide.c
	cc -c tide.c

scanpeaks: scanpeaks.o
	cc scanpeaks.o -o scanpeaks -lm

scanpeaks.o: scanpeaks.c
	cc -c scanpeaks.c

clean:
	rm -f *.o tide scanpeaks *~
