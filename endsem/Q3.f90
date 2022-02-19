!name: Debasis Buxy
!PRN: 22020004154
!Q3
function rho(x)
    implicit none
    real*8 :: rho, x
    if (x >= 0 .and. x < 1) then
        rho = x
    else if (x >= 1 .and. x < 2) then
        rho = 2-x
    else
        rho = 0
    end if
end function rho

function RND(a,b)
    implicit none
    real*8 :: RND, a, b, r
    call random_number(r)
    RND = (b-a)*r+a
end function RND

subroutine EstimatePos(x_0, x_1, del)
    implicit none
    real*8, intent(in) :: del, x_0
    real*8, intent(out) :: x_1
    real*8 :: rho, RND, r, w, x_trial, del_i

    del_i = RND(-del,del)
    x_trial = x_0+del_i
    w = rho(x_trial)/rho(x_0)
    if(w>=1) then
        x_1 = x_trial
    else
        call random_number(r)
        if(r<=w) then
            x_1 = x_trial
        else
            x_1 = x_0
        end if
    end if
end subroutine EstimatePos

program Metropolis
    implicit none
    integer :: i, n
    real*8 :: x_0, x_1, del
    real*8 :: sum, sumSq, mean, meanSq, variance
    open(unit=1, file="distin.dat")
    x_0 = 1.0
    n = 1100000 
    del = 0.5

    sum = 0.0
    sumSq = 0.0
    do i = 1, n
        call EstimatePos(x_0, x_1, del)
        write(1,*) x_1
        x_0 = x_1
        sum = sum + x_1
        sumSq = sumSq + x_1**2
    end do
    mean = sum/n
    meanSq = sumSq/n
    variance = meanSq - mean**2
    write (*, 110) "Mean", mean, "Standard deviation", sqrt(variance)
110 format(2(/A, ' = ', F10.6))
end program Metropolis
!Mean =   0.999325
!Standard deviation =   0.408707
