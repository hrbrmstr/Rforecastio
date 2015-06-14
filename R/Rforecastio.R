#' Get or set FORECASTIO_API_KEY value
#'
#' The API wrapper functions in this package all rely on a ForecastIO API
#' key residing in the environment variable \code{FORECASTIO_API_KEY}. The
#' easiest way to accomplish this is to set it in the `\code{.Renviron}` file in your
#' home directory.
#'
#' @param force force setting a new ForecastIO API key for the current environment?
#' @return atomic character vector containing the ForecastIO API key
#' @export
forecastio_api_key <- function(force = FALSE) {

  env <- Sys.getenv('FORECASTIO_API_KEY')
  if (!identical(env, "") && !force) return(env)

  if (!interactive()) {
    stop("Please set env var FORECASTIO_API_KEY to your ForecastIO API key",
      call. = FALSE)
  }

  message("Couldn't find env var FORECASTIO_API_KEY See ?forecastio_api_key for more details.")
  message("Please enter your API key and press enter:")
  pat <- readline(": ")

  if (identical(pat, "")) {
    stop("PassiveTotal API key entry failed", call. = FALSE)
  }

  message("Updating FORECASTIO_API_KEY env var to PAT")
  Sys.setenv(FORECASTIO_API_KEY = pat)

  pat

}

#' Retrieve the current forecast (for the next week)
#'
#' The Forecast API lets you query for most locations on the globe, and returns:
#' \enumerate{
#'   \item{current conditions}
#'   \item{minute-by-minute forecasts out to 1 hour (where available)}
#'   \item{hour-by-hour forecasts out to 48 hours}
#'   \item{day-by-day forecasts out to 7 days}
#' }
#'
#' If you wish to have results in something besides Imperial units, set \code{units} to
#' one of (\code{si}, \code{ca}, \code{uk}). Setting \code{units} to \code{auto} will
#' have the API select the relevant units automatically, based on geographic location. This
#' value is set to \code{us} (Imperial) units by default.
#'
#' If you wish to have text summaries presented in a different language, set \code{language} to
#' one of (\code{ar}, \code{bs}, \code{de}, \code{es}, \code{fr}, \code{it}, \code{nl}, \code{pl},
#' \code{pt}, \code{ru}, \code{sv}, \code{tet}, \code{tr}, \code{x-pig-latin}, \code{zh}). This value
#' is set to \code{en} (English) by default.
#'
#' See the Options section of the official \href{https://developer.forecast.io/docs/v2}{Forecast API documentation}
#' for more information.
#' @param latitude forecast latitude (character, decimal format)
#' @param longitude forecast longitude (character, decimal format)
#' @param units return the API response in units other than the default Imperial unit
#' @param language return text summaries in the desired language
#' @param exclude exclude some number of data blocks from the API response. This is useful for
#'        reducing latency and saving cache space. This should be a comma-separated string
#'        (without spaces) including one or more of the following: (\code{currently}, \code{minutely},
#'        \code{hourly}, \code{daily}, \code{alerts}, \code{flags}). Crafting a request with all of
#'        the above blocks excluded is exceedingly silly and not recommended. Setting this parameter
#'        to \code{NULL} (the default) does not exclude any parameters from the results.
#' @param extend setting this parameter to \code{hourly} the API will return hourly data for the
#'        next seven days, rather than the next two.
#' @return an \code{rforecastio} object that contains the original JSON response object, a list
#'         of  named `tbl_df` `data.frame` objects corresponding to what was returned by the API and
#'         relevant response headers (\code{cache-control}, \code{expires}, \code{x-forecast-api-calls},
#'         \code{x-response-time}).
#' @export
#' @note You must have \code{FORECASTIO_API_KEY} in you \code{.Renvion} file for this to work
#' @examples
#' tmp <- get_current_forecast(37.8267, -122.423)
get_current_forecast <- function(latitude, longitude,
                                 units="us", language="en",
                                 exclude=NULL, extend=NULL) {

  url <- sprintf("https://api.forecast.io/forecast/%s/%s,%s",
                 forecastio_api_key(), latitude, longitude)

  params <- list(units=units, language=language)

  if (!is.null(exclude)) params$exclude <- exclude
  if (!is.null(extend)) params$extend <- extend

  resp <- GET(url, query=params)
  stop_for_status(resp)

  tmp <- content(resp, as="parsed")

  lys <- c("hourly", "minutely", "daily")

  # hourly, minutely and daily blocks might not be in the response
  # so only process the ones that are actually in the response

  lapply(lys[which(lys %in% names(tmp))], function(x) {

    dat <- bind_rows(lapply(tmp[[x]]$data, as_data_frame))

    # various time fields might not be in the block data, so only
    # process which ones are in the block data

    ftimes <- c("time", "sunriseTime", "sunsetTime", "temperatureMinTime",
                "temperatureMaxTime", "apparentTemperatureMinTime",
                "apparentTemperatureMaxTime", "precipIntensityMaxTime")

    # convert times to POSIXct since they make sense in tbl_dfs/data.frames

    ly <- mutate_each_(dat, funs(convert_time), vars=ftimes[which(ftimes %in% colnames(dat))])

  }) -> fio_data

  fio_data <- setNames(fio_data, lys[which(lys %in% names(tmp))])

  # add currently as a data frame to the return list since that's helpful for
  # rbinding later for folks

  if ("currently" %in% names(tmp)) {
    currently <- as_data_frame(tmp$currently)
    if ("time" %in% colnames(currently)) {
      currently <- mutate(currently, time=convert_time(time))
    }
    fio_data$currently <- currently
  }

  fio_data$json <- tmp

  dev_heads <- c("cache-control", "expires", "x-forecast-api-calls", "x-response-time")
  ret_heads <- headers(resp)

  ret_val <- c(fio_data, ret_heads[dev_heads[which(dev_heads %in% names(ret_heads))]])
  class(ret_val) <- c("rforecastio", class(ret_val))
  return(ret_val)

}

