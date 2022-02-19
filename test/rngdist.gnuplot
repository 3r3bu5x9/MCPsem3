set term wxt font "Iosevka,9"
set grid xtics ytics
set title "Probability distribution"
plot "distout.dat" using 1:3 with points pointtype 5 title "rho(x)"
