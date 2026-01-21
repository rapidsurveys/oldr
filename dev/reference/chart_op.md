# Plot RAM-OP indicators

The plots include:

- Age by sex (pyramid plot) - a wrapper function to the
  [`pyramid_plot()`](https://rapidsurveys.io/oldr/dev/reference/pyramid_plot.md)
  function to create an age by sex pyramid plot

- Distribution of MUAC (overall and by sex) - histogram of MUAC
  distribution

- Distribution of meal frequency (overall and by sex)

- Distribution of dietary diversity score (overall and by sex)

- Distribution of K6 (overall and by sex)

- Distribution of ADL (overall and by sex)

- Plot of WASH indicators

- Plot of dementia screen (CSID) indicators

- Plot of disability (Washington Group - WG) indicators

- Plot of household hunger scale (HHS) indicators

- Plot of income indicators

## Usage

``` r
chart_op_age(
  x,
  save_chart = TRUE,
  filename = file.path(tempdir(), "populationPyramid")
)

chart_op_muac(x, save_chart = TRUE, filename = file.path(tempdir(), "chart"))

chart_op_mf(x, save_chart = TRUE, filename = file.path(tempdir(), "chart"))

chart_op_dds(x, save_chart = TRUE, filename = file.path(tempdir(), "chart"))

chart_op_k6(x, save_chart = TRUE, filename = file.path(tempdir(), "chart"))

chart_op_adl(x, save_chart = TRUE, filename = file.path(tempdir(), "chart"))

chart_op_wash(x, save_chart = TRUE, filename = file.path(tempdir(), "chart"))

chart_op_csid(x, save_chart = TRUE, filename = file.path(tempdir(), "chart"))

chart_op_wg(x, save_chart = TRUE, filename = file.path(tempdir(), "chart"))

chart_op_hhs(x, save_chart = TRUE, filename = file.path(tempdir(), "chart"))

chart_op_income(x, save_chart = TRUE, filename = file.path(tempdir(), "chart"))
```

## Arguments

- x:

  Indicators dataset produced by
  [`create_op()`](https://rapidsurveys.io/oldr/dev/reference/create_op.md)

- save_chart:

  Logical. Should chart be saved? Default is TRUE.

- filename:

  Prefix to add to output chart filename or a directory path to save
  output to instead of working directory. Default is a path to a
  temporary directory and a suggested filename. Ignored if `save_chart`
  is FALSE.

## Value

The respective plot in PNG format saved in the specified path if
`filename` is a path unless when `save_chart` is FALSE in which case the
plot is shown on current graphics device

## Examples

``` r
# Create age by sex pyramid plot using indicators.ALL dataset
chart_op_age(x = indicators.ALL)
#> Warning: NAs introduced by coercion
#> agg_record_346871191 
#>                    2 

# Create MUAC histogram using indicators.ALL dataset
chart_op_muac(x = indicators.ALL)
#> agg_record_346871191 
#>                    2 

# Create meal frequency chart using indicators.ALL dataset
chart_op_mf(x = indicators.ALL)
#> agg_record_346871191 
#>                    2 

# Create DDS chart using indicators.ALL dataset
chart_op_dds(x = indicators.ALL)
#> agg_record_346871191 
#>                    2 

# Create chart using indicators.ALL dataset
chart_op_k6(x = indicators.ALL)
#> agg_record_346871191 
#>                    2 

# Create chart using indicators.ALL dataset
chart_op_adl(x = indicators.ALL)
#> agg_record_346871191 
#>                    2 

# Create chart using indicators.ALL dataset
chart_op_wash(x = indicators.ALL)
#> agg_record_346871191 
#>                    2 

# Create chart using indicators.ALL dataset
chart_op_csid(x = indicators.ALL)
#> agg_record_346871191 
#>                    2 

# Create chart using indicators.ALL dataset
chart_op_wg(x = indicators.ALL)
#> agg_record_346871191 
#>                    2 

# Create chart using indicators.ALL dataset
chart_op_hhs(x = indicators.ALL)
#> agg_record_346871191 
#>                    2 

# Create chart using indicators.FEMALES and indicators.MALES
# dataset
chart_op_income(x = indicators.ALL)
#> agg_record_346871191 
#>                    2 
```
