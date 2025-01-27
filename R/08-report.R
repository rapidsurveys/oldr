#' 
#' Create table and report chunk of RAM-OP results
#'
#' @param estimates A data.frame of RAM-OP results produced by [merge_op()].
#' @param filename Prefix to append to report output filename. Can be specified
#'   as a path to a specific directory where to output tabular results CSV file.
#'   Defaults to a path to a temporary directory with a filename starting with
#'   *ramOP*.
#' @param output_format Either *"html"*, *"docx"*, *"odt"*, or *"pdf"*. Defaults
#'   to *"html"*.
#'
#' @returns Report of tabulated estimated results saved in CSV format in current
#'   working directory or in the specified path or a reporting chunk for
#'   specific indicators.
#'
#' @author Mark Myatt and Ernest Guevarra
#'
#' @examples
#' ##
#' x <- estimate_classic(
#'   x = create_op(testSVY), w = testPSU, replicates = 9
#' )
#' 
#' y <- estimate_probit(
#'   x = create_op(testSVY), w = testPSU, replicates = 9
#' )
#' 
#' z <- merge_op(x, y, prop2percent = TRUE)
#' report_op_table(z)
#'
#' report_op_demo()
#' report_op_hunger()
#' report_op_food()
#' report_op_disability()
#' 
#' @export
#' @rdname report_op
#'

