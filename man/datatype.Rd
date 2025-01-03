% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dimensions.R
\name{wbw_data_type}
\alias{wbw_data_type}
\alias{wbw_is_int}
\alias{wbw_is_float}
\alias{wbw_is_rgb}
\title{Get WhiteboxRaster data type}
\usage{
wbw_data_type(x)

wbw_is_int(x)

wbw_is_float(x)

wbw_is_rgb(x)
}
\arguments{
\item{x}{Raster object of class \link{WhiteboxRaster}. See \code{\link[=wbw_read_raster]{wbw_read_raster()}} for more details.}
}
\value{
\code{character} String representing the raster data type
}
\description{
Get WhiteboxRaster data type
}
\examples{
\dontrun{
raster_path <- system.file("extdata/dem.tif", package = "wbw")
wbw_read_raster(raster_path) |>
  wbw_data_type()
}
\dontrun{
raster_path <- system.file("extdata/dem.tif", package = "wbw")
wbw_read_raster(raster_path) |>
  wbw_is_int()
}
\dontrun{
raster_path <- system.file("extdata/dem.tif", package = "wbw")
wbw_read_raster(raster_path) |>
  wbw_is_float()
}
\dontrun{
raster_path <- system.file("extdata/dem.tif", package = "wbw")
wbw_read_raster(raster_path) |>
  wbw_is_rgb()
}
}
\keyword{utils}
