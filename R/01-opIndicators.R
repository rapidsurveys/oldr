#' 
#' Create older people indicators dataset from survey data collected using the
#' standard RAM-OP questionnaire. The indicator sets covered by the standard
#' RAM-OP survey are:
#' 
#' @section Demographic indicators:
#' 
#' **Variable** | **Description**
#' :--- | :---
#' `psu`` | Primary sampling unit
#' `resp1`` | Respondent is SUBJECT
#' `resp2` | Respondent is FAMILY CARER
#' `resp3` | Respondent is OTHER CARER
#' `resp4` | Respondent is OTHER
#' `age` | Age of respondent (years)
#' `ageGrp1` | Age of respondent is between 50 and 59 years
#' `ageGrp2` | Age of respondent is between 60 and 69 years
#' `ageGrp3` | Age of respondent is between 70 and 79 years
#' `ageGrp4` | Age of respondent is between 80 and 89 years
#' `ageGrp5` | Age of respondent is between 90 years and older
#' `sex1` | Male
#' `sex2` | Female
#' `marital1` | Marital status = SINGLE
#' `marital2` | Marital status = MARRIED
#' `marital3` | Marital status = LIVING TOGETHER
#' `marital4` | Marital status = DIVORCED
#' `marital5` | Marital status = SEPARATED
#' `marital6` | Marital status = OTHER
#' `alone` | Respondent lives alone
#' 
#' @section Dietary intake indicators:
#' 
#' These dietary intake indicators have been purpose-built for older people but
#' the basic approach used is described in:
#' 
#' \cite{Kennedy G, Ballard T, Dop M C (2011). Guidelines for Measuring
#' Household and Individual Dietary Diversity. Rome, FAO
#' \url{http://www.fao.org/docrep/014/i1983e/i1983e00.htm}}
#' 
#' and extended to include indicators of probable adequate intake of a number of
#' nutrients / micronutrients.
#' 
#' **Variable** | **Description**
#' :--- | :---
#' `MF`` | Meal frequency
#' `DDS`` | Dietary Diversity Score (count of 11 groups)
#' `FG01`` | Cereals
#' `FG02` | Roots and tubers
#' `FG03` | Fruits and vegetables
#' `FG04` | All meat
#' `FG05` | Eggs
#' `FG06` | Fish
#' `FG07` | Legumes, nuts and seeds
#' `FG08` | Milk and milk products
#' `FG09` | Fats
#' `FG10` | Sugar
#' `FG11` | Other
#' `proteinRich` | Protein rich foods
#' `pProtein` | Protein rich plant sources of protein
#' `aProtein` | Protein rich animal sources of protein
#' `pVitA` | Plant sources of vitamin A
#' `aVitA` | Animal sources of vitamin A
#' `xVitA` | Any source of vitamin A
#' `ironRich` | Iron rich foods
#' `caRich` | Calcium rich foods
#' `znRich` | Zinc rich foods
#' `vitB1` | Vitamin B1-rich foods
#' `vitB2` | Vitamin B2-rich foods
#' `vitB3` | Vitamin B3-rich foods
#' `vitB6` | Vitamin B6-rich foods
#' `vitB12` | Vitamin B12-rich foods
#' `vitBcomplex` | Vitamin B1/B2/B3/B6/B12-rich foods
#'
#' @section Household Hunger Scale (HHS):
#'
#' The HHS is described in:
#'
#' \cite{Ballard T, Coates J, Swindale A, Deitchler M (2011). Household Hunger
#' Scale: Indicator Definition and Measurement Guide. Washington DC,
#' FANTA-2 Bridge, FHI 360
#' \url{https://www.fantaproject.org/monitoring-and-evaluation/household-hunger-scale-hhs}}
#'
#' **Variable** | **Description**
#' :--- | :---
#' `HHS1` | Little or no hunger in household
#' `HHS2` | Moderate hunger in household
#' `HHS3` | Severe hunger in household
#'
#' @section Katz Index of Independence in Activities of Daily Living score:
#'
#' The Katz ADL score is described in:
#'
#' \cite{Katz S, Ford AB, Moskowitz RW, Jackson BA, Jaffe MW (1963). Studies
#' of illness in the aged. The Index of ADL: a standardized measure of
#' biological and psychosocial function. JAMA, 1963, 185(12):914-9
#' \doi{10.1001/jama.1963.03060120024016}}
#'
#' \cite{Katz S, Down TD, Cash HR, Grotz, RC (1970). Progress in the development
#' of the index of ADL. The Gerontologist, 10(1), 20-30
#' \doi{10.1093/geront/10.4_Part_1.274}}
#'
#' \cite{Katz S (1983). Assessing self-maintenance: Activities of daily living,
#' mobility and instrumental activities of daily living. JAGS, 31(12),
#' 721-726 \doi{10.1111/j.1532-5415.1983.tb03391.x}}
#'
#' **Variable** | **Description**
#' :--- | :---
#' ADL01 | Bathing
#' ADL02 | Dressing
#' ADL03 | Toileting
#' ADL04 | Transferring (mobility)
#' ADL05 | Continence
#' ADL06 | Feeding
#' scoreADL | ADL Score
#' classADL1 | Severity of dependence 1
#' classADL2 | Severity of dependence 2
#' classADL3 | Severity of dependence 3
#' hasHelp | Have someone to help with everyday activities
#' unmetNeed | Need help but has no helper
#'
#' @section K6 Short form psychological distress score:
#'
#' The K6 score is described in:
#'
#' \cite{Kessler RC, Andrews G, Colpe LJ, Hiripi E, Mroczek, DK, Normand SLT,
#' et al. (2002). Short screening scales to monitor population prevalences
#' and trends in non-specific psychological distress. Psychological
#' Medicine, 32(6), 959–976 \doi{10.1017/S0033291702006074}}
#'
#' **Variable** | **Description**
#' :--- | :---
#' K6 | K6 score
#' K6Case | K6 score > 12  (in serious psychological distress)
#'
#' @section Brief Community Screening Instrument for Dementia (CSID):
#'
#' The CSID dementia screening tool is described in:
#'
#' \cite{Prince M, et al. (2010). A brief dementia screener suitable for use
#' by non-specialists in resource poor settings - The cross-cultural
#' derivation and validation of the brief Community Screening Instrument
#' for Dementia. International Journal of Geriatric Psychiatry, 26(9),
#' 899–907 \doi{10.1002/gps.2622}}
#'
#' **Variable** | **Description**
#' :--- | :---
#' DS | Probable dementia by CSID screen
#'
#' @section Health and health-seeking indicators:
#'
#' **Variable** | **Description**
#' :--- | :---
#' H1 | Chronic condition
#' H2 | Takes drugs regularly for chronic condition
#' H31 | No drugs available
#' H32 | Too expensive / no money
#' H33 | Too old to look for care
#' H34 | Use traditional medicine
#' H35 | Drugs don't help
#' H36 | No-one to help me
#' H37 | No need
#' H38 | Other
#' H39 | No reason given
#' H4 | Recent disease episode
#' H5 | Accessed care for recent disease episode
#' H61 | No drugs available
#' H62 | Too expensive / no money
#' H63 | Too old to look for care
#' H64 | Use traditional medicine
#' H65 | Drugs don't help
#' H66 | No-one to help me
#' H67 | No need
#' H68 | Other
#' H69 | No reason given
#'
#' @section Income and income sources:
#'
#' **Variable** | **Description**
#' :--- | :---
#' M1 | Has a personal income
#' M2A | Agriculture / fishing / livestock
#' M2B | Wages / salary
#' M2C | Sale of charcoal / bricks / etc.
#' M2D | Trading (e.g. market or shop)
#' M2E | Investments
#' M2F | Spending savings / sale of assets
#' M2G | Charity
#' M2H | Cash transfer / Social security
#' M2I | Other
#'
#' @section Water, sanitation and hygiene (WASH) indicators:
#'
#' These are a (core) subset of indicators from:
#'
#' \cite{WHO / UNICEF (2006). Core Questions on Drinking-water and Sanitation
#' for Household Surveys. Geneva, WHO / UNICEF
#' \url{http://www.who.int/water_sanitation_health/monitoring/household_surveys/en/}}
#'
#' **Variable** | **Description**
#' :--- | :---
#' W1 | Improved source of drinking water
#' W2 | Safe drinking water (improved source OR adequate treatment)
#' W3 | Improved sanitation facility
#' W4 | Improved non-shared sanitation facility
#'
#' @section Anthropometry and screening:
#'
#' **Variable** | **Description**
#' :--- | :---
#' MUAC | Mid-upper arm circumference (mm)
#' oedema | Bilateral pitting oedema (may not be nutritional)
#' screened | Either MUAC or oedema checked previously
#'
#' @section Visual impairment by "Tumbling E" method:
#'
#' The "Tumbling E" method is described in:
#'
#' \cite{Taylor HR (1978). Applying new design principles to the construction of
#' an illiterate E Chart. Am J Optom & Physiol Optics 55:348}
#'
#' **Variable** | **Description**
#' :--- | :---
#' poorVA | Poor visual acuity (correct in < 3 of 4 tests)
#'
#' @section Miscellaneous indicators:
#'
#' **Variable** | **Description**
#' :--- | :---
#' chew | Problems chewing food
#' food | Anyone in HH receives a ration
#' NFRI | Anyone in HH received non-food relief item/s (NFRI) in previous month
#'
#' @section Washington Group on Disability:
#'
#' See:
#'
#'   \url{http://www.washingtongroup-disability.com}
#'   \url{https://www.cdc.gov/nchs/washington_group/wg_documents.htm}
#'
#' for details.
#'
#' **Variable** | **Description**
#' :--- | :---
#' wgVisionD0 | Vision domain 0
#' wgVisionD1 | Vision domain 1
#' wgVisionD2 | Vision domain 2
#' wgVisionD3 | Vision domain 3
#' wgHearingD0 | Hearing domain 0
#' wgHearingD1 | Hearing domain 1
#' wgHearingD2 | Hearing domain 2
#' wgHearingD3 | Hearing domain 3
#' wgMobilityD0 | Mobility domain 0
#' wgMobilityD1 | Mobility domain 1
#' wgMobilityD2 | Mobility domain 2
#' wgMobilityD3 | Mobility domain 3
#' wgRememberingD0 | Remembering domain 0
#' wgRememberingD1 | Remembering domain 1
#' wgRememberingD2 | Remembering domain 2
#' wgRememberingD3 | Remembering domain 3
#' wgSelfCareD0 | Self-care domain 0
#' wgSelfCareD1 | Self-care domain 1
#' wgSelfCareD2 | Self-care domain 2
#' wgSelfCareD3 | Self-care domain 3
#' wgCommunicatingD0 | Communication domain 0
#' wgCommunicatingD1 | Communication domain 1
#' wgCommunicatingD2 | Communication domain 2
#' wgCommunicatingD3 | Communication domain 3
#' wgP0 | Overall 0
#' wgP1 | Overall 1
#' wgP2 | Overall 2
#' wgP3 | Overall 3
#' wgPM | Any disability
#'
#' @param svy A data.frame collected using the standard RAM-OP questionnaire
#' @param indicators A character vector of indicator set names. The vector may
#'   include one or more of the following: *"demo"*, *"food"*, *"hunger"*,
#'   *"disability"*, *"adl"*, *"mental"*, *"dementia"*, *"health"*, *"income"*,
#'   *"wash"*, *"anthro"*, *"oedema"*, *"screening"*, *"visual"*, *"misc"*.
#'   Default is all indicator set names. 
#' @param sex A character value of *"m"*, *"f"*, or "*mf*" to indicate whether
#'   to report indicators for *males*, *females*, or *both* respectively.
#'   Default is *"mf"* for both sexes.
#'
#' @return A tibble of older people indicators
#'
#' @examples
#' # Create indicators dataset from RAM-OP survey data collected from
#' # Addis Ababa, Ethiopia
#' create_op(testSVY)
#' 
#' @export
#' @rdname create_op
#' 

