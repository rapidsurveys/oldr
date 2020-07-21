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
#' Create a report chunk for demography indicators
#'
#' @return A reporting chunk for demographic indicators
#'
#' @examples
#'   report_op_demo()
#'
#' @export
#'
#
################################################################################

report_op_demo <- function() {
  cat("\n")
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
  cat("```\n")
}


################################################################################
#
#' Create a report chunk for food indicators
#'
#' @return A reporting chunk for food indicators
#'
#' @examples
#'   report_op_food()
#'
#' @export
#'
#
################################################################################

report_op_food <- function() {
  cat("\n")
  cat("# Diet\n")
  cat("## Meal frequency\n")
  cat("\n")
  cat("```{r mfPlot}\n")
  cat("oldr::chart_mf(x = oldr::create_op_all(svy = svy), save.chart = FALSE)\n")
  cat("```\n")
  cat("\n")
  cat("```{r mfTable}\n")
  cat("knitr::kable(x = resultsDF[20, seq(from = 3, to = ncol(resultsDF), by = 1)],\n")
  cat("  caption = 'Meal frequency',\n")
  cat("  digits = 2,\n")
  cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) %>%\n")
  cat("  kableExtra::kable_styling(bootstrap_option = c('striped')) %>%\n")
  cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  cat("```\n")
  cat("\n")
  cat("## Dietary diversity\n")
  cat("```{r ddsPlot}\n")
  cat("oldr::chart_dds(x = oldr::create_op_all(svy = svy), save.chart = FALSE)\n")
  cat("```\n")
  cat("\n")
  cat("```{r ddsTable}\n")
  cat("knitr::kable(x = resultsDF[21:32, seq(from = 3, to = ncol(resultsDF), by = 1)],\n")
  cat("  caption = 'Dietary diversity',\n")
  cat("  digits = 2,\n")
  cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) %>%\n")
  cat("  kableExtra::kable_styling(bootstrap_option = c('striped')) %>%\n")
  cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  cat("```\n")
  cat("\n")
  cat("## Nutrient intake\n")
  cat("```{r nutrientTable}\n")
  cat("knitr::kable(x = resultsDF[33:47, seq(from = 3, to = ncol(resultsDF), by = 1)],\n")
  cat("  caption = 'Nutrient intake',\n")
  cat("  digits = 2,\n")
  cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) %>%\n")
  cat("  kableExtra::kable_styling(bootstrap_option = c('striped')) %>%\n")
  cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  cat("```\n")
}


################################################################################
#
#' Create a report chunk for activities of food security indicators
#'
#' @return A reporting chunk for food security indicators
#'
#' @examples
#'   report_op_hunger()
#'
#' @export
#'
#
################################################################################

report_op_hunger <- function() {
  cat("\n")
  cat("# Food security\n")
  cat("\n")
  cat("## Household hunger score\n")
  cat("```{r hhsPlot}\n")
  cat("oldr::chart_hhs(x = oldr::create_op_all(svy = svy), save.chart = FALSE)\n")
  cat("```\n")
  cat("\n")
  cat("```{r hhsTable}\n")
  cat("knitr::kable(x = resultsDF[48:50, seq(from = 3, to = ncol(resultsDF), by = 1)],\n")
  cat("  caption = 'Household hunger score',\n")
  cat("  digits = 2,\n")
  cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) %>%\n")
  cat("  kableExtra::kable_styling(bootstrap_option = c('striped')) %>%\n")
  cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  cat("```\n")
}


################################################################################
#
#' Create a report chunk for disability indicators
#'
#' @return A reporting chunk for disability indicators
#'
#' @examples
#'   report_op_disability()
#'
#' @export
#'
#
################################################################################

