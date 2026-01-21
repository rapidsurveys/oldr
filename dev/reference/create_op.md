# Create older people indicators dataset from survey data collected using the standard RAM-OP questionnaire.

The indicator sets covered by the standard RAM-OP survey are:

- Demographic indicators

- Dietary intake indicators

- Household hunger scale

- Katz Index of Independence in Activities of Daily Living score

- K6 Short form psychological distress score

- Brief Community Screening Instrument for Dementia (CSID)

- Health and health-seeking indicators

- Income and income sources

- Water, sanitation and hygiene (WASH) indicators

- Anthropometry and screening

- Visual impairment by "Tumbling E" method

- Miscellaneous indicators

- Washington Group on Disability

## Usage

``` r
create_op(
  svy,
  indicators = c("demo", "food", "hunger", "disability", "adl", "mental", "dementia",
    "health", "income", "wash", "anthro", "oedema", "screening", "visual", "misc"),
  sex = c("mf", "m", "f")
)

create_op_demo(svy, sex = c("mf", "m", "f"))

create_op_food(svy, sex = c("mf", "m", "f"))

create_op_hunger(svy, sex = c("mf", "m", "f"))

create_op_adl(svy, sex = c("mf", "m", "f"))

create_op_disability(svy, sex = c("mf", "m", "f"))

create_op_mental(svy, sex = c("mf", "m", "f"))

create_op_dementia(svy, sex = c("mf", "m", "f"))

create_op_health(svy, sex = c("mf", "m", "f"))

create_op_income(svy, sex = c("mf", "m", "f"))

create_op_wash(svy, sex = c("mf", "m", "f"))

create_op_anthro(svy, sex = c("mf", "m", "f"))

create_op_oedema(svy, sex = c("mf", "m", "f"))

create_op_screening(svy, sex = c("mf", "m", "f"))

create_op_visual(svy, sex = c("mf", "m", "f"))

create_op_misc(svy, sex = c("mf", "m", "f"))
```

## Arguments

