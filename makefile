# Start of the makefile
# Defining variables
FC = gfortran
FLFLAGS = -lfftw3 -lquadmath -lm 
#MakeFile
all: FFT deFFT

FFT: FFT.o
	${FC} ${FLFLAGS} -o $@ $^
	rm $^

FFT.o : src/FFT.F90
	${FC} -c $^

deFFT: deFFT.o
	${FC} ${FLFLAGS} -o $@ $^
	rm $^

deFFT.o : src/deFFT.F90
	${FC} -c $^