report_op_table <- function(estimates,
                            filename = paste(tempdir(), "ramOP", sep = "/")) {
  ## Create report filename
  reportFilename <- paste(filename, ".report.csv", sep = "")

  estimates$LABEL <- as.character(estimates$LABEL)

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

#'
#' @export
#' @rdname report_op
#' 

report_op_demo <- function(output_format = c("html", "docx", "odt", "pdf")) {
  output_format <- match.arg(output_format)

  cat("\n")
  cat("# Sample description\n")
  cat("\n")
  cat("## Type of respondents\n")
  cat("```{r respondentTable}\n")
  if (output_format == "html") {
    cat("knitr::kable(x = resultsDF[1:4, ],\n")
    cat("  caption = 'Type of respondent',\n")
    cat("  booktabs = TRUE,\n")
    cat("  digits = 2,\n")
    cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>\n")
    cat("  kableExtra::kable_styling(bootstrap_options = c('striped')) |>\n")
    cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  } else {
    cat("knitr::kable(x = resultsDF[1:4, ], caption = 'Type of respondent', digits = 2)\n")
  }
  cat("```\n")
  cat("\n")
  cat("## Age structure by sex\n")
  cat("```{r agePlot}\n")
  cat("oldr::chart_op_age(x = oldr::create_op(svy = svy), save_chart = FALSE)\n")
  cat("```\n")
  cat("\n")
  cat("```{r ageTable}\n")
  if (output_format == "html") {
    cat("knitr::kable(x = resultsDF[5:10, ],\n")
    cat("  caption = 'Respondent age group by sex',\n")
    cat("  booktabs = TRUE,\n")
    cat("  digits = 2,\n")
    cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>\n")
    cat("  kableExtra::kable_styling(bootstrap_options = c('striped')) |>\n")
    cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  } else {
    cat("knitr::kable(x = resultsDF[5:10, ], caption = 'Respondent age group by sex', digits = 2)\n")
  }
  cat("```\n")
  cat("\n")
  cat("## Respondents by sex\n")
  cat("```{r sexTable}\n")
  if (output_format == "html") {
    cat("knitr::kable(x = resultsDF[11:12, ],\n")
    cat("  caption = 'Sex of respondents',\n")
    cat("  booktabs = TRUE,\n")
    cat("  digits = 2,\n")
    cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>\n")
    cat("  kableExtra::kable_styling(bootstrap_options = c('striped')) |>\n")
    cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  } else {
    cat("knitr::kable(x = resultsDF[11:12, ], caption = 'Sex of respondents', digits = 2)\n")
  }
  cat("```\n")
  cat("\n")
  cat("## Marital status of respondents\n")
  cat("```{r marriedTable}\n")
  if (output_format == "html") {
    cat("knitr::kable(x = resultsDF[13:19, ],\n")
    cat("  caption = 'Marital status',\n")
    cat("  booktabs = TRUE,\n")
    cat("  digits = 2,\n")
    cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>\n")
    cat("  kableExtra::kable_styling(bootstrap_options = c('striped')) |>\n")
    cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  } else {
    cat("knitr::kable(x = resultsDF[13:19, ], caption = 'Marital status', digits = 2)\n")
  }
  cat("```\n")
}


#'
#' @export
#' @rdname report_op
#'

report_op_food <- function(output_format = c("html", "docx", "odt", "pdf")) {
  output_format <- match.arg(output_format)

  cat("\n")
  cat("# Diet\n")
  cat("## Meal frequency\n")
  cat("\n")
  cat("```{r mfPlot}\n")
  cat("oldr::chart_op_mf(x = oldr::create_op(svy = svy), save_chart = FALSE)\n")
  cat("```\n")
  cat("\n")
  cat("```{r mfTable}\n")
  if (output_format == "html") {
    cat("knitr::kable(x = resultsDF[20, ],\n")
    cat("  caption = 'Meal frequency',\n")
    cat("  booktabs = TRUE,\n")
    cat("  digits = 2,\n")
    cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>\n")
    cat("  kableExtra::kable_styling(bootstrap_options = c('striped')) |>\n")
    cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  } else {
    cat("knitr::kable(x = resultsDF[20, ], caption = 'Meal frequency', digits = 2)\n")
  }
  cat("```\n")
  cat("\n")
  cat("## Dietary diversity\n")
  cat("```{r ddsPlot}\n")
  cat("oldr::chart_op_dds(x = oldr::create_op(svy = svy), save_chart = FALSE)\n")
  cat("```\n")
  cat("\n")
  cat("```{r ddsTable}\n")
  if (output_format == "html") {
    cat("knitr::kable(x = resultsDF[21:32, ],\n")
    cat("  caption = 'Dietary diversity',\n")
    cat("  booktabs = TRUE,\n")
    cat("  digits = 2,\n")
    cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>\n")
    cat("  kableExtra::kable_styling(bootstrap_options = c('striped')) |>\n")
    cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  } else {
    cat("knitr::kable(x = resultsDF[21:32, ], caption = 'Dietary diversity', digits = 2)\n")
  }
  cat("```\n")
  cat("\n")
  cat("## Nutrient intake\n")
  cat("```{r nutrientTable}\n")
  if (output_format == "html") {
    cat("knitr::kable(x = resultsDF[33:47, ],\n")
    cat("  caption = 'Nutrient intake',\n")
    cat("  booktabs = TRUE,\n")
    cat("  digits = 2,\n")
    cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>\n")
    cat("  kableExtra::kable_styling(bootstrap_options = c('striped')) |>\n")
    cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  } else {
    cat("knitr::kable(x = resultsDF[33:47, ], caption = 'Nutrient intake', digits = 2)\n")
  }
  cat("```\n")
}


#'
#' @export
#' @rdname report_op
#'

report_op_hunger <- function(output_format = c("html", "docx", "odt", "pdf")) {
  output_format <- match.arg(output_format)

  cat("\n")
  cat("# Food security\n")
  cat("\n")
  cat("## Household hunger score\n")
  cat("```{r hhsPlot}\n")
  cat("oldr::chart_op_hhs(x = oldr::create_op(svy = svy), save_chart = FALSE)\n")
  cat("```\n")
  cat("\n")
  cat("```{r hhsTable}\n")
  if (output_format == "html") {
    cat("knitr::kable(x = resultsDF[48:50, ],\n")
    cat("  caption = 'Household hunger score',\n")
    cat("  booktabs = TRUE,\n")
    cat("  digits = 2,\n")
    cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>\n")
    cat("  kableExtra::kable_styling(bootstrap_options = c('striped')) |>\n")
    cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  } else {
    cat("knitr::kable(x = resultsDF[48:50, ], caption = 'Household hunger score', digits = 2)\n")
  }
  cat("```\n")
}


#'
#' @export
#' @rdname report_op
#'

report_op_disability <- function(output_format = c("html", "docx", 
                                                   "odt", "pdf")) {
  output_format <- match.arg(output_format)
  
  cat("\n")
  cat("# Disability\n")
  cat("\n")
  cat("## Overall\n")
  cat("\n")
  cat("```{r wgPlot}\n")
  cat("oldr::chart_op_wg(x = oldr::create_op(svy = svy), save_chart = FALSE)\n")
  cat("```\n")
  cat("\n")
  cat("```{r wgTable}\n")
  if (output_format == "html") {
    cat("knitr::kable(x = resultsDF[75:79, ],\n")
    cat("  caption = 'Overall disability',\n")
    cat("  booktabs = TRUE,\n")
    cat("  digits = 2,\n")
    cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>\n")
    cat("  kableExtra::kable_styling(bootstrap_options = c('striped')) |>\n")
    cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  } else {
    cat("knitr::kable(x = resultsDF[75:79, ], caption = 'Overall disability', digits = 2)\n")
  }
  cat("```\n")
  cat("\n")
  cat("## Vision\n")
  cat("\n")
  cat("```{r visionTable}\n")
  if (output_format == "html") {
    cat("knitr::kable(x = resultsDF[51:54, ],\n")
    cat("  caption = 'Disability related to vision',\n")
    cat("  booktabs = TRUE,\n")
    cat("  digits = 2,\n")
    cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>\n")
    cat("  kableExtra::kable_styling(bootstrap_options = c('striped')) |>\n")
    cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  } else {
    cat("knitr::kable(x = resultsDF[51:54, ], caption = 'Disability related to vision', digits = 2)\n")
  }
  cat("```\n")
  cat("\n")
  cat("## Hearing\n")
  cat("\n")
  cat("```{r hearingTable}\n")
  if (output_format == "html") {
    cat("knitr::kable(x = resultsDF[55:58, ],\n")
    cat("  caption = 'Disability related to hearing',\n")
    cat("  booktabs = TRUE,\n")
    cat("  digits = 2,\n")
    cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>\n")
    cat("  kableExtra::kable_styling(bootstrap_options = c('striped')) |>\n")
    cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  } else {
    cat("knitr::kable(x = resultsDF[55:58, ], caption = 'Disability related to hearing', digits = 2)\n")
  }
  cat("```\n")
  cat("\n")
  cat("## Mobility\n")
  cat("\n")
  cat("```{r mobilityTable}\n")
  if (output_format == "html") {
    cat("knitr::kable(x = resultsDF[59:62, ],\n")
    cat("  caption = 'Disability related to mobility',\n")
    cat("  booktabs = TRUE,\n")
    cat("  digits = 2,\n")
    cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>\n")
    cat("  kableExtra::kable_styling(bootstrap_options = c('striped')) |>\n")
    cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  } else {
    cat("knitr::kable(x = resultsDF[59:62, ], caption = 'Disability related to mobility', digits = 2)\n")
  }
  cat("```\n")
  cat("\n")
  cat("## Remembering\n")
  cat("\n")
  cat("```{r rememberingTable}\n")
  if (output_format == "html") {
    cat("knitr::kable(x = resultsDF[63:66, ],\n")
    cat("  caption = 'Disability related to remembering',\n")
    cat("  booktabs = TRUE,\n")
    cat("  digits = 2,\n")
    cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>\n")
    cat("  kableExtra::kable_styling(bootstrap_options = c('striped')) |>\n")
    cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  } else {
    cat("knitr::kable(x = resultsDF[63:66, ], caption = 'Disability related to remembering', digits = 2)\n")
  }
  cat("```\n")
  cat("\n")
  cat("## Self-care\n")
  cat("\n")
  cat("```{r selfCareTable}\n")
  if (output_format == "html") {
    cat("knitr::kable(x = resultsDF[67:70, ],\n")
    cat("  caption = 'Disability related to self-care',\n")
    cat("  booktabs = TRUE,\n")
    cat("  digits = 2,\n")
    cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>\n")
    cat("  kableExtra::kable_styling(bootstrap_options = c('striped')) |>\n")
    cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  } else {
    cat("knitr::kable(x = resultsDF[67:70, ], caption = 'Disability related to self-care', digits = 2)\n")
  }
  cat("```\n")
  cat("\n")
  cat("## Communicating\n")
  cat("\n")
  cat("```{r communicatingTable}\n")
  if (output_format == "html") {
    cat("knitr::kable(x = resultsDF[71:74, ],\n")
    cat("  caption = 'Disability related to communicating',\n")
    cat("  booktabs = TRUE,\n")
    cat("  digits = 2,\n")
    cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>\n")
    cat("  kableExtra::kable_styling(bootstrap_options = c('striped')) |>\n")
    cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  } else {
    cat("knitr::kable(x = resultsDF[71:74, ], caption = 'Disability related to communicating', digits = 2)\n")
  }
  cat("```\n")
}


#'
#' @export
#' @rdname report_op
#'

report_op_adl <- function(output_format = c("html", "docx", "odt", "pdf")) {
  output_format <- match.arg(output_format)

  cat("\n")
  cat("# Activities of daily living\n")
  cat("```{r adlPlot}\n")
  cat("oldr::chart_op_adl(x = oldr::create_op(svy = svy), save_chart = FALSE)\n")
  cat("```\n")
  cat("\n")
  cat("```{r adlTable}\n")
  if (output_format == "html") {
    cat("knitr::kable(x = resultsDF[80:91, ],\n")
    cat("  caption = 'Activities of daily living',\n")
    cat("  booktabs = TRUE,\n")
    cat("  digits = 2,\n")
    cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>\n")
    cat("  kableExtra::kable_styling(bootstrap_options = c('striped')) |>\n")
    cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  } else {
    cat("knitr::kable(x = resultsDF[80:91, ], caption = 'Activities of daily living', digits = 2)\n")
  }
  cat("```\n")
}


#'
#' @export
#' @rdname report_op
#'

report_op_mental <- function(output_format = c("html", "docx", "odt", "pdf")) {
  output_format <- match.arg(output_format)

  cat("\n")
  cat("# Mental health\n")
  cat("\n")
  cat("```{r k6Plot}\n")
  cat("oldr::chart_op_k6(x = oldr::create_op(svy = svy), save_chart = FALSE)\n")
  cat("```\n")
  cat("\n")
  cat("```{r k6Table}\n")
  if (output_format == "html") {
    cat("knitr::kable(x = resultsDF[92:93, ],\n")
    cat("  caption = 'Psychological distress',\n")
    cat("  booktabs = TRUE,\n")
    cat("  digits = 2,\n")
    cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>\n")
    cat("  kableExtra::kable_styling(bootstrap_options = c('striped')) |>\n")
    cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  } else {
    cat("knitr::kable(x = resultsDF[92:93, ], caption = 'Psychological distress', digits = 2)\n")
  }
  cat("```\n")
}


#'
#' @export
#' @rdname report_op
#'

report_op_dementia <- function(output_format = c("html", "docx", 
                                                 "odt", "pdf")) {
  output_format <- match.arg(output_format)
  
  cat("\n")
  cat("# Dementia\n")
  cat("\n")
  cat("```{r csidPlot}\n")
  cat("oldr::chart_op_csid(x = oldr::create_op(svy = svy), save_chart = FALSE)\n")
  cat("```\n")
  cat("\n")
  cat("```{r csidTable}\n")
  if (output_format == "html") {
    cat("knitr::kable(x = resultsDF[94, ],\n")
    cat("  caption = 'Dementia',\n")
    cat("  booktabs = TRUE,\n")
    cat("  digits = 2,\n")
    cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>\n")
    cat("  kableExtra::kable_styling(bootstrap_options = c('striped')) |>\n")
    cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  } else {
    cat("knitr::kable(x = resultsDF[94, ], caption = 'Dementia', digits = 2)\n")
  }
  cat("```\n")
}


#'
#' @export
#' @rdname report_op
#'

report_op_health <- function(output_format = c("html", "docx", "odt", "pdf")) {
  output_format <- match.arg(output_format)

  cat("\n")
  cat("# Health\n")
  cat("\n")
  cat("## Chronic illness\n")
  cat("\n")
  cat("```{r chronicTable}\n")
  if (output_format == "html") {
    cat("knitr::kable(x = resultsDF[95:96, ],\n")
    cat("  caption = 'Prevalence of chronic illness',\n")
    cat("  booktabs = TRUE,\n")
    cat("  digits = 2,\n")
    cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>\n")
    cat("  kableExtra::kable_styling(bootstrap_options = c('striped')) |>\n")
    cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  } else {
    cat("knitr::kable(x = resultsDF[95:96, ], caption = 'Prevalence of chronic illness', digits = 2)\n")
  }
  cat("```\n")
  cat("### Reasons for not taking drugs for long term disease\n")
  cat("\n")
  cat("```{r reasonsChronicTable}\n")
  if (output_format == "html") {
    cat("knitr::kable(x = resultsDF[97:105, ],\n")
    cat("  caption = 'Reasons for not taking drugs for long term disease',\n")
    cat("  booktabs = TRUE,\n")
    cat("  digits = 2,\n")
    cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>\n")
    cat("  kableExtra::kable_styling(bootstrap_options = c('striped')) |>\n")
    cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  } else {
    cat("knitr::kable(x = resultsDF[97:105, ], caption = 'Reasons for not taking drugs for long term disease', digits = 2)\n")
  }
  cat("```\n")
  cat("\n")
  cat("## Recent illness\n")
  cat("\n")
  cat("```{r recentTable}\n")
  if (output_format == "html") {
    cat("knitr::kable(x = resultsDF[106:107, ],\n")
    cat("  caption = 'Prevalence of recent illness',\n")
    cat("  booktabs = TRUE,\n")
    cat("  digits = 2,\n")
    cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>\n")
    cat("  kableExtra::kable_styling(bootstrap_options = c('striped')) |>\n")
    cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  } else {
    cat("knitr::kable(x = resultsDF[106:107, ], caption = 'Prevalence of recent illness', digits = 2)\n")
  }
  cat("```\n")
  cat("### Reasons for not taking drugs for recent illness\n")
  cat("\n")
  cat("```{r reasonsRecentTable}\n")
  if (output_format == "html") {
    cat("knitr::kable(x = resultsDF[108:116, ],\n")
    cat("  caption = 'Reasons for not taking drugs for recent illness',\n")
    cat("  booktabs = TRUE,\n")
    cat("  digits = 2,\n")
    cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>\n")
    cat("  kableExtra::kable_styling(bootstrap_options = c('striped')) |>\n")
    cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  } else {
    cat("knitr::kable(x = resultsDF[108:116, ], caption = 'Reasons for not taking drugs for recent illness', digits = 2)\n")
  }
  cat("```\n")
}


#'
#' @export
#' @rdname report_op
#'

report_op_oedema <- function(output_format = c("html", "docx", "odt", "pdf")) {
  output_format <- match.arg(output_format)

  cat("\n")
  cat("# Oedema\n")
  cat("\n")
  cat("```{r otherTable}\n")
  if (output_format == "html") {
    cat("knitr::kable(x = resultsDF[131, ],\n")
    cat("  caption = 'Prevalence of oedema',\n")
    cat("  booktabs = TRUE,\n")
    cat("  digits = 2,\n")
    cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>\n")
    cat("  kableExtra::kable_styling(bootstrap_options = c('striped')) |>\n")
    cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  } else {
    cat("knitr::kable(x = resultsDF[131, ], caption = 'Prevalence of oedema', digits = 2)\n")
  }
  cat("```\n")
}


#'
#' @export
#' @rdname report_op
#'

report_op_anthro <- function(output_format = c("html", "docx", "odt", "pdf")) {
  output_format <- match.arg(output_format)

  cat("\n")
  cat("# Anthropometry\n")
  cat("\n")
  cat("```{r anthroTable}\n")
  if (output_format == "html") {
    cat("knitr::kable(x = resultsDF[137:139, ],\n")
    cat("  caption = 'Prevalence of acute malnutrition',\n")
    cat("  booktabs = TRUE,\n")
    cat("  digits = 2,\n")
    cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>\n")
    cat("  kableExtra::kable_styling(bootstrap_options = c('striped')) |>\n")
    cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  } else {
    cat("knitr::kable(x = resultsDF[137:139, ], caption = 'Prevalence of acute malnutrition', digits = 2)\n")
  }
  cat("```\n")
}


#'
#' @export
#' @rdname report_op
#'

report_op_screen <- function(output_format = c("html", "docx", "odt", "pdf")) {
  output_format <- match.arg(output_format)

  cat("\n")
  cat("# Screening\n")
  cat("\n")
  cat("```{r screenTable}\n")
  if (output_format == "html") {
    cat("knitr::kable(x = resultsDF[132, ],\n")
    cat("  caption = 'MUAC and oedema screening',\n")
    cat("  booktabs = TRUE,\n")
    cat("  digits = 2,\n")
    cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>\n")
    cat("  kableExtra::kable_styling(bootstrap_options = c('striped')) |>\n")
    cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  } else {
    cat("knitr::kable(x = resultsDF[132, ], caption = 'MUAC and oedema screening', digits = 2)\n")
  }
  cat("```\n")
}


#'
#' @export
#' @rdname report_op
#'

report_op_visual <- function(output_format = c("html", "docx", "odt", "pdf")) {
  output_format <- match.arg(output_format)

  cat("\n")
  cat("# Visual acuity\n")
  cat("\n")
  cat("```{r visualTable}\n")
  if (output_format == "html") {
    cat("knitr::kable(x = resultsDF[133, ],\n")
    cat("  caption = 'Visual impairment',\n")
    cat("  booktabs = TRUE,\n")
    cat("  digits = 2,\n")
    cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>\n")
    cat("  kableExtra::kable_styling(bootstrap_options = c('striped')) |>\n")
    cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  } else {
    cat("knitr::kable(x = resultsDF[133, ], caption = 'Visual impairment', digits = 2)\n")
  }
  cat("```\n")
}



#'
#' @export
#' @rdname report_op
#'

report_op_income <- function(output_format = c("html", "docx", "odt", "pdf")) {
  output_format <- match.arg(output_format)

  cat("\n")
  cat("# Income\n")
  cat("\n")
  cat("```{r incomePlot}\n")
  cat("oldr::chart_op_income(x = create_op(svy = svy),\n")
  cat("  save_chart = FALSE)\n")
  cat("```\n")
  cat("\n")
  cat("```{r incomeTable}\n")
  if (output_format == "html") {
    cat("knitr::kable(x = resultsDF[117:126, ],\n")
    cat("  caption = 'Income',\n")
    cat("  booktabs = TRUE,\n")
    cat("  digits = 2,\n")
    cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>\n")
    cat("  kableExtra::kable_styling(bootstrap_options = c('striped')) |>\n")
    cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  } else {
    cat("knitr::kable(x = resultsDF[117:126, ], caption = 'Income', digits = 2)\n")
  }
  cat("```\n")
}


#'
#' @export
#' @rdname report_op
#'

report_op_wash <- function(output_format = c("html", "docx", "odt", "pdf")) {
  output_format <- match.arg(output_format)

  cat("\n")
  cat("# Water, sanitation, and hygiene\n")
  cat("\n")
  cat("```{r washPlot}\n")
  cat("oldr::chart_op_wash(x = create_op(svy = svy), save_chart = FALSE)\n")
  cat("```\n")
  cat("\n")
  cat("```{r washTable}\n")
  if (output_format == "html") {
    cat("knitr::kable(x = resultsDF[127:130, ],\n")
    cat("  caption = 'Water, sanitation, and hygiene',\n")
    cat("  booktabs = TRUE,\n")
    cat("  digits = 2,\n")
    cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>\n")
    cat("  kableExtra::kable_styling(bootstrap_options = c('striped')) |>\n")
    cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  } else {
    cat("knitr::kable(x = resultsDF[127:130, ], caption = 'Water, sanitation, and hygiene', digits = 2)\n")
  }
  cat("```\n")
}


#'
#' @export
#' @rdname report_op
#'

report_op_misc <- function(output_format = c("html", "docx", "odt", "pdf")) {
  output_format <- match.arg(output_format)

  cat("\n")
  cat("# Miscellaneous indicators\n")
  cat("\n")
  cat("```{r miscTable}\n")
  if (output_format == "html") {
    cat("knitr::kable(x = resultsDF[134:136, ],\n")
    cat("  caption = 'Miscellaneous indicators',\n")
    cat("  booktabs = TRUE,\n")
    cat("  digits = 2,\n")
    cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>\n")
    cat("  kableExtra::kable_styling(bootstrap_options = c('striped')) |>\n")
    cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  } else {
    cat("knitr::kable(x = resultsDF[134:136, ], caption = 'Miscellaneous indicators', digits = 2)\n")
  }
  cat("```\n")
}


#' 
#' Create an HTML report document containing RAM-OP survey results
#'
#' @param estimates A data.frame of RAM-OP results produced by [merge_op()].
#' @param svy A data.frame collected using the standard RAM-OP questionnaire
#' @param indicators A character vector of indicator names
#' @param filename Filename for output document. Can be specified as a path to a
#'   specific directory where to output report document. Defaults to a path to
#'   a temporary directory and a filename `ramOPreport``.
#' @param title Title of report
#' @param view Logical. Open report in current browser? Default is FALSE.
#'
#' @returns An HTML document in the working directory or if filename is a path,
#'   to a specified directory.
#'
#' @author Ernest Guevarra
#'
#' @examples
#' classicResults <- estimate_classic(
#'   x = create_op(testSVY), w = testPSU, replicates = 9
#' )
#'
#' probitResults <- estimate_probit(
#'   x = create_op(testSVY), w = testPSU, replicates = 9
#' )
#'
#' resultsDF <- merge_op(x = classicResults, y = probitResults)
#'
#' library(rmarkdown)
#' 
#' if (pandoc_available("1.12.3")) {
#'   report_op_html(
#'     svy = testSVY, estimates = resultsDF, indicators = "mental",
#'     filename = paste(tempdir(), "report", sep = "/")
#'   )
#' }
#'
#' @export
#'

report_op_html <- function(estimates,
                           svy,
                           indicators = c("demo", "food", "hunger",
                                          "disability", "adl", "mental",
                                          "dementia", "health", "income",
                                          "wash", "anthro", "oedema",
                                          "screening", "visual", "misc"),
                           filename = paste(tempdir(), "ramOPreport", sep = "/"),
                           title = "RAM-OP Report",
                           view = FALSE) {
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
          cat("resultsDF <- get(params$estimates) |>\n")
          cat("  dplyr::select(LABEL:UCL.FEMALES)\n")
          cat("svy <- get(params$svy)\n")
          cat("```\n")
          cat("\n")
          cat("<hr>\n")
          if ("demo" %in% indicators) report_op_demo()
          if ("food" %in% indicators) report_op_food()
          if ("hunger" %in% indicators) report_op_hunger()
          if ("disability" %in% indicators) report_op_disability()
          if ("adl" %in% indicators) report_op_adl()
          if ("mental" %in% indicators) report_op_mental()
          if ("dementia" %in% indicators) report_op_dementia()
          if ("health" %in% indicators) report_op_health()
          if ("visual" %in% indicators) report_op_visual()
          if ("oedema" %in% indicators) report_op_oedema()
          if ("anthro" %in% indicators) report_op_anthro()
          if ("screening" %in% indicators) report_op_screen()
          if ("income" %in% indicators) report_op_income()
          if ("wash" %in% indicators) report_op_wash()
          if ("misc" %in% indicators) report_op_misc()
          cat("\n")
        }
      )
    }
  )

  ## Render document in HTML format
  rmarkdown::render(input = paste(filename, ".Rmd", sep = ""),
                    output_format = "html_document")

  ## Check if report is to be viewed
  if (view) {
    ## Open HTML
    utils::browseURL(url = paste(filename, ".html", sep = ""))
  }
}


