# Concatenate classic and PROBIT estimates into a single data.frame

Concatenate classic and PROBIT estimates into a single data.frame

## Usage

``` r
merge_op(x, y, prop2percent = FALSE)
```

## Arguments

- x:

  Classic estimates
  [`data.frame()`](https://rdrr.io/r/base/data.frame.html)

- y:

  Probit estimates
  [`data.frame()`](https://rdrr.io/r/base/data.frame.html)

- prop2percent:

  Logical. Should proportion type indicators be converted to percentage?
  Default is FALSE.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
of combined classic and probit estimates.

## Author

Ernest Guevarra

## Examples

``` r
indicators <- c(
  "demo", "anthro", "food", "hunger", "adl", "disability",
  "mental", "dementia", "health", "oedema", "screening", "income",
  "wash", "visual", "misc"
)

classicIndicators <- indicators[indicators != "anthro"]

## Bootstrap classic
classicEstimates <- estimate_classic(
  x = indicators.ALL, w = testPSU, 
  indicators = classicIndicators, replicates = 9
)
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure

probitEstimates <- estimate_probit(
  x = indicators.ALL, w = testPSU, replicates = 9
)
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure
#> ✔ x has the appropriate/expected data structure

merge_op(x = classicEstimates, y = probitEstimates)
#> # A tibble: 139 × 13
#>    INDICATOR GROUP       LABEL TYPE  EST.ALL LCL.ALL UCL.ALL EST.MALES LCL.MALES
#>    <fct>     <fct>       <fct> <fct>   <dbl>   <dbl>   <dbl>     <dbl>     <dbl>
#>  1 resp1     Survey      Resp… Prop… 8.65e-1  0.824   0.898     0.843    0.728  
#>  2 resp2     Survey      Resp… Prop… 9.38e-2  0.0510  0.132     0.0795   0.0204 
#>  3 resp3     Survey      Resp… Prop… 3.65e-2  0.0167  0.0698    0.0779   0.0342 
#>  4 resp4     Survey      Resp… Prop… 5.21e-3  0       0.0104    0.0123   0      
#>  5 age       Demography… Mean… Mean  7.09e+1 69.0    72.9      70.6     69.4    
#>  6 ageGrp1   Demography… Self… Prop… 0        0       0         0        0      
#>  7 ageGrp2   Demography… Self… Prop… 5.42e-1  0.45    0.605     0.523    0.423  
#>  8 ageGrp3   Demography… Self… Prop… 2.45e-1  0.198   0.331     0.267    0.232  
#>  9 ageGrp4   Demography… Self… Prop… 1.72e-1  0.129   0.242     0.157    0.0737 
#> 10 ageGrp5   Demography… Self… Prop… 4.17e-2  0.0125  0.0823    0.0341   0.00227
#> # ℹ 129 more rows
#> # ℹ 4 more variables: UCL.MALES <dbl>, EST.FEMALES <dbl>, LCL.FEMALES <dbl>,
#> #   UCL.FEMALES <dbl>
```
