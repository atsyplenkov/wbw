# Whitebox Workflows for R `{wbw}` <img src="man/figures/logo.png" align="right" height="135" alt="" />

<!-- badges: start -->
[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![WBW
Functions](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/atsyplenkov/0c46250def94614c4a3ef8b4de7460e6/raw/wbw-progress.json)](https://github.com/atsyplenkov/wbw/issues/1)
[![R-CMD-check](https://github.com/atsyplenkov/wbw/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/atsyplenkov/wbw/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/atsyplenkov/wbw/graph/badge.svg)](https://app.codecov.io/gh/atsyplenkov/wbw)
![GitHub last
commit](https://img.shields.io/github/last-commit/atsyplenkov/wbw)
<!-- badges: end -->

The `{wbw}` package provides R bindings for the [Whitebox Workflows for
Python](https://www.whiteboxgeo.com/manual/wbw-user-manual/book/preface.html)
— a powerful and fast library for advanced geoprocessing, with focus on
hydrological, geomorphometric and remote sensing analysis of raster,
vector and LiDAR data.

## Basic workflow

The `{wbw}` R package introduces several new S7 classes, including
`WhiteboxRaster` and `WhiteboxVector` which serves as a bridge between
Python and R.

``` r
library(wbw)

raster_path <- system.file("extdata/dem.tif", package = "wbw")
dem <- wbw_read_raster(raster_path)
dem
#> +------------------------------------------+ 
#> | WhiteboxRaster                           |
#> | dem.tif                                  |
#> |..........................................| 
#> | bands       : 1                          |
#> | dimensions  : 726, 800  (nrow, ncol)     |
#> | resolution  : 5.002392, 5.000243  (x, y) |
#> | EPSG        : 2193  (Linear_Meter)       |
#> | min value   : 63.698193                  |
#> | max value   : 361.020721                 |
#> +------------------------------------------+
```

The true power of `{wbw}` unleashes when there’s a need to run several
operations sequentially, i.e., in a pipeline. Unlike the original
Whitebox Tools, WbW [stores files in
memory](https://www.whiteboxgeo.com/manual/wbw-user-manual/book/introduction.html#how-does-wbw-compare-with-related-whitebox-products),
reducing the amount of intermediate I/O operations.

For example, a DEM can be smoothed (or filtered), and then the slope can
be estimated as follows:

``` r
dem |>
  wbw_mean_filter() |> 
  wbw_slope(units = "d")
#> +------------------------------------------+ 
#> | WhiteboxRaster                           |
#> | Slope (degrees)                          |
#> |..........................................| 
#> | bands       : 1                          |
#> | dimensions  : 726, 800  (nrow, ncol)     |
#> | resolution  : 5.002392, 5.000243  (x, y) |
#> | EPSG        : 2193  (Linear_Meter)       |
#> | min value   : 0.005972                   |
#> | max value   : 50.069439                  |
#> +------------------------------------------+
```

## Yet Another RSpatial Package? Why?

The above example may remind you of the `{terra}` package, and it is not
a coincidence. The `{wbw}` package is designed to be fully compatible
with `{terra}`, and the conversion between `WhiteboxRaster` and
`SpatRaster` objects happens in milliseconds (well, depending on the
raster size, of course).

``` r
library(terra)

wbw_read_raster(raster_path) |> 
  wbw_gaussian_filter(sigma = 1.5) |> 
  wbw_aspect() |> 
  as_rast() |> # Conversion to SpatRaster
  plot(main = "Aspect")
```

<img src="man/figures/README-terra-1.png" width="75%" />

Even though `{wbw}` can be faster than `{terra}` in some cases, it is by
no means intended to replace it.

``` r
requireNamespace("bench", quietly = TRUE)

bench::mark(
  terra = {
    s <- 
      raster_path |> 
        rast() |> 
        terrain("slope", unit = "radians") |> 
        focal(w = 15, "mean") |> 
        global(\(x) median(x, na.rm = TRUE))

  round(s$global, 2)

  },
  wbw = {
    raster_path |>
      wbw_read_raster() |> 
      wbw_slope("radians") |> 
      wbw_mean_filter(15, 15) |> 
      median() |> 
      round(2)
  },
  check = TRUE,
  iterations = 11L
)
#> # A tibble: 2 × 6
#>   expression      min   median `itr/sec` mem_alloc `gc/sec`
#>   <bch:expr> <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl>
#> 1 terra       290.7ms  291.5ms      3.43   28.58MB     17.2
#> 2 wbw          37.5ms   39.1ms     25.5     3.72KB      0
```

## Installation

You can install the development version of `{wbw}` from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("atsyplenkov/wbw")
```

> [!TIP]
> The `{wbw}` package requires the `whitebox-workflows` Python library
> v1.3.3+. However, you should not worry about it, as the package
> is designed to install all dependencies automatically on the first run.

Your machine should have **Python 3.8+** installed with `pip` and `venv` configured. Usually, these requirements are met on all modern computers. However, clean Debian installs may require the installation of system dependencies:


```bash
apt update
apt install python3 python3-pip python3-venv -y
```

## Contributing

Contributions are welcome! Please see our [contributing
guidelines](CONTRIBUTING.md) for details. There is an open issue for the
`{wbw}` package [here](https://github.com/atsyplenkov/wbw/issues/1) that
contains a list of functions yet to be implemented. This is a good place
to start.

## See also

Geomorphometric and hydrological analysis in R can be also done with:

- [`{whitebox}`](https://github.com/opengeos/whiteboxR) — An R frontend for the [WhiteboxTools](https://www.whiteboxgeo.com) standalone runner. <br>
- [`{traudem}`](https://github.com/lucarraro/traudem/) — R bindings to [TauDEM](https://hydrology.usu.edu/taudem/taudem5/) (Terrain Analysis Using Digital Elevation Models) command-line interface. <br>
- [`{RSagacmd}`](https://github.com/stevenpawley/Rsagacmd/) and [`{RSAGA}`](https://github.com/r-spatial/RSAGA) — Links R with [SAGA GIS](https://sourceforge.net/projects/saga-gis/). <br>
- [`{rivnet}`](https://github.com/lucarraro/rivnet) — river network extraction from DEM using TauDEM.