# Apply bootstrap to RAM-OP indicators using a PROBIT estimator.

Apply bootstrap to RAM-OP indicators using a PROBIT estimator.

## Usage

``` r
estimate_probit(
  x,
  w,
  gam.stat = probit_gam,
  sam.stat = probit_sam,
  params = "MUAC",
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

- gam.stat:

  A function operating on data in `x` to estimate GAM prevalence for
  older people. Fixed to
  [`probit_gam()`](https://rapidsurveys.io/oldr/reference/op_probit.md).

- sam.stat:

  A function operating on data in `x` to estimate SAM prevalence for
  older people. Fixed to
  [`probit_sam()`](https://rapidsurveys.io/oldr/reference/op_probit.md).

- params:

  Parameters (named columns in `x`) passed to the function specified in
  `statistic`; fixed to *"MUAC"* as indicator amenable to probit
  estimation.

- outputColumns:

  Names of columns in output data frame.

- replicates:

  Number of bootstrap replicate case and non-case.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
of boot estimates using PROBIT.

## Examples

``` r
test <- estimate_probit(x = indicators.ALL, w = testPSU, replicates = 3)
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure

test
#> # A tibble: 3 × 10
#>   INDICATOR   EST.ALL  LCL.ALL UCL.ALL EST.MALES LCL.MALES UCL.MALES EST.FEMALES
#>   <chr>         <dbl>    <dbl>   <dbl>     <dbl>     <dbl>     <dbl>       <dbl>
#> 1 GAM       0.0419     9.65e-3 4.57e-2  6.65e- 3  3.33e- 4   1.24e-2     0.0439 
#> 2 MAM       0.0419     9.65e-3 4.57e-2  6.65e- 3  3.33e- 4   1.24e-2     0.0411 
#> 3 SAM       0.0000187  9.33e-7 2.26e-5  3.25e-19  1.63e-20   1.08e-7     0.00282
#> # ℹ 2 more variables: LCL.FEMALES <dbl>, UCL.FEMALES <dbl>
```
