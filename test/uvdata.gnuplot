set border linewidth 1.5
set lmargin at screen 0.25
set title "(aE)^2 vs Energy(eV)" font "Iosevka-Bold,18"
set ylabel "(aE)^2" font "Iosevka-Bold,16"
set xlabel "Energy(eV)" font "Iosevka-Bold,16"
set xtics font "Iosevka-Medium,12"
set ytics font "Iosevka-Medium,12"
plot "uvdata.txt" using 2:7 with linespoint pointtype 5 linewidth 2 notitle