# RAM-OP Population Dataset

This is a short and narrow file with one record per PSU and just two
variables

## Usage

``` r
testPSU
```

## Format

A data frame with 2 columns and 16 rows:

- `psu`:

  The PSU identifier. This must use the same coding system used to
  identify the PSUs that is used in the main RAM-OP dataset

- `pop`:

  The population of the PSU

The PSU dataset is used during data analysis to weight data by PSU
population.

## Examples

``` r
testPSU
#> # A tibble: 16 × 2
#>      psu   pop
#>    <int> <int>
#>  1   201  1724
#>  2   202   969
#>  3   203  2451
#>  4   204   697
#>  5   205  2132
#>  6   206   593
#>  7   207   509
#>  8   208  2436
#>  9   209  1756
#> 10   210  1708
#> 11   211  1747
#> 12   212  1070
#> 13   213   288
#> 14   214  2004
#> 15   215  2076
#> 16   216  2076
```
