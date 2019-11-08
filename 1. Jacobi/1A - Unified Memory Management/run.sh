pgcc -acc -fast -ta=tesla:cc60,managed -Minfo=accel jacobi.c laplace2d.c -o jacobi

nvprof --cpu-profiling on --metrics dram_read_transactions ./jacobi
nvprof --cpu-profiling on --metrics flop_count_dp ./jacobi
nvprof --system-profiling on ./jacobi
nvprof --csv --system-profiling on --devices 0 --log-file report.log ./jacobi