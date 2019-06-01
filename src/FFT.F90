program main
      use, intrinsic :: iso_c_binding
      IMPLICIT NONE
      include '/usr/include/fftw3.f03'
!          write (*,*) "Hello World!"
      integer i
      integer,parameter:: n=1024
      type(C_PTR) :: plan
      real(C_DOUBLE), allocatable :: in(:)
      complex(C_DOUBLE_COMPLEX),allocatable :: out(:)
      real :: dt=1/real(n-1)
      real :: t=0.0

      allocate(in(n))
      allocate(out(n/2+1))

      open(1,file='time.dat')
      do i=1,n
      t=t+dt
      in(i)=f(t)
      write(1,*) t," ",in(i)
      end do

      plan = fftw_plan_dft_r2c_1d(n, in,out, FFTW_ESTIMATE+FFTW_UNALIGNED)
      call fftw_execute_dft_r2c(plan, in, out)

      open(2, file = 'data1.dat')

      do i=1,n/2+1
      write(2,*) i," ",abs(out(i))
      end do
      close(2)

      call fftw_destroy_plan(plan)

  CONTAINS
  function f(x) result(y)
      real, parameter :: PI = 3.14159265359

      real, intent(in) :: x ! input
      complex(C_DOUBLE_COMPLEX) :: y ! output

      y = sin(2*pi*x*200)+2*sin(2*pi*x*400)
  end function f
end program main

