% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/conversion.R
\name{wbw_to_degrees}
\alias{wbw_to_degrees}
\title{Convert to degrees}
\usage{
wbw_to_degrees(x)
}
\arguments{
\item{x}{Raster object of class \link{WhiteboxRaster}. See \code{\link[=wbw_read_raster]{wbw_read_raster()}} for more details.}
}
\value{
\link{WhiteboxRaster} object in degrees
}
\description{
Convert to degrees
}
\examples{
f <- system.file("extdata/dem.tif", package = "wbw")
wbw_read_raster(f) |>
  wbw_slope(units = "r") |>
  wbw_to_degrees()
}
\seealso{
\code{\link[=wbw_to_radians]{wbw_to_radians()}}, \code{\link[=wbw_slope]{wbw_slope()}}
}
\keyword{Converts}
\keyword{[WhiteboxRaster]}
\keyword{a}
\keyword{conversions}
\keyword{degrees}
\keyword{from}
\keyword{radians}
\keyword{to}
