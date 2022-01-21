set term wxt font "Iosevka,9"
set title "Current Vs Voltage"
set ylabel "Current(µA)"
set xlabel "Voltage(V)"
set yrange [0:140]
set grid xtics ytics
f1(x) = m1*x + b1
f2(x) = m2*x + b2
fit [0:6] f1(x) "VIpc.txt" using 1:2 via m1,b1
fit [0:6] f2(x) "VIpc.txt" using 1:3 via m2,b2
plot "VIpc.txt" using 1:2 with points pointtype 5 title "Dark",\
     "VIpc.txt" using 1:3 with points pointtype 4 title "Light",\
 f1(x) with lines linecolor rgb "#F58225" notitle,\
 f2(x) with lines linecolor rgb "#48AAAD" notitle
set label 1 sprintf("slope = %1.3f",m1) at 4,30
set label 2 sprintf("slope = %1.3f",m2) at 4,80
replot