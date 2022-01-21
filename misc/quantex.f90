module modex
   implicit none
   integer :: yourscore, totalscore, yourpartscore, totalpartscore, t1(3), t2(3)
contains
   function RND(a, b)
      implicit none
      real :: RND, a, b, r
      call random_number(r)
      RND = (b - a)*r + a
   end function RND

   function binToss()
      implicit none
      integer :: binToss
      real :: r
      call random_number(r)
      if (r < 0.5) then
         binToss = 1
      else
         binToss = 0
      end if
   end function binToss
end module modex

subroutine multiplicationTable(a, b)
   use modex
   implicit none
   integer :: i, j, n, a, b
   write (1, *) "MULTIPLICATION TABLE 1-20"
   write (*, *) "MULTIPLICATION TABLE 1-20"
   do i = 1, a
      do j = 1, b
         write (*, 100) i, j
         read (*, *) n
         if (i*j == n) then
            yourpartscore = yourpartscore + 1
         else
            write (*, 101) "Incorrect! Correct answer: ", i*j
         end if
         totalpartscore = totalpartscore + 1
      end do
   end do
   write (*, *)
100 format(i0, "x", i0, "=?")
101 format(a, i0)
end subroutine multiplicationTable

subroutine random2digprod(a, b, turns)
   use modex
   implicit none
   integer :: m, n, ans, turns, a, b, i
   write (1, *) "RANDOM 2 DIGIT MULTIPLICATION"
   write (*, *) "RANDOM 2 DIGIT MULTIPLICATION"
   do i = 1, turns
      m = int(RND(1.0*a, 1.0*b))
      n = int(RND(1.0*a, 1.0*b))
      write (*, 100) m, n
      read (*, *) ans
      if (m*n == ans) then
         yourpartscore = yourpartscore + 1
      else
         write (*, 101) "Incorrect! Correct answer: ", m*n
      end if
      totalpartscore = totalpartscore + 1
   end do
   write (*, *)
100 format(i0, "x", i0, "=?")
101 format(a, i0)
end subroutine random2digprod

subroutine random2digsum(a, b, turns)
   use modex
   implicit none
   integer :: m, n, ans, turns, a, b, i
   write (1, *) "RANDOM 2 DIGIT ADDITION/SUBTRACTION"
   write (*, *) "RANDOM 2 DIGIT ADDITION/SUBTRACTION"
   do i = 1, turns
      m = int(RND(1.0*a, 1.0*b))
      n = int(RND(1.0*a, 1.0*b))

      if (binToss() == 0) then
         write (*, 100) m, n
         read (*, *) ans
         if (m + n == ans) then
            yourpartscore = yourpartscore + 1
         else
            write (*, 101) "Incorrect! Correct answer: ", m + n
         end if
      else
         write (*, 110) m, n
         read (*, *) ans
         if (m - n == ans) then
            yourpartscore = yourpartscore + 1
         else
            write (*, 101) "Incorrect! Correct answer: ", m - n
         end if
      end if
      totalpartscore = totalpartscore + 1
   end do
   write (*, *)
100 format(i0, "+", i0, "=?")
110 format(i0, "-", i0, "=?")
101 format(a, i0)
end subroutine random2digsum

subroutine sqtable(n)
   use modex
   implicit none
   integer :: i, ans, n
   write (1, *) "TABLE OF SQUARES 1-25"
   write (*, *) "TABLE OF SQUARES 1-25"
   do i = 1, n
      write (*, 100) i, 2
      read (*, *) ans
      if (i**2 == ans) then
         yourpartscore = yourpartscore + 1
      else
         write (*, 101) "Incorrect! Correct answer: ", i**2
      end if
      totalpartscore = totalpartscore + 1
   end do
   write (*, *)
100 format(i0, "^", i0, "=?")
101 format(a, i0)
end subroutine sqtable

subroutine cubetable(n)
   use modex
   implicit none
   integer :: i, ans, n
   write (1, *) "TABLE OF CUBES 1-25"
   write (*, *) "TABLE OF CUBES 1-25"
   do i = 1, n
      write (*, 100) i, 3
      read (*, *) ans
      if (i**3 == ans) then
         yourpartscore = yourpartscore + 1
      else
         write (*, 101) "Incorrect! Correct answer: ", i**3
      end if
      totalpartscore = totalpartscore + 1
   end do
   write (*, *)
100 format(i0, "^", i0, "=?")
101 format(a, i0)
end subroutine cubetable

subroutine disptotalscore()
   use modex
   implicit none
   write (1, 101) "Total score = ", ((1.0*yourscore)/totalscore)*100
101 format(a, f5.1, "%")
end subroutine disptotalscore

subroutine disppartscore()
   use modex
   implicit none
   write (1, 101) "Score = ", yourpartscore, totalpartscore
   call updatescore()
101 format(a, i0, '/', i0)
end subroutine disppartscore

subroutine updatescore()
   use modex
   implicit none
   yourscore = yourscore + yourpartscore
   totalscore = totalscore + totalpartscore
   yourpartscore = 0
   totalpartscore = 0
end subroutine updatescore

subroutine dispdateandtime()
   implicit none
   integer :: dt(8)
   call date_and_time(values=dt)
   write (1, 103) dt(1), '/', dt(2), '/', dt(3), ' ', dt(5), ':', dt(6), ':', dt(7)
103 format(i4, 5(a, i2.2))
end subroutine

subroutine startwatch()
    use modex
    implicit none
    integer :: dt(8)
    call date_and_time(values=dt)
    t1(1) = dt(5)
    t1(2) = dt(6)
    t1(3) = dt(7)
 end subroutine startwatch

 subroutine endwatch()
    use modex
    implicit none
    integer :: dt(8)
    call date_and_time(values=dt)
    t2(1) = dt(5)
    t2(2) = dt(6)
    t2(3) = dt(7)
 end subroutine endwatch

subroutine togglewatch(i)
    use modex
    implicit none
    integer :: i, tim(3)
    if (i == 1) then
        call startwatch()
    else
        call endwatch()
        if (t2(2) < t1(2)) then
            t2(2) = t2(2)+60
            t2(1) = t2(1)-1
        end if
        if (t2(3) < t1(3)) then
            t2(3) = t2(3)+60
            t2(2) = t2(2)-1
        end if
        tim(1) = t2(1)-t1(1)
        tim(2) = t2(2)-t1(2)
        tim(3) = t2(3)-t1(3)
    write (1, 103) "Elapsed time", "->", tim(1), ':', tim(2), ':', tim(3)
    103 format(a, 3(a, i2.2))
    end if
end subroutine togglewatch
program main
   use modex
   implicit none
   logical :: exists
   inquire (file="quantex.log", exist=exists)
   if (exists) then
      open (1, file="quantex.log", status="old", position="append", action="write")
   else
      open (1, file="quantex.log", status="new", action="write")
   end if
   yourpartscore = 0
   totalpartscore = 0
   yourscore = 0
   totalscore = 0
   call dispdateandtime()
   call togglewatch(1)
   call multiplicationTable(20, 10)
   call disppartscore()
   call sqtable(25)
   call disppartscore()
   call cubetable(25)
   call disppartscore()
   call random2digsum(10, 99, 20)
   call disppartscore()
   call random2digprod(10, 99, 20)
   call disppartscore()
   call togglewatch(0)
   call disptotalscore()
   write(*,*) "Result generated! Check quantex.log"
   write (1, *)
end program main
