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
wbw_max_procs <- function(max_procs = -1) {
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

#' Download Sample Data
#' @keywords system
#'
#' @description
#' There are a number of available sample datasets that can be readily used
#' to test Whitebox Workflows for Python.
#'
#' @param data_set \code{character}, dataset name. See Details
#' @param path \code{character}, path to where download sample datasets. If
#' \code{NULL}, the currect working directory is used
#'
#' @details
#' Available datasets:
#'
#' | **Dataset Name** | **Description** | **Size** |
#' |-----------------|-----------------|-----------|
#' | Guelph_landsat | Landsat 5 sub-area (7 bands) | 10.9 MB |
#' | Grand_Junction | Small DEM in high-relief terrain | 5.8 MB |
#' | GTA_lidar | Airborne lidar point cloud (LAZ) | 54.3 MB |
#' | jay_brook | Airborne lidar point cloud (LAZ) | 76.3 MB |
#' | Jay_State_Forest | Lidar-derived DEM | 27.7 MB |
#' | Kitchener_lidar | Airborne lidar point cloud (LAZ) | 41.6 MB |
#' | London_air_photo | High-resolution RGB air photo | 87.3 MB |
#' | mill_brook | Airborne lidar point cloud (LAZ) | 49.9 MB |
#' | peterborough_drumlins | Lidar-derived DEM | 22.0 MB |
#' | Southern_Ontario_roads | Vector roads layer | 7.1 MB |
#' | StElisAk | Airborne lidar point cloud (LAZ) | 54.5 MB |
#'
#' @examples
#' \dontrun{
#' # Download sample data
#' wbw_download_sample_data(data_set = "Guelph_landsat", path = tempdir())
#' }
#' @export
#' @importFrom utils download.file unzip
wbw_download_sample_data <- function(data_set = NULL, path = NULL) {
  # Set Download Path if NULL
  if (is.null(path)) {
    path <- getwd()
  }
  checkmate::assert_directory(
    path,
    access = "w"
  )

  # Select Dataset
  data_set <- checkmate::matchArg(
    data_set,
    choices = c(
      "Guelph_landsat",
      "Grand_Junction",
      "GTA_lidar",
      "jay_brook",
      "Jay_State_Forest",
      "Kitchener_lidar",
      "London_air_photo",
      "mill_brook",
      "peterborough_drumlins",
      "Southern_Ontario_roads",
      "StElisAk"
    )
  )

  # Create sub-directory if it doesn't exist
  download_path <- file.path(path, data_set)
  if (!dir.exists(download_path)) {
    dir.create(download_path)
  }

  # Download Data
  base_url <- "https://www.whiteboxgeo.com/sample_data/"
  data_url <- paste0(base_url, data_set, ".zip")
  download.file(
    data_url,
    destfile = file.path(download_path, paste0(data_set, ".zip"))
  )

  # Unzip Data
  temp_dir <- file.path(download_path, "temp_extract")
  dir.create(temp_dir)

  unzip(
    file.path(download_path, paste0(data_set, ".zip")),
    exdir = temp_dir
  )

  # Check if data_set folder exists inside the extracted contents
  dataset_folder <- file.path(temp_dir, data_set)
  if (dir.exists(dataset_folder)) {
    # If dataset folder exists, move its contents to download_path
    files_to_move <- list.files(dataset_folder, full.names = TRUE)
    file.copy(files_to_move, download_path, recursive = TRUE)
  } else {
    # If no specific dataset folder, move all contents except __MACOSX
    all_contents <- list.files(temp_dir, full.names = TRUE)
    files_to_move <- all_contents[!grepl("__MACOSX", all_contents)]
    file.copy(files_to_move, download_path, recursive = TRUE)
  }

  # Clean up
  unlink(temp_dir, recursive = TRUE)
  unlink(file.path(download_path, paste0(data_set, ".zip")))

  # Return download path
  cli::cli_alert_success(
    c(
      "Sample dataset '{.val {data_set}}' ",
      "downloaded to: {.file {download_path}}"
    )
  )
  return(download_path)
}
