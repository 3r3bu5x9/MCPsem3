function FUNC(X,Y)
    implicit none
    real :: FUNC, Y, X
    FUNC = X**2
end function FUNC

program EULER
    implicit none
    real :: FUNC
    real :: H, X0, Y0, X1, Y1
    integer :: I, N
    open(unit=1, file="eulerout.txt")
    H = 0.1
    X0 = 0.0
    Y0 = 0.0
    N = 100
    write(1,*) X0, Y0
    do I = 1, N
        Y1 = Y0 + H*FUNC(X0,Y0)
        X1 = X0 + H
        write(1,*) X1, Y1
        Y0 = Y1
        X0 = X1
    end do
end program EULER