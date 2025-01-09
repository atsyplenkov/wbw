# Run package tests
if (requireNamespace("tinytest", quietly = TRUE)) {
  # Initialize session
  have_wbw <- reticulate::py_module_available("whitebox_workflows")
  have_numpy <- reticulate::py_module_available("numpy")
  if (!have_wbw & !have_numpy) {
    wbw_install(system = TRUE)
  }
  
  tinytest::test_package("wbw", pattern = "^test_.*\\.[rR]$")
} 