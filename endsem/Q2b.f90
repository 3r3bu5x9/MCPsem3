!name: Debasis Buxy
!PRN: 22020004154
!Q2b
module modIsing1D
    integer, allocatable :: s(:)
    integer :: n
    real*8, parameter :: zero = 0.0_8
end module modIsing1D

subroutine getEnergy(Energy)
    use modIsing1D
    implicit none
    real*8, intent(out) :: Energy
    integer :: k
    Energy = zero
    do k = 1, n-1
        Energy = Energy-s(k)*s(k+1)
    end do
    Energy = Energy-s(n)*s(1)
end subroutine getEnergy

subroutine initSpinConfig()
    use modIsing1D
    implicit none
    integer :: i, m
    m = n/2
    do i = 1, m-1
        s(i) = 1
    end do
    do i = m, n
        s(i) = -1
    end do
end subroutine

subroutine getMag(m)
    use modIsing1D
    implicit none
    integer, intent(out) :: m
    integer :: i
    m = zero
    do i = 1, n
        m = m+s(i)
    end do
end subroutine getMag

subroutine getOneEn(k, En)
    use modIsing1D
    implicit none
    integer, intent(in) :: k
    real*8, intent(out) :: En
    !for 1 and n positions obeying PBC
    if (k==1) then
        En = -s(1)*(s(n)+s(2))
    else if (k == n) then
        En = -s(n)*(s(n-1)+s(1))
    !for other positions
    else
        En = -s(k)*(s(k-1)+s(k+1))
    end if
end subroutine getOneEn

subroutine simulate(nmc,temp)
    use modIsing1D
    implicit none
    integer, intent(in) :: nmc
    real*8, intent(in) :: temp
    integer :: i, j, k, mag
    real*8 :: r, w, En0, Enk, delEn
    
    !generate init config
    call initSpinConfig()
    !print energy of init config
    call getEnergy(En0)
    call getMag(mag)
    !initial config
    !write(1,*) 0, mag

    do i = 1, nmc
        do j = 1, n
            call random_number(r)
            !get random pos between 1 to n
            k = int(real(n)*r)+1
            !get energy of kth spin
            call getOneEn(k, Enk)
            !calc change in energy
            delEn = -2.0_8*Enk
            if (delEn < zero) then
                s(k) = -s(k) !spin flip accepted
            else
                w = exp(-delEn/temp)
                call random_number(r)
                if (r < w) then
                    s(k) = -s(k) !spin flip accepted
                end if
            end if
            !get energy and mag of new config
        end do
        call getEnergy(En0)
        call getMag(mag)
        write(1,*) i, (1.0*mag)/n !i = nmc step ; mag/n = total magnetisation per spin
    end do
end subroutine simulate

program Ising1D
    use modIsing1D
    implicit none
    integer :: nmc
    real*8 :: temp
    open(unit=1, file="isingdata.dat")
    n = 1000
    nmc = 10000
    temp = 1.0_8
    allocate(s(n))

    !begin sim
    call simulate(nmc, temp)

    deallocate(s)
end program Ising1D