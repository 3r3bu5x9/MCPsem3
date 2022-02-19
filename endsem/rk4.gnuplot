set term wxt font "Iosevka,9"
set title "Y vs X; Q2a"
set ylabel "Y"
set xlabel "X"
set xtics pi
set format x '%.0Pπ'
set xrange [0:4*pi]
set grid xtics ytics
plot "rk4soln.out" using 1:2 with points pointtype 7 pointsize 0.3 notitle
