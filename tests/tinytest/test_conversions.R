source("setup.R")

slope_deg <- wbw_slope(x, units = "d")
slope_rad <- wbw_slope(x, units = "r")
deg_to_rad <- wbw_to_radians(slope_deg)
rad_to_deg <- wbw_to_degrees(slope_rad)

expect_inherits(deg_to_rad, c("wbw::WhiteboxRaster", "S7_object"))
expect_inherits(rad_to_deg, c("wbw::WhiteboxRaster", "S7_object"))
expect_equal(mean(slope_rad), mean(deg_to_rad))
expect_equal(mean(slope_deg), mean(rad_to_deg))
