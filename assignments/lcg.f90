!Assignment 2
!Name: Debasis Buxy
!MSID: N20021084
!PRN: 22020004154
program LCG
    implicit none
    integer :: a, c, m, x_0, x_n
    integer:: n, i, nbin, f(1000), i_bin, E
    real :: x, x_max, binSize, chisq
    open(unit=1,file="lcgout.dat")
    open(unit=2,file="lcgdist.dat")
    a = 106
    c = 1283
    m = 100001
    n = 1E4
    x_0 = 0
    x_n = x_0
    x_max = 1.0
    nbin = 100
    f = 0.0
    E = n/nbin
    chisq = 0.0
    binSize = x_max/nbin
    do i = 1, n
        x_n = mod(a*x_n+c,m)
        x = x_n/(1.0*m)
        write(1,*) x
        i_bin = int(x/binSize)+1
        f(i_bin) = f(i_bin)+1
    end do
    do i = 1, nbin
        write(2,100) (i-0.5)*binSize, f(i), f(i)/(1.0*n) !x, frequency, probability
        chisq = chisq+(f(i)-E)**2
        chisq = chisq/E
    end do
    write(*,*) "Chi^2 = ", chisq
100 format(F8.4,4X,I4,4X,F8.6)
end program LCG