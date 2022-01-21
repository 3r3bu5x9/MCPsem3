set term wxt font "Iosevka,9"
set title "1D Ising model"
set grid xtics ytics
set xzeroaxis
set yzeroaxis
set title "1 body Kepler"
set xlabel "X"
set ylabel "Y"
set xrange [-1.25:1.25]
set yrange [-1.25:1.25]
set size ratio -1
plot "onebodydata.out" using 2:3 with points pointtype 7 pointsize 0.3 notitle