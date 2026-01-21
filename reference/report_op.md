# Create table and report chunk of RAM-OP results

Create table and report chunk of RAM-OP results

## Usage

``` r
report_op_table(estimates, filename = paste(tempdir(), "ramOP", sep = "/"))

report_op_demo(output_format = c("html", "docx", "odt", "pdf"))

report_op_food(output_format = c("html", "docx", "odt", "pdf"))

report_op_hunger(output_format = c("html", "docx", "odt", "pdf"))

report_op_disability(output_format = c("html", "docx", "odt", "pdf"))

report_op_adl(output_format = c("html", "docx", "odt", "pdf"))

report_op_mental(output_format = c("html", "docx", "odt", "pdf"))

report_op_dementia(output_format = c("html", "docx", "odt", "pdf"))

report_op_health(output_format = c("html", "docx", "odt", "pdf"))

report_op_oedema(output_format = c("html", "docx", "odt", "pdf"))

report_op_anthro(output_format = c("html", "docx", "odt", "pdf"))

report_op_screen(output_format = c("html", "docx", "odt", "pdf"))

report_op_visual(output_format = c("html", "docx", "odt", "pdf"))

report_op_income(output_format = c("html", "docx", "odt", "pdf"))

report_op_wash(output_format = c("html", "docx", "odt", "pdf"))

report_op_misc(output_format = c("html", "docx", "odt", "pdf"))
```

## Arguments

