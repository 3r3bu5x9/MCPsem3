set term wxt font "Iosevka,9"
#set logscale xy 10
#set format x "%2.0t{/Symbol \264}10^{%L}"
#set format y "%2.0t{/Symbol \264}10^{%L}"
set title "log-log plot of error vs n Monte Carlo Integration"
set ylabel "log10 error"
set xlabel "log10 n"
set grid xtics ytics
f1(x) = m1*x + b1
fit [1:5] f1(x) "MCerrorplot.dat" using 1:2 via m1,b1
f2(x) = m2*x + b2
fit [1:5] f2(x) "MCerrorplot.dat" using 1:3 via m2,b2
plot "MCerrorplot.dat" using 1:2 with lines linecolor rgb "#B81118" title "Hit or Miss",\
 "MCerrorplot.dat" using 1:3 with lines linecolor rgb "#172E7C" title "Random Sampling",\
 f1(x) with lines linecolor rgb "#F58225",\
 f2(x) with lines linecolor rgb "#71BF40"
set label 1 sprintf("m1 = %1.3f",m1) at 1.75,-4.5
set label 2 sprintf("m2 = %1.3f",m2) at 1.75,-5.0
replot