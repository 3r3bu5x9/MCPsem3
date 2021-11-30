!Assignment 3
!Name: Debasis Buxy
!MSID: N20021084
function F(x)
    implicit none
    real :: F, x
    F = sqrt(1-x**2)
end function F
subroutine Integrate_RandomSampling(a, b ,n ,Iout,var)
    real,intent(in) :: a, b
    integer,intent(in) :: n
    real,intent(out) :: Iout,var
    real :: F, x(n), r, sum, sumsq
    integer :: I
    sum = 0.
    sumsq = 0.
    do I = 1, n
        call random_number(r)
        x(I) = (b-a)*r+a
        sum = sum+F(x(I))
        sumsq = sumsq+F(x(I))**2
    end do
    var = (sumsq/n)-(sum/n)**2
    Iout = (b-a)*sum/n
end subroutine Integrate_RandomSampling
program monteCarloIntegrations
    implicit none
    real, PARAMETER :: pi = 3.141592
    real :: a, b, h, Iout, eps,var
    integer :: n, I
    open(unit=1,file="MCerror.dat")
    a = 0.0
    b = 1.0
    h = 1.0
    n = 1000
    write(1,110) "  n", "   Fn", "actual error", "   sigma", "sigma/sqrt(n)" 
    do I = 0, 6
        call Integrate_RandomSampling(a,b,n,Iout,var)
        eps = abs(4*Iout-pi)
        write(1,100) n, 4*Iout, eps, sqrt(var), sqrt(var)/sqrt(real(n)) 
        n = 2*n
    end do
100 format(I5,T8,F10.6,T20,F10.6,T32,F10.6,T45,F10.6)
110 format(A,T10,A,T20,A,T32,A,T45,A)
end program monteCarloIntegrations