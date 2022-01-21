!Assignment 5
!Name: Debasis Buxy
!PRN: 22020004154
module modRK4
    implicit none
    real*8 :: K1(2), K2(2), K3(2), K4(2)
    real*8 :: h, t, u(2)
    contains
    function f1(t1,x1,x2)
        implicit none
        real*8 :: f1,t1,x1,x2
        f1 = x2
    end function f1
    
    function f2(t2,x1,x2)
        implicit none
        real*8 :: f2,t2,x1,x2
        real*8 :: w0, g
        w0 = 3.0_8
        g = 0.5_8
        f2 = -(w0**2*x1)-(g*x2)+F(t2)
    end function f2
    
    function F(t3)
        implicit none
        real*8 :: F, t3, m, w, A0
        w = 2.0_8
        A0 = 1.0_8
        m = 1.0_8
        F = m*A0*cos(w*t3)
    end function F
end module modRK4

subroutine getK1(i)
    use modRK4
    implicit none
    integer, intent(in) :: i
    if (i == 1) then
        K1(i) = h*f1(t,u(1),u(2))
    else
        K1(i) = h*f2(t,u(1),u(2))
    end if
end subroutine getK1

subroutine getK2(i)
    use modRK4
    implicit none
    integer, intent(in) :: i
    if (i == 1) then
        K2(i) = h*f1(t+h*0.5_8, u(1)+K1(1)*0.5_8, u(2)+K1(2)*0.5_8)
    else
        K2(i) = h*f2(t+h*0.5_8, u(1)+K1(1)*0.5_8, u(2)+K1(2)*0.5_8)
    end if
end subroutine getK2

subroutine getK3(i)
    use modRK4
    implicit none
    integer, intent(in) :: i
    if (i == 1) then
        K3(i) = h*f1(t+h*0.5_8, u(1)+K2(1)*0.5_8, u(2)+K2(2)*0.5_8)
    else
        K3(i) = h*f2(t+h*0.5_8, u(1)+K2(1)*0.5_8, u(2)+K2(2)*0.5_8)
    end if
end subroutine getK3

subroutine getK4(i)
    use modRK4
    implicit none
    integer, intent(in) :: i
    if (i == 1) then
        K4(i) = h*f1(t+h, u(1)+K3(1), u(2)+K3(2))
    else
        K4(i) = h*f2(t+h, u(1)+K3(1), u(2)+K3(2))
    end if
end subroutine getK4

subroutine updatew()
    use modRK4
    implicit none
    integer :: j
    do j = 1, 2
        u(j) = u(j)+(1.0_8/6)*(K1(j)+2*K2(j)+2*K3(j)+K4(j))
    end do
    t = t+h
end subroutine updatew

subroutine printpos()
    use modRK4
    implicit none
    write(1,*) t, u(1), u(2)
end subroutine printpos

program RungeKutta4
    use modRK4
    implicit none
    integer :: i, n
    open(unit=1, file="rk4soln.out")
    t = 0.0_8
    h = 0.01_8
    write(*,*) "Enter initial position"
    read(*,*) u(1)
    write(*,*) "Enter initial velocity"
    read(*,*) u(2)
    n = 1500
    call printpos()
    do i = 1, n
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