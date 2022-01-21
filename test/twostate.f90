function P(x)
    implicit none
    real :: P, x
    P = exp(-x)
end function P

subroutine EstimateEnergy(Er_0, Er_1)
    implicit none
    real, intent(in) :: Er_0
    real, intent(out) :: Er_1
    real :: P, r, w, Er_trial, delE

    !write(*,*)
    !write(*,*) "Er_0 = ", Er_0
    Er_trial = -Er_0
    delE = Er_trial-Er_0
    if (delE <= 0) then
        Er_1 = Er_trial
    else
        w = P(Er_trial)/P(Er_0)
        !write(*,*) "Er_t= ", Er_trial
        !write(*,*) "w = ", w
        if(w>=1) then
            Er_1 = Er_trial
            !write(*,*) "accepted"
        else
            call random_number(r)
            !write(*,*) "r = ", r
            if(r<=w) then
                Er_1 = Er_trial
                !write(*,*) "accepted"
            else
                Er_1 = Er_0
                !write(*,*) "rejected"
            end if
        end if
    end if
    !write(*,*) "Er_1 = ", Er_1
end subroutine EstimateEnergy

program Metropolis
    implicit none
    integer :: i, n
    real :: E, Er_0, Er_1
    real, parameter :: lambda = 40 !1 eV = lambda kT
    open(unit=1, file="Edata.dat")
    write(*,*) "Enter energy in eV"
    read(*,*) E

    n = 100000
    Er_0 = E*lambda
    do i = 1, n
        call EstimateEnergy(Er_0, Er_1)
        write(1,*) Er_1
        Er_0 = Er_1
    end do
    write(*,*) "E_mean(actual) = ", -E*tanh(E*lambda)
end program Metropolis
