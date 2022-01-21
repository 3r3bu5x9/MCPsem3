!Program: Monte carlo by samaple mean method
!Name: Nachiket Tatke
!Date: 30/11/2021
!PRN: 22020004698
        program assign3
            implicit none
            integer:: i,n,j
            real::a,b,r,sumn,x,func,inte,error,pi
                    
            write(*,*)"Set your lower limit"
            read(*,*)a
            write(*,*)"Set your upper limit"
            read(*,*)b
            write(*,*)"Set your sample size"
            read(*,*)n
            pi=3.141592653
            sumn=0.0
            open(unit=6,file="mocaintread.txt")
                do j=0,6
                    do i=1,n
                        call random_number(r)
                        r=(b-a)*r+a
                        x=r
                        sumn=sumn+func(x)
                    end do
                inte=((b-a)*sumn)/n
                error=abs(pi-(4*inte))
                write(6,*)log(real(n)),log(abs(error))
                n=2*n
                end do
            end program assign3
            
            function func(x)
            implicit none
            real:: func,x
            func=((1-x**2)**0.5)
            end function func