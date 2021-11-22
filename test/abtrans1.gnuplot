set border linewidth 1.5
set lmargin at screen 0.25
set title "Corrected Transmittance vs Wavelength" font "Iosevka-Bold,18"
set ylabel "Corrected Transmittance T{c}" font "Iosevka-Bold,16"
set xlabel "Wavelength(nm)" font "Iosevka-Bold,16"
set xtics font "Iosevka-Medium,12"
set ytics font "Iosevka-Medium,12"
plot "uvdata.txt" using 1:8 with linespoint pointtype 5 linewidth 2 linetype rgb "red" title "T{c}"