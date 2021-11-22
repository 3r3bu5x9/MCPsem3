function F(x)
    implicit none
    real :: F, x
    F = sqrt(1-x**2)
end function F
subroutine Integrate_HitOrMiss(a, b, h, n, Iout)
    implicit none
    real,intent(in) :: a, b, h
    integer,intent(in) :: n
    real,intent(out) :: Iout
    real :: F, x(n), y(n), r, area
    integer :: I, n_s
    n_s = 0
    do I = 1, n
        call random_number(r)
        x(I) = (b-a)*r+a
        call random_number(r)
        y(I) = h*r
        if (y(I) <= F(x(I))) then
            n_s = n_s+1
        end if
    end do
    area = (b-a)*h
    Iout = ((area*n_s)/n)
end subroutine Integrate_HitOrMiss
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
    real, PARAMETER :: pi = 3.141592653589793238 
    real :: a, b, h, Iout1, Iout2, err1, err2
    integer :: n, I
    open(unit=1,file="MCerrorplotalt.dat")
    a = 0.0
    b = 1.0
    h = 1.0
    do I = 1, 8
        n = 10**I
        call Integrate_HitOrMiss(a,b,h,n,Iout1)
        call Integrate_RandomSampling(a,b,n,Iout2)
        err1 = abs(4*Iout1-pi)
        err2 = abs(4*Iout2-pi)
        write(1,*) n, err1, err2
        !write(1,*) log10(real(I)), log10(err1), log10(err2)
    end do
    call Integrate_HitOrMiss(a,b,h,n,Iout1)
    call Integrate_RandomSampling(a,b,n,Iout2)
    !write(*,*) "Error(H/M) = ", abs(4*Iout1-pi)
    !write(*,*) "Error(RS)  = ", abs(4*Iout2-pi)
end program monteCarloIntegrations