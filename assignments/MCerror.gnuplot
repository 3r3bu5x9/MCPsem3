set term wxt font "Iosevka,9"
set title "log-log plot of error vs n Monte Carlo Integration(Sample Mean method)"
set ylabel "log error"
set xlabel "log n"
set grid xtics ytics
f(x) = m*x + b
fit [6:12] f(x) "MCerrorplot.dat" using 1:2 via m,b
plot "MCerrorplot.dat" using 1:2 with points pointtype 3 title "Error",\
 f(x) with lines linecolor rgb "#F58225"
set label 1 sprintf("slope = %1.3f",m) at 7.5,-5.5
replot