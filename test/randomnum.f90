program test
    implicit none
    real :: r(5)
    call random_seed()
    call random_number(r)
    write(*,*) r
end program test