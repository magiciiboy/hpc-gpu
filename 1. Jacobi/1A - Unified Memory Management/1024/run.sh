pgcc -acc -fast -ta=tesla:cc60,managed -Minfo=accel jacobi.c laplace2d.c -o jacobi

nvprof --cpu-profiling on --metrics dram_read_transactions ./jacobi > report_DRAM.log
nvprof --cpu-profiling on --metrics flop_count_dp ./jacobi > report_DP.log
nvprof --system-profiling on ./jacobi > report_Time_Power.log
nvprof --csv --system-profiling on --devices 0 --log-file report.log ./jacobi