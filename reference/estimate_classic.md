# Apply bootstrap to RAM-OP indicators using a classical estimator.

Apply bootstrap to RAM-OP indicators using a classical estimator.

## Usage

``` r
estimate_classic(
  x,
  w,
  statistic = bbw::bootClassic,
  indicators = c("demo", "food", "hunger", "adl", "disability", "mental", "dementia",
    "health", "oedema", "screening", "income", "wash", "visual", "misc"),
  params = get_variables(indicators),
  outputColumns = params,
  replicates = 399
)
```

## Arguments

- x:

  Indicators dataset produced by
  [`create_op()`](https://rapidsurveys.io/oldr/reference/create_op.md)
  with primary sampling unit (PSU) in column named *"psu"*.

- w:

  A data frame with primary sampling unit (PSU) in column named *"psu"*
  and survey weight (i.e. PSU population) in column named *"pop"*.

- statistic:

  A function operating on data in `x`. Fixed to
  [`bbw::bootClassic()`](https://rapidsurveys.io/bbw/reference/bootClassic.html)
  function for means.

- indicators:

  A character vector of indicator set names to estimate. Indicator set
  names are *"demo"*, *"food"*, *"hunger"*, *"disability"*, *"adl"*,
  *"mental"*, *"dementia"*, *"health"*, *"income"*, *"wash"*,
  *"visual"*, and *"misc"*. Default is all indicator sets.

- params:

  Parameters (named columns in `x`) passed to the function specified in
  `statistic`. This is equivalent to variables corresponding to the
  indicator sets specified in `indicators`. The function
  [`get_variables()`](https://rapidsurveys.io/oldr/reference/get_variables.md)
  is used to specify these variables.

- outputColumns:

  Names of columns in output data frame. This defaults to values
  specified in `params`.

- replicates:

  Number of bootstrap replicates

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
of boot estimates using
[`bbw::bootClassic()`](https://rapidsurveys.io/bbw/reference/bootClassic.html)
mean function

## Examples

``` r
test <- estimate_classic(
  x = indicators.ALL, w = testPSU, replicates = 9
)
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure

test
#> # A tibble: 136 × 10
#>    INDICATOR EST.ALL  LCL.ALL UCL.ALL EST.MALES LCL.MALES UCL.MALES EST.FEMALES
#>    <chr>       <dbl>    <dbl>   <dbl>     <dbl>     <dbl>     <dbl>       <dbl>
#>  1 resp1      0.880   0.792    0.896     0.847     0.757     0.919      0.861  
#>  2 resp2      0.0885  0.0740   0.164     0.0759    0.0282    0.120      0.115  
#>  3 resp3      0.0260  0.00833  0.0562    0.0488    0.0151    0.108      0.00862
#>  4 resp4      0       0        0.0188    0.0256    0         0.0572     0      
#>  5 age       71.2    69.4     73.1      71.6      69.1      73.3       71.5    
#>  6 ageGrp1    0       0        0         0         0         0          0      
#>  7 ageGrp2    0.526   0.423    0.579     0.5       0.395     0.638      0.469  
#>  8 ageGrp3    0.234   0.2      0.304     0.256     0.177     0.291      0.243  
#>  9 ageGrp4    0.229   0.120    0.276     0.197     0.127     0.282      0.239  
#> 10 ageGrp5    0.0312  0.0115   0.0812    0.0488    0.0143    0.108      0.00893
#> # ℹ 126 more rows
#> # ℹ 2 more variables: LCL.FEMALES <dbl>, UCL.FEMALES <dbl>
```
