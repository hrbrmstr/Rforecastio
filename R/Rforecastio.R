# 
# Rforecastio
#
# Simple R interface to forecast.io JSON weather data
# 
# API Docs: https://developer.forecast.io/docs/v2
# Dev site: https://developer.forecast.io/
#
# Copyright (c) 2013 Bob Rudis (@hrbrmstr) bob@rudis.net
#
# MIT License
#

require(RJSONIO)
require(RCurl)

#
# fio.forecast()
#
# obtain data from http://forecast.io
#
# for just the forecat, pass in your:
#
# - forecast.io api key (character)
# - latitude (characeter)
# - longitude (character)
# 
# for history, pass the time (unix timestamp format) to for.time
#
# returns a list of three named elements:
#
# - "json" which is the converted (to R object) JSON from forecast.io,
#   which is great for extracting the metadata
#
# - "hourly.df" which has the hourly readings/forecast
#
# - "minutely.df" which is NULL if "for.time" was not used, otherwise will have
#   the "minutely" forecast as a data frame
#

fio.forecast <- function(api.key, latitude, longitude, for.time) {
  
  # using RCurl's getURLContent() since it fully supports http or https
  if (missing(for.time)) {
    fio.json <- getURLContent(sprintf("https://api.forecast.io/forecast/%s/%s,%s",
                                      api.key, latitude, longitude))
  } else {
    fio.json <- getURLContent(sprintf("https://api.forecast.io/forecast/%s/%s,%s,%d",
                                      api.key, latitude, longitude, for.time))
  }
  
  # take the JSON blob we got from forecast.io and make an R list from it
  fio <- fromJSON(fio.json)
  
  # extract hourly forecast data  
  fio.hourly.df <- data.frame(
    time = ISOdatetime(1960,1,1,0,0,0) + sapply(fio$hourly$data,"[[","time"),
    summary = sapply(fio$hourly$data,"[[","summary"),
    icon = sapply(fio$hourly$data,"[[","icon"),
    precipIntensity = sapply(fio$hourly$data,"[[","precipIntensity"),
    temperature = sapply(fio$hourly$data,"[[","temperature"),
    apparentTemperature = sapply(fio$hourly$data,"[[","apparentTemperature"),
    dewPoint = sapply(fio$hourly$data,"[[","dewPoint"),
    windSpeed = sapply(fio$hourly$data,"[[","windSpeed"),
    windBearing = sapply(fio$hourly$data,"[[","windBearing"),
    cloudCover = sapply(fio$hourly$data,"[[","cloudCover"),
    humidity = sapply(fio$hourly$data,"[[","humidity"),
    pressure = sapply(fio$hourly$data,"[[","pressure"),
    visibility = sapply(fio$hourly$data,"[[","visibility"),
    ozone = sapply(fio$hourly$data,"[[","ozone")
  )
  
  # 'minutely' only returns for current forecast
  if (missing(for.time)) {
    # extract minutely forecast data  
    fio.minutely.df <- data.frame(
      time = ISOdatetime(1960,1,1,0,0,0) + sapply(fio$minutely$data,"[[","time"),
      precipIntensity = sapply(fio$minutely$data,"[[","precipIntensity"),
      precipProbability = sapply(fio$minutely$data,"[[","precipProbability")
    )
  } else {
    fio.minutely.df <- NULL
  }
  
  return(list(json=fio, hourly.df=fio.hourly.df, minutely.df=fio.minutely.df))
  
}
