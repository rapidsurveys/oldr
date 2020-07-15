################################################################################
#
#' Create table of RAM-OP results
#'
#' @param FILENAME Prefix to append to report output filename
#'
#' @return Report of tabulated estimated results saved in CSV format in current
#'     working directory
#'
#' @examples
#'   #
#'   \dontrun{
#'     reportOP("TEST")
#'   }
#'
#' @export
#'
#
################################################################################

reportOP <- function(FILENAME) {

  ## Open file for output
  withr::with_options(width = 132)
  reportFilename <- paste(FILENAME, ".report.csv", sep="")
  withr::with_output_sink(reportFilename, append = FALSE, type = "output")

  ## Present results by indicator group
  for(i in unique(estimates$GROUP)) {

    ## Select results for current indicator group
    x <- subset(estimates, GROUP == i)

    ## Header for current indicator group
    cat(",,,,,,,,,,\n")
    cat(i, ",,,,,,,,,,\n", sep = "")
    cat(",,ALL,,,MALES,,,FEMALES,,\n")
    cat("INDICATOR,TYPE,EST,LCL,UCL,EST,LCL,UCL,EST,LCL,UCL\n")

    ## Report line for each indicator in this indicator group
    for(j in 1:nrow(x)) {

      ## Present results for a single indicator
      cat(x$LABEL[j], ",", x$TYPE[j], ",", sep = "")
      cat(sprintf("%.4f", x$EST.ALL[j]), ",", sep = "")
      cat(sprintf("%.4f", x$LCL.ALL[j]), ",", sep = "")
      cat(sprintf("%.4f", x$UCL.ALL[j]), ",", sep = "")
      cat(sprintf("%.4f", x$EST.MALES[j]), ",", sep = "")
      cat(sprintf("%.4f", x$LCL.MALES[j]), ",", sep = "")
      cat(sprintf("%.4f", x$UCL.MALES[j]), ",", sep = "")
      cat(sprintf("%.4f", x$EST.FEMALES[j]), ",", sep = "")
      cat(sprintf("%.4f", x$LCL.FEMALES[j]), ",", sep = "")
      cat(sprintf("%.4f", x$UCL.FEMALES[j]))
      cat("\n")
    }
  }

  ## Close report file
  withr::with_output_sink()
}
