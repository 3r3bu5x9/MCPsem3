set title "rho(x) vs x"
set xlabel "x"
set ylabel "rho(x)"
plot "dist.dat" using 1:3 with linespoint pointtype 5 title "probability density"
