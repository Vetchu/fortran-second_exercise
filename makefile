# Start of the makefile
# Defining variables
FC = gfortran
FLFLAGS = -lfftw3 -lquadmath -lm 
#MakeFile
FFT: FFT.o
		${FC} ${FLFLAGS} -o $@ $^
FFT.o : src/FFT.F90
	    ${FC} -c $^
