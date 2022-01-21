set term wxt font "Iosevka,9"
set grid xtics ytics
set xzeroaxis
set yzeroaxis
set title "2 body Kepler; body 2"
set xlabel "X"
set ylabel "Y"
#set xrange [-1.0:2.0]
#set yrange [-1.25:1.25]
#set size ratio -1
plot "twobodydata.out" using 6:7 with points pointtype 7 linecolor rgb "red" pointsize 0.3 notitle