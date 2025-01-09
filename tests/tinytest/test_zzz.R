# Test version string format
version <- wbw_version()
expect_true(is.character(version))
expect_true(grepl("^\\d+\\.\\d+\\.\\d+$", version))
