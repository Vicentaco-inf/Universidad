#!/usr/bin/gnuplot -persist
set term png
set output 'ej4.png'
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
    linecolor rgb '#d102bc' \
    linetype 1 linewidth 2 \
    pointtype 3 pointsize 1.5

set logscale x
set xtics (0.0001, 1, 1000)

plot 'Ej4.dat' using 1:2 with linespoints linestyle 1 title '-t 0','' using 1:5 with linespoints linestyle 2 title '-t 1','' using 1:8 with linespoints linestyle 3 title '-t 2','' using 1:11 with linespoints linestyle 4 title '-t 3'
