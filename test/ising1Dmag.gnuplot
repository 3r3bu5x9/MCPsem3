set term wxt font "Iosevka,9"
set title "1D Ising model"
set yrange [-8000:8000]

set ylabel "magnetisation"
set xlabel "nmc"
set grid xtics ytics
plot "isingdata.dat" using 1:3 with points pointtype 7 pointsize 0.05 notitle