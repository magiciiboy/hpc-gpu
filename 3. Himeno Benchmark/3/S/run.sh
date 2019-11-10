pgcc -acc -fast -ta=tesla:cc60,managed -Minfo=accel ../himenoBMT.c -DSMALL -o bmt

# DRAM
rm report_bmt.log
nvprof --csv --cpu-profiling on \
    --metrics dram_read_transactions \
    --print-gpu-summary \
    --print-openacc-summary \
    --print-openmp-summary \
    --print-api-summary \
    --print-summary \
    --print-summary-per-gpu \
    -o report_DRAM.nvprof \
    --log-file report_DRAM.log ./bmt >> report_bmt.log


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
    --log-file report_DP.log ./bmt >> report_bmt.log

# Timing vs Power
# nvprof --csv --system-profiling on --log-file report_Time_Power.log ./bmt >> report_bmt.log

# Human-readable report
nvprof --csv --system-profiling on \
    --devices 0 \
    --log-file report.log ./bmt >> report_bmt.log