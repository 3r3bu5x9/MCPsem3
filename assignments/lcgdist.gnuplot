set title "probability vs x"
set xlabel "x"
set ylabel "probability"
plot "lcgdist.dat" using 1:3 with linespoint title "probability"
