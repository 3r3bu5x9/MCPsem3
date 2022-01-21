set term wxt font "Iosevka,9"
set grid xtics ytics
#set multiplot layout 1,2
set multiplot 
set xzeroaxis
set yzeroaxis
set title "2 body motion under gravitational force"
set xlabel "X"
set ylabel "Y"
set xrange [-0.6:0.6]
set yrange [-0.6:0.6]
set size ratio -1
set key right
plot "twobodydata.out" using 2:3 with points pointtype 7 linecolor rgb "blue" pointsize 0.3 title "body 1"
unset title
set title " "
set key left
plot "twobodydata.out" using 6:7 with points pointtype 7 linecolor rgb "red" pointsize 0.3 title "body 2"
