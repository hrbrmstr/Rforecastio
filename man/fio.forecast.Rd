\name{fio.forecast}
\alias{fio.forecast}
\title{obtain data from http://forecast.io}
\usage{
fio.forecast(api.key, latitude, longitude, for.time)
}
\arguments{
  \item{api.key}{your forecast.io API key}

  \item{latitude}{forecast latitude (character, decimal
  format)}

  \item{longitude}{forecast longitude (character, decimal
  format)}

  \item{for.time}{unix timestamp if requesting history
  (optional)}
}
\value{
a list of three named elements:\cr \itemize{ \item
\code{json} which is the converted (to R object) JSON from
forecast.io, which is great for extracting the metadata
\item \code{hourly.df} which has the hourly
readings/forecast \item \code{daily.df} which has the daily
summary/forecast \item \code{minutely.df} which is NULL if
"for.time" was not used, otherwise will have the "minutely"
forecast as a data frame }
}
\description{
obtain data from http://forecast.io
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

