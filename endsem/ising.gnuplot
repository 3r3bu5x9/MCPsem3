set term wxt font "Iosevka,9"
set title "1D Ising model; Q2b"
set ylabel "magnetisation per spin (m)"
set xlabel "nmc"
set yrange [-1:1]

set grid xtics ytics
plot "isingdata.dat" using 1:2 with linespoint pointtype 7 pointsize 0.1 notitle