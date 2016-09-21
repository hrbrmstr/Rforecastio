
[![Build Status](https://travis-ci.org/hrbrmstr/Rforecastio.svg)](https://travis-ci.org/hrbrmstr/Rforecastio)

`Rforecastio` : Tools to Work with the Dark Sky API

-   Forecast API Docs: <https://darksky.net/dev/docs>
-   Forecast Dev site: <https://darksky.net/dev/>

The following functions are implemented:

-   `forecastio_api_key` : Get or set FORECASTIO\_API\_KEY value
-   `get_current_forecast` : Retrieve the current forecast (for the next week)
-   `get_forecast_for` : Retrieve weather data for a specific place/time
-   `plot.rforecastio` : Plot method for rforecastio objects
-   `print.rforecastio` : A tad more human readable default printing

There have been several major enhancements to the way this package works with the API. Also, the structures returned in the list are now classes as `rforecastio` objects (which afford the use of an S3 plotting method) and the data frames are now `tbl_df` objects (so they work like regular data frames but get all the `dplyr` goodness, too).

### News

-   2.3.0 - Fixed API URL (thx Lasse Vilhelmsen!)
-   2.2.0 - `print()` method, made JSON & headers optional in respons object, smarter printing
-   Version 2.1.1 released - fix "language" parameter per \#9
-   Version 2.1.0 released - added `httr::GET` pass-through `...` parameter to salient functions
-   Version 2.0.0 released - complete overhaul of the package
-   Version 2.0.1 released - Did a check `--as-cran` and fixed *many* things invisible to the users of this package

### Installation

``` r
devtools::install_github("hrbrmstr/Rforecastio")
```

### Usage

``` r
library(Rforecastio)

# current verison
packageVersion("Rforecastio")
```

    ## [1] '2.3.0'

``` r
now <- get_current_forecast(43.2672, -70.8617)
print(now)
```

    ## minutely 
    ## ======================================================================================================================== 
    ## Observations: 61
    ## Variables: 3
    ## $ time              <dttm> 2016-09-21 06:17:00, 2016-09-21 06:18:00, 2016-09-21 06:19:00, 2016-09-21 06:20:00, 2016...
    ## $ precipIntensity   <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
    ## $ precipProbability <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
    ## 
    ## hourly 
    ## ======================================================================================================================== 
    ## Observations: 49
    ## Variables: 16
    ## $ time                <dttm> 2016-09-21 06:00:00, 2016-09-21 07:00:00, 2016-09-21 08:00:00, 2016-09-21 09:00:00, 20...
    ## $ summary             <chr> "Clear", "Clear", "Clear", "Clear", "Clear", "Clear", "Clear", "Clear", "Clear", "Clear...
    ## $ icon                <chr> "clear-night", "clear-day", "clear-day", "clear-day", "clear-day", "clear-day", "clear-...
    ## $ precipIntensity     <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...
    ## $ precipProbability   <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...
    ## $ temperature         <dbl> 60.45, 61.04, 64.13, 68.18, 72.31, 75.73, 78.26, 80.47, 81.92, 82.34, 81.63, 79.48, 75....
    ## $ apparentTemperature <dbl> 60.45, 61.04, 64.13, 68.18, 72.31, 75.73, 78.26, 80.37, 81.23, 81.46, 80.91, 79.48, 75....
    ## $ dewPoint            <dbl> 57.17, 57.23, 58.11, 58.08, 57.35, 56.27, 55.12, 54.70, 54.21, 53.88, 53.33, 52.49, 51....
    ## $ humidity            <dbl> 0.89, 0.87, 0.81, 0.70, 0.59, 0.51, 0.45, 0.41, 0.39, 0.38, 0.38, 0.39, 0.43, 0.49, 0.5...
    ## $ windSpeed           <dbl> 5.50, 5.54, 5.98, 5.69, 5.95, 5.83, 5.14, 5.20, 5.27, 5.52, 5.79, 6.09, 4.70, 3.68, 3.4...
    ## $ windBearing         <int> 289, 296, 298, 303, 303, 300, 289, 277, 270, 267, 265, 264, 263, 259, 258, 257, 259, 26...
    ## $ visibility          <dbl> 9.25, 8.88, 9.08, 9.76, 10.00, 10.00, 10.00, 10.00, 10.00, 10.00, 10.00, 10.00, 10.00, ...
    ## $ cloudCover          <dbl> 0.10, 0.16, 0.17, 0.19, 0.19, 0.19, 0.21, 0.21, 0.21, 0.19, 0.17, 0.15, 0.15, 0.17, 0.1...
    ## $ pressure            <dbl> 1018.89, 1019.48, 1019.94, 1020.22, 1020.37, 1020.41, 1020.28, 1020.03, 1019.80, 1019.5...
    ## $ ozone               <dbl> 267.65, 268.17, 268.60, 268.86, 269.03, 269.12, 269.15, 269.11, 268.97, 268.71, 268.36,...
    ## $ precipType          <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,...
    ## 
    ## daily 
    ## ======================================================================================================================== 
    ## Observations: 8
    ## Variables: 27
    ## $ time                       <dttm> 2016-09-21, 2016-09-22, 2016-09-23, 2016-09-24, 2016-09-25, 2016-09-26, 2016-09...
    ## $ summary                    <chr> "Clear throughout the day.", "Partly cloudy overnight.", "Light rain starting in...
    ## $ icon                       <chr> "clear-day", "partly-cloudy-night", "rain", "clear-day", "clear-day", "clear-day...
    ## $ sunriseTime                <dttm> 2016-09-21 06:31:22, 2016-09-22 06:32:28, 2016-09-23 06:33:34, 2016-09-24 06:34...
    ## $ sunsetTime                 <dttm> 2016-09-21 18:43:59, 2016-09-22 18:42:09, 2016-09-23 18:40:19, 2016-09-24 18:38...
    ## $ moonPhase                  <dbl> 0.68, 0.72, 0.75, 0.79, 0.83, 0.86, 0.90, 0.93
    ## $ precipIntensity            <dbl> 0.000, 0.000, 0.003, 0.000, 0.000, 0.000, 0.000, 0.002
    ## $ precipIntensityMax         <dbl> 0.0000, 0.0000, 0.0151, 0.0000, 0.0000, 0.0000, 0.0000, 0.0049
    ## $ precipProbability          <dbl> 0.00, 0.00, 0.45, 0.00, 0.00, 0.00, 0.00, 0.17
    ## $ temperatureMin             <dbl> 60.45, 57.55, 52.51, 42.19, 38.67, 37.75, 37.23, 37.13
    ## $ temperatureMinTime         <dttm> 2016-09-21 06:00:00, 2016-09-22 05:00:00, 2016-09-23 23:00:00, 2016-09-24 23:00...
    ## $ temperatureMax             <dbl> 82.34, 78.79, 76.26, 64.89, 57.91, 62.08, 60.06, 63.78
    ## $ temperatureMaxTime         <dttm> 2016-09-21 15:00:00, 2016-09-22 14:00:00, 2016-09-23 12:00:00, 2016-09-24 15:00...
    ## $ apparentTemperatureMin     <dbl> 60.45, 57.55, 52.51, 38.69, 34.63, 33.62, 35.05, 37.13
    ## $ apparentTemperatureMinTime <dttm> 2016-09-21 06:00:00, 2016-09-22 05:00:00, 2016-09-23 23:00:00, 2016-09-24 23:00...
    ## $ apparentTemperatureMax     <dbl> 81.46, 78.79, 76.26, 64.89, 57.91, 62.08, 60.06, 63.78
    ## $ apparentTemperatureMaxTime <dttm> 2016-09-21 15:00:00, 2016-09-22 14:00:00, 2016-09-23 12:00:00, 2016-09-24 15:00...
    ## $ dewPoint                   <dbl> 55.47, 54.40, 53.39, 39.67, 33.36, 35.27, 35.13, 39.50
    ## $ humidity                   <dbl> 0.64, 0.65, 0.64, 0.63, 0.61, 0.64, 0.65, 0.68
    ## $ windSpeed                  <dbl> 4.44, 1.65, 3.99, 6.51, 8.39, 4.07, 1.96, 1.83
    ## $ windBearing                <int> 275, 172, 253, 314, 312, 313, 76, 144
    ## $ visibility                 <dbl> 9.66, 10.00, 10.00, 10.00, NA, NA, NA, NA
    ## $ cloudCover                 <dbl> 0.16, 0.11, 0.47, 0.04, 0.00, 0.03, 0.28, 0.80
    ## $ pressure                   <dbl> 1019.42, 1020.52, 1015.70, 1018.16, 1019.32, 1020.79, 1024.43, 1027.86
    ## $ ozone                      <dbl> 267.59, 258.92, 266.50, 307.41, 326.02, 313.50, 302.12, 297.17
    ## $ precipIntensityMaxTime     <dttm> NA, NA, 2016-09-23 20:00:00, NA, NA, NA, NA, 2016-09-28 22:00:00
    ## $ precipType                 <chr> NA, NA, "rain", NA, NA, NA, NA, "rain"
    ## 
    ## currently 
    ## ======================================================================================================================== 
    ## Observations: 1
    ## Variables: 17
    ## $ time                 <dttm> 2016-09-21 06:17:38
    ## $ summary              <chr> "Clear"
    ## $ icon                 <chr> "clear-night"
    ## $ nearestStormDistance <int> 26
    ## $ nearestStormBearing  <int> 192
    ## $ precipIntensity      <int> 0
    ## $ precipProbability    <int> 0
    ## $ temperature          <dbl> 60.62
    ## $ apparentTemperature  <dbl> 60.62
    ## $ dewPoint             <dbl> 57.19
    ## $ humidity             <dbl> 0.88
    ## $ windSpeed            <dbl> 5.5
    ## $ windBearing          <int> 291
    ## $ visibility           <dbl> 9.14
    ## $ cloudCover           <dbl> 0.12
    ## $ pressure             <dbl> 1019.06
    ## $ ozone                <dbl> 267.8

``` r
then <- get_forecast_for(43.2672, -70.8617, "2013-05-06T12:00:00-0400", add_headers=TRUE)
print(then)
```

    ## hourly 
    ## ======================================================================================================================== 
    ## Observations: 24
    ## Variables: 14
    ## $ time                <dttm> 2013-05-06 00:00:00, 2013-05-06 01:00:00, 2013-05-06 02:00:00, 2013-05-06 03:00:00, 20...
    ## $ summary             <chr> "Clear", "Clear", "Clear", "Clear", "Clear", "Clear", "Clear", "Partly Cloudy", "Partly...
    ## $ icon                <chr> "clear-night", "clear-night", "clear-night", "clear-night", "clear-night", "clear-night...
    ## $ precipIntensity     <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    ## $ precipProbability   <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    ## $ temperature         <dbl> 38.85, 37.09, 35.98, 34.41, 32.17, 32.31, 32.31, 38.90, 43.85, 48.67, 52.36, 56.46, 60....
    ## $ apparentTemperature <dbl> 37.07, 37.09, 35.98, 34.41, 32.17, 32.31, 29.67, 38.90, 41.82, 46.09, 52.36, 56.46, 60....
    ## $ dewPoint            <dbl> 34.70, 33.68, 33.52, 32.31, 30.45, 30.59, 30.41, 36.43, 38.67, 41.70, 43.14, 41.86, 41....
    ## $ humidity            <dbl> 0.85, 0.87, 0.91, 0.92, 0.93, 0.93, 0.93, 0.91, 0.82, 0.77, 0.71, 0.58, 0.50, 0.47, 0.4...
    ## $ windSpeed           <dbl> 3.00, NA, NA, NA, 2.94, NA, 3.00, NA, 3.94, 5.98, 5.52, 5.82, 6.03, 8.81, 9.40, 9.17, 7...
    ## $ windBearing         <int> 210, NA, NA, NA, 304, NA, 330, NA, 184, 166, 160, 173, 127, 101, 108, 141, 142, 127, 14...
    ## $ visibility          <dbl> 9.84, 8.23, 8.76, 8.46, 7.03, 6.77, 5.85, 8.40, 8.46, 10.00, 10.00, 10.00, 10.00, 10.00...
    ## $ cloudCover          <dbl> 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.59, 0.25, 0.16, 0.05, 0.05, 0.05, 0.05, 0.0...
    ## $ pressure            <dbl> 1024.98, 1024.88, 1024.66, 1024.38, 1024.04, 1024.10, 1024.40, 1024.92, 1025.14, 1025.3...
    ## 
    ## daily 
    ## ======================================================================================================================== 
    ## Observations: 1
    ## Variables: 24
    ## $ time                       <dttm> 2013-05-06
    ## $ summary                    <chr> "Foggy overnight."
    ## $ icon                       <chr> "fog"
    ## $ sunriseTime                <dttm> 2013-05-06 05:30:54
    ## $ sunsetTime                 <dttm> 2013-05-06 19:51:43
    ## $ moonPhase                  <dbl> 0.9
    ## $ precipIntensity            <int> 0
    ## $ precipIntensityMax         <int> 0
    ## $ precipProbability          <int> 0
    ## $ temperatureMin             <dbl> 32.17
    ## $ temperatureMinTime         <dttm> 2013-05-06 04:00:00
    ## $ temperatureMax             <dbl> 63.03
    ## $ temperatureMaxTime         <dttm> 2013-05-06 14:00:00
    ## $ apparentTemperatureMin     <dbl> 29.67
    ## $ apparentTemperatureMinTime <dttm> 2013-05-06 06:00:00
    ## $ apparentTemperatureMax     <dbl> 63.03
    ## $ apparentTemperatureMaxTime <dttm> 2013-05-06 14:00:00
    ## $ dewPoint                   <dbl> 39.32
    ## $ humidity                   <dbl> 0.76
    ## $ windSpeed                  <dbl> 4.54
    ## $ windBearing                <int> 140
    ## $ visibility                 <dbl> 8.05
    ## $ cloudCover                 <dbl> 0.18
    ## $ pressure                   <dbl> 1023.47
    ## 
    ## currently 
    ## ======================================================================================================================== 
    ## Observations: 1
    ## Variables: 14
    ## $ time                <dttm> 2013-05-06 12:00:00
    ## $ summary             <chr> "Clear"
    ## $ icon                <chr> "clear-day"
    ## $ precipIntensity     <int> 0
    ## $ precipProbability   <int> 0
    ## $ temperature         <dbl> 60.5
    ## $ apparentTemperature <dbl> 60.5
    ## $ dewPoint            <dbl> 41.59
    ## $ humidity            <dbl> 0.5
    ## $ windSpeed           <dbl> 6.03
    ## $ windBearing         <int> 127
    ## $ visibility          <int> 10
    ## $ cloudCover          <dbl> 0.05
    ## $ pressure            <dbl> 1024.18

``` r
# getting data for more than one location

more_than_one <- data.frame(loc=c("Maine", "Seattle"),
                            lon=c(43.2672, 47.6097),
                            lat=c(70.8617, 122.3331),
                            when=c("2013-05-06T12:00:00-0400",
                                   "2013-05-06T12:00:00-0400"),
                            stringsAsFactors=FALSE)

bigger_list <- mapply(get_forecast_for, 
       more_than_one$lon, more_than_one$lat, more_than_one$when,
       SIMPLIFY=FALSE)
names(bigger_list) <- more_than_one$loc

bigger_list$Seattle[[1]]
```

    ## # A tibble: 24 × 13
    ##                   time       summary                icon precipType temperature apparentTemperature dewPoint humidity
    ##                 <dttm>         <chr>               <chr>      <chr>       <dbl>               <dbl>    <dbl>    <dbl>
    ## 1  2013-05-06 12:00:00 Partly Cloudy partly-cloudy-night       rain       57.34               57.34    36.96     0.46
    ## 2  2013-05-06 13:00:00         Clear         clear-night       rain       55.78               55.78    37.89     0.51
    ## 3  2013-05-06 14:00:00         Clear         clear-night       rain       54.52               54.52    38.45     0.54
    ## 4  2013-05-06 15:00:00 Partly Cloudy partly-cloudy-night       rain       53.33               53.33    38.50     0.57
    ## 5  2013-05-06 16:00:00 Partly Cloudy partly-cloudy-night       rain       52.43               52.43    38.36     0.59
    ## 6  2013-05-06 17:00:00 Partly Cloudy   partly-cloudy-day       rain       52.86               52.86    38.38     0.58
    ## 7  2013-05-06 18:00:00 Mostly Cloudy   partly-cloudy-day       rain       55.25               55.25    38.42     0.53
    ## 8  2013-05-06 19:00:00 Partly Cloudy   partly-cloudy-day       rain       58.97               58.97    38.10     0.46
    ## 9  2013-05-06 20:00:00 Partly Cloudy   partly-cloudy-day       rain       63.02               63.02    37.66     0.39
    ## 10 2013-05-06 21:00:00 Partly Cloudy   partly-cloudy-day       rain       67.49               67.49    37.57     0.33
    ## # ... with 14 more rows, and 5 more variables: windSpeed <dbl>, windBearing <int>, visibility <dbl>, cloudCover <dbl>,
    ## #   pressure <dbl>

``` r
bigger_list$Maine[[1]]
```

    ## # A tibble: 24 × 13
    ##                   time summary        icon precipType temperature apparentTemperature dewPoint humidity windSpeed
    ##                 <dttm>   <chr>       <chr>      <chr>       <dbl>               <dbl>    <dbl>    <dbl>     <dbl>
    ## 1  2013-05-05 14:00:00   Clear clear-night       rain       53.29               53.29    35.65     0.51      3.41
    ## 2  2013-05-05 15:00:00   Clear clear-night       rain       52.38               52.38    36.48     0.55      3.32
    ## 3  2013-05-05 16:00:00   Clear clear-night       rain       51.25               51.25    40.43     0.66     13.00
    ## 4  2013-05-05 17:00:00   Clear clear-night       rain       48.31               48.31    37.36     0.66      2.53
    ## 5  2013-05-05 18:00:00   Clear clear-night       rain       50.96               50.96    38.04     0.61      2.05
    ## 6  2013-05-05 19:00:00   Clear clear-night       rain       50.25               50.25    38.24     0.63      3.49
    ## 7  2013-05-05 20:00:00   Clear clear-night       rain       48.85               48.36    36.79     0.63      3.01
    ## 8  2013-05-05 21:00:00   Clear   clear-day       rain       55.50               55.50    41.43     0.59      3.97
    ## 9  2013-05-05 22:00:00   Clear   clear-day       rain       61.63               61.63    41.26     0.47      1.12
    ## 10 2013-05-05 23:00:00   Clear   clear-day       rain       61.24               61.24    39.30     0.44      2.82
    ## # ... with 14 more rows, and 4 more variables: windBearing <int>, visibility <dbl>, cloudCover <dbl>, pressure <dbl>

``` r
print(sprintf("You have used %s API calls.", then$`x-forecast-api-calls`))
```

    ## [1] "You have used 22 API calls."

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

    ## [1] "Wed Sep 21 06:17:40 2016"

``` r
test_dir("tests/")
```

    ## testthat results ========================================================================================================
    ## OK: 2 SKIPPED: 0 FAILED: 0
    ## 
    ## DONE ===================================================================================================================
