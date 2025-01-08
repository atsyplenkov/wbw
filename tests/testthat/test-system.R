source('../test-setup.R')

test_that(
  "setting custom max_procs fails",
  {
    expect_error(wbw_max_procs(0))
    expect_error(wbw_max_procs(-20))
    expect_error(wbw_max_procs(1.1))
  }
)

test_that(
  "setting custom max_procs works",
  {
    wbw_max_procs(-1)
    t_parallel <- system.time(wbw_slope(x))

    wbw_max_procs(1)
    t_1 <- system.time(wbw_slope(x))

    expect_true(t_1[3] >= t_parallel[3])

  }
)


