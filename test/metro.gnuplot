set term wxt font "Iosevka,9"
set grid xtics ytics
set title "Position extimates following exp(-x) using Metropolis algorithm"
y = 0
set xlabel "time"
set ylabel "position"
plot "distin.dat" using y:1 with points pointsize 1 pointtype 7 title "x_i"