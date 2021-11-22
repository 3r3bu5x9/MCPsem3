set title "f(x) vs x"
set xlabel "x"
set ylabel "f(x)"
plot "dist.dat" using 1:2 with linespoint pointtype 5 title "frequency"
