[![Build Status](https://travis-ci.org/hrbrmstr/Rforecastio.svg)](https://travis-ci.org/hrbrmstr/Rforecastio)

Rforecastio - API access to the [Forecast API](https://developer.forecast.io/docs/v2) from R.

-   Forecast API Docs: <https://developer.forecast.io/docs/v2>
-   Forecast Dev site: <https://developer.forecast.io/>

**NOTE: THIS IS A MAJOR REWRITE OF THE INTERFACE**

One of the biggest changes (besides splitting one function into two) is that the API wrapper functions in this package all rely on a ForecastIO API key that now resides in the environment variable . The easiest way to get this into your environment is to set it in the `\code{.Renviron}` file in your home directory.

The following functions are implemented:

-   `forecastio_api_key` : Get or set FORECASTIO\_API\_KEY value
-   `get_current_forecast` : Retrieve the current forecast (for the next week)
-   `get_forecast_for` : Retrieve weather data for a specific place/time
-   `plot.rforecastio` : Plot method for rforecastio objects

There have been several major enhancements to the way this package works with the API. Also, the structures returned in the list are now classes as `rforecastio` objects (which afford the use of an S3 plotting method) and the data frames are now `tbl_df` objects (so they work like regular data frames but get all the `dplyr` goodness, too).

### News

-   Version 2.0.0 released - complete overhaul of the package

### Installation

``` r
devtools::install_github("hrbrmstr/Rforecastio")
```

### Usage

``` r
library(Rforecastio)
```

    ## Loading required package: ggplot2

``` r
# current verison
packageVersion("Rforecastio")
```

    ## [1] '2.0.0'

``` r
now <- get_current_forecast(43.2672, -70.8617)
print(now$hourly)
```

    ## Source: local data frame [49 x 16]
    ## 
    ##                   time       summary                icon precipIntensity precipProbability temperature
    ## 1  2015-06-14 18:00:00         Clear           clear-day               0                 0       70.56
    ## 2  2015-06-14 19:00:00 Partly Cloudy   partly-cloudy-day               0                 0       67.76
    ## 3  2015-06-14 20:00:00 Partly Cloudy   partly-cloudy-day               0                 0       64.87
    ## 4  2015-06-14 21:00:00 Partly Cloudy partly-cloudy-night               0                 0       62.43
    ## 5  2015-06-14 22:00:00 Partly Cloudy partly-cloudy-night               0                 0       61.31
    ## 6  2015-06-14 23:00:00 Mostly Cloudy partly-cloudy-night               0                 0       60.44
    ## 7  2015-06-15 00:00:00 Mostly Cloudy partly-cloudy-night               0                 0       59.35
    ## 8  2015-06-15 01:00:00      Overcast              cloudy               0                 0       59.03
    ## 9  2015-06-15 02:00:00      Overcast              cloudy               0                 0       58.60
    ## 10 2015-06-15 03:00:00      Overcast              cloudy               0                 0       58.13
    ## ..                 ...           ...                 ...             ...               ...         ...
    ## Variables not shown: apparentTemperature (dbl), dewPoint (dbl), humidity (dbl), windSpeed (dbl), windBearing (int),
    ##   visibility (dbl), cloudCover (dbl), pressure (dbl), ozone (dbl), precipType (chr)

``` r
then <- get_forecast_for(43.2672, -70.8617, "2013-05-06T12:00:00-0400")
print(then$daily)
```

    ## Source: local data frame [1 x 24]
    ## 
    ##         time          summary icon         sunriseTime          sunsetTime moonPhase precipIntensity precipIntensityMax
    ## 1 2013-05-06 Foggy overnight.  fog 2013-05-06 05:30:55 2013-05-06 19:51:42       0.9               0                  0
    ## Variables not shown: precipProbability (int), temperatureMin (dbl), temperatureMinTime (time), temperatureMax (dbl),
    ##   temperatureMaxTime (time), apparentTemperatureMin (dbl), apparentTemperatureMinTime (time), apparentTemperatureMax
    ##   (dbl), apparentTemperatureMaxTime (time), dewPoint (dbl), humidity (dbl), windSpeed (dbl), windBearing (int),
    ##   visibility (dbl), cloudCover (dbl), pressure (dbl)

``` r
print(sprintf("You have used %s API calls.", then$`x-forecast-api-calls`))
```

    ## [1] "You have used 33 API calls."

``` r
plot(now)
```

![](README_files/figure-markdown_github/unnamed-chunk-3-1.png)

### Test Results

``` r
library(Rforecastio)
library(testthat)

date()
```

    ## [1] "Sun Jun 14 18:36:21 2015"

``` r
test_dir("tests/")
```

    ## basic functionality : ..
