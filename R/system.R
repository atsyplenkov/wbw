#' Set Maximum Parallel Processors
#' @keywords system
#'
#' @description
#' Determines the number of processors used by functions that are parallelized.
#' If set to -1 (`max_procs=-1`), the default, all available processors will be
#' used. To limit processing, set `max_procs` to a positive whole number less 
#' than the number of system processors.
#'
#' @param max_procs \code{integer} Number of processors to use. Use -1 for all
#'   available processors, or a positive integer to limit processor usage.
#'
#' @eval rd_wbw_link("max_procs")
#'
#' @examples
#' \dontrun{
#' raster_path <- system.file("extdata/dem.tif", package = "wbw")
#' x <- wbw_read_raster(raster_path)
#'
#' # Use 1 processor
#' wbw_max_procs(1)
#' system.time(wbw_slope(x))
#'
#' # Use all available processors
#' wbw_max_procs(-1)
#' system.time(wbw_slope(x))
#' }
#' @export
wbw_max_procs <-
  function(max_procs = -1) {
    check_env(wbe)
    max_procs <- checkmate::asInteger(
      max_procs,
      len = 1
    )
    checkmate::assert_true(
      max_procs >= -1 && max_procs != 0
    )
    wbe$max_procs <- max_procs
  }
