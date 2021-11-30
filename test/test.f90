!Prog: Linear congruential method
!Name: Nachiket Tatke
!Date:18/11/2021
!PRN:22020004698
        program assigntwo
            implicit none
            integer::a,c,i,m,n,x0,x1,ibin,f(1000),nbin,cnt,E
            real::xmax,binsize,x,chisq
            a = 106
            c = 1283
            m = 100001
            n = 10000
            E=n/nbin
            chisq=0.0
            open(unit=3,file="lcom.txt")
            open(unit=4,file="lcom2.txt")
            write(*,*)"Write max value of x"
            read(*,*)xmax
            write(*,*)"Write number of bins"
            read(*,*)nbin
            binsize=xmax/nbin
            cnt=0
            f=0
            x0=0
                do i=1,n
                    x1=mod((a*x0+c),m)
                    x0=x1
                    write(3,*) x1/(1.0*m)
                x = x1/(1.0*m)
                    cnt=cnt+1
                    ibin=int(x/binsize)+1
                    f(ibin)=f(ibin)+1
                end do
                do i=1,nbin
                    write(4,*) i-binsize*0.5,f(i),f(i)/(cnt*binsize)
                    chisq=chisq+(f(i)-E)**2
                    chisq=chisq/E
                end do
            write(*,*)"ChiSq= " ,chisq
            end program assigntwo