report_op_disability <- function() {
  cat("\n")
  cat("# Disability\n")
  cat("\n")
  cat("## Overall\n")
  cat("\n")
  cat("```{r wgPlot}\n")
  cat("oldr::chart_wg(x = oldr::create_op_all(svy = svy), save.chart = FALSE)\n")
  cat("```\n")
  cat("\n")
  cat("```{r wgTable}\n")
  cat("knitr::kable(x = resultsDF[75:79, seq(from = 3, to = ncol(resultsDF), by = 1)],\n")
  cat("  caption = 'Overall disability',\n")
  cat("  digits = 2,\n")
  cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) %>%\n")
  cat("  kableExtra::kable_styling(bootstrap_option = c('striped')) %>%\n")
  cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  cat("```\n")
  cat("\n")
  cat("## Vision\n")
  cat("\n")
  cat("```{r visionTable}\n")
  cat("knitr::kable(x = resultsDF[51:54, seq(from = 3, to = ncol(resultsDF), by = 1)],\n")
  cat("  caption = 'Disability related to vision',\n")
  cat("  digits = 2,\n")
  cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) %>%\n")
  cat("  kableExtra::kable_styling(bootstrap_option = c('striped')) %>%\n")
  cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  cat("```\n")
  cat("\n")
  cat("## Hearing\n")
  cat("\n")
  cat("```{r hearingTable}\n")
  cat("knitr::kable(x = resultsDF[55:58, seq(from = 3, to = ncol(resultsDF), by = 1)],\n")
  cat("  caption = 'Disability related to hearing',\n")
  cat("  digits = 2,\n")
  cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) %>%\n")
  cat("  kableExtra::kable_styling(bootstrap_option = c('striped')) %>%\n")
  cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  cat("```\n")
  cat("\n")
  cat("## Mobility\n")
  cat("\n")
  cat("```{r mobilityTable}\n")
  cat("knitr::kable(x = resultsDF[59:62, seq(from = 3, to = ncol(resultsDF), by = 1)],\n")
  cat("  caption = 'Disability related to mobility',\n")
  cat("  digits = 2,\n")
  cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) %>%\n")
  cat("  kableExtra::kable_styling(bootstrap_option = c('striped')) %>%\n")
  cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  cat("```\n")
  cat("\n")
  cat("## Remembering\n")
  cat("\n")
  cat("```{r rememberingTable}\n")
  cat("knitr::kable(x = resultsDF[63:66, seq(from = 3, to = ncol(resultsDF), by = 1)],\n")
  cat("  caption = 'Disability related to remembering',\n")
  cat("  digits = 2,\n")
  cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) %>%\n")
  cat("  kableExtra::kable_styling(bootstrap_option = c('striped')) %>%\n")
  cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  cat("```\n")
  cat("\n")
  cat("## Self-care\n")
  cat("\n")
  cat("```{r selfCareTable}\n")
  cat("knitr::kable(x = resultsDF[67:70, seq(from = 3, to = ncol(resultsDF), by = 1)],\n")
  cat("  caption = 'Disability related to self-care',\n")
  cat("  digits = 2,\n")
  cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) %>%\n")
  cat("  kableExtra::kable_styling(bootstrap_option = c('striped')) %>%\n")
  cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  cat("```\n")
  cat("\n")
  cat("## Communicating\n")
  cat("\n")
  cat("```{r communicatingTable}\n")
  cat("knitr::kable(x = resultsDF[71:74, seq(from = 3, to = ncol(resultsDF), by = 1)],\n")
  cat("  caption = 'Disability related to communicating',\n")
  cat("  digits = 2,\n")
  cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) %>%\n")
  cat("  kableExtra::kable_styling(bootstrap_option = c('striped')) %>%\n")
  cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  cat("```\n")
}


################################################################################
#
#' Create a report chunk for activities of daily living indicators
#'
#' @return A reporting chunk for ADL indicators
#'
#' @examples
#'   report_op_adl()
#'
#' @export
#'
#
################################################################################

report_op_adl <- function() {
  cat("\n")
  cat("# Activities of daily living\n")
  cat("```{r adlPlot}\n")
  cat("oldr::chart_adl(x = oldr::create_op_all(svy = svy), save.chart = FALSE)\n")
  cat("```\n")
  cat("\n")
  cat("```{r adlTable}\n")
  cat("knitr::kable(x = resultsDF[80:91, seq(from = 3, to = ncol(resultsDF), by = 1)],\n")
  cat("  caption = 'Activities of daily living',\n")
  cat("  digits = 2,\n")
  cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) %>%\n")
  cat("  kableExtra::kable_styling(bootstrap_option = c('striped')) %>%\n")
  cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  cat("```\n")
}


################################################################################
#
#' Create a report chunk for mental health indicators
#'
#' @return A reporting chunk for mental health indicators
#'
#' @examples
#'   report_op_mental()
#'
#' @export
#'
#
################################################################################

report_op_mental <- function() {
  cat("\n")
  cat("# Mental health\n")
  cat("\n")
  cat("```{r k6Plot}\n")
  cat("oldr::chart_k6(x = oldr::create_op_all(svy = svy), save.chart = FALSE)\n")
  cat("```\n")
  cat("\n")
  cat("```{r k6Table}\n")
  cat("knitr::kable(x = resultsDF[92:93, seq(from = 3, to = ncol(resultsDF), by = 1)],\n")
  cat("  caption = 'Psychological distress',\n")
  cat("  digits = 2,\n")
  cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) %>%\n")
  cat("  kableExtra::kable_styling(bootstrap_option = c('striped')) %>%\n")
  cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  cat("```\n")
}