#' Retrieve weather data for a specific place/time
#'
#' Query for a specific time, past or future (for many places, 60 years in the past to 10 years in the future).
#'
#' If you wish to have results in something besides Imperial units, set \code{units} to
#' one of (\code{si}, \code{ca}, \code{uk}). Setting \code{units} to \code{auto} will
#' have the API select the relevant units automatically, based on geographic location. This
#' value is set to \code{us} (Imperial) units by default.
#'
#' If you wish to have text summaries presented in a different language, set \code{language} to
#' one of (\code{ar}, \code{bs}, \code{de}, \code{es}, \code{fr}, \code{it}, \code{nl}, \code{pl},
#' \code{pt}, \code{ru}, \code{sv}, \code{tet}, \code{tr}, \code{x-pig-latin}, \code{zh}). This value
#' is set to \code{en} (English) by default.
#'
#' See the Options section of the official \href{https://developer.forecast.io/docs/v2}{Forecast API documentation}
#' for more information.
#'
#' @param latitude forecast latitude (character, decimal format)
#' @param longitude forecast longitude (character, decimal format)
#' @param timestamp should either be a UNIX time (that is, seconds since midnight GMT on 1 Jan 1970)
#'        or a string formatted as follows: \code{[YYYY]-[MM]-[DD]T[HH]:[MM]:[SS]} (with an optional
#'        time zone formatted as \code{Z} for GMT time or \code{[+|-][HH][MM]} for an offset in hours
#'        or minutes). For the latter format, if no timezone is present, local time (at the provided
#'         latitude and longitude) is assumed. (This string format is a subset of ISO 8601 time. An
#'         as example, \code{2013-05-06T12:00:00-0400}.)
#' @param units return the API response in units other than the default Imperial unit
#' @param language return text summaries in the desired language
#' @param exclude exclude some number of data blocks from the API response. This is useful for
#'        reducing latency and saving cache space. This should be a comma-separated string
#'        (without spaces) including one or more of the following: (\code{currently}, \code{minutely},
#'        \code{hourly}, \code{daily}, \code{alerts}, \code{flags}). Crafting a request with all of
#'        the above blocks excluded is exceedingly silly and not recommended. Setting this parameter
#'        to \code{NULL} (the default) does not exclude any parameters from the results.
#' @return an \code{rforecastio} object that contains the original JSON response object, a list
#'         of  named `tbl_df` `data.frame` objects corresponding to what was returned by the API and
#'         relevant response headers (\code{cache-control}, \code{expires}, \code{x-forecast-api-calls},
#'         \code{x-response-time}).
#' @export
#' @note You must have \code{FORECASTIO_API_KEY} in you \code{.Renvion} file for this to work
#' @examples
#' tmp <- get_forecast_for(37.8267,-122.423, "2013-05-06T12:00:00-0400")
get_forecast_for <- function(latitude, longitude, timestamp,
                             units="us", language="en", exclude=NULL) {

  # see comments in get_current_forecast since I was too lazy to abstract out the
  # common bits

  url <- sprintf("https://api.forecast.io/forecast/%s/%s,%s,%s",
                 forecastio_api_key(), latitude, longitude, timestamp)

  params <- list(units=units, language=language)

  if (!is.null(exclude)) params$exclude <- exclude

  resp <- GET(url, query=params)
  stop_for_status(resp)

  tmp <- content(resp, as="parsed")

  lys <- c("hourly", "minutely", "daily")

  lapply(lys[which(lys %in% names(tmp))], function(x) {

    dat <- bind_rows(lapply(tmp[[x]]$data, as_data_frame))

    ftimes <- c("time", "sunriseTime", "sunsetTime", "temperatureMinTime",
                "temperatureMaxTime", "apparentTemperatureMinTime",
                "apparentTemperatureMaxTime", "precipIntensityMaxTime")

    ly <- mutate_each_(dat, funs(convert_time), vars=ftimes[which(ftimes %in% colnames(dat))])

  }) -> fio_data

  fio_data <- setNames(fio_data, lys[which(lys %in% names(tmp))])

  if ("currently" %in% names(tmp)) {
    currently <- as_data_frame(tmp$currently)
    if ("time" %in% colnames(currently)) {
      currently <- mutate(currently, time=convert_time(time))
    }
    fio_data$currently <- currently
  }

  fio_data$json <- tmp

  dev_heads <- c("cache-control", "expires", "x-forecast-api-calls", "x-response-time")
  ret_heads <- headers(resp)

  ret_val <- c(fio_data, ret_heads[dev_heads[which(dev_heads %in% names(ret_heads))]])
  class(ret_val) <- c("rforecastio", class(ret_val))
  return(ret_val)

}

# helper function to convert timestamps
# not really needed but it makes the mutate_each_ call a bit cleaner this way
convert_time <- function(x) as.POSIXct(x, origin="1970-01-01")
