# RAM-OP Indicators Dataset - MALES

Indicators dataset calculated from a dataset collected from a RAM-OP
survey conducted in Addis Ababa, Ethiopia in early 2014. This indicator
dataset is from the subset of men/males of the total sample.

## Usage

``` r
indicators.MALES
```

## Format

A data frame with 138 columns and 113 rows:

- `psu`:

  Cluster (PSU) identifier

- `resp1`:

  Respondent is SUBJECT

- `resp2`:

  Respondent is FAMILY CARER

- `resp3`:

  Respondent is OTHER CARER

- `resp4`:

  Respondent is OTHER

- `age`:

  Age of respondents (years)

- `ageGrp1`:

  Age of respondent is between 50 and 59 years

- `ageGrp2`:

  Age of respondent is between 60 and 69 years

- `ageGrp3`:

  Age of respondent is between 70 and 79 years

- `ageGrp4`:

  Age of respondent is between 80 and 89 years

- `ageGrp5`:

  Age of respondent is 90 years or older

- `sex1`:

  Sex = MALE

- `sex2`:

  Sex = FEMALE

- `marital1`:

  Marital status = SINGLE

- `marital2`:

  Marital status = MARRIED

- `marital3`:

  Marital status = LIVING TOGETHER

- `marital4`:

  Marital status = DIVORCED

- `marital5`:

  Marital status = WIDOWED

- `marital6`:

  Marital status = OTHER

- `alone`:

  Respondent lives alone

- `MF`:

  Meal frequency

- `DDS`:

  DDS (count of 11 groups)

- `FG01`:

  Cereals

- `FG02`:

  Roots and tubers

- `FG03`:

  Fruits and vegetables

- `FG04`:

  All meat

- `FG05`:

  Eggs

- `FG06`:

  Fish

- `FG07`:

  Legumes, nuts, and seeds

- `FG08`:

  Milk and milk products

- `FG09`:

  Fats

- `FG10`:

  Sugar

- `FG11`:

  Other

- `proteinRich`:

  Protein rich animal sources of protein

- `pProtein`:

  Protein rich plant sources of protein

- `aProtein`:

  Protein rich animal sources of protein

- `pVitA`:

  Plant sources of vitamin A

- `aVitA`:

  Animal sources of vitamin A

- `xVitA`:

  Any source of vitamin A

- `ironRich`:

  Iron rich foods

- `caRich`:

  Calcium rich foods

- `znRich`:

  Zinc rich foods

- `vitB1`:

  Vitamin B1-rich foods

- `vitB2`:

  Vitamin B2-rich foods

- `vitB3`:

  Vitamin B3-rich foods

- `vitB6`:

  Vitamin B6-rich foods

- `vitB12`:

  Vitamin B12-rich foods

- `vitBcomplex`:

  Vitamin B1/B2/B3/B6/B12-rich foods

- `HHS1`:

  Little or no hunger in household

- `HHS2`:

  Moderate hunger in household

- `HHS3`:

  Severe hunger in household

- `ADL01`:

  Bathing

- `ADL02`:

  Dressing

- `ADL03`:

  Toileting

- `ADL04`:

  Transferring (mobility)

- `ADL05`:

  Continence

- `ADL06`:

  Feeding

- `scoreADL`:

  ADL score

- `classADL1`:

  Severity of dependence = INDEPENDENT

- `classADL2`:

  Severity of dependence = PARTIAL DEPENDENCY

- `classADL3`:

  Severity of dependence = SEVERE DEPENDENCY

- `hasHelp`:

  Has someone to help with ADL

- `unmetNeed`:

  Unmet need (dependency with NO helper)

- `K6`:

  K6 score

- `K6Case`:

  K6 score \> 12 (in serious psychological distress)

- `DS`:

  Probable dementia by CSID screen

- `H1`:

  Chronic condition

- `H2`:

  Takes drugs regularly for chronic condition

- `H31`:

  Main reason for not taking drugs for chronic condition: No drugs
  available

- `H32`:

  Main reason for not taking drugs for chronic condition: Too expensive
  / no money

- `H33`:

  Main reason for not taking drugs for chronic condition: Too old to
  look for care

- `H34`:

  Main reason for not taking drugs for chronic condition: Use
  traditional medicine

- `H35`:

  Main reason for not taking drugs for chronic condition: Drugs don't
  help

- `H36`:

  Main reason for not taking drugs for chronic condition: No one to help
  me

- `H37`:

  Main reason for not taking drugs for chronic condition: No need

- `H38`:

  Main reason for not taking drugs for chronic condition: Other

- `H39`:

  Main reason for not taking drugs for chronic condition: No reason
  given

- `H4`:

  Recent disease episode

- `H5`:

  Accessed care for recent disease episode

- `H61`:

  Main reason for not accessing care for recent disease episode: No
  drugs available

- `H62`:

  Main reason for not accessing care for recent disease episode: Too
  expensive / no money

- `H63`:

  Main reason for not accessing care for recent disease episode: Too old
  to look for care

