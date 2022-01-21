set term wxt font "Iosevka,9"
set title "1D Ising model"
set yrange [-10000:-9500]

set ylabel "Energy"
set xlabel "nmc"
set grid xtics ytics
plot "isingdata.dat" using 1:2 with points pointtype 7 pointsize 0.5 linecolor rgb "red" notitle