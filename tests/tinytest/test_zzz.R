# Test version string format
version <- wbw_version()
expect_true(is.character(version))
expect_true(grepl("^\\d+\\.\\d+\\.\\d+$", version))

# Note: The more complex tests involving mocking from the original testthat version
# are harder to implement in tinytest. Consider either:
# 1. Using a different mocking approach
# 2. Writing simpler tests that don't require mocking
# 3. Skipping those tests if they're not critical 