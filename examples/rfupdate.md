I've bumped up the version number of `Rforecastio` to `1.2.0`. The new
features are:

-   added `...` to the `fio.forecast` function call to let users pass in
    `ssl.verifypeer=FALSE` and `proxy="host:port"` options (any CURL
    options, actually). h/t Stefan Fritsch
-   using `plyr` for easier conversion of JSON-\>data frame
-   adding in a new `daily` forecast data frame
-   roxygen2 inline documentation
-   fixed horrible bug in the package code that will finally teach me to
    clear the environment before testing

<!-- -->

    library(Rforecastio)
    library(ggplot2)
    library(plyr)

    # NEVER put API keys in revision control systems or source code!
    fio.api.key= readLines("~/.forecast.io")

    my.latitude = "43.2673"
    my.longitude = "-70.8618"

    # can add proxy='host:port' and ssl.verifypeer=FALSE to the end of the fio.forecast call

    fio.list <- fio.forecast(fio.api.key, my.latitude, my.longitude)

    fio.gg <- ggplot(data=fio.list$hourly.df, aes(x=time, y=temperature))
    fio.gg <- fio.gg + labs(y="Readings", x="", title="Houry Readings")
    fio.gg <- fio.gg + geom_line(aes(y=humidity*100), color="green", size=0.25)
    fio.gg <- fio.gg + geom_line(aes(y=temperature), color="red", size=0.25)
    fio.gg <- fio.gg + geom_line(aes(y=dewPoint), color="blue", size=0.25)
    fio.gg <- fio.gg + theme_bw()
    fio.gg

![hourly](/examples/rfupdate_files/figure-markdown_strict/hourly.png)

    fio.gg <- ggplot(data=fio.list$daily.df, aes(x=time, y=temperature))
    fio.gg <- fio.gg + labs(y="Readings", x="", title="Daily Readings")
    fio.gg <- fio.gg + geom_line(aes(y=humidity*100), color="green", size=0.25)
    fio.gg <- fio.gg + geom_line(aes(y=temperatureMax), color="red", size=0.25)
    fio.gg <- fio.gg + geom_line(aes(y=temperatureMin), color="red", linetype=2, size=0.25)
    fio.gg <- fio.gg + geom_line(aes(y=dewPoint), color="blue", size=0.25)
    fio.gg <- fio.gg + theme_bw()
    fio.gg

![daily](/examples/rfupdate_files/figure-markdown_strict/daily.png)
