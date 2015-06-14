# silly CRAN

temperature <- humidity <- precipIntensity <- temperatureMinTime <-
  temperatureMin <- temperatureMaxTime <- temperatureMax <- NULL

#' Plot method for rforecastio xs:
#'
#' Uses ggplot2 & grid.arrange to produce graphs for rforecastio xs
#'
#' @param x an rforecastio x
#' @param \dots ignored
#' @param readings specify which readings to plot. will plot all available by default
#' @return frame grob
#' @export
#' @method plot rforecastio
plot.rforecastio <- function(x, ...,
                             readings=c("hourly", "minutely", "daily")) {


  lapply(readings[readings %in% names(x)], function(rdng) {

    gg <- ggplot()

    if (rdng == "hourly") {
      gg <- gg + geom_line(data=x[[rdng]], aes(x=time, y=temperature, color="Temperature"))
      gg <- gg + geom_line(data=x[[rdng]], aes(x=time, y=humidity*10, color="Humidity"))
      gg <- gg + scale_color_manual(name="Readings", values=c("green", "red"))

    }

    if (rdng == "minutely") {
      gg <- gg + geom_line(data=x[[rdng]], aes(x=time, y=precipIntensity, color="Precipitation\nIntensity"))
      gg <- gg + scale_color_manual(name="Readings", values=c("blue"))
    }

    if (rdng == "daily") {
      gg <- gg + geom_line(data=x[[rdng]], aes(x=temperatureMinTime, y=temperatureMin, color="Temp (min)"), linetype=2)
      gg <- gg + geom_line(data=x[[rdng]], aes(x=temperatureMaxTime, y=temperatureMax, color="Temp (max)"))
      gg <- gg + geom_line(data=x[[rdng]], aes(x=time, y=humidity*100, color="Humidity"))
      gg <- gg + scale_color_manual(name="Readings", values=c("green", "red", "red"))
    }

    gg <- gg + labs(x=NULL, y=NULL, title=sprintf("%s readings", rdng))
    gg <- gg + theme_bw()

    gg

  }) -> the_plots

  do.call(grid.arrange, c(the_plots, ncol=1))

}