- svy:

  A [`data.frame()`](https://rdrr.io/r/base/data.frame.html) collected
  using the standard RAM-OP questionnaire.

- indicators:

  A character vector of indicator set names. The vector may include one
  or more of the following: *"demo"*, *"food"*, *"hunger"*,
  *"disability"*, *"adl"*, *"mental"*, *"dementia"*, *"health"*,
  *"income"*, *"wash"*, *"anthro"*, *"oedema"*, *"screening"*,
  *"visual"*, *"misc"*. Default is all indicator set names.

- sex:

  A character value of *"m"*, *"f"*, or "*mf*" to indicate whether to
  report indicators for *males*, *females*, or *both* respectively.
  Default is *"mf"* for both sexes.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
of older people indicators.

## Demographic indicators

|              |                                                 |
|--------------|-------------------------------------------------|
| **Variable** | **Description**                                 |
| `psu`        | Primary sampling unit                           |
| `resp1`      | Respondent is SUBJECT                           |
| `resp2`      | Respondent is FAMILY CARER                      |
| `resp3`      | Respondent is OTHER CARER                       |
| `resp4`      | Respondent is OTHER                             |
| `age`        | Age of respondent (years)                       |
| `ageGrp1`    | Age of respondent is between 50 and 59 years    |
| `ageGrp2`    | Age of respondent is between 60 and 69 years    |
| `ageGrp3`    | Age of respondent is between 70 and 79 years    |
| `ageGrp4`    | Age of respondent is between 80 and 89 years    |
| `ageGrp5`    | Age of respondent is between 90 years and older |
| `sex1`       | Male                                            |
| `sex2`       | Female                                          |
| `marital1`   | Marital status = SINGLE                         |
| `marital2`   | Marital status = MARRIED                        |
| `marital3`   | Marital status = LIVING TOGETHER                |
| `marital4`   | Marital status = DIVORCED                       |
| `marital5`   | Marital status = SEPARATED                      |
| `marital6`   | Marital status = OTHER                          |
| `alone`      | Respondent lives alone                          |

## Dietary intake indicators

These dietary intake indicators have been purpose-built for older people
but the basic approach used is described in:

Kennedy G, Ballard T, Dop M C (2011). Guidelines for Measuring Household
and Individual Dietary Diversity. Rome, FAO
<https://www.fao.org/4/i1983e/i1983e00.htm>

and extended to include indicators of probable adequate intake of a
number of nutrients / micronutrients.

|               |                                              |
|---------------|----------------------------------------------|
| **Variable**  | **Description**                              |
| `MF`          | Meal frequency                               |
| `DDS`         | Dietary Diversity Score (count of 11 groups) |
| `FG01`        | Cereals                                      |
| `FG02`        | Roots and tubers                             |
| `FG03`        | Fruits and vegetables                        |
| `FG04`        | All meat                                     |
| `FG05`        | Eggs                                         |
| `FG06`        | Fish                                         |
| `FG07`        | Legumes, nuts and seeds                      |
| `FG08`        | Milk and milk products                       |
| `FG09`        | Fats                                         |
| `FG10`        | Sugar                                        |
| `FG11`        | Other                                        |
| `proteinRich` | Protein rich foods                           |
| `pProtein`    | Protein rich plant sources of protein        |
| `aProtein`    | Protein rich animal sources of protein       |
| `pVitA`       | Plant sources of vitamin A                   |
| `aVitA`       | Animal sources of vitamin A                  |
| `xVitA`       | Any source of vitamin A                      |
| `ironRich`    | Iron rich foods                              |
| `caRich`      | Calcium rich foods                           |
| `znRich`      | Zinc rich foods                              |
| `vitB1`       | Vitamin B1-rich foods                        |
| `vitB2`       | Vitamin B2-rich foods                        |
| `vitB3`       | Vitamin B3-rich foods                        |
| `vitB6`       | Vitamin B6-rich foods                        |
| `vitB12`      | Vitamin B12-rich foods                       |
| `vitBcomplex` | Vitamin B1/B2/B3/B6/B12-rich foods           |

## Household Hunger Scale (HHS)

The HHS is described in:

Ballard T, Coates J, Swindale A, Deitchler M (2011). Household Hunger
Scale: Indicator Definition and Measurement Guide. Washington DC,
FANTA-2 Bridge, FHI 360
<https://inddex.nutrition.tufts.edu/data4diets/indicator/household-hunger-scale-hhs>

|              |                                  |
|--------------|----------------------------------|
| **Variable** | **Description**                  |
| `HHS1`       | Little or no hunger in household |
| `HHS2`       | Moderate hunger in household     |
| `HHS3`       | Severe hunger in household       |

## Katz Index of Independence in Activities of Daily Living score

The Katz ADL score is described in:

Katz S, Ford AB, Moskowitz RW, Jackson BA, Jaffe MW (1963). Studies of
illness in the aged. The Index of ADL: a standardized measure of
biological and psychosocial function. JAMA, 1963, 185(12):914-9
[doi:10.1001/jama.1963.03060120024016](https://doi.org/10.1001/jama.1963.03060120024016)

Katz S, Down TD, Cash HR, Grotz, RC (1970). Progress in the development
of the index of ADL. The Gerontologist, 10(1), 20-30
[doi:10.1093/geront/10.4_Part_1.274](https://doi.org/10.1093/geront/10.4_Part_1.274)

Katz S (1983). Assessing self-maintenance: Activities of daily living,
mobility and instrumental activities of daily living. JAGS, 31(12),
721-726
[doi:10.1111/j.1532-5415.1983.tb03391.x](https://doi.org/10.1111/j.1532-5415.1983.tb03391.x)

|              |                                               |
|--------------|-----------------------------------------------|
| **Variable** | **Description**                               |
| `ADL01`      | Bathing                                       |
| `ADL02`      | Dressing                                      |
| `ADL03`      | Toileting                                     |
| `ADL04`      | Transferring (mobility)                       |
| `ADL05`      | Continence                                    |
| `ADL06`      | Feeding                                       |
| `scoreADL`   | ADL Score                                     |
| `classADL1`  | Severity of dependence 1                      |
| `classADL2`  | Severity of dependence 2                      |
| `classADL3`  | Severity of dependence 3                      |
| `hasHelp`    | Have someone to help with everyday activities |
| `unmetNeed`  | Need help but has no helper                   |

## K6 Short form psychological distress score

The K6 score is described in:

Kessler RC, Andrews G, Colpe LJ, Hiripi E, Mroczek, DK, Normand SLT, et
al. (2002). Short screening scales to monitor population prevalences and
trends in non-specific psychological distress. Psychological Medicine,
32(6), 959–976
[doi:10.1017/S0033291702006074](https://doi.org/10.1017/S0033291702006074)

|              |                                                    |
|--------------|----------------------------------------------------|
| **Variable** | **Description**                                    |
| `K6`         | K6 score                                           |
| `K6Case`     | K6 score \> 12 (in serious psychological distress) |

## Brief Community Screening Instrument for Dementia (CSID)

The CSID dementia screening tool is described in:

Prince M, et al. (2010). A brief dementia screener suitable for use by
non-specialists in resource poor settings - The cross-cultural
derivation and validation of the brief Community Screening Instrument
for Dementia. International Journal of Geriatric Psychiatry, 26(9),
899–907 [doi:10.1002/gps.2622](https://doi.org/10.1002/gps.2622)

|              |                                  |
|--------------|----------------------------------|
| **Variable** | **Description**                  |
| `DS`         | Probable dementia by CSID screen |

## Health and health-seeking indicators

|              |                                             |
|--------------|---------------------------------------------|
| **Variable** | **Description**                             |
| `H1`         | Chronic condition                           |
| `H2`         | Takes drugs regularly for chronic condition |
| `H31`        | No drugs available                          |
| `H32`        | Too expensive / no money                    |
| `H33`        | Too old to look for care                    |
| `H34`        | Use traditional medicine                    |
| `H35`        | Drugs don't help                            |
| `H36`        | No-one to help me                           |
| `H37`        | No need                                     |
| `H38`        | Other                                       |
| `H39`        | No reason given                             |
| `H4`         | Recent disease episode                      |
| `H5`         | Accessed care for recent disease episode    |
| `H61`        | No drugs available                          |
| `H62`        | Too expensive / no money                    |
| `H63`        | Too old to look for care                    |
| `H64`        | Use traditional medicine                    |
| `H65`        | Drugs don't help                            |
| `H66`        | No-one to help me                           |
| `H67`        | No need                                     |
| `H68`        | Other                                       |
| `H69`        | No reason given                             |

## Income and income sources

|              |                                   |
|--------------|-----------------------------------|
| **Variable** | **Description**                   |
| `M1`         | Has a personal income             |
| `M2A`        | Agriculture / fishing / livestock |
| `M2B`        | Wages / salary                    |
| `M2C`        | Sale of charcoal / bricks / etc.  |
| `M2D`        | Trading (e.g. market or shop)     |
| `M2E`        | Investments                       |
| `M2F`        | Spending savings / sale of assets |
| `M2G`        | Charity                           |
| `M2H`        | Cash transfer / Social security   |
| `M2I`        | Other                             |

## Water, sanitation and hygiene (WASH) indicators

These are a (core) subset of indicators from:

WHO / UNICEF (2006). Core Questions on Drinking-water and Sanitation for
Household Surveys. Geneva, WHO / UNICEF
<https://www.who.int/publications/i/item/9241563265>

|              |                                                             |
|--------------|-------------------------------------------------------------|
| **Variable** | **Description**                                             |
| `W1`         | Improved source of drinking water                           |
| `W2`         | Safe drinking water (improved source OR adequate treatment) |
| `W3`         | Improved sanitation facility                                |
| `W4`         | Improved non-shared sanitation facility                     |

## Anthropometry and screening

|              |                                                   |
|--------------|---------------------------------------------------|
| **Variable** | **Description**                                   |
| `MUAC`       | Mid-upper arm circumference (mm)                  |
| `oedema`     | Bilateral pitting oedema (may not be nutritional) |
| `screened`   | Either MUAC or oedema checked previously          |

## Visual impairment by "Tumbling E" method

The "Tumbling E" method is described in:

Taylor HR (1978). Applying new design principles to the construction of
an illiterate E Chart. Am J Optom & Physiol Optics 55:348

|              |                                                 |
|--------------|-------------------------------------------------|
| **Variable** | **Description**                                 |
| poorVA       | Poor visual acuity (correct in \< 3 of 4 tests) |

## Miscellaneous indicators

|              |                                                                       |
|--------------|-----------------------------------------------------------------------|
| **Variable** | **Description**                                                       |
| `chew`       | Problems chewing food                                                 |
| `food`       | Anyone in HH receives a ration                                        |
| `NFRI`       | Anyone in HH received non-food relief item/s (NFRI) in previous month |

## Washington Group on Disability

See:

<https://www.washingtongroup-disability.com/>

for details.

|                     |                        |
|---------------------|------------------------|
| **Variable**        | **Description**        |
| `wgVisionD0`        | Vision domain 0        |
| `wgVisionD1`        | Vision domain 1        |
| `wgVisionD2`        | Vision domain 2        |
| `wgVisionD3`        | Vision domain 3        |
| `wgHearingD0`       | Hearing domain 0       |
| `wgHearingD1`       | Hearing domain 1       |
| `wgHearingD2`       | Hearing domain 2       |
| `wgHearingD3`       | Hearing domain 3       |
| `wgMobilityD0`      | Mobility domain 0      |
| `wgMobilityD1`      | Mobility domain 1      |
| `wgMobilityD2`      | Mobility domain 2      |
| `wgMobilityD3`      | Mobility domain 3      |
| `wgRememberingD0`   | Remembering domain 0   |
| `wgRememberingD1`   | Remembering domain 1   |
| `wgRememberingD2`   | Remembering domain 2   |
| `wgRememberingD3`   | Remembering domain 3   |
| `wgSelfCareD0`      | Self-care domain 0     |
| `wgSelfCareD1`      | Self-care domain 1     |
| `wgSelfCareD2`      | Self-care domain 2     |
| `wgSelfCareD3`      | Self-care domain 3     |
| `wgCommunicatingD0` | Communication domain 0 |
| `wgCommunicatingD1` | Communication domain 1 |
| `wgCommunicatingD2` | Communication domain 2 |
| `wgCommunicatingD3` | Communication domain 3 |
| `wgP0`              | Overall 0              |
| `wgP1`              | Overall 1              |
| `wgP2`              | Overall 2              |
| `wgP3`              | Overall 3              |
| `wgPM`              | Any disability         |

## Examples

``` r
# Create indicators dataset from RAM-OP survey data collected from
# Addis Ababa, Ethiopia
create_op(testSVY)
#> ℹ Checking if demo, food, hunger, disability, adl, mental, dementia, health, income, wash, anthro, oedema, screening, visual, misc are RAM-OP indicators
#> ✔ All of `indicators` are RAM-OP indicators
#> # A tibble: 192 × 138
#>      psu  sex1  sex2 resp1 resp2 resp3 resp4   age ageGrp1 ageGrp2 ageGrp3
#>    <int> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <int>   <dbl>   <dbl>   <dbl>
#>  1   201     0     1     1     0     0     0    67       0       1       0
#>  2   201     1     0     1     0     0     0    74       0       0       1
#>  3   201     1     0     1     0     0     0    60       0       1       0
#>  4   201     0     1     1     0     0     0    60       0       1       0
#>  5   201     0     1     1     0     0     0    85       0       0       0
#>  6   201     1     0     0     1     0     0    86       0       0       0
#>  7   201     1     0     1     0     0     0    80       0       0       0
#>  8   201     0     1     1     0     0     0    60       0       1       0
#>  9   201     1     0     1     0     0     0    62       0       1       0
#> 10   201     0     1     1     0     0     0    72       0       0       1
#> # ℹ 182 more rows
#> # ℹ 127 more variables: ageGrp4 <dbl>, ageGrp5 <dbl>, marital1 <dbl>,
#> #   marital2 <dbl>, marital3 <dbl>, marital4 <dbl>, marital5 <dbl>,
#> #   marital6 <dbl>, alone <dbl>, MF <dbl>, DDS <dbl>, FG01 <dbl>, FG02 <dbl>,
#> #   FG03 <dbl>, FG04 <dbl>, FG05 <dbl>, FG06 <dbl>, FG07 <dbl>, FG08 <dbl>,
#> #   FG09 <dbl>, FG10 <dbl>, FG11 <dbl>, proteinRich <dbl>, pProtein <dbl>,
#> #   aProtein <dbl>, pVitA <dbl>, aVitA <dbl>, xVitA <dbl>, ironRich <dbl>, …
create_op(testSVY, indicators = "demo")
#> ℹ Checking if demo are RAM-OP indicators
#> ✔ All of `indicators` are RAM-OP indicators
#> # A tibble: 192 × 20
#>      psu  sex1  sex2 resp1 resp2 resp3 resp4   age ageGrp1 ageGrp2 ageGrp3
#>    <int> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <int>   <dbl>   <dbl>   <dbl>
#>  1   201     0     1     1     0     0     0    67       0       1       0
#>  2   201     1     0     1     0     0     0    74       0       0       1
#>  3   201     1     0     1     0     0     0    60       0       1       0
#>  4   201     0     1     1     0     0     0    60       0       1       0
#>  5   201     0     1     1     0     0     0    85       0       0       0
#>  6   201     1     0     0     1     0     0    86       0       0       0
#>  7   201     1     0     1     0     0     0    80       0       0       0
#>  8   201     0     1     1     0     0     0    60       0       1       0
#>  9   201     1     0     1     0     0     0    62       0       1       0
#> 10   201     0     1     1     0     0     0    72       0       0       1
#> # ℹ 182 more rows
#> # ℹ 9 more variables: ageGrp4 <dbl>, ageGrp5 <dbl>, marital1 <dbl>,
#> #   marital2 <dbl>, marital3 <dbl>, marital4 <dbl>, marital5 <dbl>,
#> #   marital6 <dbl>, alone <dbl>
create_op(testSVY, indicators = "hunger", sex = "m")
#> ℹ Checking if hunger are RAM-OP indicators
#> ✔ All of `indicators` are RAM-OP indicators
#> # A tibble: 79 × 6
#>      psu  sex1  sex2  HHS1  HHS2  HHS3
#>    <int> <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1   201     1     0     1     0     0
#>  2   201     1     0     1     0     0
#>  3   201     1     0     0     1     0
#>  4   201     1     0     1     0     0
#>  5   201     1     0     0     0     1
#>  6   202     1     0     1     0     0
#>  7   202     1     0     0     1     0
#>  8   202     1     0     1     0     0
#>  9   202     1     0     1     0     0
#> 10   202     1     0     0     1     0
#> # ℹ 69 more rows
```
