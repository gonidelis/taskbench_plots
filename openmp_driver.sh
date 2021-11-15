# Copyright (c) 2021 Giannis Gonidelis
#
# Output Taskbench problem size (aka -iter) and FLOP/S 
# in CSV format for OpenMP. Converting FLOP/s to TFLOP/s is being
# done by python dataframe handling later on.

# If hyperthreading enabled:
#grep ^cpu\\scores /proc/cpuinfo | uniq |  awk '{print $4}'

# CORES=$(grep -c ^processor /proc/cpuinfo)

CORES=$((12))
# echo "iter, tflops"

for i in {6..21}
do
    for j in {1..3}
    do
        ITER=$((2 ** $i)) 
        echo -n "$ITER, "

        /home/giannis/TaskBench/openmp_hpx/openmp/main \
        -kernel compute_bound -steps 1000 -width 16 -iter $ITER -worker $CORES \
        | grep "FLOP/s" | cut -f2  -d " "   
    done
done