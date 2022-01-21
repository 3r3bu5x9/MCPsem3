program analyse
    implicit none
    real*8 :: M, E, sumM, sumE, sumMsq, sumEsq, varE, varM, specificHeat, susciptibility, T
    integer :: i, n, nmc, io
    open(unit=1, file="ising.out")
    open (unit=2, file='isingresults.dat', status="old", position="append", action="write")
    write(*,*) "Enter temperature: "
    read(*,*) T
    sumE   = 0.0_8
    sumM   = 0.0_8
    sumEsq = 0.0_8
    sumMsq = 0.0_8
    n = 0 
    do i = 1, 5000
        read(1,*)
    end do
    do
        read(1,*,iostat=io) nmc, E, M
        if(io < 0) exit
        if(io > 0) then
            write(*,*) "Error in input"
            exit
        end if
        sumE = sumE + E
        sumM = sumM + M
        sumEsq = sumEsq + E**2
        sumMsq = sumMsq + M**2
        n = n+1
    end do
    varE = (sumEsq/n)-(sumE/n)**2
    varM = (sumMsq/n)-(sumM/n)**2
    specificHeat = varE/T**2
    susciptibility = varM/T
    write(*,*) "Specific heat = ", specificHeat
    write(*,*) "Susceptibility = ", susciptibility
    write(2,*) T, specificHeat, susciptibility
end program analyse