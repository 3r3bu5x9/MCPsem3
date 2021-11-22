program RNGDIST
    implicit none
    integer :: i, n, nbin, i_bin, f(100), io
    real :: x, x_max, bin_size, sum, var2, p_x, rho_x, mean
    open(unit=1,file="x.dat")
    open(unit=2,file="dist.dat")
    write(*,*) "Enter max value of x(x_max) and number of bins(nbin)"
    read(*,*) x_max, nbin
    f = 0.0
    n = 0
    sum = 0.0
    var2 = 0.0
    bin_size = x_max/nbin
    do
        read(1,*,iostat=io) x 
        if(io < 0) exit
        if(io > 0) then
            write(*,*) "Error in input"
            exit
        end if
        i_bin = int(x/bin_size)+1
        f(i_bin) = f(i_bin) + 1
        sum = sum+x
        n = n+1
    end do
    mean = sum/n
    do i = 1, nbin
        x = i-bin_size*0.5
        p_x = f(i)/(1.0*n)
        rho_x = f(i)/(n*bin_size)
        write(2,100) x, f(i), rho_x !x, f(x), rho(x)
        var2 = var2 + (x-mean)**2*p_x
    end do
    write(*,*) "Variance", var2
100 format(F8.4,4X,I0,4X,F6.4)
end program RNGDIST