create_op <- function(svy,
                      indicators = c("demo", "food", "hunger", "disability", 
                                     "adl", "mental", "dementia", "health", 
                                     "income", "wash", "anthro", "oedema",
                                     "screening", "visual", "misc"),
                      sex = c("mf", "m", "f")) {
  ## Check specified indicators ----
  indicators <- check_indicators(indicators = indicators)

  ## Check sex ----
  sex <- match.arg(sex)

  df <- data.frame(
    psu = svy$psu,
    sex1 = bbw::recode(svy$d3, "1=1; 2=0; else=NA"),
    sex2 = bbw::recode(svy$d3, "1=0; 2=1; else=NA")
  ) |>
    subset_by_sex(sex = sex)


  ## demographic indicators ----
  #demo       <- create_op_demo(svy = svy)

  ## Dietary intake indicators ----
  #food       <- create_op_food(svy = svy)

  ## Household Hunger Scale ----
  #hunger     <- create_op_hunger(svy = svy)

  ##  Katz "Index of Independence in Activities of Daily Living" (ADL) score
  #adl        <- create_op_adl(svy = svy)

  ##  K6: Short form psychological distress score ----
  #mental     <- create_op_mental(svy = svy)

  ## CISD
  #dementia   <- create_op_dementia(svy = svy)

  ##  Health indicators : CHRONIC CONDITIONS
  #health     <- create_op_health(svy = svy)

  ##  Income and income sources ----
  #income     <- create_op_income(svy = svy)

  ##  Water, Sanitation, and Hygiene (WASH) indicators ----
  #wash       <- create_op_wash(svy = svy)

  ##  Anthropometry and screening ----
  #anthro     <- create_op_anthro(svy = svy)
  #oedema     <- create_op_oedema(svy = svy)
  #screening  <- create_op_screening(svy = svy)

  ##  Visual impairment by "Tumbling E" method ----
  #visual     <- create_op_visual(svy = svy)

  ##  Miscellaneous indicators ----
  #misc       <- create_op_misc(svy = svy)

  ## Washington Group (WG) short set of question designed to identify ----
  ## people with a disability in a census or survey format.
  #disability <- create_op_disability(svy = svy)

  ##  Make summary data.frame for ALL respondents ----
  # indicators <- tibble::tibble(
  #   demo,
  #   subset(food, select = c(-psu, -sex1, -sex2)),
  #   subset(hunger, select = c(-psu, -sex1, -sex2)),
  #   subset(disability, select = c(-psu, -sex1, -sex2)),
  #   subset(adl, select = c(-psu, -sex1, -sex2)),
  #   subset(mental, select = c(-psu, -sex1, -sex2)),
  #   subset(dementia, select = c(-psu, -sex1, -sex2)),
  #   subset(health, select = c(-psu, -sex1, -sex2)),
  #   subset(income, select = c(-psu, -sex1, -sex2)),
  #   subset(wash, select = c(-psu, -sex1, -sex2)),
  #   subset(anthro, select = c(-psu, -sex1, -sex2)),
  #   subset(oedema, select = c(-psu, -sex1, -sex2)),
  #   subset(screening, select = c(-psu, -sex1, -sex2)),
  #   subset(visual, select = c(-psu, -sex1, -sex2)),
  #   subset(misc, select = c(-psu, -sex1, -sex2))
  # )

  indicators <- lapply(
    X = indicators, FUN = create_op_indicators, svy = svy, sex = sex
  ) |>
    do.call(cbind, args = _)

  indicators <- tibble::tibble(df, indicators)

  ## Return indicators ----
  indicators
}


