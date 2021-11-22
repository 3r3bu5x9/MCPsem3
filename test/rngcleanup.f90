program CLEANUP
    implicit none
    real :: A, B, LAMBDA, TEMP, X
    integer :: I, N
    open(unit=1, file="rngoutraw.txt")
    open(unit=2, file="rngout.txt")
    write(*,*) "Enter lower, upper bounds and number of data points, multiplier"
    read(*,*) A, B, N, LAMBDA
    do I = 1, N
        read(1,*) X
        TEMP = LAMBDA*X
        if (TEMP > A .AND. TEMP < B ) then
            write(2,100) TEMP
        end if
    end do
100 format(F6.2)
end program CLEANUP