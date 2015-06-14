#
# Rforecastio
#
# Simple R interface to forecast.io JSON weather data
#
# API Docs: https://developer.forecast.io/docs/v2
# Dev site: https://developer.forecast.io/
#
# Copyright (c) 2014 Bob Rudis (@hrbrmstr) bob@rudis.net
#
# MIT License
#

require(RJSONIO)
require(RCurl)
require(plyr)

#' Obtain data from \url{http://forecast.io}
#'
#' @param api.key your forecast.io API key
#' @param latitude forecast latitude (character, decimal format)
#' @param longitude forecast longitude (character, decimal format)
#' @param for.time Unix timestamp if requesting history (optional)
#' @param time.formatter specify \code{as.POSIXct} or \code{as.POSIXlt} (defaults to \code{as.POSIXlt})
#' @param ... named values that are interpreted as CURL options governing the request (i.e. if you have SSL certificate issues or need to use a proxy)
#' @import plyr RCurl RJSONIO
#' @export
#' @return a list of four named elements:
#' \itemize{
#'   \item{\code{json}}{ which is the converted (to R object) JSON from forecast.io, which is great for extracting the metadata}
#'   \item{\code{hourly.df}}{ which has the hourly readings/forecast}
#'   \item{\code{daily.df}}{ which has the daily summary/forecast}
#'   \item{\code{minutely.df}}{ which is \code{NULL} if \code{for.time} was not used, otherwise will have the "minutely" forecast as a data frame}
#' }
#' @examples
#' \dontrun{
#' # NEVER put API keys in revision control systems or source code!
#' fio.api.key = readLines("~/.forecast.io")
#'
#' my.latitude = "43.2673"
#' my.longitude = "-70.8618"
#'
#' # get data for "no"
#' fio.list <- fio.forecast(fio.api.key, my.latitude, my.longitude)
#'
#' # or
#'
#' fio.list <- fio.forecast(fio.api.key, my.latitude, my.longitude, for.time=as.integer(Sys.time())-(60*60*6))
#' }
#'
fio.forecast <- function(api.key, latitude, longitude, for.time, time.formatter=as.POSIXlt, ...) {

  # using RCurl's getURLContent() since it fully supports http or https
  if (missing(for.time)) {
    fio.json <- getURLContent(url=sprintf("https://api.forecast.io/forecast/%s/%s,%s",
                                      api.key, latitude, longitude), 
                              .opts = list(ssl.verifypeer = FALSE, followlocation=TRUE), ...)
  } else {
    fio.json <- getURLContent(url=sprintf("https://api.forecast.io/forecast/%s/%s,%s,%d",
                                      api.key, latitude, longitude, for.time), 
                              .opts = list(ssl.verifypeer = FALSE, followlocation=TRUE), ...)
  }

  if (class(fio.json) == "raw") {
    fio.json <- rawToChar(fio.json)
  }

  # take the JSON blob we got from forecast.io and make an R list from it
  fio <- fromJSON(fio.json)

  # extract hourly forecast data
  fio.hourly.df <- ldply(fio$hourly$data, data.frame)
  fio.hourly.df$time <- timely(time.formatter, fio.hourly.df$time, origin="1970-01-01")

  # extract daily forecast data
  fio.daily.df <-  ldply(fio$daily$data, data.frame)
  fio.daily.df$time <- timely(time.formatter, fio.daily.df$time, origin="1970-01-01")
  fio.daily.df$sunriseTime <- timely(time.formatter, fio.daily.df$sunriseTime, origin="1970-01-01")
  fio.daily.df$sunsetTime <- timely(time.formatter, fio.daily.df$sunsetTime, origin="1970-01-01")
  fio.daily.df$temperatureMinTime <- timely(time.formatter, fio.daily.df$temperatureMinTime, origin="1970-01-01")
  fio.daily.df$temperatureMaxTime <- timely(time.formatter, fio.daily.df$temperatureMaxTime, origin="1970-01-01")
  fio.daily.df$apparentTemperatureMinTime <- timely(time.formatter, fio.daily.df$apparentTemperatureMinTime, origin="1970-01-01")
  fio.daily.df$apparentTemperatureMaxTime <- timely(time.formatter, fio.daily.df$apparentTemperatureMaxTime, origin="1970-01-01")
  fio.daily.df$precipIntensityMaxTime <- timely(time.formatter, fio.daily.df$precipIntensityMaxTime, origin="1970-01-01")

  # 'minutely' only returns for current forecast
  if (missing(for.time)) {

    # if "minutely" is in the return values
    if ("minutely" %in% names(fio)) {

      # extract minutely forecast data
      # the structure returned has missing fields so we ahve to account for that
      fio.minutely.df <- do.call("rbind.fill", lapply(fio$minutely$data, function(x) {
        if (typeof(x) == "list") {
          return(data.frame(x))
        } else {
          tmp <- data.frame(rbind(x))
        }
      }))
      fio.minutely.df$time <- timely(time.formatter, fio.minutely.df$time, origin="1970-01-01")

    } else {
      fio.minutely.df <- NULL
    }

  } else {

    fio.minutely.df <- NULL

  }

  return(list(json=fio,
              hourly.df=fio.hourly.df,
              daily.df=fio.daily.df,
              minutely.df=fio.minutely.df))

}

# added this via Stefan Fritsch
timely <- function(time.formatter, x, ...) {
  if (!is.function(time.formatter)) stop("time.formatter is not a function.")
  if (!is.null(x)) time.formatter(x, ...) else NULL
}