#'
#' @export
#' @rdname create_op
#'

create_op_demo <- function(svy, sex = c("mf", "m", "f")) {
  ## Check sex ----
  sex <- match.arg(sex)
  
  ## Get PSU ----
  psu <- svy$psu

  ## Recode variables ----
  resp1    <- bbw::recode(svy$d1, "1=1; 5:9=1; NA=1; else=0")
  resp2    <- bbw::recode(svy$d1, "2=1; else=0")
  resp3    <- bbw::recode(svy$d1, "3=1; else=0")
  resp4    <- bbw::recode(svy$d1, "4=1; else=0")
  age      <- bbw::recode(svy$d2, "888=NA; 999=NA")
  ageGrp1  <- bbw::recode(age,"50:59=1; NA=NA; else=0")
  ageGrp2  <- bbw::recode(age,"60:69=1; NA=NA; else=0")
  ageGrp3  <- bbw::recode(age,"70:79=1; NA=NA; else=0")
  ageGrp4  <- bbw::recode(age,"80:89=1; NA=NA; else=0")
  ageGrp5  <- bbw::recode(age,"90:hi=1; NA=NA; else=0")
  sex1     <- bbw::recode(svy$d3, "1=1; 2=0; else=NA")
  sex2     <- bbw::recode(svy$d3, "1=0; 2=1; else=NA")
  marital1 <- bbw::recode(svy$d4, "1=1; else=0")
  marital2 <- bbw::recode(svy$d4, "2=1; else=0")
  marital3 <- bbw::recode(svy$d4, "3=1; else=0")
  marital4 <- bbw::recode(svy$d4, "4=1; else=0")
  marital5 <- bbw::recode(svy$d4, "5=1; else=0")
  marital6 <- bbw::recode(svy$d4, "6=1; else=0")
  alone    <- bbw::recode(svy$d5, "1=1; else=0")

  ## Concatenate variables ----
  demo_indicators <- tibble::tibble(
    psu, resp1, resp2, resp3, resp4, age, ageGrp1, ageGrp2, ageGrp3, ageGrp4, 
    ageGrp5, sex1, sex2, marital1, marital2, marital3, marital4, marital5, 
    marital6, alone
  )

  demo_indicators <- subset_by_sex(demo_indicators, sex = sex)

  ## Return demo indicators all
  demo_indicators
}


#'
#' @export
#' @rdname create_op
#'

