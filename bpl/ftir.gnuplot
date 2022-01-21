set term wxt font "Iosevka,9"
set title "Transmission vs Wavenumber"
set ylabel "%Transmission"
set xlabel "Wavenumber(cm^{-1})"
set grid xtics ytics
plot "ftir.txt" using 1:2 with lines title "FTIR for HCL"
set label 1 sprintf("P branch") at 2600, 40
set label 2 sprintf("R branch") at 3100, 40
replot