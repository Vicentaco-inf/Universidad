#!/usr/bin/gnuplot -persist
set term png
set output 'ej5_2.png'
set grid
set style line 1 \
    linecolor rgb '#0060ad' \
    linetype 1 linewidth 2 \
    pointtype 7 pointsize 1.5


plot 'ejercicio5_2.dat' with linespoints linestyle 1 title 'epsilon 1.0'
