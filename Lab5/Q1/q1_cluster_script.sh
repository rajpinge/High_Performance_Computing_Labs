#!/bin/bash

gcc -Wall -fopenmp -o q1_serial q1_serial.c -lm
gcc -Wall -fopenmp -o q1_parallel_tree q1_parallel_tree.c -lm
gcc -Wall -fopenmp -o q1_intermediate_scan q1_intermediate_scan.c -lm

echo changing number of threads, size = 1e7
echo	   

thread=1
echo Threads_${thread}
export OMP_NUM_THREADS=${thread}
serial_line="$(./q1_serial 10000000)"
echo Serial: ${serial_line}
stime="$(echo "${serial_line}" | awk '{ print $2 }')"
parallel_line="$(./q1_parallel_tree 10000000)"
echo Parallel: ${parallel_line}
ptime="$(echo "${parallel_line}" | awk '{ print $2 }')"

speedup_tree_scan="$(echo "$stime/$ptime" | bc -l)"

parallel_intermediate="$(./q1_intermediate_scan 10000000 $thread)"
echo ParallelSimpleDiv: ${parallel_intermediate}
pintermediatetime="$(echo "${parallel_intermediate}" | awk '{ print $2 }')"

speedup_intermediate="$(echo "$stime/$pintermediatetime" | bc -l)"

echo speedup ${thread} thread: ${speedup_tree_scan} ${speedup_intermediate}
echo "$thread $speedup_tree_scan $speedup_intermediate" > q1_coresVsSpeedup_size1e7.txt
echo 

for i in 2 3 4 6 8 10 12
do

thread=$i
echo Threads_${thread}
export OMP_NUM_THREADS=${thread}
serial_line="$(./q1_serial 10000000)"
echo Serial: ${serial_line}
stime="$(echo "${serial_line}" | awk '{ print $2 }')"
parallel_line="$(./q1_parallel_tree 10000000)"
echo Parallel: ${parallel_line}
ptime="$(echo "${parallel_line}" | awk '{ print $2 }')"

speedup_tree_scan="$(echo "$stime/$ptime" | bc -l)"

parallel_intermediate="$(./q1_intermediate_scan 10000000 $thread)"
echo ParallelSimpleDiv: ${parallel_intermediate}
pintermediatetime="$(echo "${parallel_intermediate}" | awk '{ print $2 }')"

speedup_intermediate="$(echo "$stime/$pintermediatetime" | bc -l)"

echo speedup ${thread} thread: ${speedup_tree_scan} ${speedup_intermediate}
echo "$thread $speedup_tree_scan $speedup_intermediate" >> q1_coresVsSpeedup_size1e7.txt
echo 

done

echo changing number of threads, size = 1e8
echo	   

thread=1
echo Threads_${thread}
export OMP_NUM_THREADS=${thread}
serial_line="$(./q1_serial 100000000)"
echo Serial: ${serial_line}
stime="$(echo "${serial_line}" | awk '{ print $2 }')"
parallel_line="$(./q1_parallel_tree 100000000)"
echo Parallel: ${parallel_line}
ptime="$(echo "${parallel_line}" | awk '{ print $2 }')"

speedup_tree_scan="$(echo "$stime/$ptime" | bc -l)"

parallel_intermediate="$(./q1_intermediate_scan 100000000 $thread)"
echo ParallelSimpleDiv: ${parallel_intermediate}
pintermediatetime="$(echo "${parallel_intermediate}" | awk '{ print $2 }')"

speedup_intermediate="$(echo "$stime/$pintermediatetime" | bc -l)"

echo speedup ${thread} thread: ${speedup_tree_scan} ${speedup_intermediate}
echo "$thread $speedup_tree_scan $speedup_intermediate" > q1_coresVsSpeedup_size1e8.txt
echo 

for i in 2 3 4 6 8 10 12
do

thread=$i
echo Threads_${thread}
export OMP_NUM_THREADS=${thread}
serial_line="$(./q1_serial 100000000)"
echo Serial: ${serial_line}
stime="$(echo "${serial_line}" | awk '{ print $2 }')"
parallel_line="$(./q1_parallel_tree 100000000)"
echo Parallel: ${parallel_line}
ptime="$(echo "${parallel_line}" | awk '{ print $2 }')"

speedup_tree_scan="$(echo "$stime/$ptime" | bc -l)"

parallel_intermediate="$(./q1_intermediate_scan 100000000 $thread)"
echo ParallelSimpleDiv: ${parallel_intermediate}
pintermediatetime="$(echo "${parallel_intermediate}" | awk '{ print $2 }')"

speedup_intermediate="$(echo "$stime/$pintermediatetime" | bc -l)"

echo speedup ${thread} thread: ${speedup_tree_scan} ${speedup_intermediate}
echo "$thread $speedup_tree_scan $speedup_intermediate" >> q1_coresVsSpeedup_size1e8.txt
echo 

done 
      
echo changing input size
echo

input=1000
size="$(echo "l($input)/l(10)" | bc -l)"
echo number of points = 1e${size%%.*}
serial_line="$(./q1_serial $input)"
echo Serial: ${serial_line}
stime="$(echo "${serial_line}" | awk '{ print $2 }')"
parallel_line="$(./q1_parallel_tree $input)"
echo Parallel: ${parallel_line}
ptime="$(echo "${parallel_line}" | awk '{ print $2 }')"

speedup_tree_scan="$(echo "$stime/$ptime" | bc -l)"

parallel_intermediate="$(./q1_intermediate_scan $input $thread)"
echo ParallelSimpleDiv: ${parallel_intermediate}
pintermediatetime="$(echo "${parallel_intermediate}" | awk '{ print $2 }')"

speedup_intermediate="$(echo "$stime/$pintermediatetime" | bc -l)"

echo speedup 1e$size: ${speedup_tree_scan} ${speedup_intermediate}
echo ${size%%.*} "$stime $ptime $pintermediatetime" > q1_problemSizeVsTime.txt
echo ${size%%.*} "$speedup_tree_scan $speedup_intermediate" > q1_problemSizeVsSpeedup.txt
echo 

for inpsize in 10000 100000 1000000 10000000 100000000 1000000000
do

input=$inpsize
size="$(echo "l($input)/l(10)" | bc -l)"
echo number of points = 1e${size%%.*}
serial_line="$(./q1_serial $input)"
echo Serial: ${serial_line}
stime="$(echo "${serial_line}" | awk '{ print $2 }')"
parallel_line="$(./q1_parallel_tree $input)"
echo Parallel: ${parallel_line}
ptime="$(echo "${parallel_line}" | awk '{ print $2 }')"

speedup_tree_scan="$(echo "$stime/$ptime" | bc -l)"

parallel_intermediate="$(./q1_intermediate_scan $input $thread)"
echo ParallelSimpleDiv: ${parallel_intermediate}
pintermediatetime="$(echo "${parallel_intermediate}" | awk '{ print $2 }')"

speedup_intermediate="$(echo "$stime/$pintermediatetime" | bc -l)"

echo speedup 1e$size: ${speedup_tree_scan} ${speedup_intermediate}
echo ${size%%.*} "$stime $ptime $pintermediatetime" >> q1_problemSizeVsTime.txt
echo ${size%%.*} "$speedup_tree_scan $speedup_intermediate" >> q1_problemSizeVsSpeedup.txt
echo 
	
done