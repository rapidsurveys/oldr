# Estimate all standard RAM-OP indicators

Estimate all standard RAM-OP indicators

## Usage

``` r
estimate_op(
  x,
  w,
  indicators = c("demo", "anthro", "food", "hunger", "adl", "disability", "mental",
    "dementia", "health", "oedema", "screening", "income", "wash", "visual", "misc"),
  replicates = 399
)
```

## Arguments

- x:

  Indicators dataset produced by
  [`create_op()`](https://rapidsurveys.io/oldr/dev/reference/create_op.md)
  with primary sampling unit (PSU) in column named *"psu"*\`

- w:

  A data frame with primary sampling unit (PSU) in column named *"psu"*
  and survey weight (i.e. PSU population) in column named *"pop"*.

- indicators:

  A character vector of indicator set names to estimate. Indicator set
  names are *"demo"*, *"anthro"*, *"food"*, *"hunger"*, *"disability"*,
  *"adl"*, *"mental"*, *"dementia"*, *"health"*, *"income"*, *"wash"*,
  *"visual"*, and *"misc"*. Default is all indicator sets.

- replicates:

  Number of bootstrap replicates. Default is 399.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
of boot estimates for all specified standard RAM-OP indicators.

## Examples

``` r
estimate_op(x = create_op(testSVY), w = testPSU, replicates = 9)
#> ℹ Checking if demo, food, hunger, disability, adl, mental, dementia, health, income, wash, anthro, oedema, screening, visual, misc are RAM-OP indicators
#> ✔ All of `indicators` are RAM-OP indicators
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure
#> # A tibble: 139 × 13
#>    INDICATOR GROUP       LABEL TYPE  EST.ALL LCL.ALL UCL.ALL EST.MALES LCL.MALES
#>    <fct>     <fct>       <fct> <fct>   <dbl>   <dbl>   <dbl>     <dbl>     <dbl>
#>  1 resp1     Survey      Resp… Prop…   87.0   81.5     91.7      80        75.6 
#>  2 resp2     Survey      Resp… Prop…    7.81   5.83    10.9       9.88      2.86
#>  3 resp3     Survey      Resp… Prop…    3.65   0.729    6.67      4.82      1.20
#>  4 resp4     Survey      Resp… Prop…    1.04   0        2.08      1.27      0   
#>  5 age       Demography… Mean… Mean    70.2   69.0     71.7      71.4      69.1 
#>  6 ageGrp1   Demography… Self… Prop…    0      0        0         0         0   
#>  7 ageGrp2   Demography… Self… Prop…   54.2   48.0     62.2      50        39.6 
#>  8 ageGrp3   Demography… Self… Prop…   22.4   19.5     33.3      27.5      17.2 
#>  9 ageGrp4   Demography… Self… Prop…   18.8   11.5     26.1      18.5       6.86
#> 10 ageGrp5   Demography… Self… Prop…    2.08   0.729    4.06      4.82      1.51
#> # ℹ 129 more rows
#> # ℹ 4 more variables: UCL.MALES <dbl>, EST.FEMALES <dbl>, LCL.FEMALES <dbl>,
#> #   UCL.FEMALES <dbl>
```
