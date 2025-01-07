#' Convert to radians
#' @keywords conversions
#'
#' Converts a [WhiteboxRaster] from degrees to radians
#'
#' @eval rd_input_raster("x")
#'
#' @return [WhiteboxRaster] object in radians
#'
#' @seealso [wbw_to_degrees()], [wbw_slope()]
#'
#' @examples
#' f <- system.file("extdata/dem.tif", package = "wbw")
#' wbw_read_raster(f) |>
#'   wbw_slope(units = "d") |>
#'   wbw_to_radians()
#' @export
wbw_to_radians <-
  S7::new_generic(
    name = "wbw_to_radians",
    dispatch_args = "x",
    fun = function(x) {
      S7::S7_dispatch()
    }
  )

S7::method(wbw_to_radians, WhiteboxRaster) <-
  function(x) {
    # Checks
    check_env(wbe)
    # Return Raster
    WhiteboxRaster(
      name = if (grepl("\\(degrees\\)", x@name)) {
        sub("\\(degrees\\)", "(radians)", x@name)
      } else {
        x@name
      },
      source = x@source$to_radians()
    )
  }

#' Convert to degrees
#' @keywords conversions
#'
#' Converts a [WhiteboxRaster] from radians to degrees
#'
#' @eval rd_input_raster("x")
#'
#' @return [WhiteboxRaster] object in degrees
#'
#' @seealso [wbw_to_radians()], [wbw_slope()]
#'
#' @examples
#' f <- system.file("extdata/dem.tif", package = "wbw")
#' wbw_read_raster(f) |>
#'   wbw_slope(units = "r") |>
#'   wbw_to_degrees()
#' @export
wbw_to_degrees <-
  S7::new_generic(
    name = "wbw_to_degrees",
    dispatch_args = "x",
    fun = function(x) {
      S7::S7_dispatch()
    }
  )

S7::method(wbw_to_degrees, WhiteboxRaster) <-
  function(x) {
    # Checks
    check_env(wbe)
    # Return Raster
    WhiteboxRaster(
      name = if (grepl("\\(radians\\)", x@name)) {
        sub("\\(radians\\)", "(degrees)", x@name)
      } else {
        x@name
      },
      source = x@source$to_degrees()
    )
  }


#' Convert WhiteboxRaster to SpatRaster
#' @keywords terra
#'
#' Converts a [WhiteboxRaster] to a SpatRaster object
#'
#' @eval rd_input_raster("x")
#'
#' @return SpatRaster object
#'
#' @seealso [WhiteboxRaster()]
#'
#' @examples
#' \dontrun{
#' f <- system.file("extdata/dem.tif", package = "wbw")
#' wbw_read_raster(f) |>
#'   wbw_slope(units = "r") |>
#'   as_rast()
#' }
#' @export
as_rast <-
  S7::new_generic(
    name = "as_rast",
    dispatch_args = "x",
    fun = function(x) {
      S7::S7_dispatch()
    }
  )

S7::method(as_rast, WhiteboxRaster) <-
  function(x) {
    # Checks
    check_env(wbe)

    # Prepare data
    v <- as_vector(x)
    wbw_nodata <- x@source$configs$nodata
    # TODO:
    # Depending on the x@source$configs$data_type,
    # Use either NA_integer_ or NA_real_
    v[v == wbw_nodata] <- NA

    # Prepare CRS and Extent
    ext <-
      c(
        # Note the differences in east and south between reading by
        # GDAL (i.e. terra) and WhiteboxTools
        x@source$configs$west,
        x@source$configs$east + wbw_xres(x),
        x@source$configs$south - wbw_yres(x),
        x@source$configs$north
      )
    crs <- if (x@source$configs$epsg_code == 0) {
      x@source$configs$coordinate_ref_system_wkt
    } else {
      terra::crs(paste0("epsg:", x@source$configs$epsg_code))
    }

    # Convert
    new_rast <-
      terra::rast(
        vals = v,
        nlyrs = 1L,
        crs = crs,
        extent = ext,
        resolution = wbw_res(x),
        names = x@name
      )

    # Convert to integer if necessary
    if (wbw_is_int(x)) {
      new_rast <- terra::as.int(new_rast)
    }

    # Return
    new_rast
  }

#' Convert SpatRaster to WhiteboxRaster
#' @keywords terra
#'
#' Converts a SpatRaster to a [WhiteboxRaster] object
#'
#' @param x SpatRaster object
#'
#' @return [WhiteboxRaster] object
#'
#' @seealso [WhiteboxRaster()]
#'
#' @examples
#' \dontrun{
#' library(terra)
#' f <- system.file("extdata/dem.tif", package = "wbw")
#' rast(f) |>
#'   as_wbw_raster()
#' }
#' @export
as_wbw_raster <-
  S7::new_generic(
    name = "as_wbw_raster",
    dispatch_args = "x",
    fun = function(x) {
      S7::S7_dispatch()
    }
  )

if (requireNamespace("terra", quietly = TRUE)) {
  S7::method(
    as_wbw_raster,
    methods::getClass("SpatRaster", where = asNamespace("terra"))
  ) <-
    function(x) {
      # Checks
      checkmate::assert_class(
        wbw,
        classes = c(
          "python.builtin.module",
          "python.builtin.object"
        )
      )
      checkmate::assert_true(
        terra::nlyr(x) == 1
      )

      # SpatRaster information
      na_terra <- terra::NAflag(x)
      nodata_value <- if (is.nan(na_terra)) {
        -9999
      } else {
        na_terra
      }
      res_terra <- terra::res(x)
      name_terra <- names(x)
      type_terra <- any(c(
        terra::is.int(x),
        terra::is.bool(x),
        terra::is.factor(x)
      ))
      ext_terra <- terra::ext(x)
      data_terra <- as.matrix(x, wide = TRUE)
      data_terra[is.na(data_terra)] <- nodata_value

      # Create new RasterConfigs
      new_config <- wbw$RasterConfigs()
      new_config$title <- name_terra

      # Dimensions
      new_config$bands <- as.integer(terra::nlyr(x))
      new_config$columns <- as.integer(terra::ncol(x))
      new_config$rows <- as.integer(terra::nrow(x))
      new_config$west <- as.double(ext_terra[1])
      ## Note the differences in east and south between reading by
      ## GDAL (i.e. terra) and WhiteboxTools
      new_config$east <- as.double(ext_terra[2]) - res_terra[1]
      new_config$south <- as.double(ext_terra[3]) + res_terra[2]
      new_config$north <- as.double(ext_terra[4])

      # CRS
      new_config$coordinate_ref_system_wkt <- terra::crs(x)
      new_config$resolution_x <- res_terra[1]
      new_config$resolution_y <- res_terra[2]

      # Data type
      new_config$nodata <- nodata_value
      new_config$data_type <-
        if (type_terra) {
          wbw$RasterDataType$I16
        } else {
          wbw$RasterDataType$F32
        }

      # Create WhiteboxRaster
      new_raster <- wbe$new_raster(new_config)
      wbw_env$matrix_to_wbw(data_terra, new_raster)

      WhiteboxRaster(
        name = name_terra,
        source = new_raster
      )
    }
}
