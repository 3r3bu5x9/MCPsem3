set border linewidth 1.5
set lmargin at screen 0.25
set title "Absorbance/Transmittance vs Wavelength" font "Iosevka-Bold,18"
set ylabel "Absorbance" font "Iosevka-Bold,16"
set xlabel "Wavelength" font "Iosevka-Bold,16"
set xtics font "Iosevka-Medium,12"
set ytics font "Iosevka-Medium,12"
plot "uvdata.txt" using 1:3 with linespoint pointtype 7 linewidth 2 linetype rgb "blue" title "Absorbance" 