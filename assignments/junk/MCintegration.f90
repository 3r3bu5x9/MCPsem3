!Assignment 3
!Name: Debasis Buxy
!MSID: N20021084
function F(x)
    implicit none
    real :: F, x
    F = sqrt(1-x**2)
end function F
subroutine Integrate_RandomSampling(a, b ,n ,Iout)
    real,intent(in) :: a, b
    integer,intent(in) :: n
    real,intent(out) :: Iout
    real :: F, x(n), r, sum
    integer :: I
    sum = 0.
    do I = 1, n
        call random_number(r)
        x(I) = (b-a)*r+a
        sum = sum+F(x(I))
    end do
    Iout = (b-a)*sum/n
end subroutine Integrate_RandomSampling
program monteCarloIntegrations
    implicit none
    real, PARAMETER :: pi = 3.141592
    real :: a, b, h, Iout, eps
    integer :: n, I
    open(unit=1,file="MCerrorplot.dat")
    a = 0.0
    b = 1.0
    h = 1.0
    n = 1000
    do I = 0, 6
        call Integrate_RandomSampling(a,b,n,Iout)
        eps = abs(4*Iout-pi)
        write(1,100) log((real(n))), log(eps)
        n = 2*n
    end do
100 format(F10.6,4x, F10.6)
end program monteCarloIntegrations