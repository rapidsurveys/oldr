################################################################################
#
#' Create table of RAM-OP results
#'
#' @param estimates A data.frame of RAM-OP results produced by
#'   \link{merge_estimates} function.
#' @param filename Prefix to append to report output filename. Can be specified
#'   as a path to a specific directory where to output tabular results CSV file
#'
#' @return Report of tabulated estimated results saved in CSV format in current
#'     working directory or in the specified path
#'
#' @examples
#'   #
#'   \dontrun{
#'     report_op_table("TEST")
#'   }
#'
#' @export
#'
#
################################################################################

report_op_table <- function(estimates, filename) {

  ## Create report filename
  reportFilename <- paste(filename, ".report.csv", sep="")

  ## Open file for output
  withr::with_options(
    new = list(width = 132),

    withr::with_output_sink(
      new = reportFilename,
      code =
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
          for(j in seq_len(nrow(x))) {
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
        },
      append = FALSE
    )
  )
}


################################################################################
#
#' Create a report document containing RAM-OP survey results
#'
#' @param estimates A data.frame of RAM-OP results produced by
#'   \link{merge_estimates} function.
#' @param filename Filename for output document. Can be specified as a path to a
#'   specific directory where to output report document
#' @param title Title of report
#' @param output Type of output. One of two choices: 1) \code{html_document}
#'   to produce and HTML output; or 2) \code{pdf_document} to produce a PDF
#'   output. Default is \code{html_document}
#'
#' @return A document of specified output type in the working directory or
#'   if filename is a path, to a specified directory.
#'
#' @examples
#'   #
#'   classicResults <- estimate_classic(x = create_op_all(testSVY),
#'                                      w = testPSU,
#'                                      replicates = 9)
#'
#'   probitResults <- estimate_probit(x = create_op_all(testSVY),
#'                                    w = testPSU,
#'                                    replicates = 9)
#'
#'   resultsDF <- merge_estimates(x = classicResults, y = probitResults,)
#'
#'   report_op_document(estimates = resultsDF)
#'
#'
#'
#
################################################################################

report_op_document <- function(estimates,
                               filename = "ramOPreport",
                               title = filename,
                               output = "html_document") {
}