#' 
#' Create a DOCX report document containing RAM-OP survey results
#'
#' @param estimates A data.frame of RAM-OP results produced by [merge_op()].
#' @param svy A data.frame collected using the standard RAM-OP questionnaire
#' @param indicators A character vector of indicator names
#' @param filename Filename for output document. Can be specified as a path to a
#'   specific directory where to output report document. Defaults to a path to
#'   a temporary directory and a filename `ramOPreport`.
#' @param title Title of report
#' @param view Logical. Open report in current environment? Default is FALSE.
#'
#' @returns An DOCX in the working directory or if filename is a path, to a
#'   specified directory.
#'
#' @author Ernest Guevarra
#'
#' @examples
#' classicResults <- estimate_classic(
#'   x = create_op(testSVY), w = testPSU, replicates = 9
#' )
#'
#' probitResults <- estimate_probit(
#'   x = create_op(testSVY), w = testPSU, replicates = 9
#' )
#'
#' resultsDF <- merge_op(x = classicResults, y = probitResults)
#'
#' library(rmarkdown)
#' 
#' if (pandoc_version() >= numeric_version("1.12.3")) {
#'   report_op_docx(
#'     svy = testSVY, estimates = resultsDF, indicators = "mental",
#'     filename = paste(tempdir(), "report", sep = "/")
#'   )
#' }
#'
#' @export
#'

