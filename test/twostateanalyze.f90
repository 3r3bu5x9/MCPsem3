program Analyze
    implicit none
    integer :: n, io
    real :: E_r, sum
    real, parameter :: lambda = 40 !1 eV = lambda kT
    open(unit=1, file="Edata.dat")
    sum = 0
    do
        if (n <= 1000) then
            read(1,*,iostat=io)
        else
            read(1,*,iostat=io) E_r
        end if
        if(io < 0) exit
        if(io > 0) then
            write(*,*) "Error in input"
            exit
        end if
        n = n+1
        sum = sum+E_r
    end do
    n = n-1000
    write(*,*) "E_mean(est) = ",sum/(n*lambda)
end program Analyze