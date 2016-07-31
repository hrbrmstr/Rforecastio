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
