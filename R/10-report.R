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
          x <- subset(estimates, estimates$GROUP == i)

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
#' Create an HTML report document containing RAM-OP survey results
#'
#' @param estimates A data.frame of RAM-OP results produced by
#'   \link{merge_estimates} function.
#' @param svy A data.frame collected using the standard RAM-OP questionnaire
#' @param filename Filename for output document. Can be specified as a path to a
#'   specific directory where to output report document
#' @param title Title of report
#'
#' @return An HTML document in the working directory or if filename is a path,
#'   to a specified directory.
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
#'   resultsDF <- merge_estimates(x = classicResults, y = probitResults)
#'
#'   report_op_html(svy = testSVY,
#'                  estimates = resultsDF,
#'                  filename = paste(tempdir(), "report", sep = "/"))
#'
#' @export
#'
#
################################################################################

report_op_html <- function(estimates,
                           svy,
                           filename = "ramOPreport",
                           title = "RAM-OP Report") {
  ## Create Rmd report file
  withr::with_options(
    new = list(width = 80),
    code = {
      withr::with_output_sink(
        new = paste(filename, ".Rmd", sep = ""),
        code = {
          cat("---\n")
          cat("title: ", title, "\n", sep = "")
          cat("output:\n")
          cat("  html_document:\n")
          cat("    toc: true\n")
          cat("    toc_depth: 2\n")
          cat("    number_sections: true\n")
          cat("    fig_caption: true\n")
          cat("params:\n")
          cat("  estimates: 'estimates'\n")
          cat("  svy: 'svy'\n")
          cat("---\n")
          cat("\n")
          cat("```{r setup, include = FALSE}\n")
          cat("knitr::opts_chunk$set(\n")
          cat("  message = FALSE,\n")
          cat("  warning = FALSE,\n")
          cat("  error = FALSE,\n")
          cat("  echo = FALSE,\n")
          cat("  collapse = TRUE,\n")
          cat("  out.width = '80%',\n")
          cat("  fig.align = 'center',\n")
          cat("  comment = '#>')\n")
          cat("\n")
          cat("library(magrittr)\n")
          cat("resultsDF <- get(params$estimates)\n")
          cat("svy <- get(params$svy)\n")
          cat("```\n")
          cat("\n")
          cat("<hr>\n")
          cat("# Sample description\n")
          cat("\n")
          cat("## Type of respondents\n")
          cat("```{r respondentTable}\n")
          cat("knitr::kable(x = resultsDF[1:4, seq(from = 3, to = ncol(resultsDF), by = 1)],\n")
          cat("  caption = 'Type of respondent',\n")
          cat("  digits = 2,\n")
          cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) %>%\n")
          cat("  kableExtra::kable_styling(bootstrap_option = c('striped')) %>%\n")
          cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
          cat("```\n")
          cat("\n")
          cat("## Age structure by sex\n")
          cat("```{r agePlot}\n")
          cat("oldr::chart_age(x = oldr::create_op_all(svy = svy), save.chart = FALSE)\n")
          cat("```\n")
          cat("\n")
          cat("```{r ageTable}\n")
          cat("knitr::kable(x = resultsDF[6:10, seq(from = 3, to = ncol(resultsDF), by = 1)],\n")
          cat("  caption = 'Respondent age group by sex',\n")
          cat("  digits = 2,\n")
          cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) %>%\n")
          cat("  kableExtra::kable_styling(bootstrap_option = c('striped')) %>%\n")
          cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
          cat("```\n")
          cat("\n")
          cat("## Respondents by sex\n")
          cat("```{r sexTable}\n")
          cat("knitr::kable(x = resultsDF[11:12, seq(from = 3, to = ncol(resultsDF), by = 1)],\n")
          cat("  caption = 'Sex of respondents',\n")
          cat("  digits = 2,\n")
          cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) %>%\n")
          cat("  kableExtra::kable_styling(bootstrap_option = c('striped')) %>%\n")
          cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
          cat("```\n")
          cat("\n")
          cat("## Marital status of respondents\n")
          cat("```{r marriedTable}\n")
          cat("knitr::kable(x = resultsDF[13:19, seq(from = 3, to = ncol(resultsDF), by = 1)],\n")
          cat("  caption = 'Marital status',\n")
          cat("  digits = 2,\n")
          cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) %>%\n")
          cat("  kableExtra::kable_styling(bootstrap_option = c('striped')) %>%\n")
          cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
          cat("```")
        }
      )
    }
  )

  ## Render document in HTML format
  rmarkdown::render(input = paste(filename, ".Rmd", sep = ""),
                    output_format = "html_document")

  ## Open HTML
  utils::browseURL(url = paste(filename, ".html", sep = ""))
}