create_op_food <- function(svy, sex = c("mf", "m", "f")) {
  ## Check sex ----
  sex <- match.arg(sex)

  ##
  psu <- svy$psu

  ##
  sex1     <- bbw::recode(svy$d3, "1=1; 2=0; else=NA")
  sex2     <- bbw::recode(svy$d3, "1=0; 2=1; else=NA")

  #
  #  Dietary intake indicators
  #
  ##  Meal frequency
  MF <- bbw::recode(svy$f1, "9=0; NA=0")

  ##  Recode dietary diversity data
  svy$f2a <- bbw::recode(svy$f2a, "1=1; else=0")
  svy$f2b <- bbw::recode(svy$f2b, "1=1; else=0")
  svy$f2c <- bbw::recode(svy$f2c, "1=1; else=0")
  svy$f2d <- bbw::recode(svy$f2d, "1=1; else=0")
  svy$f2e <- bbw::recode(svy$f2e, "1=1; else=0")
  svy$f2f <- bbw::recode(svy$f2f, "1=1; else=0")
  svy$f2g <- bbw::recode(svy$f2g, "1=1; else=0")
  svy$f2h <- bbw::recode(svy$f2h, "1=1; else=0")
  svy$f2i <- bbw::recode(svy$f2i, "1=1; else=0")
  svy$f2j <- bbw::recode(svy$f2j, "1=1; else=0")
  svy$f2k <- bbw::recode(svy$f2k, "1=1; else=0")
  svy$f2l <- bbw::recode(svy$f2l, "1=1; else=0")
  svy$f2m <- bbw::recode(svy$f2m, "1=1; else=0")
  svy$f2n <- bbw::recode(svy$f2n, "1=1; else=0")
  svy$f2o <- bbw::recode(svy$f2o, "1=1; else=0")
  svy$f2p <- bbw::recode(svy$f2p, "1=1; else=0")
  svy$f2q <- bbw::recode(svy$f2q, "1=1; else=0")
  svy$f2r <- bbw::recode(svy$f2r, "1=1; else=0")
  svy$f2s <- bbw::recode(svy$f2s, "1=1; else=0")

  ##  Dietary diversity
  FG01 <- svy$f2c
  FG02 <- svy$f2g
  FG03 <- ifelse(svy$f2d == 1 | svy$f2f == 1 | svy$f2i == 1, 1, 0)
  FG04 <- ifelse(svy$f2j == 1 | svy$f2k == 1 | svy$f2q == 1, 1, 0)
  FG05 <- svy$f2n
  FG06 <- svy$f2l
  FG07 <- svy$f2h
  FG08 <- ifelse(svy$f2a == 1 | svy$f2m == 1, 1, 0)
  FG09 <- ifelse(svy$f2e == 1 | svy$f2o == 1, 1, 0)
  FG10 <- svy$f2r
  FG11 <- ifelse(svy$f2b == 1 | svy$f2p == 1 | svy$f2s == 1, 1, 0)

  ## Sum food groups to 'DDS'
  DDS <- FG01 + FG02 + FG03 + FG04 + FG05 + FG06 + FG07 + FG08 + FG09 + FG10 + FG11

  ##  Protein rich foods in diet from aminal, plant, and all sources
  aProtein <- ifelse(svy$f2j == 1 | svy$f2k == 1 | svy$f2q ==1 | svy$f2n == 1 |
                       svy$f2a == 1 | svy$f2m == 1, 1, 0)
  pProtein <- ifelse(svy$f2h == 1 | svy$f2p == 1, 1, 0)
  proteinRich <- ifelse(aProtein == 1 | pProtein == 1, 1, 0)

  ##  Micronutrient intake (vitamin A, iron, calcium, zinc)
  pVitA    <- ifelse(svy$f2d == 1 | svy$f2e == 1 | svy$f2f == 1, 1, 0)
  aVitA    <- ifelse(svy$f2a == 1 | svy$f2j == 1 | svy$f2m == 1 | svy$f2n == 1, 1, 0)
  xVitA    <- ifelse(pVitA == 1 | aVitA == 1, 1, 0)
  ironRich <- ifelse(svy$f2f == 1 | svy$f2j == 1 | svy$f2k == 1 | svy$f2l == 1, 1, 0)
  caRich   <- ifelse(svy$f2a == 1 | svy$f2m == 1, 1, 0)
  znRich   <- ifelse(svy$f2h == 1 | svy$f2j == 1 | svy$f2k == 1 |
                       svy$f2l == 1 | svy$f2p == 1 | svy$f2q == 1, 1, 0)

  ##  Micronutrient intake (B vitamins)
  vitB1  <- ifelse(svy$f2a == 1 | svy$f2e == 1 | svy$f2h == 1 | svy$f2j == 1 |
                     svy$f2k == 1 | svy$f2l == 1 | svy$f2m == 1 | svy$f2n == 1 |
                     svy$f2p == 1, 1, 0)
  vitB2  <- ifelse(svy$f2a == 1 | svy$f2f == 1 | svy$f2h == 1 | svy$f2j == 1 |
                     svy$f2k == 1 | svy$f2l == 1 | svy$f2m == 1, 1, 0)
  vitB3  <- ifelse(svy$f2h == 1 | svy$f2j == 1 | svy$f2k == 1 | svy$f2l == 1, 1, 0)
  vitB6  <- ifelse(svy$f2d == 1 | svy$f2f == 1 | svy$f2h == 1 | svy$f2i == 1 |
                     svy$f2k == 1 | svy$f2l == 1, 1, 0)
  vitB12 <- ifelse(svy$f2j == 1 | svy$f2k == 1 | svy$f2l == 1 | svy$f2m == 1 |
                     svy$f2n == 1, 1, 0)
  vitBsources <- vitB1 + vitB2 + vitB3 + vitB6 + vitB12
  vitBcomplex <- ifelse(vitBsources == 5, 1, 0)

  ## Concatenate
  food_indicators <- tibble::tibble(
    psu, sex1, sex2, MF, DDS, FG01, FG02, FG03, FG04, FG05, FG06, FG07, FG08, 
    FG09, FG10, FG11, proteinRich, pProtein, aProtein, pVitA, aVitA, xVitA,
    ironRich, caRich, znRich, vitB1, vitB2, vitB3, vitB6, vitB12, vitBcomplex
  )

  ## Subset by sex ----
  food_indicators <- subset_by_sex(food_indicators, sex = sex)

  ## Return results
  food_indicators
}


#'
#' @export
#' @rdname create_op
#'

create_op_hunger <- function(svy, sex = c("mf", "m", "f")) {
  ## Check sex ----
  sex <- match.arg(sex)


  ##
  psu <- svy$psu

  ##
  sex1 <- bbw::recode(svy$d3, "1=1; 2=0; else=NA")
  sex2 <- bbw::recode(svy$d3, "1=0; 2=1; else=NA")

  ##  Sum components and classify hunger into three separate indicator variables
  sumHHS <- svy$f3 + svy$f4 + svy$f5
  HHS1 <- bbw::recode(sumHHS, "0:1=1; else=0")
  HHS2 <- bbw::recode(sumHHS, "2:3=1; else=0")
  HHS3 <- bbw::recode(sumHHS, "4:6=1; else=0")

  ## Concatenate
  hunger_indicators <- tibble::tibble(psu, sex1, sex2, HHS1, HHS2, HHS3)

  ## Subset by sex
  hunger_indicators <- subset_by_sex(hunger_indicators, sex = sex)

  ## Return results
  hunger_indicators
}


#'
#' @export
#' @rdname create_op
#'