report_op_docx <- function(estimates,
                           svy,
                           indicators = c("demo", "food", "hunger",
                                          "disability", "adl", "mental",
                                          "dementia", "health", "income",
                                          "wash", "anthro", "oedema",
                                          "screening", "visual", "misc"),
                           filename = paste(tempdir(), "ramOPreport", sep = "/"),
                           title = "RAM-OP Report",
                           view = FALSE) {
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
          cat("  word_document:\n")
          cat("    reference_docx: ", system.file('template', 'word_template.docx', package = 'oldr'), "\n")
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
          cat("  comment = '#>')\n")
          cat("\n")
          cat("resultsDF <- get(params$estimates) |>\n")
          cat("  dplyr::select(LABEL:UCL.FEMALES)\n")
          cat("svy <- get(params$svy)\n")
          cat("```\n")
          cat("\n")
          cat("<hr>\n")
          if ("demo" %in% indicators) report_op_demo("docx")
          if ("food" %in% indicators) report_op_food("docx")
          if ("hunger" %in% indicators) report_op_hunger("docx")
          if ("disability" %in% indicators) report_op_disability("docx")
          if ("adl" %in% indicators) report_op_adl("docx")
          if ("mental" %in% indicators) report_op_mental("docx")
          if ("dementia" %in% indicators) report_op_dementia("docx")
          if ("health" %in% indicators) report_op_health("docx")
          if ("visual" %in% indicators) report_op_visual("docx")
          if ("oedema" %in% indicators) report_op_oedema("docx")
          if ("anthro" %in% indicators) report_op_anthro("docx")
          if ("screening" %in% indicators) report_op_screen("docx")
          if ("income" %in% indicators) report_op_income("docx")
          if ("wash" %in% indicators) report_op_wash("docx")
          if ("misc" %in% indicators) report_op_misc("docx")
          cat("\n")
        }
      )
    }
  )

  ## Render document in HTML format
  rmarkdown::render(
    input = paste(filename, ".Rmd", sep = ""),
    output_format = "word_document"
  )

  ## Check if report is to be viewed
  if (view) {
    ## Open DOCX
    system(paste("open '", paste(filename, ".docx", sep = ""), "'", sep = ""))
  }
}


