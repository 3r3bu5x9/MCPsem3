function P(x)
    implicit none
    real :: P, x
    if (x >= 0) then
        P = exp(-x)
    else
        P = 0
    end if
end function P

function RND(a,b)
    implicit none
    real :: RND, a, b, r
    call random_number(r)
    RND = (b-a)*r+a
end function RND

subroutine EstimatePos(x_0, x_1, del)
    implicit none
    real, intent(in) :: del, x_0
    real, intent(out) :: x_1
    real :: P, RND, r, w, x_trial, del_i

    del_i = RND(-del,del)
    x_trial = x_0+del_i
    w = P(x_trial)/P(x_0)
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
    real :: x_0, x_1, del
    open(unit=1, file="distin.dat")
    write(*,*) "Enter initpos, number of step, stepsize"
    read(*,*) x_0, n, del

    do i = 1, n
        call EstimatePos(x_0, x_1, del)
        write(1,*) x_1
        x_0 = x_1
    end do
end program Metropolis
