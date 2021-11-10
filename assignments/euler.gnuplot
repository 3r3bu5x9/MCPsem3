set title "Euler's method"
set xlabel "X"
set ylabel "Y"
set xrange [0:10]
plot "eulerout.txt" using 1:2 with lines title "approx", (1/3.0)*x**3 with lines