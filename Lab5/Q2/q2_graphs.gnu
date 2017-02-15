set terminal epslatex size 3.5,2.62 color colortext

set output 'q2_problemSizeVsTime.tex'
set title 'Graph to plot the variation in time compared to the number of points in log scale'
set xlabel 'size[log base 10]'
set ylabel 'time[sec]'
set xrange [0:10]
set yrange [0:10]
set xtics (0,1,2,3,4,5,6,7,8,9,10)
set ytics (0,2,4,6,8,10)
set key left
plot "q2_problemSizeVsTime.txt" using 1:2 with linespoints title '$Serial Code$', \
"q2_problemSizeVsTime.txt" using 1:3 with linespoints title '$Scan Filter$', \
"q2_problemSizeVsTime.txt" using 1:4 with linespoints title '$Basic Parallel$'

set output 'q2_problemSizeVsSpeedup.tex'
set title 'Graph to plot the variation in speedup compared to the number of points in log scale'
set xlabel 'size[log base 10]'
set ylabel 'Speedup'
set xrange [0:10]
set yrange [0:6]
set xtics (0,1,2,3,4,5,6,7,8,9,10)
set ytics (0,1,2,3,4,5,6)
set key left
plot "q2_problemSizeVsSpeedup.txt" using 1:2 with linespoints title '$Scan Filter Speedup$', \
"q2_problemSizeVsSpeedup.txt" using 1:3 with linespoints title '$Basic Parallel Speedup$'

set output 'q2_coresVsSpeedup.tex'
set title 'Graph to plot the variation int speedup compared to the number of cores for filtering using scan'
set xlabel 'No. of Cores'
set ylabel 'Speedup'
set xrange [0:15]
set yrange [0:6]
set xtics (0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)
set ytics (0,1,2,3,4,5,6)
set key left
plot "q2_coresVsSpeedup_size1e7.txt" using 1:2 with linespoints title '$Size 1e7$', \
"q2_coresVsSpeedup_size1e8.txt" using 1:2 with linespoints title '$Size 1e8$'