################################################################################
#
#' Create a report chunk for dementia indicators
#'
#' @return A reporting chunk for dementia indicators
#'
#' @examples
#'   report_op_dementia()
#'
#' @export
#'
#
################################################################################

report_op_dementia <- function() {
  cat("\n")
  cat("# Dementia\n")
  cat("\n")
  cat("```{r csidPlot}\n")
  cat("oldr::chart_csid(x = oldr::create_op_all(svy = svy), save.chart = FALSE)\n")
  cat("```\n")
  cat("\n")
  cat("```{r csidTable}\n")
  cat("knitr::kable(x = resultsDF[94, seq(from = 3, to = ncol(resultsDF), by = 1)],\n")
  cat("  caption = 'Dementia',\n")
  cat("  digits = 2,\n")
  cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) %>%\n")
  cat("  kableExtra::kable_styling(bootstrap_option = c('striped')) %>%\n")
  cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  cat("```\n")
}


################################################################################
#
#' Create a report chunk for health and health-seeking behaviour indicators
#'
#' @return A reporting chunk for health and health-seeking behaviour indicators
#'
#' @examples
#'   report_op_health()
#'
#' @export
#'
#
################################################################################

report_op_health <- function() {
  cat("\n")
  cat("# Health\n")
  cat("\n")
  cat("## Chronic illness\n")
  cat("\n")
  cat("```{r chronicTable}\n")
  cat("knitr::kable(x = resultsDF[95:96, seq(from = 3, to = ncol(resultsDF), by = 1)],\n")
  cat("  caption = 'Prevalence of chronic illness',\n")
  cat("  digits = 2,\n")
  cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) %>%\n")
  cat("  kableExtra::kable_styling(bootstrap_option = c('striped')) %>%\n")
  cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  cat("```\n")
  cat("### Reasons for not taking drugs for long term disease\n")
  cat("\n")
  cat("```{r reasonsChronicTable}\n")
  cat("knitr::kable(x = resultsDF[97:105, seq(from = 3, to = ncol(resultsDF), by = 1)],\n")
  cat("  caption = 'Reasons for not taking drugs for long term disease',\n")
  cat("  digits = 2,\n")
  cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) %>%\n")
  cat("  kableExtra::kable_styling(bootstrap_option = c('striped')) %>%\n")
  cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  cat("```\n")
  cat("\n")
  cat("## Recent illness\n")
  cat("\n")
  cat("```{r recentTable}\n")
  cat("knitr::kable(x = resultsDF[106:107, seq(from = 3, to = ncol(resultsDF), by = 1)],\n")
  cat("  caption = 'Prevalence of recent illness',\n")
  cat("  digits = 2,\n")
  cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) %>%\n")
  cat("  kableExtra::kable_styling(bootstrap_option = c('striped')) %>%\n")
  cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  cat("```\n")
  cat("### Reasons for not taking drugs for recent illness\n")
  cat("\n")
  cat("```{r reasonsRecentTable}\n")
  cat("knitr::kable(x = resultsDF[108:116, seq(from = 3, to = ncol(resultsDF), by = 1)],\n")
  cat("  caption = 'Reasons for not taking drugs for recent illness',\n")
  cat("  digits = 2,\n")
  cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) %>%\n")
  cat("  kableExtra::kable_styling(bootstrap_option = c('striped')) %>%\n")
  cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  cat("```\n")
}

################################################################################
#
#' Create a report chunk for oedema
#'
#' @return A reporting chunk for oedema indicators
#'
#' @examples
#'   report_op_oedema()
#'
#' @export
#'
#
################################################################################

report_op_oedema <- function() {
  cat("\n")
  cat("## Oedema\n")
  cat("\n")
  cat("```{r otherTable}\n")
  cat("knitr::kable(x = resultsDF[131, seq(from = 3, to = ncol(resultsDF), by = 1)],\n")
  cat("  caption = 'Prevalence of oedema',\n")
  cat("  digits = 2,\n")
  cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) %>%\n")
  cat("  kableExtra::kable_styling(bootstrap_option = c('striped')) %>%\n")
  cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  cat("```\n")
}

################################################################################
#
#' Create a report chunk for anthropometric indicators
#'
#' @return A reporting chunk for anhtropometric indicators
#'
#' @examples
#'   report_op_anthro()
#'
#' @export
#'
#
################################################################################

