!name: Debasis Buxy
!PRN: 22020004154
!Q2a
module modRK4
    implicit none
    real*8 :: K1(2), K2(2), K3(2), K4(2)
    real*8 :: h, x, u(2)
    real*8, PARAMETER :: pi = 3.141592
    contains
    function f1(x1,y1,y2)
        implicit none
        real*8 :: f1,x1,y1,y2
        f1 = y2
    end function f1
    
    function f2(x2,y1,y2)
        implicit none
        real*8 :: f2,x2,y1,y2
        f2 = -y1
    end function f2
end module modRK4

subroutine getK1(i)
    use modRK4
    implicit none
    integer, intent(in) :: i
    if (i == 1) then
        K1(i) = h*f1(x,u(1),u(2))
    else
        K1(i) = h*f2(x,u(1),u(2))
    end if
end subroutine getK1

subroutine getK2(i)
    use modRK4
    implicit none
    integer, intent(in) :: i
    if (i == 1) then
        K2(i) = h*f1(x+h*0.5_8, u(1)+K1(1)*0.5_8, u(2)+K1(2)*0.5_8)
    else
        K2(i) = h*f2(x+h*0.5_8, u(1)+K1(1)*0.5_8, u(2)+K1(2)*0.5_8)
    end if
end subroutine getK2

subroutine getK3(i)
    use modRK4
    implicit none
    integer, intent(in) :: i
    if (i == 1) then
        K3(i) = h*f1(x+h*0.5_8, u(1)+K2(1)*0.5_8, u(2)+K2(2)*0.5_8)
    else
        K3(i) = h*f2(x+h*0.5_8, u(1)+K2(1)*0.5_8, u(2)+K2(2)*0.5_8)
    end if
end subroutine getK3

subroutine getK4(i)
    use modRK4
    implicit none
    integer, intent(in) :: i
    if (i == 1) then
        K4(i) = h*f1(x+h, u(1)+K3(1), u(2)+K3(2))
    else
        K4(i) = h*f2(x+h, u(1)+K3(1), u(2)+K3(2))
    end if
end subroutine getK4

subroutine updatew()
    use modRK4
    implicit none
    integer :: j
    do j = 1, 2
        u(j) = u(j)+(1.0_8/6)*(K1(j)+2*K2(j)+2*K3(j)+K4(j))
    end do
    x = x+h
end subroutine updatew

subroutine printpos()
    use modRK4
    implicit none
    write(1,*) x, u(1), u(2)
end subroutine printpos

program RungeKutta4
    use modRK4
    implicit none
    open(unit=1, file="rk4soln.out")
    x = 0.0_8
    h = 0.01_8
    !initial conditions
    u(1) = 1.0
    u(2) = 0.0
    call printpos()
    do
        if (x > 4*pi) exit
        call getK1(1)
        call getK1(2)
        call getK2(1)
        call getK2(2)
        call getK3(1)
        call getK3(2)
        call getK4(1)
        call getK4(2)
        call updatew()
        call printpos()
    end do
end program RungeKutta4