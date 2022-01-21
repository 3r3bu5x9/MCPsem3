!Name: Debasis Buxy
!ms id: N20021084
!Assignment 6
module modtwobody
   implicit none
   real*8 :: x0(2), y0(2), vx0(2), vy0(2), ax0(2), ay0(2), delT
   real*8 :: x1(2), y1(2), vx1(2), vy1(2), ax1(2), ay1(2), t
   real*8 :: m(2)
   integer :: n
end module modtwobody

subroutine getposition()
   use modtwobody
   implicit none
   x1 = x0 + vx0*delT + 0.5_8*ax0*delT**2
   y1 = y0 + vy0*delT + 0.5_8*ay0*delT**2
end subroutine getposition

subroutine getvelocity()
   use modtwobody
   implicit none
   vx1 = vx0 + 0.5_8*(ax0 + ax1)*delT
   vy1 = vy0 + 0.5_8*(ay0 + ay1)*delT
end subroutine getvelocity

subroutine getacc(x, y, ax, ay)
   use modtwobody
   implicit none
   real*8, intent(in) :: x(2), y(2)
   real*8, intent(out) :: ax(2), ay(2)
   real*8 :: r3
   r3 = sqrt((x(1) - x(2))**2 + (y(1) - y(2))**2)**3
   ax(1) = -m(2)*(x(1) - x(2))/r3
   ay(1) = -m(2)*(y(1) - y(2))/r3
   ax(2) = -(m(1)/m(2))*ax(1)
   ay(2) = -(m(1)/m(2))*ay(1)
end subroutine getacc

subroutine updateacceleration()
   use modtwobody
   implicit none
   real*8 :: ax(2), ay(2)
   call getacc(x1, y1, ax, ay)
   ax1 = ax
   ay1 = ay
end subroutine updateacceleration

subroutine updateparameters()
   use modtwobody
   implicit none
   x0 = x1
   y0 = y1
   vx0 = vx1
   vy0 = vy1
   ax0 = ax1
   ay0 = ay1
   t = t + delT
end subroutine updateparameters

program twobodymotion
   use modtwobody
   implicit none
   integer :: i
   open (unit=1, file="twobodydata.in")
   open (unit=2, file="twobodydata.out")
   read (1, *)
   read (1, *) x0(1), y0(1), vx0(1), vy0(1), m(1)
   read (1, *) x0(2), y0(2), vx0(2), vy0(2), m(2)
   read (1, *) t, delT, n
   write (2, 100) t, x0(1), y0(1), vx0(1), vy0(1), x0(2), y0(2), vx0(2), vy0(2)
   do i = 1, n
      call getposition
      call updateacceleration
      call getvelocity
      call updateparameters
      write (2, 100) t, x1(1), y1(1), vx1(1), vy1(1), x1(2), y1(2), vx1(2), vy1(2)
   end do
100 format(9F10.6)
end program twobodymotion
