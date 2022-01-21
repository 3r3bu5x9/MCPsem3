module modgen
   integer, allocatable :: s(:, :)
   integer :: n, lat
   integer, parameter :: intOne = 1, intZero = 0
   real*8, parameter :: half = 0.5_8
end module

program ising
   use modgen
   implicit none
   integer :: en, totEn, totMag, delEn
   integer :: i, j, nmc, k, l, skl, flc, mcc
   real*8 :: rnd, temp, boltz, mm, een

   open (unit=1, file="ising.in")
   open (unit=2, file="ising.out")

   read (unit=1, fmt=*)
   read (unit=1, fmt=*) lat, temp, nmc

   allocate (s(0:lat + 1, 0:lat + 1))

   n = lat**2 !total number of spins

   !Generate initial configuration
   do i = 1, lat
      do j = 1, lat
         call random_number(rnd)

         if (rnd < half) then
            s(i, j) = intOne
         else
            s(i, j) = -intOne
         end if
      end do
   end do
   call applyPBC

   !write initial energy and magnetization
   call getToten(totEn)
   totMag = sum(s(1:lat, 1:lat))
   !print*,        totMag; read*
   mm = dble(totMag)/dble(n)
   een = dble(totEn)/dble(n)
   write (unit=2, fmt=*) intZero, een, mm

   !Start MC cycles
   flc = intZero !initialize attempted flips counter
   mcc = intZero !initialize MC cycles counter

   do

      flc = flc + intOne

      !Select a random row k and column l
      call random_number(rnd)
      k = int(lat*rnd) + intOne
      call random_number(rnd)
      l = int(lat*rnd) + intOne

      !Spin value at the site (k,l)
      skl = s(k, l)

      !Current energy of the spin at the site (k,l)
      call getEn(k, l, skl, en)

      !Change in energy with skl flipped to -skl
      delEn = int(-2.0_8*en) !Because the new energy is -en

      !Apply Metropolis test
      if (delEn <= intZero) then
         s(k, l) = -s(k, l) !accept the spin flip
         call applyPBC1(k, l)
         totEn = totEn + delEn !update total energy

      else
         boltz = exp(-dble(delEn)/temp)
         call random_number(rnd)
         if (rnd < boltz) then
            s(k, l) = -s(k, l) !accept the spin flip
            call applyPBC1(k, l)
            totEn = totEn + delEn !update total energy
         end if
      end if

      if (flc == n) then
         mcc = mcc + intOne
         totMag = sum(s(1:lat, 1:lat))
         !print*,        totMag; read*
         mm = dble(totMag)/dble(n)
         een = dble(totEn)/dble(n)
         write (unit=2, fmt=*) mcc, een, mm
         flc = intZero !reset the counter
      end if

      if (mcc == nmc) exit
   end do

   print *, "totEn: ", totEn
   call getTotEn(totEn)
   print *, "totEn: ", totEn

end program ising

subroutine getToten(totEn)
   !calculate energy for the entire system
   use modgen
   implicit none
   integer :: i, j
   integer, intent(out) :: totEn

   totEn = intZero
   do i = 1, lat
      do j = 1, lat
         totEn = totEn - s(i, j)*s(i + 1, j)
         totEn = totEn - s(i, j)*s(i, j + 1)
         ! i-1, j-1 not included to avoid
         !double counting of spin pairs
      end do
   end do

   return
end subroutine getToten

subroutine getEn(k, l, skl, en)
   !calculate energy for a single spin
   use modgen, only: s
   implicit none
   integer, intent(in)                :: k, l, skl
   integer, intent(out)                :: en

   en = -skl*s(k + 1, l)
   en = en - skl*s(k, l + 1)
   en = en - skl*s(k - 1, l)
   en = en - skl*s(k, l - 1)

   return
end subroutine getEn

subroutine applyPBC
   !apply PBC for the entire row and column the boundary
   use modgen, only: s, lat
   implicit none

   s(0, :) = s(lat, :)
   s(lat + 1, :) = s(1, :)
   s(:, 0) = s(:, lat)
   s(:, lat + 1) = s(:, 1)

end subroutine applyPBC

subroutine applyPBC1(k, l)
   use modgen, only: s, lat
   implicit none
   integer, intent(in)        :: k, l
   !apply PBC for a single site on the boundary

   if (k == 1) s(lat + 1, l) = s(1, l)
   if (k == lat) s(0, l) = s(lat, l)
   if (l == 1) s(k, lat + 1) = s(k, 1)
   if (l == lat) s(k, 0) = s(k, lat)

   return
end subroutine applyPBC1
