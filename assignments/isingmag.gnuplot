set term wxt font "Iosevka,9"
set title "2D Ising model - χ vs T"
set ylabel "Susceptibility χ"
set xlabel "Temperature T"
set grid xtics ytics
#plot "ising.out" using 1:3 with points pointtype 7 pointsize 0.5 notitle
plot "isingresults.dat" using 1:3 with linespoint pointtype 7 pointsize 0.5 notitle