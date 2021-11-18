# Copyright (c) 2021 Giannis Gonidelis
#
# Output Taskbench problem size (aka -iter) and FLOP/S 
# in CSV format for OpenMP. Converting FLOP/s to TFLOP/s is being
# done by python dataframe handling later on.

# If hyperthreading enabled:
#grep ^cpu\\scores /proc/cpuinfo | uniq |  awk '{print $4}'

CORES=$(grep -c ^processor /proc/cpuinfo)

# Get filename timestamp
timestamp=$(date +"%Y_%m_%d_%I_%M_%p")

for i in {6..27}
do
    for j in {1..3}
    do
        ITER=$((2 ** $i)) 
        echo -n "$ITER, " | tee -a ./csv/omp$timestamp.csv

        /home/giannis/TaskBench/openmp_hpx/openmp/main \
        -type stencil_1d -kernel compute_bound -steps 1000 -width  48 -iter $ITER -worker $CORES \
        | grep "seconds\|FLOP/s"  |  grep -Eo '[0-9]+([.][0-9]+)?+[e+]+[e-]?+[0-9]?+[0-9]' | 
        xargs | sed -e 's/ /, /g' | tee -a ./csv/omp$timestamp.csv
    done
done