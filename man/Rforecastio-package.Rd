\name{Rforecastio-package}
\alias{Rforecastio-package}
\alias{Rforecastio}
\docType{package}
\title{
Simple R interface to forecast.io weather data
}
\description{
Single function - \code{fio.forecast()} - that will return metadata and hourly/daily/minutely (if avaialble) forecast info in data frames

Ref:

\itemize{
\item forecast.io API Docs: \url{https://developer.forecast.io/docs/v2}
\item forecast.io Dev site: \url{https://developer.forecast.io/}
}

}
\details{
\tabular{ll}{
Package: \tab Rforecastio\cr
Type: \tab Package\cr
Version: \tab 1.2.0\cr
Date: \tab 2014-05-05\cr
License: \tab MIT\cr
}

The one and only function is fio.forecast()

 for just the forecat, pass in your:

\itemize{
\item forecast.io api key (character)
\item latitude (characeter)
\item longitude (character)
}

 for history, pass the time (unix timestamp format) to \code{for.time}

 returns a list of four named elements:

\itemize{
\item \code{json} which is the converted (to R object) JSON from forecast.io, which is great for extracting the metadata
\item \code{hourly.df} which has the hourly readings/forecast
\item \code{daily.df} which has the daily summary/forecast
\item \code{minutely.df} which is NULL if "for.time" was not used, otherwise will have the "minutely" forecast as a data frame
}

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
\dontrun{
# NEVER put API keys in revision control systems or source code!
fio.api.key = readLines("~/.forecast.io")

my.latitude = "43.2673"
my.longitude = "-70.8618"

# get data for "no"
fio.list <- fio.forecast(fio.api.key, my.latitude, my.longitude)

# or

fio.list <- fio.forecast(fio.api.key, my.latitude, my.longitude, for.time=as.integer(Sys.time())-(60*60*6))
}
}
