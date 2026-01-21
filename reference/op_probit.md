# PROBIT statistics function for bootstrap estimation of older people GAM

PROBIT statistics function for bootstrap estimation of older people GAM

## Usage

``` r
probit_gam(x, params, threshold = 210)

probit_sam(x, params, threshold = 185)
```

## Arguments

- x:

  A data frame with primary sampling unit (PSU) in column named *"psu"*
  and with data column/s containing the continuous variable/s of
  interest with column names corresponding to `params` values

- params:

  A vector of column names corresponding to the continuous variables of
  interest contained in `x`

- threshold:

  cut-off value for continuous variable to differentiate case and
  non-case. Default is set at 210 for `probit_gam()` and 185 for
  `probit_sam()`.

## Value

A numeric vector of the PROBIT estimate of each continuous variable of
interest with length equal to `length(params)`.

## Examples

``` r
# Example call to bootBW function:
probit_gam(x = indicators.ALL, params = "MUAC", threshold = 210)
#>          d 
#> 0.03204229 
probit_sam(x = indicators.ALL, params = "MUAC", threshold = 185)
#>            d 
#> 8.453906e-05 
```
