#' Slightly more human-readable output
#'
#' @param x an rforecastio object
#' @param ... ignored
#' @export
print.rforecastio <- function(x, ...) {

  slots <- c("minutely", "hourly", "daily", "currently")

  cons_wd <- getOption("width")

  for (has in intersect(slots, names(x))) {

    cat(has, "\n")
    cat(padz(" ", cons_wd, "="), "\n")
    dplyr::glimpse(x[[has]])
    cat("\n")

  }

}
