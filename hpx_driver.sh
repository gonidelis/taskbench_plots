# Copyright (c) 2021 Giannis Gonidelis
#
# Output Taskbench problem size (aka -iter) and FLOP/S 
# in CSV format for HPX. Converting FLOP/s to TFLOP/s is being
# done by python dataframe handling later on. Taking the 
# average of three runs for each iter is also being done by Python.

# CORES=$(grep ^cpu\\scores /proc/cpuinfo | uniq |  awk '{print $4}')
CORES=$(grep -c ^processor /proc/cpuinfo)

# Get filename timestamp
timestamp=$(date +"%Y_%m_%d_%I_%M_%p")

for i in {6..24}
do
    for j in {1..3}
    do
        ITER=$((2 ** $i)) 
        echo -n "$ITER, " | tee -a ./csv/hpx$timestamp.csv

        /home/giannis/TaskBench/openmp_hpx/hpx/bin/local_par_for \
        -kernel compute_bound -steps 1000 -width 16 -iter $ITER --hpx:threads=$CORES \
        | grep "FLOP/s" | cut -f2  -d " " | tee -a ./csv/hpx$timestamp.csv
    done   
done