#' 
#' Create a ODT report document containing RAM-OP survey results
#'
#' @param estimates A data.frame of RAM-OP results produced by [merge_op()].
#' @param svy A data.frame collected using the standard RAM-OP questionnaire
#' @param indicators A character vector of indicator names
#' @param filename Filename for output document. Can be specified as a path to a
#'   specific directory where to output report document. Defaults to a path to
#'   a temporary directory and a filename `ramOPreport`.
#' @param title Title of report
#' @param view Logical. Open report in current environment? Default is FALSE.
#'
#' @returns An ODT in the working directory or if filename is a path, to a
#'   specified directory.
#'
#' @author Ernest Guevarra
#'
#' @examples
#' classicResults <- estimate_classic(
#'   x = create_op(testSVY), w = testPSU, replicates = 9
#' )
#'
#' probitResults <- estimate_probit(
#'   x = create_op(testSVY), w = testPSU, replicates = 9
#' )
#'
#' resultsDF <- merge_op(x = classicResults, y = probitResults)
#'
#' library(rmarkdown)
#' 
#' if (pandoc_version() >= numeric_version("1.12.3")) {
#'   report_op_odt(
#'     svy = testSVY, estimates = resultsDF, indicators = "mental",
#'     filename = paste(tempdir(), "report", sep = "/")
#'   )
#' }
#'
#' @export
#'

