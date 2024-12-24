#' @export
wbw_to_rast <-
  function(raster) {
    check_input_raster(raster)
    check_package("terra")

    raster_matrix <-
      wbw_to_matrix(raster)
    raster_ext <-
      c(
        raster$configs$west,
        raster$configs$east,
        raster$configs$south,
        raster$configs$north
      )

    # TODO:
    # - check CRS
    # - what to do if CRS is not defined
    raster_crs <-
      raster$configs$coordinate_ref_system_wkt

    terra::rast(
      raster_matrix,
      crs = raster_crs,
      extent = raster_ext
    )
  }
