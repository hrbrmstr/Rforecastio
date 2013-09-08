#
# test.R
#
# shows example usage for Rforecastio package
#
# Copyright (c) 2013 Bob Rudis (@hrbrmstr) bob@rudis.net
#
# MIT License
#

library(Rforecastio)
library(ggplot2)

# NEVER put credentials or api keys in script bodies or github repos!!
# the "config" file has one thing in it, the api key string on one line
# this is all it takes to read it in
fio.api.key = readLines("~/.forecast.io")

my.latitude = "43.2673"
my.longitude = "-70.8618"

#fio.list <- fio.forecast(fio.api.key, my.latitude, my.longitude)
fio.list <- fio.forecast(fio.api.key, my.latitude, my.longitude, 
                         for.time=as.integer(Sys.time())-(60*60*6))

# fio.gg <- fio.gg + geom_line(aes(y=pressure*0.0295301), color="purple")

# setup "forecast" highlight plot area

forecast.x.min <- ISOdatetime(1960,1,1,0,0,0) + unclass(Sys.time())
forecast.x.max <- max(fio.list$hourly.df$time)
if (forecast.x.min > forecast.x.max) forecast.x.min <- forecast.x.max
fio.forecast.range.df <- data.frame(xmin=forecast.x.min, xmax=forecast.x.max,
                                    ymin=-Inf, ymax=+Inf)

# plot the readings

fio.gg <- ggplot(data=fio.list$hourly.df,aes(x=time, y=temperature))
fio.gg <- fio.gg + labs(y="Readings", x="Time")
fio.gg <- fio.gg + geom_rect(data=fio.forecast.range.df,
                             aes(xmin=xmin, xmax=xmax,
                                 ymin=ymin, ymax=ymax), 
                             fill="yellow", alpha=(0.15),
                             inherit.aes = FALSE)
fio.gg <- fio.gg + geom_line(aes(y=humidity*100), color="green")
fio.gg <- fio.gg + geom_line(aes(y=temperature), color="red")
fio.gg <- fio.gg + geom_line(aes(y=dewPoint), color="blue")
fio.gg <- fio.gg + theme_bw()
fio.gg
