# Create a PDF report document containing RAM-OP survey results

Create a PDF report document containing RAM-OP survey results

## Usage

``` r
report_op_pdf(
  estimates,
  svy,
  indicators = c("demo", "food", "hunger", "disability", "adl", "mental", "dementia",
    "health", "income", "wash", "anthro", "oedema", "screening", "visual", "misc"),
  filename = "ramOPreport",
  title = "RAM-OP Report",
  view = FALSE
)
```

## Arguments

- estimates:

  A data.frame of RAM-OP results produced by
  [`merge_op()`](https://rapidsurveys.io/oldr/reference/merge_op.md).

- svy:

  A data.frame collected using the standard RAM-OP questionnaire

- indicators:

  A character vector of indicator names

- filename:

  Filename for output document. Can be specified as a path to a specific
  directory where to output report document

- title:

  Title of report

- view:

  Logical. Open report in current PDF reader? Default is FALSE.

## Value

A PDF document in the working directory or if filename is a path, to a
specified directory.

## Examples

``` r
classicResults <- estimate_classic(
  x = create_op(testSVY), w = testPSU, replicates = 3
)
#> ℹ Checking if demo, food, hunger, disability, adl, mental, dementia, health, income, wash, anthro, oedema, screening, visual, misc are RAM-OP indicators
#> ✔ All of `indicators` are RAM-OP indicators
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure

probitResults <- estimate_probit(
  x = create_op(testSVY), w = testPSU, replicates = 3
)
#> ℹ Checking if demo, food, hunger, disability, adl, mental, dementia, health, income, wash, anthro, oedema, screening, visual, misc are RAM-OP indicators
#> ✔ All of `indicators` are RAM-OP indicators
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure

resultsDF <- merge_op(x = classicResults, y = probitResults)

if (tinytex::is_tinytex()) {
  report_op_pdf(
    svy = testSVY, estimates = resultsDF, indicators = "mental",
    filename = paste(tempdir(), "report", sep = "/")
   )
}
```