report_op_odt <- function(estimates,
                          svy,
                          indicators = c("demo", "food", "hunger",
                                         "disability", "adl", "mental",
                                         "dementia", "health", "income",
                                         "wash", "anthro", "oedema",
                                         "screening", "visual", "misc"),
                          filename = paste(tempdir(), "ramOPreport", sep = "/"),
                          title = "RAM-OP Report",
                          view = FALSE) {
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
          cat("  word_document:\n")
          cat("    reference_odt: ", system.file('template', 'odt_template.odt', package = 'oldr'), "\n")
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
          cat("  comment = '#>')\n")
          cat("\n")
          cat("resultsDF <- get(params$estimates) |>\n")
          cat("  dplyr::select(LABEL:UCL.FEMALES)\n")
          cat("svy <- get(params$svy)\n")
          cat("```\n")
          cat("\n")
          cat("<hr>\n")
          if ("demo" %in% indicators) report_op_demo("odt")
          if ("food" %in% indicators) report_op_food("odt")
          if ("hunger" %in% indicators) report_op_hunger("odt")
          if ("disability" %in% indicators) report_op_disability("odt")
          if ("adl" %in% indicators) report_op_adl("odt")
          if ("mental" %in% indicators) report_op_mental("odt")
          if ("dementia" %in% indicators) report_op_dementia("odt")
          if ("health" %in% indicators) report_op_health("odt")
          if ("visual" %in% indicators) report_op_visual("odt")
          if ("oedema" %in% indicators) report_op_oedema("odt")
          if ("anthro" %in% indicators) report_op_anthro("odt")
          if ("screening" %in% indicators) report_op_screen("odt")
          if ("income" %in% indicators) report_op_income("odt")
          if ("wash" %in% indicators) report_op_wash("odt")
          if ("misc" %in% indicators) report_op_misc("odt")
          cat("\n")
        }
      )
    }
  )

  ## Render document in HTML format
  rmarkdown::render(
    input = paste(filename, ".Rmd", sep = ""),
    output_format = "odt_document"
  )

  ## Check if report is to be viewed
  if (view) {
    ## Open ODT
    system(paste("open '", paste(filename, ".odt", sep = ""), "'", sep = ""))
  }
}


