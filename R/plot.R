#' Plot method for rforecastio objects:
#'
#' Uses ggplot2 & grid.arrange to produce graphs for rforecastio objects
#'
#' @param object an rforecastio object
#' @param \dots ignored
#' @param readings specify which readings to plot. will plot all available by default
#' @return frame grob
#'
#' @importFrom ggplot2 autoplot ggplot aes_string geom_line labs
#' @importFrom ggplot2 theme_bw ggplotGrob aes scale_color_manual
#' @importFrom gridExtra grid.arrange
#' @export
#' @method plot rforecastio
plot.rforecastio <- function(object, ...,
                             readings=c("hourly", "minutely", "daily")) {


  lapply(readings[readings %in% names(object)], function(x) {

    gg <- ggplot()

    if (x == "hourly") {
      gg <- gg + geom_line(data=object[[x]], aes(x=time, y=temperature, color="Temperature"))
      gg <- gg + geom_line(data=object[[x]], aes(x=time, y=humidity*10, color="Humidity"))
      gg <- gg + scale_color_manual(name="Readings", values=c("green", "red"))

    }

    if (x == "minutely") {
      gg <- gg + geom_line(data=object[[x]], aes(x=time, y=precipIntensity, color="Precipitation\nIntensity"))
      gg <- gg + scale_color_manual(name="Readings", values=c("blue"))
    }

    if (x == "daily") {
      gg <- gg + geom_line(data=object[[x]], aes(x=temperatureMinTime, y=temperatureMin, color="Temp (min)"), linetype=2)
      gg <- gg + geom_line(data=object[[x]], aes(x=temperatureMaxTime, y=temperatureMax, color="Temp (max)"))
      gg <- gg + geom_line(data=object[[x]], aes(x=time, y=humidity*100, color="Humidity"))
      gg <- gg + scale_color_manual(name="Readings", values=c("green", "red", "red"))
    }

    gg <- gg + labs(x=NULL, y=NULL, title=sprintf("%s readings", x))
    gg <- gg + theme_bw()
    gg

  }) -> plots

  do.call(grid.arrange, c(plots, ncol=1))

}
