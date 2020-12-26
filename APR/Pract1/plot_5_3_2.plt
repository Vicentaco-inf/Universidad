#!/usr/bin/gnuplot -persist
set term png
set output 'ej5_3_2.png'
set grid
set style line 1 \
    linecolor rgb '#0060ad' \
    linetype 1 linewidth 2 \
    pointtype 7 pointsize 1.5

set style line 2 \
    linecolor rgb '#1bd402' \
    linetype 1 linewidth 2 \
    pointtype 6 pointsize 1.5

set style line 3 \
    linecolor rgb '#c41e04' \
    linetype 1 linewidth 2 \
    pointtype 5 pointsize 1.5

set style line 4 \
    linecolor rgb '#02ebd0' \
    linetype 1 linewidth 2 \
    pointtype 4 pointsize 1.5

set style line 5 \
    linecolor rgb '#e8b602' \
    linetype 1 linewidth 2 \
    pointtype 4 pointsize 1.5

plot 'ejercicio5_3.dat' using 1:2 with linespoints linestyle 1 title 'K = 5','' using 1:3 with linespoints linestyle 2 title 'K = 10','' using 1:4 with linespoints linestyle 3 title 'K = 15','' using 1:5 with linespoints linestyle 4 title 'K = 20', '' using 1:6 with linespoints linestyle 5 title 'K = 50'
