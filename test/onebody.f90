module modonebody
   implicit none
   real*8 :: x0, y0, vx0, vy0, ax0, ay0, delT
   real*8 :: x1, y1, vx1, vy1, ax1, ay1, t
   integer :: n
end module modonebody

subroutine getposition()
   use modonebody
   implicit none
   x1 = x0 + vx0*delT + 0.5_8*ax0*delT**2
   y1 = y0 + vy0*delT + 0.5_8*ay0*delT**2
end subroutine getposition

subroutine getvelocity()
   use modonebody
   implicit none
   vx1 = vx0 + 0.5_8*(ax0 + ax1)*delT
   vy1 = vy0 + 0.5_8*(ay0 + ay1)*delT
end subroutine getvelocity

subroutine getacc(x, y, ax, ay)
   use modonebody
   implicit none
   real*8, intent(in) :: x, y
   real*8, intent(out) :: ax, ay
   real*8 :: r3
   r3 = sqrt(x**2 + y**2)**3
   ax = -x/r3
   ay = -y/r3
end subroutine getacc

subroutine updateacceleration()
   use modonebody
   implicit none
   real*8 :: ax, ay
   call getacc(x1, y1, ax, ay)
   ax1 = ax
   ay1 = ay
end subroutine updateacceleration

subroutine updateparameters()
   use modonebody
   implicit none
   x0 = x1
   y0 = y1
   vx0 = vx1
   vy0 = vy1
   ax0 = ax1
   ay0 = ay1
end subroutine updateparameters

program onebodymotion
   use modonebody
   implicit none
   integer :: i
   open (unit=1, file="onebodydata.in")
   open (unit=2, file="onebodydata.out")
   read (1, *)
   read (1, *) t, x0, y0, vx0, vy0, delT, n
   write (2, 100) t, x0, y0, vx0, vy0
   do i = 1, n
      call getposition
      call updateacceleration
      call getvelocity
      call updateparameters
      t = t + delT
      write (2, 100) t, x1, y1, vx1, vy1
   end do
100 format(5F10.6)
end program onebodymotion