#' 
#' Create a PDF report document containing RAM-OP survey results
#'
#' @param estimates A data.frame of RAM-OP results produced by [merge_op()].
#' @param svy A data.frame collected using the standard RAM-OP questionnaire
#' @param indicators A character vector of indicator names
#' @param filename Filename for output document. Can be specified as a path to a
#'   specific directory where to output report document
#' @param title Title of report
#' @param view Logical. Open report in current PDF reader? Default is FALSE.
#'
#' @returns A PDF document in the working directory or if filename is a path,
#'   to a specified directory.
#'
#' @examples
#' classicResults <- estimate_classic(
#'   x = create_op(testSVY), w = testPSU, replicates = 3
#' )
#'
#' probitResults <- estimate_probit(
#'   x = create_op(testSVY), w = testPSU, replicates = 3
#' )
#'
#' resultsDF <- merge_op(x = classicResults, y = probitResults)
#'
#' library(rmarkdown)
#' library(tinytex)
#' 
#' \donttest{
#'   if (pandoc_version() >= numeric_version("1.12.3")) {
#'     report_op_pdf(
#'       svy = testSVY, estimates = resultsDF, indicators = "mental",
#'       filename = paste(tempdir(), "report", sep = "/")
#'     )
#'   }
#' }
#' 
#' @export
#'