- `H64`:

  Main reason for not accessing care for recent disease episode: Use
  traditional medicine

- `H65`:

  Main reason for not accessing care for recent disease episode: Drugs
  don't help

- `H66`:

  Main reason for not accessing care for recent disease episode: No one
  to help me

- `H67`:

  Main reason for not accessing care for recent disease episode: No need

- `H68`:

  Main reason for not accessing care for recent disease episode: Other

- `H69`:

  Main reason for not accessing care for recent disease episode: No
  reason given

- `M1`:

  Has a personal income

- `M2A`:

  Agriculture / fishing / livestock

- `M2B`:

  Wages / salary

- `M2C`:

  Sale of charcoal / bricks / etc

- `M2D`:

  Trading (e.g. market or shop)

- `M2E`:

  Investments

- `M2F`:

  Spending savings / sale of assets

- `M2G`:

  Charity

- `M2H`:

  Cash transfer / Social security

- `M2I`:

  Other

- `W1`:

  Improved source of drinking water

- `W2`:

  Safe drinking water (improved source OR adequate treatment)

- `W3`:

  Improved sanitation facility

- `W4`:

  Improved non-shared sanitation facility

- `MUAC`:

  Mid-upper arm circumference (mm)

- `oedema`:

  Presence of oedema

- `screened`:

  Screened with oedema check and MUAC measurement in previous month

- `poorVA`:

  Poor visual acuity

- `chew`:

  Problems chewing food

- `food`:

  Anyone in household receives a ration

- `NFRI`:

  Anyone in HH received non-food relief item(s) in previous month

- `wgVisionD0`:

  Vision domain 0

- `wgVisionD1`:

  Vision domain 1

- `wgVisionD2`:

  Vision domain 2

- `wgVisionD3`:

  Vision domain 3

- `wgHearingD0`:

  Hearing domain 0

- `wgHearingD1`:

  Hearing domain 1

- `wgHearingD2`:

  Hearing domain 2

- `wgHearingD3`:

  Hearing domain 3

- `wgMobilityD0`:

  Mobility domain 0

- `wgMobilityD1`:

  Mobility domain 1

- `wgMobilityD2`:

  Mobility domain 2

- `wgMobilityD3`:

  Mobility domain 3

- `wgRememberingD0`:

  Remembering domain 0

- `wgRememberingD1`:

  Remembering domain 1

- `wgRememberingD2`:

  Remembering domain 2

- `wgRememberingD3`:

  Remembering domain 3

- `wgSelfCareD0`:

  Self-care domain 0

- `wgSelfCareD1`:

  Self-care domain 1

- `wgSelfCareD2`:

  Self-care domain 2

- `wgSelfCareD3`:

  Self-care domain 3

- `wgCommunicatingD0`:

  Communicating domain 0

- `wgCommunicatingD1`:

  Communicating domain 1

- `wgCommunicatingD2`:

  Communicating domain 2

- `wgCommunicatingD3`:

  Communicating domain 3

- `wgP0`:

  Overall prevalence 0

- `wgP1`:

  Overall prevalence 1

- `wgP2`:

  Overall prevalence 2

- `wgP3`:

  Overall prevalence 3

- `wgPM`:

  Overall prevalence

## Examples

``` r
indicators.MALES
#> # A tibble: 79 × 138
#>      psu resp1 resp2 resp3 resp4   age ageGrp1 ageGrp2 ageGrp3 ageGrp4 ageGrp5
#>    <int> <dbl> <dbl> <dbl> <dbl> <int>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
#>  1   201     1     0     0     0    74       0       0       1       0       0
#>  2   201     1     0     0     0    60       0       1       0       0       0
#>  3   201     0     1     0     0    86       0       0       0       1       0
#>  4   201     1     0     0     0    80       0       0       0       1       0
#>  5   201     1     0     0     0    62       0       1       0       0       0
#>  6   202     1     0     0     0    68       0       1       0       0       0
#>  7   202     1     0     0     0    68       0       1       0       0       0
#>  8   202     1     0     0     0    65       0       1       0       0       0
#>  9   202     1     0     0     0    67       0       1       0       0       0
#> 10   202     1     0     0     0    80       0       0       0       1       0
#> # ℹ 69 more rows
#> # ℹ 127 more variables: sex1 <dbl>, sex2 <dbl>, marital1 <dbl>, marital2 <dbl>,
#> #   marital3 <dbl>, marital4 <dbl>, marital5 <dbl>, marital6 <dbl>,
#> #   alone <dbl>, MF <dbl>, DDS <dbl>, FG01 <dbl>, FG02 <dbl>, FG03 <dbl>,
#> #   FG04 <dbl>, FG05 <dbl>, FG06 <dbl>, FG07 <dbl>, FG08 <dbl>, FG09 <dbl>,
#> #   FG10 <dbl>, FG11 <dbl>, proteinRich <dbl>, pProtein <dbl>, aProtein <dbl>,
#> #   pVitA <dbl>, aVitA <dbl>, xVitA <dbl>, ironRich <dbl>, caRich <dbl>, …
```