create_op_adl <- function(svy, sex = c("mf", "m", "f")) {
  ## Check sex ----
  sex <- match.arg(sex)

  ##
  psu <- svy$psu

  ##
  sex1     <- bbw::recode(svy$d3, "1=1; 2=0; else=NA")
  sex2     <- bbw::recode(svy$d3, "1=0; 2=1; else=NA")

  #
  #  Katz "Index of Independence in Activities of Daily Living" (ADL) score
  #
  ##  Recode ADL (activities of daily living) score data
  ADL01 <- bbw::recode(svy$a1, "2=1; else=0")    # Bathing
  ADL02 <- bbw::recode(svy$a2, "2=1; else=0")    # Dressing
  ADL03 <- bbw::recode(svy$a3, "2=1; else=0")    # Toileting
  ADL04 <- bbw::recode(svy$a4, "2=1; else=0")    # Transferring (mobility)
  ADL05 <- bbw::recode(svy$a5, "2=1; else=0")    # Continence
  ADL06 <- bbw::recode(svy$a6, "2=1; else=0")    # Feeding

  ##  Create ADL score (items summed over all six activities / dimensions)
  scoreADL <- ADL01 + ADL02 + ADL03 + ADL04 + ADL05 + ADL06

  ##  Severity of dependence (from Katz ADL score)
  classADL1 <- bbw::recode(scoreADL, "5:6=1; else=0")
  classADL2 <- bbw::recode(scoreADL, "3:4=1; else=0")
  classADL3 <- bbw::recode(scoreADL, "0:2=1; else=0")

  ##  Does the subject have someone to help with everyday activities?
  hasHelp <- bbw::recode(svy$a7, "1=1; else=0")

  ##  Does the subject need help but has no helper?
  ##
  ##  Note : Denominator is entire sample so the indicator is the proportion of
  ##         the population with unmet ADl help needs
  unmetNeed <- ifelse(scoreADL < 6 & hasHelp == 0, 1, 0)

  ## Concatenate indicators
  adl_indicators <- tibble::tibble(
    psu, sex1, sex2, ADL01, ADL02, ADL03, ADL04, ADL05, ADL06, scoreADL, 
    classADL1, classADL2, classADL3, hasHelp, unmetNeed
  )

  ## Subset by sex
  adl_indicators <- subset_by_sex(adl_indicators, sex = sex)

  ## Return results
  adl_indicators
}


#'
#' @export
#' @rdname create_op
#'

create_op_disability <- function(svy, sex = c("mf", "m", "f")) {
  ## Check sex ----
  sex <- match.arg(sex)

  ##
  psu <- svy$psu

  ##
  sex1     <- bbw::recode(svy$d3, "1=1; 2=0; else=NA")
  sex2     <- bbw::recode(svy$d3, "1=0; 2=1; else=NA")

  ##  Washington Group (WG) short set of question designed to identify people 
  ##  with a disability in a census or survey format.

  ## Missing values
  svy$wg1 <- bbw::recode(svy$wg1, "9=0; NA=0")
  svy$wg2 <- bbw::recode(svy$wg2, "9=0; NA=0")
  svy$wg3 <- bbw::recode(svy$wg3, "9=0; NA=0")
  svy$wg4 <- bbw::recode(svy$wg4, "9=0; NA=0")
  svy$wg5 <- bbw::recode(svy$wg5, "9=0; NA=0")
  svy$wg6 <- bbw::recode(svy$wg6, "9=0; NA=0")

  ## Vision domain
  wgVisionD0 <- ifelse(svy$wg1 == 0, 1, 0)
  wgVisionD1 <- ifelse(svy$wg1 == 1 | svy$wg1 == 2 | svy$wg1 == 3, 1, 0)
  wgVisionD2 <- ifelse(svy$wg1 == 2 | svy$wg1 == 3, 1, 0)
  wgVisionD3 <- ifelse(svy$wg1 == 3, 1, 0)

  ## Hearing domain
  wgHearingD0 <- ifelse(svy$wg2 == 0, 1, 0)
  wgHearingD1 <- ifelse(svy$wg2 == 1 | svy$wg2 == 2 | svy$wg2 == 3, 1, 0)
  wgHearingD2 <- ifelse(svy$wg2 == 2 | svy$wg2 == 3, 1, 0)
  wgHearingD3 <- ifelse(svy$wg2 == 3, 1, 0)

  ## Mobility domain
  wgMobilityD0 <- ifelse(svy$wg3 == 0, 1, 0)
  wgMobilityD1 <- ifelse(svy$wg3 == 1 | svy$wg3 == 2 | svy$wg3 == 3, 1, 0)
  wgMobilityD2 <- ifelse(svy$wg3 == 2 | svy$wg3 == 3, 1, 0)
  wgMobilityD3 <- ifelse(svy$wg3 == 3, 1, 0)

  ## Remembering domain
  wgRememberingD0 <- ifelse(svy$wg4 == 0, 1, 0)
  wgRememberingD1 <- ifelse(svy$wg4 == 1 | svy$wg4 == 2 | svy$wg4 == 3, 1, 0)
  wgRememberingD2 <- ifelse(svy$wg4 == 2 | svy$wg4 == 3, 1, 0)
  wgRememberingD3 <- ifelse(svy$wg4 == 3, 1, 0)

  ## Self-care domain
  wgSelfCareD0 <- ifelse(svy$wg5 == 0, 1, 0)
  wgSelfCareD1 <- ifelse(svy$wg5 == 1 | svy$wg5 == 2 | svy$wg5 == 3, 1, 0)
  wgSelfCareD2 <- ifelse(svy$wg5 == 2 | svy$wg5 == 3, 1, 0)
  wgSelfCareD3 <- ifelse(svy$wg5 == 3, 1, 0)

  ## Communicating domain
  wgCommunicatingD0 <- ifelse(svy$wg6 == 0, 1, 0)
  wgCommunicatingD1 <- ifelse(svy$wg6 == 1 | svy$wg6 == 2 | svy$wg6 == 3, 1, 0)
  wgCommunicatingD2 <- ifelse(svy$wg6 == 2 | svy$wg6 == 3, 1, 0)
  wgCommunicatingD3 <- ifelse(svy$wg6 == 3, 1, 0)

  ## Overall prevalence
  wgP0 <- ifelse(
    wgVisionD0 + wgHearingD0 + wgMobilityD0 + wgRememberingD0 +
      wgSelfCareD0 + wgCommunicatingD0 == 6, 1, 0
  )
  wgP1 <- ifelse(
    wgVisionD1 + wgHearingD1 + wgMobilityD1 + wgRememberingD1 +
      wgSelfCareD1 + wgCommunicatingD1 >  0, 1, 0
  )
  wgP2 <- ifelse(
    wgVisionD2 + wgHearingD2 + wgMobilityD2 + wgRememberingD2 +
      wgSelfCareD2 + wgCommunicatingD2 >  0, 1, 0
  )
  wgP3 <- ifelse(
    wgVisionD3 + wgHearingD3 + wgMobilityD3 + wgRememberingD3 +
      wgSelfCareD3 + wgCommunicatingD3 >  0, 1, 0
  )
  wgPM <- ifelse(
    wgVisionD1 + wgHearingD1 + wgMobilityD1 + wgRememberingD1 +
      wgSelfCareD1 + wgCommunicatingD1 >  1, 1, 0
  )

  ## Concatenate
  disability_indicators <- tibble::tibble(
    psu, sex1, sex2, wgVisionD0, wgVisionD1, wgVisionD2, wgVisionD3, 
    wgHearingD0, wgHearingD1, wgHearingD2, wgHearingD3,wgMobilityD0,
    wgMobilityD1, wgMobilityD2, wgMobilityD3, wgRememberingD0, 
    wgRememberingD1, wgRememberingD2, wgRememberingD3, wgSelfCareD0, 
    wgSelfCareD1, wgSelfCareD2, wgSelfCareD3, wgCommunicatingD0, 
    wgCommunicatingD1, wgCommunicatingD2, wgCommunicatingD3, wgP0, wgP1, wgP2, 
    wgP3, wgPM
  )

  ## Subset by sex
  disability_indicators <- subset_by_sex(disability_indicators, sex = sex)

  # Return results
  disability_indicators
}


