set term wxt font "Iosevka,9"
set lmargin at screen 0.1
set rmargin at screen 0.65
set title "Resistance/Current Vs Intensity"
set ylabel "Current(mA)"
set xlabel "Intensity(lux)"
set multiplot
set key outside
set yrange [0.4:1.8]
set ytics nomirror
set key bottom right
plot "intensitypc.txt" using 2:3 axis x1y1 with linespoint pointtype 7 linecolor rgb "blue" title "Resistance vs Intensity"

unset ytics
set y2tics nomirror
set y2range [2:10]
unset ylabel
set y2label "Resistance(Ω) x 10^3"
set key top right
plot "intensitypc.txt" using 2:4 axis x1y2 with linespoint pointtype 5 linecolor rgb "red" title "Current vs Intensity"