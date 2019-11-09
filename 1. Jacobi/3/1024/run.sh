pgcc -acc -fast -ta=tesla:cc60,managed -Minfo=accel jacobi.c laplace2d.c -o jacobi

# Run Jacopi 3 times for getting results and time information
./jacobi >> report_Jacopi.log
./jacobi >> report_Jacopi.log
./jacobi >> report_Jacopi.log

# DRAM
rm report_Jacopi.log
nvprof --csv --cpu-profiling on \
    --metrics dram_read_transactions \
    --print-gpu-summary \
    --print-openacc-summary \
    --print-openmp-summary \
    --print-api-summary \
    --print-summary \
    --print-summary-per-gpu \
    -o report_DRAM.nvprof \
    --log-file report_DRAM.log ./jacobi


# DP
nvprof --csv --cpu-profiling on \
    --metrics flop_count_dp \
    --print-gpu-summary \
    --print-openacc-summary \
    --print-openmp-summary \
    --print-api-summary \
    --print-summary \
    --print-summary-per-gpu \
    -o report_DP.nvprof \
    --log-file report_DP.log ./jacobi

# Timing vs Power
# nvprof --csv --system-profiling on --log-file report_Time_Power.log ./jacobi

# Human-readable report
nvprof --csv --system-profiling on \
    --devices 0 \
    --log-file report.log ./jacobi