#'
#' @export
#' @rdname create_op
#'

create_op_mental <- function(svy, sex = c("mf", "m", "f")) {
  ## Check sex ----
  sex <- match.arg(sex)

  ##
  psu <- svy$psu

  ##
  sex1     <- bbw::recode(svy$d3, "1=1; 2=0; else=NA")
  sex2     <- bbw::recode(svy$d3, "1=0; 2=1; else=NA")

  ## K6: Short form psychological distress score
  ##
  ## Recode DON'T KNOW, REFUSED, NA and MISSING values to 5 (NONE)
  svy$k6a <- bbw::recode(svy$k6a, "6:9=5")
  svy$k6b <- bbw::recode(svy$k6b, "6:9=5")
  svy$k6c <- bbw::recode(svy$k6c, "6:9=5")
  svy$k6d <- bbw::recode(svy$k6d, "6:9=5")
  svy$k6e <- bbw::recode(svy$k6e, "6:9=5")
  svy$k6f <- bbw::recode(svy$k6f, "6:9=5")

  ## Reverse coding & create K6 score (i.e. the sum of individual item scores)
  svy$k6a <- 5 - svy$k6a
  svy$k6b <- 5 - svy$k6b
  svy$k6c <- 5 - svy$k6d
  svy$k6d <- 5 - svy$k6d
  svy$k6e <- 5 - svy$k6e
  svy$k6f <- 5 - svy$k6f
  K6 <- svy$k6a + svy$k6b + svy$k6c + svy$k6d + svy$k6e + svy$k6f

  ##  Apply case-definition for serious psychological distress(i.e. K6 > 12)
  K6Case <- bbw::recode(K6, "0:12=0; 13:hi=1")

  ## Concatenate indicators
  mental_indicators <- tibble::tibble(psu, sex1, sex2, K6, K6Case)

  ## Convert to tibble
  mental_indicators <- subset_by_sex(mental_indicators, sex = sex)

  ## Return results
  mental_indicators
}


#'
#' @export
#' @rdname create_op
#'

create_op_dementia <- function(svy, sex = c("mf", "m", "f")) {
  ## Check sex ----
  sex <- match.arg(sex)

  ##
  psu <- svy$psu

  ##
  sex1     <- bbw::recode(svy$d3, "1=1; 2=0; else=NA")
  sex2     <- bbw::recode(svy$d3, "1=0; 2=1; else=NA")

  ##  Recode scored components to 0 / 1 (with 1 = correct)
  svy$ds1  <- bbw::recode(svy$ds1,  "1=1; else=0") # Nose
  svy$ds2  <- bbw::recode(svy$ds2,  "1=1; else=0") # Hammer
  svy$ds3  <- bbw::recode(svy$ds3,  "1=1; else=0") # Day of week
  svy$ds4  <- bbw::recode(svy$ds4,  "1=1; else=0") # Season
  svy$ds5  <- bbw::recode(svy$ds5,  "1=1; else=0") # Point to window then door
  svy$ds6a <- bbw::recode(svy$ds6a, "1=1; else=0") # Memory "CHILD"
  svy$ds6b <- bbw::recode(svy$ds6b, "1=1; else=0") # Memory "HOUSE"
  svy$ds6c <- bbw::recode(svy$ds6c, "1=1; else=0") # Memory "ROAD"

  ##  Sum correct items into CSID score
  scoreCSID <- svy$ds1 + svy$ds2 + svy$ds3 + svy$ds4 +
    svy$ds5 + svy$ds6a + svy$ds6b + svy$ds6c

  ##  Classify dementia :
  DS <- bbw::recode(scoreCSID, "0:4=1; 5:8=0")

  ## Concatenate
  dementia_indicators <- tibble::tibble(psu, sex1, sex2, DS)

  ## Convert to tibble
  dementia_indicators <- subset_by_sex(dementia_indicators, sex = sex)

  ## Return results
  dementia_indicators
}


#'
#' @export
#' @rdname create_op
#'

