# This file is part of the standard setup for testthat.
# It is recommended that you do not modify it.
#
# Where should you do additional test configuration?
# Learn more about the roles of various files in:
# * https://r-pkgs.org/testing-design.html#sec-tests-files-overview
# * https://testthat.r-lib.org/articles/special-files.html

library(testthat)
library(wbw)

# Initialize session
have_wbw <- reticulate::py_module_available("whitebox_workflows")
have_numpy <- reticulate::py_module_available("numpy")
if (!have_wbw & !have_numpy) {
  wbw_install(system = TRUE)
}
