program RNGDIST
    implicit none
    integer :: I, N, Nbin, Ibin, Fx(100)
    real :: X(10000), Xmax, BinSize
    open(unit=1,file="distdataIN.txt")
    open(unit=2,file="distdataOUT.txt")
    write(*,*) "Enter number of data points and number of bins"
    read(*,*) N, Nbin
    read(1,*) X(1)
    Xmax = X(1) !initialize max to initial data pt
    Fx = 0.0
    do I=2, N
        read(1,*) X(I)
        if (X(I) > Xmax) then
            Xmax = X(I)
        end if
    end do
    Xmax = int(Xmax)+1 !ceil
    BinSize = Xmax/Nbin
    do I = 1, N
        Ibin = int(X(I)/BinSize)+1
        Fx(Ibin) = Fx(Ibin) + 1
    end do
    do I = 1, Nbin
        write(2,100) I-BinSize*0.5, Fx(I), Fx(I)/(N*BinSize)
    end do
100 format(F8.4,4X,I0,4X,F8.4)
end program RNGDIST