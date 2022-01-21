module modIsing1D
    integer, allocatable :: s(:)
    integer :: n
    real*8, parameter :: zero = 0.0_8
end module modIsing1D

subroutine getRandomSpin(spin)
    implicit none
    integer, intent(out) :: spin
    real*8 :: r
    call random_number(r)
    if (r <= 0.5_8) then
        spin = 1
    else
        spin = -1
    end if
end subroutine getRandomSpin

subroutine getEnergy(Energy)
    use modIsing1D
    implicit none
    real*8, intent(out) :: Energy
    integer :: k
    Energy = zero
    do k = 1, n-1
        Energy = Energy-s(k)*s(k+1)
    end do
end subroutine getEnergy

subroutine initSpinConfig()
    use modIsing1D
    implicit none
    integer :: i
    do i = 1, n
        call getRandomSpin(s(i))
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
    if (k==1) then
        En = -(s(1)*s(2))
    else if (k == n) then
        En = -(s(k-1)*s(k))
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
    write(1,*) 0, En0, mag

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
        write(1,*) i, En0, mag
    end do
end subroutine simulate

program Ising1D
    use modIsing1D
    implicit none
    integer :: nmc
    real*8 :: temp
    open(unit=1, file="isingdata.dat")
    n = 10000
    nmc = 100000
    temp = 0.25_8
    allocate(s(n))

    !begin sim
    call simulate(nmc, temp)

    deallocate(s)
end program Ising1D