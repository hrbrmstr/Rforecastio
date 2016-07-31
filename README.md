
[![Build Status](https://travis-ci.org/hrbrmstr/Rforecastio.svg)](https://travis-ci.org/hrbrmstr/Rforecastio)

`Rforecastio` : Tools to Work with the 'Forecast' 'API'

-   Forecast API Docs: <https://developer.forecast.io/docs/v2>
-   Forecast Dev site: <https://developer.forecast.io/>

The following functions are implemented:

-   `forecastio_api_key` : Get or set FORECASTIO\_API\_KEY value
-   `get_current_forecast` : Retrieve the current forecast (for the next week)
-   `get_forecast_for` : Retrieve weather data for a specific place/time
-   `plot.rforecastio` : Plot method for rforecastio objects
-   `print.rforecastio` : A tad more human readable default printing

There have been several major enhancements to the way this package works with the API. Also, the structures returned in the list are now classes as `rforecastio` objects (which afford the use of an S3 plotting method) and the data frames are now `tbl_df` objects (so they work like regular data frames but get all the `dplyr` goodness, too).

### News

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

    ## [1] '2.2.0'

``` r
now <- get_current_forecast(43.2672, -70.8617)
print(now)
```

    ## minutely 
    ## ======================================================================================================================== 
    ## Observations: 61
    ## Variables: 5
    ## $ time                 <time> 2016-07-31 09:18:00, 2016-07-31 09:19:00, 2016-07-31 09:20:00, 2016-07-31 09:21:00, 2...
    ## $ precipIntensity      <dbl> 0.0176, 0.0164, 0.0149, 0.0148, 0.0150, 0.0147, 0.0150, 0.0152, 0.0153, 0.0154, 0.0147...
    ## $ precipIntensityError <dbl> 0.0009, 0.0010, 0.0009, 0.0009, 0.0010, 0.0009, 0.0010, 0.0011, 0.0012, 0.0013, 0.0013...
    ## $ precipProbability    <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,...
    ## $ precipType           <chr> "rain", "rain", "rain", "rain", "rain", "rain", "rain", "rain", "rain", "rain", "rain"...
    ## 
    ## hourly 
    ## ======================================================================================================================== 
    ## Observations: 49
    ## Variables: 16
    ## $ time                <time> 2016-07-31 09:00:00, 2016-07-31 10:00:00, 2016-07-31 11:00:00, 2016-07-31 12:00:00, 20...
    ## $ summary             <chr> "Light Rain", "Light Rain", "Light Rain", "Light Rain", "Light Rain", "Light Rain", "Li...
    ## $ icon                <chr> "rain", "rain", "rain", "rain", "rain", "rain", "rain", "rain", "partly-cloudy-day", "p...
    ## $ precipIntensity     <dbl> 0.0189, 0.0326, 0.0347, 0.0297, 0.0247, 0.0184, 0.0132, 0.0067, 0.0022, 0.0025, 0.0000,...
    ## $ precipProbability   <dbl> 0.49, 0.53, 0.54, 0.53, 0.51, 0.48, 0.45, 0.28, 0.06, 0.07, 0.00, 0.00, 0.00, 0.00, 0.0...
    ## $ precipType          <chr> "rain", "rain", "rain", "rain", "rain", "rain", "rain", "rain", "rain", "rain", NA, NA,...
    ## $ temperature         <dbl> 65.59, 66.53, 67.56, 68.51, 69.63, 70.78, 72.99, 74.04, 74.55, 73.20, 71.22, 69.15, 67....
    ## $ apparentTemperature <dbl> 65.59, 66.53, 67.56, 68.51, 69.63, 70.78, 72.99, 74.04, 74.55, 73.20, 71.22, 69.15, 67....
    ## $ dewPoint            <dbl> 59.80, 59.17, 59.78, 60.49, 61.48, 62.59, 64.47, 65.96, 66.63, 66.27, 65.51, 64.91, 64....
    ## $ humidity            <dbl> 0.82, 0.77, 0.76, 0.76, 0.75, 0.75, 0.75, 0.76, 0.76, 0.79, 0.82, 0.86, 0.89, 0.90, 0.9...
    ## $ windSpeed           <dbl> 5.26, 5.37, 5.16, 5.21, 4.29, 3.95, 4.16, 3.77, 3.76, 3.76, 3.99, 3.27, 2.75, 2.38, 2.2...
    ## $ windBearing         <int> 31, 40, 50, 63, 72, 80, 86, 89, 94, 100, 81, 79, 85, 97, 99, 76, 31, 13, 6, 6, 11, 8, 2...
    ## $ visibility          <dbl> 7.53, 8.41, 8.53, 9.92, 8.76, 9.93, 9.90, 9.77, 9.66, 9.52, 9.44, 9.25, 9.10, 8.95, 8.8...
    ## $ cloudCover          <dbl> 0.87, 0.98, 0.99, 1.00, 1.00, 1.00, 0.94, 0.86, 0.82, 0.80, 0.80, 0.82, 0.84, 0.88, 0.9...
    ## $ pressure            <dbl> 1019.96, 1020.22, 1020.38, 1020.38, 1020.26, 1020.07, 1019.73, 1019.27, 1018.94, 1018.8...
    ## $ ozone               <dbl> 293.15, 293.25, 293.26, 293.09, 292.84, 292.68, 292.74, 292.89, 292.89, 292.50, 291.96,...
    ## 
    ## daily 
    ## ======================================================================================================================== 
    ## Observations: 8
    ## Variables: 27
    ## $ time                       <time> 2016-07-31, 2016-08-01, 2016-08-02, 2016-08-03, 2016-08-04, 2016-08-05, 2016-08...
    ## $ summary                    <chr> "Light rain until afternoon.", "Light rain until evening.", "Mostly cloudy until...
    ## $ icon                       <chr> "rain", "rain", "partly-cloudy-day", "partly-cloudy-day", "rain", "rain", "partl...
    ## $ sunriseTime                <time> 2016-07-31 05:34:14, 2016-08-01 05:35:18, 2016-08-02 05:36:23, 2016-08-03 05:37...
    ## $ sunsetTime                 <time> 2016-07-31 20:07:48, 2016-08-01 20:06:38, 2016-08-02 20:05:26, 2016-08-03 20:04...
    ## $ moonPhase                  <dbl> 0.93, 0.96, 0.99, 0.03, 0.06, 0.10, 0.13, 0.16
    ## $ precipIntensity            <dbl> 0.0088, 0.0083, 0.0018, 0.0000, 0.0061, 0.0049, 0.0035, 0.0009
    ## $ precipIntensityMax         <dbl> 0.0347, 0.0239, 0.0042, 0.0000, 0.0255, 0.0143, 0.0130, 0.0013
    ## $ precipIntensityMaxTime     <time> 2016-07-31 11:00:00, 2016-08-01 11:00:00, 2016-08-02 10:00:00, NA, 2016-08-04 1...
    ## $ precipProbability          <dbl> 0.54, 0.51, 0.15, 0.00, 0.51, 0.46, 0.45, 0.02
    ## $ precipType                 <chr> "rain", "rain", "rain", NA, "rain", "rain", "rain", "rain"
    ## $ temperatureMin             <dbl> 64.78, 59.97, 59.99, 55.27, 61.19, 66.45, 68.46, 59.50
    ## $ temperatureMinTime         <time> 2016-07-31 06:00:00, 2016-08-01 06:00:00, 2016-08-02 23:00:00, 2016-08-03 04:00...
    ## $ temperatureMax             <dbl> 74.55, 72.73, 76.85, 82.80, 84.86, 88.85, 87.59, 81.85
    ## $ temperatureMaxTime         <time> 2016-07-31 17:00:00, 2016-08-01 11:00:00, 2016-08-02 16:00:00, 2016-08-03 15:00...
    ## $ apparentTemperatureMin     <dbl> 64.78, 59.97, 59.99, 55.27, 61.19, 66.45, 68.46, 59.50
    ## $ apparentTemperatureMinTime <time> 2016-07-31 06:00:00, 2016-08-01 06:00:00, 2016-08-02 23:00:00, 2016-08-03 04:00...
    ## $ apparentTemperatureMax     <dbl> 74.55, 72.73, 76.85, 83.86, 90.66, 101.14, 88.73, 81.89
    ## $ apparentTemperatureMaxTime <time> 2016-07-31 17:00:00, 2016-08-01 11:00:00, 2016-08-02 16:00:00, 2016-08-03 15:00...
    ## $ dewPoint                   <dbl> 61.85, 63.03, 60.67, 59.04, 65.62, 70.87, 65.96, 57.87
    ## $ humidity                   <dbl> 0.81, 0.87, 0.80, 0.74, 0.80, 0.82, 0.71, 0.66
    ## $ windSpeed                  <dbl> 2.75, 3.80, 4.00, 1.59, 5.68, 6.61, 9.18, 9.37
    ## $ windBearing                <int> 48, 22, 43, 157, 217, 224, 260, 277
    ## $ visibility                 <dbl> 9.29, 9.67, 10.00, 10.00, NA, NA, NA, NA
    ## $ cloudCover                 <dbl> 0.87, 0.89, 0.59, 0.17, 0.08, 0.12, 0.31, 0.07
    ## $ pressure                   <dbl> 1019.28, 1019.16, 1019.14, 1018.71, 1016.80, 1012.89, 1004.69, 1004.93
    ## $ ozone                      <dbl> 293.11, 306.51, 320.24, 294.27, 289.34, 287.42, 296.38, 312.59
    ## 
    ## currently 
    ## ======================================================================================================================== 
    ## Observations: 1
    ## Variables: 18
    ## $ time                 <time> 2016-07-31 09:18:56
    ## $ summary              <chr> "Light Rain"
    ## $ icon                 <chr> "rain"
    ## $ nearestStormDistance <int> 0
    ## $ precipIntensity      <dbl> 0.0165
    ## $ precipIntensityError <dbl> 0.001
    ## $ precipProbability    <int> 1
    ## $ precipType           <chr> "rain"
    ## $ temperature          <dbl> 65.89
    ## $ apparentTemperature  <dbl> 65.89
    ## $ dewPoint             <dbl> 59.61
    ## $ humidity             <dbl> 0.8
    ## $ windSpeed            <dbl> 5.28
    ## $ windBearing          <int> 33
    ## $ visibility           <dbl> 7.81
    ## $ cloudCover           <dbl> 0.91
    ## $ pressure             <dbl> 1020.04
    ## $ ozone                <dbl> 293.18

``` r
then <- get_forecast_for(43.2672, -70.8617, "2013-05-06T12:00:00-0400", add_headers=TRUE)
print(then)
```

    ## hourly 
    ## ======================================================================================================================== 
    ## Observations: 24
    ## Variables: 14
    ## $ time                <time> 2013-05-06 00:00:00, 2013-05-06 01:00:00, 2013-05-06 02:00:00, 2013-05-06 03:00:00, 20...
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
    ## $ time                       <time> 2013-05-06
    ## $ summary                    <chr> "Foggy overnight."
    ## $ icon                       <chr> "fog"
    ## $ sunriseTime                <time> 2013-05-06 05:30:54
    ## $ sunsetTime                 <time> 2013-05-06 19:51:43
    ## $ moonPhase                  <dbl> 0.9
    ## $ precipIntensity            <int> 0
    ## $ precipIntensityMax         <int> 0
    ## $ precipProbability          <int> 0
    ## $ temperatureMin             <dbl> 32.17
    ## $ temperatureMinTime         <time> 2013-05-06 04:00:00
    ## $ temperatureMax             <dbl> 63.03
    ## $ temperatureMaxTime         <time> 2013-05-06 14:00:00
    ## $ apparentTemperatureMin     <dbl> 29.67
    ## $ apparentTemperatureMinTime <time> 2013-05-06 06:00:00
    ## $ apparentTemperatureMax     <dbl> 63.03
    ## $ apparentTemperatureMaxTime <time> 2013-05-06 14:00:00
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
    ## $ time                <time> 2013-05-06 12:00:00
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

    ## # A tibble: 24 x 13
    ##                   time       summary                icon precipType temperature apparentTemperature dewPoint humidity
    ##                 <time>         <chr>               <chr>      <chr>       <dbl>               <dbl>    <dbl>    <dbl>
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

    ## # A tibble: 24 x 13
    ##                   time summary        icon precipType temperature apparentTemperature dewPoint humidity windSpeed
    ##                 <time>   <chr>       <chr>      <chr>       <dbl>               <dbl>    <dbl>    <dbl>     <dbl>
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

    ## [1] "You have used 13 API calls."

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

    ## [1] "Sun Jul 31 09:19:01 2016"

``` r
test_dir("tests/")
```

    ## testthat results ========================================================================================================
    ## OK: 2 SKIPPED: 0 FAILED: 0
    ## 
    ## DONE ===================================================================================================================
