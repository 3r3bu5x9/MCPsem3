program RNGDIST
    implicit none
    integer :: i, n, nbin, i_bin, f(100), io
    real :: x, x_max, binSize, sum, sumSq, mean, meanSq, variance
    open(unit=1,file="distin.dat")
    open(unit=2,file="distout.dat")
    write(*,*) "Enter max value of x(x_max) and number of bins(nbin)"
    read(*,*) x_max, nbin
    f = 0.0
    n = 0
    sum = 0.0
    sumSq = 0.0
    binSize = x_max/nbin
    do
        read(1,*,iostat=io) x
        if(io < 0) exit
        if(io > 0) then
            write(*,*) "Error in input"
            exit
        end if
        n = n+1
        i_bin = int(x/binSize)+1
        f(i_bin) = f(i_bin)+1
        sum = sum+x
        sumSq = sumSq+x**2
    end do
    do i = 1, nbin
        write(2,100) (i-0.5)*binSize, f(i), f(i)/(n*binSize), f(i)/(1.0*n) !x, f(x), rho(x)
    end do
    mean = sum/n
    meanSq = sumSq/n
    variance = meanSq-mean**2
    write(*,110) "Mean", mean, "Variance", variance, "Standard deviation", sqrt(variance)
100 format(F6.2,4X,I0,4X,F8.6,4X,F8.6)
110 format(3(/A,' = ',F10.6))
end program RNGDIST