create_op_health <- function(svy, sex = c("mf", "m", "f")) {
  ## Check sex ----
  sex <- match.arg(sex)

  ##
  psu <- svy$psu

  ##
  sex1     <- bbw::recode(svy$d3, "1=1; 2=0; else=NA")
  sex2     <- bbw::recode(svy$d3, "1=0; 2=1; else=NA")

  ##  Health indicators : CHRONIC CONDITIONS
  svy$h1 <- bbw::recode(svy$h1, "1=1; else=2")
  H1 <- bbw::recode(svy$h1, "1=1; else=0")
  H2 <- ifelse(H1 == 0, NA, bbw::recode(svy$h2, "1=1; else=0"))
  H3 <- ifelse(H2 == 1, NA, bbw::recode(svy$h3, "NA=9"))

  ## Indicators for main reason for NOT taking drugs for chronic condition
  H31 <- bbw::recode(H3, "1=1; NA=NA; else=0")
  H32 <- bbw::recode(H3, "2=1; NA=NA; else=0")
  H33 <- bbw::recode(H3, "3=1; NA=NA; else=0")
  H34 <- bbw::recode(H3, "4=1; NA=NA; else=0")
  H35 <- bbw::recode(H3, "5=1; NA=NA; else=0")
  H36 <- bbw::recode(H3, "6=1; NA=NA; else=0")
  H37 <- bbw::recode(H3, "7=1; NA=NA; else=0")
  H38 <- bbw::recode(H3, "8=1; NA=NA; else=0")
  H39 <- bbw::recode(H3, "9=1; NA=NA; else=0")

  ##  Health indicators : RECENT DISEASE EPISODE
  svy$h4 <- bbw::recode(svy$h4, "1=1; else=2")
  H4 <- bbw::recode(svy$h4, "1=1; else=0")
  H5 <- ifelse(H4 == 0, NA, bbw::recode(svy$h5, "1=1; else=0"))
  H6 <- ifelse(H5 == 1, NA, bbw::recode(svy$h6, "NA=9"))

  ## Indicators for main reason for NOT accessing care for recent disease episode
  H61 <- bbw::recode(H6, "1=1; NA=NA; else=0")
  H62 <- bbw::recode(H6, "2=1; NA=NA; else=0")
  H63 <- bbw::recode(H6, "3=1; NA=NA; else=0")
  H64 <- bbw::recode(H6, "4=1; NA=NA; else=0")
  H65 <- bbw::recode(H6, "5=1; NA=NA; else=0")
  H66 <- bbw::recode(H6, "6=1; NA=NA; else=0")
  H67 <- bbw::recode(H6, "7=1; NA=NA; else=0")
  H68 <- bbw::recode(H6, "8=1; NA=NA; else=0")
  H69 <- bbw::recode(H6, "9=1; NA=NA; else=0")

  ## Concatenate
  health_indicators <- tibble::tibble(
    psu, sex1, sex2, H1, H2, H31, H32, H33, H34, H35, H36, H37, H38, H39, H4, 
    H5, H61, H62, H63, H64, H65, H66, H67, H68, H69
  )

  ## Subset by sex
  health_indicators <- subset_by_sex(health_indicators, sex = sex)

  # Return results
  health_indicators
}


#'
#' @export
#' @rdname create_op
#'

create_op_income <- function(svy, sex = c("mf", "m", "f")) {
  ## Check sex ----
  sex <- match.arg(sex)

  ##
  psu <- svy$psu

  ##
  sex1     <- bbw::recode(svy$d3, "1=1; 2=0; else=NA")
  sex2     <- bbw::recode(svy$d3, "1=0; 2=1; else=NA")

  ##  Income and income sources
  ##
  ##  Create binary indicators
  M1  <- bbw::recode(svy$m1,  "1=1; else=0") # Has a personal income
  M2A <- bbw::recode(svy$m2a, "1=1; else=0") # Agriculture/fishing/livestock
  M2B <- bbw::recode(svy$m2b, "1=1; else=0") # Wages/salary
  M2C <- bbw::recode(svy$m2c, "1=1; else=0") # Sale of charcoal/bricks/etc.
  M2D <- bbw::recode(svy$m2d, "1=1; else=0") # Trading (e.g. market or shop)
  M2E <- bbw::recode(svy$m2e, "1=1; else=0") # Investments
  M2F <- bbw::recode(svy$m2f, "1=1; else=0") # Spending savings/sale of assets
  M2G <- bbw::recode(svy$m2g, "1=1; else=0") # Charity
  M2H <- bbw::recode(svy$m2h, "1=1; else=0") # Cash transfer/social security
  M2I <- bbw::recode(svy$m2i, "1=1; else=0") # Other

  ##  Check for any income (return 'correct' result in M1)
  checkForIncome <- M1 + M2A + M2B + M2C + M2D + M2E + M2F + M2G + M2H + M2I
  M1 <- ifelse(checkForIncome > 0, 1, 0)

  ## Concatenate
  income_indicators <- tibble::tibble(
    psu, sex1, sex2, M1, M2A, M2B, M2C, M2D, M2E, M2F, M2G, M2H, M2I
  )

  ## Subset by sex
  income_indicators <- subset_by_sex(income_indicators, sex = sex)

  ## Return results
  income_indicators
}


#'
#' @export
#' @rdname create_op
#'

create_op_wash <- function(svy, sex = c("mf", "m", "f")) {
  ## Check sex ----
  sex <- match.arg(sex)

  ##
  psu <- svy$psu

  ##
  sex1     <- bbw::recode(svy$d3, "1=1; 2=0; else=NA")
  sex2     <- bbw::recode(svy$d3, "1=0; 2=1; else=NA")

  ##
  ##  Water, Sanitation, and Hygiene (WASH) indicators
  ##
  ##  Recode WASH data
  svy$w1 <- bbw::recode(svy$w1, "1=1; else=0")
  svy$w2 <- bbw::recode(svy$w2, "1=1; else=0")
  svy$w3 <- bbw::recode(svy$w3, "1=1; else=0")
  svy$w4 <- bbw::recode(svy$w4, "1=1; else=0")

  ##  Create WASH indicators
  W1 <- svy$w1
  W2 <- ifelse(svy$w1 == 1 | svy$w2 == 1, 1, 0)
  W3 <- svy$w3
  W4 <- ifelse(svy$w3 == 1 & svy$w4 != 1, 1, 0)

  ## Concatenate
  wash_indicators <- tibble::tibble(psu, sex1, sex2, W1, W2, W3, W4)

  ## Subset by sex
  wash_indicators <- subset_by_sex(wash_indicators, sex = sex)

  ## Return results
  wash_indicators
}


#'
#' @export
#' @rdname create_op
#'

create_op_anthro <- function(svy, sex = c("mf", "m", "f")) {
  ## Check sex ----
  sex <- match.arg(sex)

  ##
  psu <- svy$psu

  ##
  sex1     <- bbw::recode(svy$d3, "1=1; 2=0; else=NA")
  sex2     <- bbw::recode(svy$d3, "1=0; 2=1; else=NA")

  ## Anthropometry and screening
  ##
  ## Censor REFUSAL, NOT APPLICABLE, and MISSING values codes in MUAC and Oedema
  MUAC <- bbw::recode(svy$as1, "777=NA; 888=NA; 999=NA")

  ## Concatenate
  anthro_indicators <- tibble::tibble(psu, sex1, sex2, MUAC)

  ## Subset by sex
  anthro_indicators <- subset_by_sex(anthro_indicators, sex = sex)

  ## Return results
  anthro_indicators
}


#'
#' @export
#' @rdname create_op
#'

