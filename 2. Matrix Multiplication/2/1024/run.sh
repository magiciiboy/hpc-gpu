module load cuda
module load pgi
pgcc -acc -fast -ta=tesla:cc60 -Minfo=accel matrix-acc-tile.c -o matmul

# DRAM
rm report_Matmul.log
nvprof --csv --cpu-profiling on \
    --metrics dram_read_transactions \
    --print-gpu-summary \
    --print-openacc-summary \
    --print-openmp-summary \
    --print-api-summary \
    --print-summary \
    --print-summary-per-gpu \
    -o report_DRAM.nvprof \
    --log-file report_DRAM.log ./matmul >> report_Matmul.log


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
    --log-file report_DP.log ./matmul >> report_Matmul.log

# Timing vs Power
# nvprof --csv --system-profiling on --log-file report_Time_Power.log ./matmul >> report_Matmul.log

# Human-readable report
nvprof --csv --system-profiling on \
    --devices 0 \
    --log-file report.log ./matmul >> report_Matmul.log