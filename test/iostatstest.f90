program IOSTATUS
    implicit none
    integer :: x, io
    open(unit=1, file="io.dat")
    do
        read(1,*,iostat=io) x ! io: <0 -> EOF, >0 -> error, =0 successful read 
        if(io < 0) exit
        if(io > 0) then
            write(*,*) "Error in input"
            exit
        end if
        write(*,*) x !default io=0
    end do
end program IOSTATUS