create_op_oedema <- function(svy, sex = c("mf", "m", "f")) {
  ## Check sex ----
  sex <- match.arg(sex)

  ##
  psu <- svy$psu

  ##
  sex1     <- bbw::recode(svy$d3, "1=1; 2=0; else=NA")
  sex2     <- bbw::recode(svy$d3, "1=0; 2=1; else=NA")

  ## Screening
  ##
  ## Censor REFUSAL, NOT APPLICABLE, and MISSING values codes in MUAC and Oedema
  oedema <- bbw::recode(svy$as3, "1=1; else=0")

  ## Concatenate
  oedema_indicators <- tibble::tibble(psu, sex1, sex2, oedema)

  ## Subset by sex
  oedema_indicators <- subset_by_sex(oedema_indicators, sex = sex)

  ## Return results
  oedema_indicators
}


#'
#' @export
#' @rdname create_op
#'

create_op_screening <- function(svy, sex = c("mf", "m", "f")) {
  ## Check sex ----
  sex <- match.arg(sex)

  ##
  psu <- svy$psu

  ##
  sex1     <- bbw::recode(svy$d3, "1=1; 2=0; else=NA")
  sex2     <- bbw::recode(svy$d3, "1=0; 2=1; else=NA")

  ## Screening for GAM, MAM, SAM (i.e. either MUAC or oedema checked previously)
  screened <- ifelse(svy$as2 == 1 | svy$as4 == 1, 1, 0)

  ## Concatenate
  screening_indicators <- tibble::tibble(psu, sex1, sex2, screened)

  ## Subset by sex
  screening_indicators <- subset_by_sex(screening_indicators, sex = sex)

  ## Return results
  screening_indicators
}


#'
#' @export
#' @rdname create_op
#'

create_op_visual <- function(svy, sex = c("mf", "m", "f")) {
  ## Check sex ----
  sex <- match.arg(sex)

  ##
  psu <- svy$psu

  ##
  sex1     <- bbw::recode(svy$d3, "1=1; 2=0; else=NA")
  sex2     <- bbw::recode(svy$d3, "1=0; 2=1; else=NA")

  ##  Visual impairment by "Tumbling E" method
  ##
  ##  Create binary indicators
  svy$va2a <- bbw::recode(svy$va2a, "1=1; else=0")
  svy$va2b <- bbw::recode(svy$va2b, "1=1; else=0")
  svy$va2c <- bbw::recode(svy$va2c, "1=1; else=0")
  svy$va2d <- bbw::recode(svy$va2d, "1=1; else=0")
  sumVA <- svy$va2a + svy$va2b + svy$va2c + svy$va2d
  poorVA <-  ifelse(sumVA < 3, 1, 0)

  ## Concatenate results
  visual_indicators <- tibble::tibble(psu, sex1, sex2, poorVA)

  ## Subset by sex
  visual_indicators <- subset_by_sex(visual_indicators, sex = sex)

  ## Return results
  visual_indicators
}


#'
#' @export
#' @rdname create_op
#'

create_op_misc <- function(svy, sex = c("mf", "m", "f")) {
  ## Check sex ----
  sex <- match.arg(sex)

  ##
  psu <- svy$psu

  ##
  sex1     <- bbw::recode(svy$d3, "1=1; 2=0; else=NA")
  sex2     <- bbw::recode(svy$d3, "1=0; 2=1; else=NA")

  ##  Miscellaneous indicators
  chew <- bbw::recode(svy$a8, "1=1; else=0")
  food <- bbw::recode(svy$f6, "1=1; else=0")
  NFRI <- bbw::recode(svy$f7, "1=1; else=0")

  ## Concatenate
  misc_indicators <- tibble::tibble(psu, sex1, sex2, chew, food, NFRI)

  ## Subset by sex
  misc_indicators <- subset_by_sex(misc_indicators, sex = sex)

  ## Return results
  misc_indicators
}


#'
#' Check whether indicators are RAM-OP indicators
#' 
#' @keywords internal
#' 

check_indicators <- function(indicators) {
  indicator_sets <- c(
    "demo", "food", "hunger", "disability", "adl", "mental", "dementia", 
    "health", "income", "wash", "anthro", "oedema", "screening", "visual", 
    "misc"
  )

  ## Check if indicators are in indicator_sets ----
  indicator_names <- paste(indicators, collapse = ", ")
  cli::cli_alert_info(
    "Checking if {.strong {indicator_names}} are RAM-OP indicators"
  )

  not_indicator <- which(!indicators %in% indicator_sets)
  yes_indicator <- which(indicators %in% indicator_sets)

  if (length(not_indicator) == 0) {
    indicators <- indicators
    cli::cli_alert_success("All of {.arg indicators} are RAM-OP indicators")
  } else {
    if (length(not_indicator) == length(indicators)) {
      cli::cli_abort(
        "All of {.strong {indicator_names}} are not RAM-OP indicators"
      )
    } else {
      indicators_yes      <- indicators[yes_indicator]
      indicators_no       <- indicators[not_indicator]
      indicator_names_yes <- paste(indicators_yes, collapse = ", ")
      indicator_names_no  <- paste(indicators_no, collapse = ", ")
      message1 <- ifelse(
        length(indicators_yes) == 1,
        "is a RAM-OP indicator.",
        "are RAM-OP indicators."
      )
      message2 <- ifelse(
        length(indicators_no) == 1,
        "is not a RAM-OP indicator.",
        "are not RAM-OP indicators."
      )
      cli::cli_bullets(
        c(
          "!" = "{.strong {indicator_names_no}} {message2}",
          "i" = "Only {.strong {indicator_names_yes}} {message1}",
          "i" = "Returning {.strong {indicator_names_yes}}"
        )
      )
      indicators <- indicators[yes_indicator]
    }
  }

  ## Return indicators
  indicators
}

#'
#' Subset data.frame to required sex
#' 
#' @keywords internal
#' 

subset_by_sex <- function(df, sex) {
  ## Check which sex subset to return ----
  if (sex == "mf") {
    df <- df
  } else {
    if (sex == "m") {
      df <- subset(df, subset = sex1 == 1)
    } else {
      df <- subset(df, subset = sex2 == 1)
    }
  }

  df
}


#'
#' Construct create_op_* expression
#' 
#' @keywords internal
#' 

create_op_indicators <- function(indicator, svy, sex) {
  paste0(
    indicator,
    " = create_op_", 
    indicator, 
    "(svy = svy, sex = '", sex, 
    "') |> subset(select = c(-psu, -sex1, -sex2))"
  ) |>
    str2expression() |>
    eval()
}
