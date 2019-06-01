# Start of the makefile
# Defining variables
FC = gfortran
FLFLAGS = -lquadmath -lm -I/usr/include/ -L/usr/lib/ -lfftw3 
#MakeFile
all: FFT deFFT

allplot: all
	./FFT
	./deFFT
	bash src/gnuplot.sh

FFT: FFT.o
	${FC} ${FLFLAGS} -o $@ $^
	rm $^

FFT.o : src/FFT.F90
	${FC} -c $^ ${FLFLAGS}

deFFT: deFFT.o
	${FC} -o $@ $^ ${FLFLAGS}
	rm $^

deFFT.o : src/deFFT.F90
	${FC} -c $^ ${FLFLAGS}

plot:
	bash src/gnuplot.sh
clean:
	rm FFT deFFT
cleanres:
	rm res/*
