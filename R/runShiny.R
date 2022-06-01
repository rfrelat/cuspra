# runShiny ---------------------------------------
#' Run shiny app made using cuspra package functions
#'
#' @export
runShiny <- function() {
  appDir <- system.file("app", package = "cuspra")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `comita`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
