% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/conversion.R
\name{wbw_to_radians}
\alias{wbw_to_radians}
\title{Convert to radians}
\usage{
wbw_to_radians(x)
}
\arguments{
\item{x}{Raster object of class \link{WhiteboxRaster}. See \code{\link[=wbw_read_raster]{wbw_read_raster()}} for more details.}
}
\value{
\link{WhiteboxRaster} object in radians
}
\description{
Convert to radians
}
\examples{
f <- system.file("extdata/dem.tif", package = "wbw")
wbw_read_raster(f) |>
  wbw_slope(units = "d") |>
  wbw_to_radians()
}
\seealso{
\code{\link[=wbw_to_degrees]{wbw_to_degrees()}}, \code{\link[=wbw_slope]{wbw_slope()}}
}
\keyword{Converts}
\keyword{[WhiteboxRaster]}
\keyword{a}
\keyword{conversions}
\keyword{degrees}
\keyword{from}
\keyword{radians}
\keyword{to}
