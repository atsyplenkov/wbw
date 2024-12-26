
<!-- README.md is generated from README.Rmd. Please edit that file -->

# wbw

<!-- badges: start -->

[![R-CMD-check](https://github.com/atsyplenkov/wbw/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/atsyplenkov/wbw/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/atsyplenkov/wbw/graph/badge.svg)](https://app.codecov.io/gh/atsyplenkov/wbw)
<!-- badges: end -->

The `wbw` R package provides R bindings to the [Whitebox Workflows for
Python](https://www.whiteboxgeo.com/manual/wbw-user-manual/book/preface.html)
— a powerful and fast library for advanced geoprocessing, with focus on
hydrological, geomorphometric and remote sensing analysis of raster,
vector and LiDAR data.

## Installation

You can install the development version of wbw from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("atsyplenkov/wbw")

# To install Python dependencies run
wbw::wbw_install()
```

## Basic workflow

The `wbw` R package introduces two new S7 classes, `WhiteboxRaster` and
`WhiteboxVector` which serves as a bridge between Python and R.

``` r
library(wbw)

raster_path <- 
  system.file("extdata/dem.tif", package = "wbw")
dem <- wbw_read_raster(raster_path)
dem
#> dem.tif 
#> class       : wbw::WhiteboxRaster 
#> bands       : 1 
#> dimensions  : 726, 800  (nrow, ncol)
#> resolution  : 5.002392, 5.000243  (x, y)
#> EPSG        : 2193 
#> units       : Linear_Meter 
#> min values  : 63.69819 
#> max values  : 361.0207
```

One can estimate slope in degrees based on the DEM as follows:

``` r
slope_pct <- 
  wbw_slope(dem, units = "d")
summary(slope_pct)
#> Number of non-nodata grid cells: 580800
#> Number of nodata grid cells: 0
#> Image minimum: 0
#> Image maximum: 70.13195037841797
#> Image range: 70.13195037841797
#> Image total: 10479246.559940413
#> Image average: 18.042779889704565
#> Image variance: 102.85853808640309
#> Image standard deviation: 10.141919842239096
```
