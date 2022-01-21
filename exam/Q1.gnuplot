set term wxt font "Iosevka,9"
set title "log-log plot of error vs n Monte Carlo Integration(Sample Mean method)"
set ylabel "log error"
set xlabel "log n"
set grid xtics ytics
plot "Q1output.dat" using 3:4 with points pointtype 5 title "Error"