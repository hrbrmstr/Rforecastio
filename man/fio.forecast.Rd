\name{fio.forecast}
\alias{fio.forecast}
\title{Retrieve forecast/readings from forecast.io}
\usage{
  fio.api.key = readLines("~/.forecast.io")
  
  my.latitude = "43.2673"
  my.longitude = "-70.8618"
  
  fio.list <- fio.forecast(fio.api.key, my.latitude, my.longitude)
  
  # or for historical data + forecast
  
  fio.list <- fio.forecast(fio.api.key, my.latitude, my.longitude, 
                           for.time=as.integer(Sys.time())-(60*60*6))
}
\arguments{
  \item{base_size}{Base font size.}
  
  \item{base_family}{Base font family.}
  
  \item{use_sizes}{If \code{TRUE}, then define sizes and
                   locations with reasonable defaults taken from
                   \code{\link{theme_gray}}.}
}
\description{
really simple R interface to forecast.io JSON data
}
\details{
 obtain data from http://forecast.io

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
\seealso{
}