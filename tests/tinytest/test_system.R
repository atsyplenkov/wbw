source("setup.R")

# Test invalid max_procs settings
expect_error(wbw_max_procs(0))
expect_error(wbw_max_procs(-20))
expect_error(wbw_max_procs(1.1))

# Test performance with different max_procs settings
wbw_max_procs(-1)
t_parallel <- system.time(wbw_slope(x))

wbw_max_procs(1)
t_1 <- system.time(wbw_slope(x))

# Check that parallel processing is faster
expect_true(t_1[3] >= t_parallel[3])
