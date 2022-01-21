set term wxt font "Iosevka,9"
set title "Hall Voltage Vs Magnetic field for Probe Current = 6 mA"
set ylabel "Hall Voltage(mV)"
set xlabel "Magnetic Field(Gauss)"
set grid xtics ytics
f(x) = m*x + b
fit [0:3500] f(x) "IBVh.txt" using 2:5 via m,b
plot "IBVh.txt" using 2:5 with points pointtype 5 notitle,\
 f(x) with lines linecolor rgb "#F58225" notitle
set label 1 sprintf("slope = %1.3f",m) at 2500,105
set label 2 sprintf("intercept = %1.3f",b) at 2500,110
replot