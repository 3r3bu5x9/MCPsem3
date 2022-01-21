set term wxt font "Iosevka,9"
set title "2D Ising model - C vs T"

set ylabel "Specific Heat C"
set xlabel "Temperature T"
set grid xtics ytics
plot "isingresults.dat" using 1:2 with linespoint pointtype 7 pointsize 0.5 linecolor rgb "red" notitle