\name{Rforecastio-package}
\alias{Rforecastio-package}
\alias{Rforecastio}
\docType{package}
\title{
Simple R interface to forecast.io weather data
}
\description{
single function - fio.forecast() - that will return metadata and hourly/minutely (if avaialble) forecast info in data frames

Ref:

- forecast.io API Docs: https://developer.forecast.io/docs/v2
- forecast.io Dev site: https://developer.forecast.io/
}
\details{
\tabular{ll}{
Package: \tab Rforecastio\cr
Type: \tab Package\cr
Version: \tab 1.0.1\cr
Date: \tab 2013-09-08\cr
License: \tab MIT\cr
}

The one and only function is fio.forecast()

 for just the forecat, pass in your:

 - forecast.io api key (character)
 - latitude (characeter)
 - longitude (character)

 for history, pass the time (unix timestamp format) to for.time

 returns a list of three named elements:

 - "json" which is the converted (to R object) JSON from forecast.io,
   which is great for extracting the metadata

 - "hourly.df" which has the hourly readings/forecast

 - "minutely.df" which is NULL if "for.time" was not used, otherwise will have
   the "minutely" forecast as a data frame

}
\author{
Maintainer: Bob Rudis <bob@rudis..net>
}
\references{
}
\keyword{ package }
\seealso{
}
\examples{
# fio.list <- fio.forecast(fio.api.key, my.latitude, my.longitude)
# fio.list <- fio.forecast(fio.api.key, my.latitude, my.longitude, for.time=as.integer(Sys.time())-(60*60*6))
}