report_op_anthro <- function() {
  cat("\n")
  cat("## Anthropometry\n")
  cat("\n")
  cat("```{r anthroTable}\n")
  cat("knitr::kable(x = resultsDF[137:139, seq(from = 3, to = ncol(resultsDF), by = 1)],\n")
  cat("  caption = 'Prevalence of acute malnutrition',\n")
  cat("  digits = 2,\n")
  cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) %>%\n")
  cat("  kableExtra::kable_styling(bootstrap_option = c('striped')) %>%\n")
  cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  cat("```\n")
}


################################################################################
#
#' Create a report chunk for screening indicators
#'
#' @return A reporting chunk for screening indicators
#'
#' @examples
#'   report_op_screen()
#'
#' @export
#'
#
################################################################################

report_op_screen <- function() {
  cat("\n")
  cat("## Screening\n")
  cat("\n")
  cat("```{r screenTable}\n")
  cat("knitr::kable(x = resultsDF[132, seq(from = 3, to = ncol(resultsDF), by = 1)],\n")
  cat("  caption = 'MUAC and oedema screening',\n")
  cat("  digits = 2,\n")
  cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) %>%\n")
  cat("  kableExtra::kable_styling(bootstrap_option = c('striped')) %>%\n")
  cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  cat("```\n")
}


################################################################################
#
#' Create a report chunk for visual acuity
#'
#' @return A reporting chunk for visual acuity
#'
#' @examples
#'   report_op_visual()
#'
#' @export
#'
#
################################################################################

report_op_visual <- function() {
  cat("\n")
  cat("## Visual acuity\n")
  cat("\n")
  cat("```{r visualTable}\n")
  cat("knitr::kable(x = resultsDF[133, seq(from = 3, to = ncol(resultsDF), by = 1)],\n")
  cat("  caption = 'Visual impairment',\n")
  cat("  digits = 2,\n")
  cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) %>%\n")
  cat("  kableExtra::kable_styling(bootstrap_option = c('striped')) %>%\n")
  cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  cat("```\n")
}


################################################################################
#
#' Create a report chunk for income
#'
#' @return A reporting chunk for income
#'
#' @examples
#'   report_op_income()
#'
#' @export
#'
#
################################################################################

report_op_income <- function() {
  cat("\n")
  cat("## Income\n")
  cat("\n")
  cat("```{r incomePlot}\n")
  cat("oldr::chart_income(x.male = create_op_all(svy = svy, gender = 'm'),\n")
  cat("  x.female = create_op_all(svy = svy, gender = 'f'), save.chart = FALSE)\n")
  cat("```\n")
  cat("\n")
  cat("```{r incomeTable}\n")
  cat("knitr::kable(x = resultsDF[117:126, seq(from = 3, to = ncol(resultsDF), by = 1)],\n")
  cat("  caption = 'Income',\n")
  cat("  digits = 2,\n")
  cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) %>%\n")
  cat("  kableExtra::kable_styling(bootstrap_option = c('striped')) %>%\n")
  cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  cat("```\n")
}


################################################################################
#
#' Create a report chunk for water, sanitation and hygiene
#'
#' @return A reporting chunk for water, saniation hygiene
#'
#' @examples
#'   report_op_wash()
#'
#' @export
#'
#
################################################################################

report_op_wash <- function() {
  cat("\n")
  cat("## Water, sanitation and hygiene\n")
  cat("\n")
  cat("```{r washPlot}\n")
  cat("oldr::chart_wash(x = create_op_all(svy = svy), save.chart = FALSE)\n")
  cat("```\n")
  cat("\n")
  cat("```{r washTable}\n")
  cat("knitr::kable(x = resultsDF[127:130, seq(from = 3, to = ncol(resultsDF), by = 1)],\n")
  cat("  caption = 'Water, sanitation and hygiene',\n")
  cat("  digits = 2,\n")
  cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) %>%\n")
  cat("  kableExtra::kable_styling(bootstrap_option = c('striped')) %>%\n")
  cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  cat("```\n")
}


################################################################################
#
#' Create a report chunk for miscellaneous indicators
#'
#' @return A reporting chunk for miscellaneous indicators
#'
#' @examples
#'   report_op_misc()
#'
#' @export
#'
#
################################################################################

