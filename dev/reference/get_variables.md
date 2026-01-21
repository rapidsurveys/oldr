# Get appropriate RAM-OP indicator variable names given a specified indicator set

Get appropriate RAM-OP indicator variable names given a specified
indicator set

## Usage

``` r
get_variables(
  indicators = c("demo", "food", "hunger", "adl", "disability", "mental", "dementia",
    "health", "income", "wash", "anthro", "oedema", "screening", "visual", "misc")
)
```

## Arguments

- indicators:

  A character vector of indicator set names. Indicator set names are
  *"demo"*, *"food"*, *"hunger"*, *"disability"*, *"adl"*, *"mental"*,
  *"dementia"*, *"health"*, *"income"*, *"wash"*, *"anthro"*,
  *"screening"*, *"visual"*, and *"misc"*. Default is all indicator
  sets.

## Value

A vector of variable names