report_op_pdf <- function(estimates,
                          svy,
                          indicators = c("demo", "food", "hunger",
                                         "disability", "adl", "mental",
                                         "dementia", "health", "income",
                                         "wash", "anthro", "oedema",
                                         "screening", "visual", "misc"),
                          filename = "ramOPreport",
                          title = "RAM-OP Report",
                          view = FALSE) {
  ## Create Rmd report file
  withr::with_options(
    new = list(width = 80),
    code = {
      withr::with_output_sink(
        new = paste(filename, ".Rmd", sep = ""),
        code = {
          cat("---\n")
          cat("title: ", title, "\n", sep = "")
          cat("header-includes:\n")
          cat("  - \\usepackage{booktabs}\n")
          cat("  - \\usepackage{longtable}\n")
          cat("  - \\usepackage{array}\n")
          cat("  - \\usepackage{multirow}\n")
          cat("  - \\usepackage{wrapfig}\n")
          cat("  - \\usepackage{float}\n")
          cat("  - \\usepackage{colortbl}\n")
          cat("  - \\usepackage{pdflscape}\n")
          cat("  - \\usepackage{tabu}\n")
          cat("  - \\usepackage{threeparttable}\n")
          cat("  - \\usepackage{threeparttablex}\n")
          cat("  - \\usepackage[normalem]{ulem}\n")
          cat("  - \\usepackage{makecell}\n")
          cat("output:\n")
          cat("  pdf_document:\n")
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
          cat("library(kableExtra)\n")
          cat("resultsDF <- get(params$estimates)\n")
          cat("svy <- get(params$svy)\n")
          cat("```\n")
          cat("\n")
          cat("\\newpage\n")
          if ("demo" %in% indicators) report_op_demo("pdf")
          if ("food" %in% indicators) report_op_food("pdf")
          if ("hunger" %in% indicators) report_op_hunger("pdf")
          if ("disability" %in% indicators) report_op_disability("pdf")
          if ("adl" %in% indicators) report_op_adl("pdf")
          if ("mental" %in% indicators) report_op_mental("pdf")
          if ("dementia" %in% indicators) report_op_dementia("pdf")
          if ("health" %in% indicators) report_op_health("pdf")
          if ("visual" %in% indicators) report_op_visual("pdf")
          if ("oedema" %in% indicators) report_op_oedema("pdf")
          if ("anthro" %in% indicators) report_op_anthro("pdf")
          if ("screening" %in% indicators) report_op_screen("pdf")
          if ("income" %in% indicators) report_op_income("pdf")
          if ("wash" %in% indicators) report_op_wash("pdf")
          if ("misc" %in% indicators) report_op_misc("pdf")
          cat("\n")
        }
      )
    }
  )

  ## Render document in HTML format
  rmarkdown::render(
    input = paste(filename, ".Rmd", sep = ""),
    output_format = "pdf_document"
  )

  ## Check if report is to be viewed
  if (view) {
    ## Open PDF
    system(paste("open '", paste(filename, ".pdf", sep = ""), "'", sep = ""))
  }
}
