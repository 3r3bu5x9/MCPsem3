!Name: Debasis Buxy
!PRN: 22020004154
!Question 1
function F(x)
    implicit none
    real :: F, x, a, b
    a = 4
    b = 3
    F = sqrt((1.0-(x/a)**2)*b**2)
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
program MCRandomSampling
    implicit none
    real, PARAMETER :: pi = 3.141592653589793238 
    real :: x1, x2, Iout, error, a, b, area_actual, area_calc
    integer :: n, I
    open(unit=1,file="Q1output.dat")
    a = 4
    b = 3
    area_actual = pi*a*b
    x1 = -a
    x2 = a
    n = 2000
    do I = 1, 9
        call Integrate_RandomSampling(x1,x2,n,Iout)
        area_calc = 2*Iout
        error = area_actual-area_calc
        write(1,*) n, abs(error), log(real(n)), log(abs(error)) 
        n = 2*n 
    end do
    
end program MCRandomSampling