- estimates:

  A data.frame of RAM-OP results produced by
  [`merge_op()`](https://rapidsurveys.io/oldr/reference/merge_op.md).

- filename:

  Prefix to append to report output filename. Can be specified as a path
  to a specific directory where to output tabular results CSV file.
  Defaults to a path to a temporary directory with a filename starting
  with *ramOP*.

- output_format:

  Either *"html"*, *"docx"*, *"odt"*, or *"pdf"*. Defaults to *"html"*.

## Value

Report of tabulated estimated results saved in CSV format in current
working directory or in the specified path or a reporting chunk for
specific indicators.

## Author

Mark Myatt and Ernest Guevarra

## Examples

``` r
##
x <- estimate_classic(
  x = create_op(testSVY), w = testPSU, replicates = 9
)
#> ℹ Checking if demo, food, hunger, disability, adl, mental, dementia, health, income, wash, anthro, oedema, screening, visual, misc are RAM-OP indicators
#> ✔ All of `indicators` are RAM-OP indicators
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure

y <- estimate_probit(
  x = create_op(testSVY), w = testPSU, replicates = 9
)
#> ℹ Checking if demo, food, hunger, disability, adl, mental, dementia, health, income, wash, anthro, oedema, screening, visual, misc are RAM-OP indicators
#> ✔ All of `indicators` are RAM-OP indicators
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure

z <- merge_op(x, y, prop2percent = TRUE)
report_op_table(z)

report_op_demo()
#> 
#> # Sample description
#> 
#> ## Type of respondents
#> ```{r respondentTable}
#> knitr::kable(x = resultsDF[1:4, ],
#>   caption = 'Type of respondent',
#>   booktabs = TRUE,
#>   digits = 2,
#>   col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>
#>   kableExtra::kable_styling(bootstrap_options = c('striped')) |>
#>   kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))
#> ```
#> 
#> ## Age structure by sex
#> ```{r agePlot}
#> oldr::chart_op_age(x = oldr::create_op(svy = svy), save_chart = FALSE)
#> ```
#> 
#> ```{r ageTable}
#> knitr::kable(x = resultsDF[5:10, ],
#>   caption = 'Respondent age group by sex',
#>   booktabs = TRUE,
#>   digits = 2,
#>   col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>
#>   kableExtra::kable_styling(bootstrap_options = c('striped')) |>
#>   kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))
#> ```
#> 
#> ## Respondents by sex
#> ```{r sexTable}
#> knitr::kable(x = resultsDF[11:12, ],
#>   caption = 'Sex of respondents',
#>   booktabs = TRUE,
#>   digits = 2,
#>   col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>
#>   kableExtra::kable_styling(bootstrap_options = c('striped')) |>
#>   kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))
#> ```
#> 
#> ## Marital status of respondents
#> ```{r marriedTable}
#> knitr::kable(x = resultsDF[13:19, ],
#>   caption = 'Marital status',
#>   booktabs = TRUE,
#>   digits = 2,
#>   col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>
#>   kableExtra::kable_styling(bootstrap_options = c('striped')) |>
#>   kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))
#> ```
report_op_hunger()
#> 
#> # Food security
#> 
#> ## Household hunger score
#> ```{r hhsPlot}
#> oldr::chart_op_hhs(x = oldr::create_op(svy = svy), save_chart = FALSE)
#> ```
#> 
#> ```{r hhsTable}
#> knitr::kable(x = resultsDF[48:50, ],
#>   caption = 'Household hunger score',
#>   booktabs = TRUE,
#>   digits = 2,
#>   col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>
#>   kableExtra::kable_styling(bootstrap_options = c('striped')) |>
#>   kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))
#> ```
report_op_food()
#> 
#> # Diet
#> ## Meal frequency
#> 
#> ```{r mfPlot}
#> oldr::chart_op_mf(x = oldr::create_op(svy = svy), save_chart = FALSE)
#> ```
#> 
#> ```{r mfTable}
#> knitr::kable(x = resultsDF[20, ],
#>   caption = 'Meal frequency',
#>   booktabs = TRUE,
#>   digits = 2,
#>   col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>
#>   kableExtra::kable_styling(bootstrap_options = c('striped')) |>
#>   kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))
#> ```
#> 
#> ## Dietary diversity
#> ```{r ddsPlot}
#> oldr::chart_op_dds(x = oldr::create_op(svy = svy), save_chart = FALSE)
#> ```
#> 
#> ```{r ddsTable}
#> knitr::kable(x = resultsDF[21:32, ],
#>   caption = 'Dietary diversity',
#>   booktabs = TRUE,
#>   digits = 2,
#>   col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>
#>   kableExtra::kable_styling(bootstrap_options = c('striped')) |>
#>   kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))
#> ```
#> 
#> ## Nutrient intake
#> ```{r nutrientTable}
#> knitr::kable(x = resultsDF[33:47, ],
#>   caption = 'Nutrient intake',
#>   booktabs = TRUE,
#>   digits = 2,
#>   col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>
#>   kableExtra::kable_styling(bootstrap_options = c('striped')) |>
#>   kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))
#> ```
report_op_disability()
#> 
#> # Disability
#> 
#> ## Overall
#> 
#> ```{r wgPlot}
#> oldr::chart_op_wg(x = oldr::create_op(svy = svy), save_chart = FALSE)
#> ```
#> 
#> ```{r wgTable}
#> knitr::kable(x = resultsDF[75:79, ],
#>   caption = 'Overall disability',
#>   booktabs = TRUE,
#>   digits = 2,
#>   col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>
#>   kableExtra::kable_styling(bootstrap_options = c('striped')) |>
#>   kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))
#> ```
#> 
#> ## Vision
#> 
#> ```{r visionTable}
#> knitr::kable(x = resultsDF[51:54, ],
#>   caption = 'Disability related to vision',
#>   booktabs = TRUE,
#>   digits = 2,
#>   col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>
#>   kableExtra::kable_styling(bootstrap_options = c('striped')) |>
#>   kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))
#> ```
#> 
#> ## Hearing
#> 
#> ```{r hearingTable}
#> knitr::kable(x = resultsDF[55:58, ],
#>   caption = 'Disability related to hearing',
#>   booktabs = TRUE,
#>   digits = 2,
#>   col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>
#>   kableExtra::kable_styling(bootstrap_options = c('striped')) |>
#>   kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))
#> ```
#> 
#> ## Mobility
#> 
#> ```{r mobilityTable}
#> knitr::kable(x = resultsDF[59:62, ],
#>   caption = 'Disability related to mobility',
#>   booktabs = TRUE,
#>   digits = 2,
#>   col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>
#>   kableExtra::kable_styling(bootstrap_options = c('striped')) |>
#>   kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))
#> ```
#> 
#> ## Remembering
#> 
#> ```{r rememberingTable}
#> knitr::kable(x = resultsDF[63:66, ],
#>   caption = 'Disability related to remembering',
#>   booktabs = TRUE,
#>   digits = 2,
#>   col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>
#>   kableExtra::kable_styling(bootstrap_options = c('striped')) |>
#>   kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))
#> ```
#> 
#> ## Self-care
#> 
#> ```{r selfCareTable}
#> knitr::kable(x = resultsDF[67:70, ],
#>   caption = 'Disability related to self-care',
#>   booktabs = TRUE,
#>   digits = 2,
#>   col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>
#>   kableExtra::kable_styling(bootstrap_options = c('striped')) |>
#>   kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))
#> ```
#> 
#> ## Communicating
#> 
#> ```{r communicatingTable}
#> knitr::kable(x = resultsDF[71:74, ],
#>   caption = 'Disability related to communicating',
#>   booktabs = TRUE,
#>   digits = 2,
#>   col.names = c('Indicator', 'Type', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL', 'Est', '95% LCL', '95% UCL')) |>
#>   kableExtra::kable_styling(bootstrap_options = c('striped')) |>
#>   kableExtra::add_header_above(c(' ' = 2, 'ALL' = 3, 'MALES' = 3, 'FEMALES' = 3))
#> ```
```
