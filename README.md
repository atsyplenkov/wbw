
<!-- README.md is generated from README.Rmd. Please edit that file -->

# wbw

<!-- badges: start -->
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

The `wbw` R package introduces two new S7 classes, `WbwRaster` and
`WbwVector` which serves as a bridge between Python and R.

``` r
library(wbw)
#> wbw v0.0.1 -- using whitebox-workflows v1.3.3
#> To suppress this message, add `wbw.message = suppressed`to your .Renviron file.

raster_path <- 
  system.file("extdata/dem.tif", package = "wbw")
dem <- wbw_read_raster(raster_path)
dem
#> dem.tif 
#> class       : wbw::WbwRaster 
#> bands       : 1 
#> dimensions  : 726, 800  (nrow, ncol)
#> resolution  : 5.002392, 5.000243  (x, y)
#> EPSG        : 2193 
#> units       : Linear_Meter 
#> min values  : 63.69819 
#> max values  : 361.0207
```