report_op_misc <- function() {
  cat("\n")
  cat("## Miscellaneous indicators\n")
  cat("\n")
  cat("```{r miscTable}\n")
  cat("knitr::kable(x = resultsDF[134:136, seq(from = 3, to = ncol(resultsDF), by = 1)],\n")
  cat("  caption = 'Miscellaneous indicators',\n")
  cat("  digits = 2,\n")
  cat("  col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) %>%\n")
  cat("  kableExtra::kable_styling(bootstrap_option = c('striped')) %>%\n")
  cat("  kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))\n")
  cat("```\n")
}


################################################################################
#
#' Create an HTML report document containing RAM-OP survey results
#'
#' @param estimates A data.frame of RAM-OP results produced by
#'   \link{merge_estimates} function.
#' @param svy A data.frame collected using the standard RAM-OP questionnaire
#' @param indicators A character vector of indicator names
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
#'                  indicators = c("demo", "hunger"),
#'                  filename = paste(tempdir(), "report", sep = "/"))
#'
#' @export
#'
#
################################################################################

report_op_html <- function(estimates,
                           svy,
                           indicators = c("demo", "food", "hunger",
                                          "disability", "adl", "mental",
                                          "dementia", "health", "income",
                                          "wash", "anthro", "oedema",
                                          "screening", "visual", "misc"),
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
          if("demo" %in% indicators) report_op_demo()
          if("food" %in% indicators) report_op_food()
          if("hunger" %in% indicators) report_op_hunger()
          if("disability" %in% indicators) report_op_disability()
          if("adl" %in% indicators) report_op_adl()
          if("mental" %in% indicators) report_op_mental()
          if("dementia" %in% indicators) report_op_dementia()
          if("health" %in% indicators) report_op_health()
          if("visual" %in% indicators) report_op_visual()
          if("oedema" %in% indicators) report_op_oedema()
          if("anthro" %in% indicators) report_op_anthro()
          if("screening" %in% indicators) report_op_screen()
          if("income" %in% indicators) report_op_income()
          if("wash" %in% indicators) report_op_wash()
          if("misc" %in% indicators) report_op_misc()
          cat("\n")
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


################################################################################
#
# Create a PDF report document containing RAM-OP survey results
#
# @param estimates A data.frame of RAM-OP results produced by
#   \link{merge_estimates} function.
# @param svy A data.frame collected using the standard RAM-OP questionnaire
# @param indicators A character vector of indicator names
# @param filename Filename for output document. Can be specified as a path to a
#   specific directory where to output report document
# @param title Title of report
#
# @return A PDF document in the working directory or if filename is a path,
#   to a specified directory.
#
# @examples
#   #
#   classicResults <- estimate_classic(x = create_op_all(testSVY),
#                                      w = testPSU,
#                                      replicates = 9)
#
#   probitResults <- estimate_probit(x = create_op_all(testSVY),
#                                    w = testPSU,
#                                    replicates = 9)
#
#   resultsDF <- merge_estimates(x = classicResults, y = probitResults)
#
#   report_op_pdf(svy = testSVY,
#                 estimates = resultsDF,
#                 indicators = c("demo", "food"),
#                 filename = paste(tempdir(), "report", sep = "/"))
#
#
#
################################################################################

report_op_pdf <- function(estimates,
                           svy,
                           indicators = c("demo", "food", "hunger",
                                          "disability", "adl", "mental",
                                          "dementia", "health", "income",
                                          "wash", "anthro", "oedema",
                                          "screening", "visual", "misc"),
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
          cat("  pdf_document:\n")
          cat("    toc: true\n")
          cat("    toc_depth: 2\n")
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
          if("demo" %in% indicators) report_op_demo()
          if("food" %in% indicators) report_op_food()
          if("hunger" %in% indicators) report_op_hunger()
          if("disability" %in% indicators) report_op_disability()
          if("adl" %in% indicators) report_op_adl()
          if("mental" %in% indicators) report_op_mental()
          if("dementia" %in% indicators) report_op_dementia()
          if("health" %in% indicators) report_op_health()
          if("visual" %in% indicators) report_op_visual()
          if("oedema" %in% indicators) report_op_oedema()
          if("anthro" %in% indicators) report_op_anthro()
          if("screening" %in% indicators) report_op_screen()
          if("income" %in% indicators) report_op_income()
          if("wash" %in% indicators) report_op_wash()
          if("misc" %in% indicators) report_op_misc()
          cat("\n")
        }
      )
    }
  )

  ## Render document in HTML format
  rmarkdown::render(input = paste(filename, ".Rmd", sep = ""),
                    output_format = "pdf_document")

  ## Open PDF
  system(paste("open '", paste(filename, ".pdf", sep = ""), "'", sep = ""))
}
