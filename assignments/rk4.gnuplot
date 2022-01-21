set term wxt font "Iosevka,9"
set title "Response of a driven damped oscillator using 4th order Runge Kutta method; X vs t"
set ylabel "X"
set xlabel "t"
set xrange[0:15]
set grid xtics ytics
plot "rk4soln.out" using 1:2 with points pointtype 7 pointsize 0.3 notitle
