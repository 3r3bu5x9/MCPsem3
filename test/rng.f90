program LCG
    implicit none
    integer :: A, C, M, X0, Xn, P
    open(unit=1,file="rngoutraw.txt")
    write(*,*) "Enter a, c, m, X0"
    read(*,*) A, C, M, X0
    Xn = X0
    P = 0
    do
        P = P+1
        write(1,*) Xn
        Xn = mod(A*Xn+C,M)
        if (Xn == X0) exit
    end do
end program LCG