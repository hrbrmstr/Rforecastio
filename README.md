Rforecastio
===========

v1.1.0 update:


This is a simple R interface to forecast.io weather data. It uses `RCurl` and `RJSONIO` and `plyr`to fetch and extract the JSON weather/forecast data from http://forecast.io and returns the metadata and readings

- forecast.io API Docs: https://developer.forecast.io/docs/v2
- forecast.io Dev site: https://developer.forecast.io/

Install it from straight from github:

    library("devtools")
    install_github("Rforecastio", "hrbrmstr")


Usage quick start: 

    fio.api.key = readLines("~/.forecast.io")
     
    my.latitude = "43.2673"
    my.longitude = "-70.8618"
     
    fio.list <- fio.forecast(fio.api.key, my.latitude, my.longitude)
    
See example usage in <code>examples/test.R</code>

Hit: http://rud.is/b/tag/rforecastio/ occassionally to see if the blog has any more info (it will!)

![sample of what you can do](/examples/test.png)
