program main
    use, intrinsic :: iso_c_binding
    IMPLICIT NONE
    include 'fftw3.f03'
    integer i
    integer,parameter:: n=2024
    type(C_PTR) :: plan,plan2
    real(C_DOUBLE), allocatable :: in(:)
    complex(C_DOUBLE_COMPLEX),allocatable :: out(:)
    real :: dt=7/real(n-1)
    real :: t=0.0

    integer,parameter :: seed = 86456

    call srand(seed)

    allocate(in(n))
    allocate(out(n/2+1))

    open(0,file='res/beforeNoise.dat')
    do i=1,n
    t=t+dt
    in(i)=cos(t)
    write(0,*) t," ",in(i)
    end do
    close(0)

    t=0
    open(1,file='res/afterNoise.dat')
    do i=1,n
    t=t+dt
    in(i)=f(t)
    write(1,*) t," ",in(i)
    end do
    close(1)

    plan = fftw_plan_dft_r2c_1d(n, in,out, FFTW_ESTIMATE+FFTW_UNALIGNED)
    call fftw_execute_dft_r2c(plan, in, out)

    open(2, file = 'res/afterNoiseFFT.dat')
    do i=1,n/2+1
    write(2,*) i," ",abs(out(i))
    end do
    close(2)

    do i=1,n/2
        if (abs(out(i))<real(50)) THEN
            out(i)=(0,0)
        end if
    end do

    plan2=fftw_plan_dft_c2r_1d(n,out,in,FFTW_ESTIMATE+FFTW_UNALIGNED)
    call fftw_execute_dft_c2r(plan2, out, in)

    open(3, file = 'res/afterCorrection.dat')
    t=0
    do i=1,n
    t=t+dt
    write(3,*) t," ",in(i)/n
    end do
    close(3)


    call fftw_destroy_plan(plan)

CONTAINS
    function f(x) result(y)
        IMPLICIT NONE
            real, parameter :: PI = 3.14159265359
        real :: rand
        real, intent(in) :: x ! input
        complex(C_DOUBLE_COMPLEX) :: y ! output
        y =cos(x)+rand(0)
    end function f
end program main

