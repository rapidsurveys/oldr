# Create a DOCX report document containing RAM-OP survey results

Create a DOCX report document containing RAM-OP survey results

## Usage

``` r
report_op_docx(
  estimates,
  svy,
  indicators = c("demo", "food", "hunger", "disability", "adl", "mental", "dementia",
    "health", "income", "wash", "anthro", "oedema", "screening", "visual", "misc"),
  filename = paste(tempdir(), "ramOPreport", sep = "/"),
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
  directory where to output report document. Defaults to a path to a
  temporary directory and a filename `ramOPreport`.

- title:

  Title of report

- view:

  Logical. Open report in current environment? Default is FALSE.

## Value

An DOCX in the working directory or if filename is a path, to a
specified directory.

## Author

Ernest Guevarra

## Examples

``` r
classicResults <- estimate_classic(
  x = create_op(testSVY), w = testPSU, replicates = 9
)
#> ℹ Checking if demo, food, hunger, disability, adl, mental, dementia, health, income, wash, anthro, oedema, screening, visual, misc are RAM-OP indicators
#> ✔ All of `indicators` are RAM-OP indicators
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure

probitResults <- estimate_probit(
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

resultsDF <- merge_op(x = classicResults, y = probitResults)

if (rmarkdown::pandoc_version() >= numeric_version("1.12.3")) {
  report_op_docx(
    svy = testSVY, estimates = resultsDF, indicators = "mental",
    filename = paste(tempdir(), "report", sep = "/")
  )
}
#> 
#> 
#> processing file: report.Rmd
#> 1/7          
#> 2/7 [setup]  
#> 3/7          
#> 4/7 [k6Plot] 
#> 5/7          
#> 6/7 [k6Table]
#> 7/7          
#> output file: report.knit.md
#> /opt/hostedtoolcache/pandoc/3.1.11/x64/pandoc +RTS -K512m -RTS report.knit.md --to docx --from markdown+autolink_bare_uris+tex_math_single_backslash --output report.docx --lua-filter /home/runner/work/_temp/Library/rmarkdown/rmarkdown/lua/pagebreak.lua --highlight-style tango --reference-doc /home/runner/work/_temp/Library/oldr/template/word_template.docx 
#> 
#> Output created: report.docx
```
