################################################################################
#
#' create_op_demo
#'
#' Create older people indicators dataframe for demography and situation from
#' survey data collected using the standard RAM-OP questionnaire
#'
#' @section Indicators: Demography and situation
#'
#' \strong{Demography}
#' \describe{
#' \item{\code{psu}}{Primary sampling unit}
#' \item{\code{resp1}}{Respondent is SUBJECT}
#' \item{\code{resp2}}{Respondent is FAMILY CARER}
#' \item{\code{resp3}}{Respondent is OTHER CARER}
#' \item{\code{resp4}}{Respondent is OTHER}
#' \item{\code{age}}{Age of respondent (years)}
#' \item{\code{ageGrp1}}{Age of respondent is between 50 and 59 years}
#' \item{\code{ageGrp2}}{Age of respondent is between 50 and 59 years}
#' \item{\code{ageGrp3}}{Age of respondent is between 50 and 59 years}
#' \item{\code{ageGrp4}}{Age of respondent is between 50 and 59 years}
#' \item{\code{ageGrp5}}{Age of respondent is between 50 and 59 years}
#' \item{\code{sex1}}{Male}
#' \item{\code{sex2}}{Female}
#' \item{\code{marital1}}{Marital status = SINGLE}
#' \item{\code{marital2}}{Marital status = MARRIED}
#' \item{\code{marital3}}{Marital status = LIVING TOGETHER}
#' \item{\code{marital4}}{Marital status = DIVORCED}
#' \item{\code{marital5}}{Marital status = SEPARATED}
#' \item{\code{marital6}}{Marital status = OTHER}
#' \item{\code{alone}}{Respondent lives alone}
#' }
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of older people indicators on demography and situation
#'
#' @examples
#'
#' # Create demography and situation indicators dataset from RAM-OP survey data
#' # collected from Addis Ababa, Ethiopia
#' create_op_demo(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_demo <- function(svy) {
  ##
  psu <- svy$psu
  ##
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
  ##
  demo.indicators.ALL <- data.frame(psu, resp1, resp2, resp3, resp4,
                                    age, ageGrp1, ageGrp2, ageGrp3, ageGrp4, ageGrp5,
                                    sex1, sex2, marital1, marital2, marital3,
                                    marital4, marital5, marital6,
                                    alone)
  ##
  return(demo.indicators.ALL)
}


################################################################################
#
#' create_op_demo_males
#'
#' Create male older people indicators dataframe for demography and situation
#' from survey data collected using the standard RAM-OP questionnaire
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of male older people indicators on demography and
#'     situation
#'
#' @examples
#'
#' # Create demography and situation indicators dataset from RAM-OP survey data
#' # collected from Addis Ababa, Ethiopia
#' create_op_demo_males(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_demo_males <- function(svy) {
  demo.indicators.MALES <- subset(create_op_demo(svy = svy), sex1 == 1)
  return(demo.indicators.MALES)
}


################################################################################
#
#' create_op_demo_females
#'
#' Create female older people indicators dataframe for demography and situation
#' from survey data collected using the standard RAM-OP questionnaire
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of female older people indicators on demography and
#'     situation
#'
#' @examples
#'
#' # Create demography and situation indicators dataset from RAM-OP survey data
#' # collected from Addis Ababa, Ethiopia
#' create_op_demo_females(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_demo_females <- function(svy) {
  demo.indicators.FEMALES <- subset(create_op_demo(svy = svy), sex2 == 1)
  return(demo.indicators.FEMALES)
}


################################################################################
#
#' create_op_food
#'
#' Create older people indicators for food intake from survey data collected
#' using the standard RAM-OP questionnaire
#'
#' @section Indicators: Dietary intake indicators
#'
#' These dietary intake indicators have been purpose-built for older people but
#' the basic approach used is described in:
#'
#' \cite{Kennedy G, Ballard T, Dop M C (2011). Guidelines for Measuring Household
#' and Individual Dietary Diversity. Rome, FAO
#' \url{http://www.fao.org/docrep/014/i1983e/i1983e00.htm}}
#'
#' and extended to include indicators of probable adequate intake of a number of
#' nutrients / micronutrients.
#'
#' \describe{
#' \item{\code{MF}}{Meal frequenct}
#' \item{\code{DDS}}{Dietary Diversity Score (count of 11 groups)}
#' \item{\code{FG01}}{Cereals}
#' \item{\code{FG02}}{Roots and tubers}
#' \item{\code{FG03}}{Fruits and vegetables}
#' \item{\code{FG04}}{All meat}
#' \item{\code{FG05}}{Eggs}
#' \item{\code{FG06}}{Fish}
#' \item{\code{FG07}}{Legumes, nuts and seeds}
#' \item{\code{FG08}}{Milk and milk products}
#' \item{\code{FG09}}{Fats}
#' \item{\code{FG10}}{Sugar}
#' \item{\code{FG11}}{Other}
#' \item{\code{proteinRich}}{Protein rich foods}
#' \item{\code{pProtein}}{Protein rich plant sources of protein}
#' \item{\code{aProtein}}{Protein rich animal sources of protein}
#' \item{\code{pVitA}}{Plant sources of vitamin A}
#' \item{\code{aVitA}}{Animal sources of vitamin A}
#' \item{\code{xVitA}}{Any source of vitamin A}
#' \item{\code{ironRich}}{Iron rich foods}
#' \item{\code{caRich}}{Calcium rich foods}
#' \item{\code{znRich}}{Zinc rich foods}
#' \item{\code{vitB1}}{Vitamin B1-rich foods}
#' \item{\code{vitB2}}{Vitamin B2-rich foods}
#' \item{\code{vitB3}}{Vitamin B3-rich foods}
#' \item{\code{vitB6}}{Vitamin B6-rich foods}
#' \item{\code{vitB12}}{Vitamin B12-rich foods}
#' \item{\code{vitBcomplex}}{Vitamin B1/B2/B3/B6/B12-rich foods}
#' }
#'
#' @param svy A dataframe collected using the standard RAM-OP questionniare
#'
#' @return A dataframe of older people indicators on food intake
#'
#' @examples
#'
#' # Create food intake indicators dataset from RAM-OP survey data collected
#' # from Addis Ababa, Ethiopia
#' create_op_food(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_food <- function(svy) {
  #
  psu <- svy$psu
  #
  sex1     <- bbw::recode(svy$d3, "1=1; 2=0; else=NA")
  sex2     <- bbw::recode(svy$d3, "1=0; 2=1; else=NA")
  #
  #  Dietary intake indicators
  #
  #  Meal frequency
  #
  MF <- bbw::recode(svy$f1, "9=0; NA=0")
  #
  #  Recode dietary diversity data
  #
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
  #
  #  Dietary diversity
  #
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
  #
  # Sum food groups to 'DDS'
  #
  DDS <- FG01 + FG02 + FG03 + FG04 + FG05 + FG06 + FG07 + FG08 + FG09 + FG10 + FG11
  #
  #  Protein rich foods in diet from aminal, plant, and all sources
  #
  aProtein <- ifelse(svy$f2j == 1 | svy$f2k == 1 | svy$f2q ==1 | svy$f2n == 1 | svy$f2a == 1 | svy$f2m == 1, 1, 0)
  pProtein <- ifelse(svy$f2h == 1 | svy$f2p == 1, 1, 0)
  proteinRich <- ifelse(aProtein == 1 | pProtein == 1, 1, 0)
  #
  #  Micronutrient intake (vitamin A, iron, calcium, zinc)
  #
  pVitA    <- ifelse(svy$f2d == 1 | svy$f2e == 1 | svy$f2f == 1, 1, 0)
  aVitA    <- ifelse(svy$f2a == 1 | svy$f2j == 1 | svy$f2m == 1 | svy$f2n == 1, 1, 0)
  xVitA    <- ifelse(pVitA == 1 | aVitA == 1, 1, 0)
  ironRich <- ifelse(svy$f2f == 1 | svy$f2j == 1 | svy$f2k == 1 | svy$f2l == 1, 1, 0)
  caRich   <- ifelse(svy$f2a == 1 | svy$f2m == 1, 1, 0)
  znRich   <- ifelse(svy$f2h == 1 | svy$f2j == 1 | svy$f2k == 1 | svy$f2l == 1 | svy$f2p == 1 | svy$f2q == 1, 1, 0)
  #
  #  Micronutrient intake (B vitamins)
  #
  vitB1  <- ifelse(svy$f2a == 1 | svy$f2e == 1 | svy$f2h == 1 | svy$f2j == 1 | svy$f2k == 1 | svy$f2l == 1 | svy$f2m == 1 | svy$f2n == 1 | svy$f2p == 1, 1, 0)
  vitB2  <- ifelse(svy$f2a == 1 | svy$f2f == 1 | svy$f2h == 1 | svy$f2j == 1 | svy$f2k == 1 | svy$f2l == 1 | svy$f2m == 1, 1, 0)
  vitB3  <- ifelse(svy$f2h == 1 | svy$f2j == 1 | svy$f2k == 1 | svy$f2l == 1, 1, 0)
  vitB6  <- ifelse(svy$f2d == 1 | svy$f2f == 1 | svy$f2h == 1 | svy$f2i == 1 | svy$f2k == 1 | svy$f2l == 1, 1, 0)
  vitB12 <- ifelse(svy$f2j == 1 | svy$f2k == 1 | svy$f2l == 1 | svy$f2m == 1 | svy$f2n == 1, 1, 0)
  vitBsources <- vitB1 + vitB2 + vitB3 + vitB6 + vitB12
  vitBcomplex <- ifelse(vitBsources == 5, 1, 0)
  ##
  food.indicators.ALL <- data.frame(psu, sex1, sex2, MF, DDS,
                                    FG01, FG02, FG03, FG04, FG05, FG06,
                                    FG07, FG08, FG09, FG10, FG11,
                                    proteinRich, pProtein, aProtein,
                                    pVitA, aVitA, xVitA,
                                    ironRich,
                                    caRich,
                                    znRich,
                                    vitB1, vitB2, vitB3, vitB6, vitB12,
                                    vitBcomplex)
  ##
  return(food.indicators.ALL)
}


################################################################################
#
#' create_op_food_males
#'
#' Create male older people indicators dataframe for food intake
#' from survey data collected using the standard RAM-OP questionnaire
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of male older people indicators on food intake
#'
#' @examples
#'
#' # Create food intake indicators dataset from RAM-OP survey data
#' # collected from Addis Ababa, Ethiopia
#' create_op_food_males(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_food_males <- function(svy) {
  food.indicators.MALES <- subset(create_op_food(svy = svy), sex1 == 1)
  return(food.indicators.MALES)
}


################################################################################
#
#' create_op_food_females
#'
#' Create female older people indicators dataframe for food intake
#' from survey data collected using the standard RAM-OP questionnaire
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of female older people indicators on food intake
#'
#' @examples
#'
#' # Create food intake indicators dataset from RAM-OP survey data
#' # collected from Addis Ababa, Ethiopia
#' create_op_food_females(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_food_females <- function(svy) {
  food.indicators.FEMALES <- subset(create_op_food(svy = svy), sex2 == 1)
  return(food.indicators.FEMALES)
}


################################################################################
#
#' create_op_hunger
#'
#' Create older people indicators for severe food insecurity from survey data
#' collected using the standard RAM-OP questionnaire
#'
#' @section Indicators: Household Hunger Scale (HHS)
#'
#' The HHS is described in:
#'
#' \cite{Ballard T, Coates J, Swindale A, Deitchler M (2011). Household Hunger
#' Scale: Indicator Definition and Measurement Guide. Washington DC,
#' FANTA-2 Bridge, FHI 360
#' \url{https://www.fantaproject.org/monitoring-and-evaluation/household-hunger-scale-hhs}}
#'
#' \describe{
#' \item{\code{HHS1}}{Little or no hunger in household}
#' \item{\code{HHS2}}{Moderate hunger in household}
#' \item{\code{HHS3}}{Severe hunger in household}
#' }
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of older people indicators on housedhold hunger
#'
#' @examples
#' # Create household hunger indicators dataset from RAM-OP survey data
#' # collected from Addis Ababa, Ethiopia
#' create_op_hunger(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_hunger <- function(svy) {
  #
  psu <- svy$psu
  #
  sex1     <- bbw::recode(svy$d3, "1=1; 2=0; else=NA")
  sex2     <- bbw::recode(svy$d3, "1=0; 2=1; else=NA")
  #
  #  Sum components and classify hunger into three separate indicator variables
  #
  sumHHS <- svy$f3 + svy$f4 + svy$f5
  HHS1 <- bbw::recode(sumHHS, "0:1=1; else=0")
  HHS2 <- bbw::recode(sumHHS, "2:3=1; else=0")
  HHS3 <- bbw::recode(sumHHS, "4:6=1; else=0")
  #
  hunger.indicators.ALL <- data.frame(psu, sex1, sex2, HHS1, HHS2, HHS3)
  #
  return(hunger.indicators.ALL)
}


################################################################################
#
#' create_op_hunger_males
#'
#' Create male older people indicators dataframe for household hunger
#' from survey data collected using the standard RAM-OP questionnaire
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of male older people indicators on household hunger
#'
#' @examples
#'
#' # Create household hunger indicators dataset from RAM-OP survey data
#' # collected from Addis Ababa, Ethiopia
#' create_op_hunger_males(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_hunger_males <- function(svy) {
  food.indicators.MALES <- subset(create_op_hunger(svy = svy), sex1 == 1)
  return(food.indicators.MALES)
}


################################################################################
#
#' create_op_hunger_females
#'
#' Create female older people indicators dataframe for household hunger
#' from survey data collected using the standard RAM-OP questionnaire
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of female older people indicators on household hunger
#'
#' @examples
#'
#' # Create household hunger indicators dataset from RAM-OP survey data
#' # collected from Addis Ababa, Ethiopia
#' create_op_hunger_females(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_hunger_females <- function(svy) {
  food.indicators.FEMALES <- subset(create_op_hunger(svy = svy), sex2 == 1)
  return(food.indicators.FEMALES)
}


################################################################################
#
#' create_op_adl
#'
#' Create older people indicators dataframe on acitvities of daily living
#' from survey data collected using the standard RAM-OP questionnaire
#'
#' @section Indicators: Katz "Index of Independence in Activities of Daily Living" (ADL) score
#'
#' The Katz ADL score is described in:
#'
#' \cite{Katz S, Ford AB, Moskowitz RW, Jackson BA, Jaffe MW (1963). Studies
#' of illness in the aged. The Index of ADL: a standardized measure of
#' biological and psychosocial function. JAMA, 1963, 185(12):914-9
#' \url{doi:10.1001/jama.1963.03060120024016}}
#'
#' \cite{Katz S, Down TD, Cash HR, Grotz, RC (1970). Progress in the development
#' of the index of ADL. The Gerontologist, 10(1), 20-30
#' \url{doi:10.1093/geront/10.4_Part_1.274}}
#'
#' \cite{Katz S (1983). Assessing self-maintenance: Activities of daily living,
#' mobility and instrumental activities of daily living. JAGS, 31(12),
#' 721-726 \url{doi:10.1111/j.1532-5415.1983.tb03391.x}}
#'
#' \describe{
#' \item{\code{ADL01}}{Bathing}
#' \item{\code{ADL02}}{Dressing}
#' \item{\code{ADL03}}{Toileting}
#' \item{\code{ADL04}}{Transferring (mobility)}
#' \item{\code{ADL05}}{Continence}
#' \item{\code{ADL06}}{Feeding}
#' \item{\code{scoreADL}}{ADL Score}
#' \item{\code{classADL1}}{Severity of dependence 1}
#' \item{\code{classADL2}}{Severity of dependence 2}
#' \item{\code{classADL3}}{Severity of dependence 3}
#' \item{\code{hasHelp}}{Have someone to help with everyday activities}
#' \item{\code{unmetNeed}}{Need help but has no helper}
#' }
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of older people indicators on activities of daily living
#'
#' @examples
#'
#' # Create activities of daily living indicators dataset from RAM-OP survey
#' # data collected from Addis Ababa, Ethiopia
#' create_op_adl(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_adl <- function(svy) {
  #
  psu <- svy$psu
  #
  sex1     <- bbw::recode(svy$d3, "1=1; 2=0; else=NA")
  sex2     <- bbw::recode(svy$d3, "1=0; 2=1; else=NA")
  #
  #  Katz "Index of Independence in Activities of Daily Living" (ADL) score
  #
  #  Recode ADL (activities of daily living) score data
  #
  ADL01 <- bbw::recode(svy$a1, "2=1; else=0")    # Bathing
  ADL02 <- bbw::recode(svy$a2, "2=1; else=0")    # Dressing
  ADL03 <- bbw::recode(svy$a3, "2=1; else=0")    # Toileting
  ADL04 <- bbw::recode(svy$a4, "2=1; else=0")    # Transferring (mobility)
  ADL05 <- bbw::recode(svy$a5, "2=1; else=0")    # Continence
  ADL06 <- bbw::recode(svy$a6, "2=1; else=0")    # Feeding
  #
  #  Create ADL score (items summed over all six activities / dimensions)
  #
  scoreADL <- ADL01 + ADL02 + ADL03 + ADL04 + ADL05 + ADL06
  #
  #  Severity of dependence (from Katz ADL score)
  #
  classADL1 <- bbw::recode(scoreADL, "5:6=1; else=0")
  classADL2 <- bbw::recode(scoreADL, "3:4=1; else=0")
  classADL3 <- bbw::recode(scoreADL, "0:2=1; else=0")
  #
  #  Does the subject have someone to help with everyday activities?
  #
  hasHelp <- bbw::recode(svy$a7, "1=1; else=0")
  #
  #  Does the subject need help but has no helper?
  #
  #  Note : Denominator is entire sample so the indicator is the proportion of
  #         the population with unmet ADl help needs
  #
  unmetNeed <- ifelse(scoreADL < 6 & hasHelp == 0, 1, 0)
  #
  adl.indicators.ALL <- data.frame(psu, sex1, sex2,
                                          ADL01, ADL02, ADL03, ADL04, ADL05, ADL06, scoreADL,
                                          classADL1, classADL2, classADL3, hasHelp, unmetNeed)
  #
  return(adl.indicators.ALL)
}

################################################################################
#
#' create_op_adl_males
#'
#' Create male older people indicators dataframe for activities of daily
#' living from survey data collected using the standard RAM-OP questionnaire
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of male older people indicators on activities of daily
#'     living
#'
#' @examples
#'
#' # Create activities of daily living indicators dataset from RAM-OP survey
#' # data collected from Addis Ababa, Ethiopia
#' create_op_adl_males(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_adl_males <- function(svy) {
  adl.indicators.MALES <- subset(create_op_adl(svy = svy), sex1 == 1)
  return(adl.indicators.MALES)
}


################################################################################
#
#' create_op_adl_females
#'
#' Create female older people indicators dataframe for activities of daily
#' living from survey data collected using the standard RAM-OP questionnaire
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of female older people indicators on activities of daily
#'     living
#'
#' @examples
#'
#' # Create activities of daily living indicators dataset from RAM-OP survey
#' # data collected from Addis Ababa, Ethiopia
#' create_op_adl_females(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_adl_females <- function(svy) {
  adl.indicators.FEMALES <- subset(create_op_adl(svy = svy), sex2 == 1)
  return(adl.indicators.FEMALES)
}


################################################################################
#
#' create_op_disability
#'
#' Create older people indicators dataframe on disability from survey data
#' collected using the standard RAM-OP questionnaire
#'
#' @section Indicators: Washington Group on Disability
#'
#' See:
#'
#'   \url{http://www.washingtongroup-disability.com}
#'   \url{https://www.cdc.gov/nchs/washington_group/wg_documents.htm}
#'
#' for details.
#'
#' \describe{
#' \item{\code{wgVisionD0}}{Vision domain 0}
#' \item{\code{wgVisionD1}}{Vision domain 1}
#' \item{\code{wgVisionD2}}{Vision domain 2}
#' \item{\code{wgVisionD3}}{Vision domain 3}
#' \item{\code{wgHearingD0}}{Hearing domain 0}
#' \item{\code{wgHearingD1}}{Hearing domain 1}
#' \item{\code{wgHearingD2}}{Hearing domain 2}
#' \item{\code{wgHearingD3}}{Hearing domain 3}
#' \item{\code{wgMobilityD0}}{Mobility domain 0}
#' \item{\code{wgMobilityD1}}{Mobility domain 1}
#' \item{\code{wgMobilityD2}}{Mobility domain 2}
#' \item{\code{wgMobilityD3}}{Mobility domain 3}
#' \item{\code{wgRememberingD0}}{Remembering domain 0}
#' \item{\code{wgRememberingD1}}{Remembering domain 1}
#' \item{\code{wgRememberingD2}}{Remembering domain 2}
#' \item{\code{wgRememberingD3}}{Remembering domain 3}
#' \item{\code{wgSelfCareD0}}{Self-care domain 0}
#' \item{\code{wgSelfCareD1}}{Self-care domain 1}
#' \item{\code{wgSelfCareD2}}{Self-care domain 2}
#' \item{\code{wgSelfCareD3}}{Self-care domain 3}
#' \item{\code{wgCommunicatingD0}}{Communication domain 0}
#' \item{\code{wgCommunicatingD1}}{Communication domain 1}
#' \item{\code{wgCommunicatingD2}}{Communication domain 2}
#' \item{\code{wgCommunicatingD3}}{Communication domain 3}
#' \item{\code{wgP0}}{Overall 0}
#' \item{\code{wgP1}}{Overall 1}
#' \item{\code{wgP2}}{Overall 2}
#' \item{\code{wgP3}}{Overall 3}
#' \item{\code{wgPM}}{Any disability}
#' }
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of older people indicators on disability
#'
#' @examples
#'
#' # Create disability indicators dataset from RAM-OP survey data
#' # collected from Addis Ababa, Ethiopia
#' create_op_disability(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_disability <- function(svy) {
  #
  psu <- svy$psu
  #
  sex1     <- bbw::recode(svy$d3, "1=1; 2=0; else=NA")
  sex2     <- bbw::recode(svy$d3, "1=0; 2=1; else=NA")
  ##############################################################################
  #
  #  Washington Group (WG) short set of question designed to identify people with a
  #  disability in a census or survey format.
  #
  # Missing values
  #
  svy$wg1 <- bbw::recode(svy$wg1, "9=0; NA=0")
  svy$wg2 <- bbw::recode(svy$wg2, "9=0; NA=0")
  svy$wg3 <- bbw::recode(svy$wg3, "9=0; NA=0")
  svy$wg4 <- bbw::recode(svy$wg4, "9=0; NA=0")
  svy$wg5 <- bbw::recode(svy$wg5, "9=0; NA=0")
  svy$wg6 <- bbw::recode(svy$wg6, "9=0; NA=0")
  #
  ##############################################################################
  #
  # Vision domain
  #
  wgVisionD0 <- ifelse(svy$wg1 == 0, 1, 0)
  wgVisionD1 <- ifelse(svy$wg1 == 1 | svy$wg1 == 2 | svy$wg1 == 3, 1, 0)
  wgVisionD2 <- ifelse(svy$wg1 == 2 | svy$wg1 == 3, 1, 0)
  wgVisionD3 <- ifelse(svy$wg1 == 3, 1, 0)
  #
  ##############################################################################
  #
  # Hearing domain
  #
  wgHearingD0 <- ifelse(svy$wg2 == 0, 1, 0)
  wgHearingD1 <- ifelse(svy$wg2 == 1 | svy$wg2 == 2 | svy$wg2 == 3, 1, 0)
  wgHearingD2 <- ifelse(svy$wg2 == 2 | svy$wg2 == 3, 1, 0)
  wgHearingD3 <- ifelse(svy$wg2 == 3, 1, 0)
  #
  ##############################################################################
  #
  # Mobility domain
  #
  wgMobilityD0 <- ifelse(svy$wg3 == 0, 1, 0)
  wgMobilityD1 <- ifelse(svy$wg3 == 1 | svy$wg3 == 2 | svy$wg3 == 3, 1, 0)
  wgMobilityD2 <- ifelse(svy$wg3 == 2 | svy$wg3 == 3, 1, 0)
  wgMobilityD3 <- ifelse(svy$wg3 == 3, 1, 0)
  #
  ##############################################################################
  #
  # Remembering domain
  #
  wgRememberingD0 <- ifelse(svy$wg4 == 0, 1, 0)
  wgRememberingD1 <- ifelse(svy$wg4 == 1 | svy$wg4 == 2 | svy$wg4 == 3, 1, 0)
  wgRememberingD2 <- ifelse(svy$wg4 == 2 | svy$wg4 == 3, 1, 0)
  wgRememberingD3 <- ifelse(svy$wg4 == 3, 1, 0)
  #
  ##############################################################################
  #
  # Self-care domain
  #
  wgSelfCareD0 <- ifelse(svy$wg5 == 0, 1, 0)
  wgSelfCareD1 <- ifelse(svy$wg5 == 1 | svy$wg5 == 2 | svy$wg5 == 3, 1, 0)
  wgSelfCareD2 <- ifelse(svy$wg5 == 2 | svy$wg5 == 3, 1, 0)
  wgSelfCareD3 <- ifelse(svy$wg5 == 3, 1, 0)
  #
  ##############################################################################
  #
  # Communicating domain
  #
  wgCommunicatingD0 <- ifelse(svy$wg6 == 0, 1, 0)
  wgCommunicatingD1 <- ifelse(svy$wg6 == 1 | svy$wg6 == 2 | svy$wg6 == 3, 1, 0)
  wgCommunicatingD2 <- ifelse(svy$wg6 == 2 | svy$wg6 == 3, 1, 0)
  wgCommunicatingD3 <- ifelse(svy$wg6 == 3, 1, 0)
  #
  ##############################################################################
  #
  # Overall prevalence
  #
  wgP0 <- ifelse(wgVisionD0 + wgHearingD0 + wgMobilityD0 + wgRememberingD0 + wgSelfCareD0 + wgCommunicatingD0 == 6, 1, 0)
  wgP1 <- ifelse(wgVisionD1 + wgHearingD1 + wgMobilityD1 + wgRememberingD1 + wgSelfCareD1 + wgCommunicatingD1 >  0, 1, 0)
  wgP2 <- ifelse(wgVisionD2 + wgHearingD2 + wgMobilityD2 + wgRememberingD2 + wgSelfCareD2 + wgCommunicatingD2 >  0, 1, 0)
  wgP3 <- ifelse(wgVisionD3 + wgHearingD3 + wgMobilityD3 + wgRememberingD3 + wgSelfCareD3 + wgCommunicatingD3 >  0, 1, 0)
  wgPM <- ifelse(wgVisionD1 + wgHearingD1 + wgMobilityD1 + wgRememberingD1 + wgSelfCareD1 + wgCommunicatingD1 >  1, 1, 0)
  #
  disability.indicators.ALL <- data.frame(psu, sex1, sex2,
                                          wgVisionD0, wgVisionD1, wgVisionD2,
                                          wgVisionD3, wgHearingD0, wgHearingD1,
                                          wgHearingD2, wgHearingD3,wgMobilityD0,
                                          wgMobilityD1, wgMobilityD2, wgMobilityD3,
                                          wgRememberingD0, wgRememberingD1,
                                          wgRememberingD2, wgRememberingD3,
                                          wgSelfCareD0, wgSelfCareD1,
                                          wgSelfCareD2, wgSelfCareD3,
                                          wgCommunicatingD0, wgCommunicatingD1,
                                          wgCommunicatingD2, wgCommunicatingD3,
                                          wgP0, wgP1, wgP2, wgP3, wgPM)
  #
  return(disability.indicators.ALL)
}


################################################################################
#
#' create_op_disability_males
#'
#' Create male older people indicators dataframe for disability from survey
#' data collected using the standard RAM-OP questionnaire
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of male older people indicators on disability
#'
#' @examples
#'
#' # Create disability indicators dataset from RAM-OP survey data collected
#' # from Addis Ababa, Ethiopia
#' create_op_disability_males(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_disability_males <- function(svy) {
  disability.indicators.MALES <- subset(create_op_disability(svy = svy), sex1 == 1)
  return(disability.indicators.MALES)
}


################################################################################
#
#' create_op_disability_females
#'
#' Create female older people indicators dataframe for disability from survey
#' data collected using the standard RAM-OP questionnaire
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of female older people indicators on disability
#'
#' @examples
#'
#' # Create disability indicators dataset from RAM-OP survey data collected
#' # from Addis Ababa, Ethiopia
#' create_op_disability_females(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_disability_females <- function(svy) {
  disability.indicators.FEMALES <- subset(create_op_disability(svy = svy), sex2 == 1)
  return(disability.indicators.FEMALES)
}


################################################################################
#
#' create_op_mental
#'
#' Create older people indicators dataframe for mental health from survey data
#' collected using the standard RAM-OP questionnaire.
#'
#' @section Indicators: K6 Short form psychological distress score
#'
#' The K6 score is described in:
#'
#' \cite{Kessler RC, Andrews G, Colpe LJ, Hiripi E, Mroczek, DK, Normand SLT,
#' et al. (2002). Short screening scales to monitor population prevalences
#' and trends in non-specific psychological distress. Psychological
#' Medicine, 32(6), 959–976 \url{doi:10.1017/S0033291702006074}}
#'
#' \describe{
#' \item{\code{K6}}{K6 score}
#' \item{\code{K6Case}}{K6 score > 12  (in serious psychological distress)}
#' }
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of older people indicators on mental health
#'
#' @examples
#'
#' # Create mental health indicators dataset from RAM-OP survey data
#' # collected from Addis Ababa, Ethiopia
#' create_op_mental(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_mental <- function(svy) {
  #
  psu <- svy$psu
  #
  sex1     <- bbw::recode(svy$d3, "1=1; 2=0; else=NA")
  sex2     <- bbw::recode(svy$d3, "1=0; 2=1; else=NA")
  #
  #  K6 : Short form psychological distress score
  #
  #  Recode DON'T KNOW, REFUSED, NA and MISSING values to 5 (NONE)
  #
  svy$k6a <- bbw::recode(svy$k6a, "6:9=5")
  svy$k6b <- bbw::recode(svy$k6b, "6:9=5")
  svy$k6c <- bbw::recode(svy$k6c, "6:9=5")
  svy$k6d <- bbw::recode(svy$k6d, "6:9=5")
  svy$k6e <- bbw::recode(svy$k6e, "6:9=5")
  svy$k6f <- bbw::recode(svy$k6f, "6:9=5")
  #
  #  Reverse coding & create K6 score (i.e. as the sum of individual item scores)
  #
  svy$k6a <- 5 - svy$k6a
  svy$k6b <- 5 - svy$k6b
  svy$k6c <- 5 - svy$k6d
  svy$k6d <- 5 - svy$k6d
  svy$k6e <- 5 - svy$k6e
  svy$k6f <- 5 - svy$k6f
  K6 <- svy$k6a + svy$k6b + svy$k6c + svy$k6d + svy$k6e + svy$k6f
  #
  #  Apply case-definition for serious psychological distress(i.e. K6 > 12)
  #
  K6Case <- bbw::recode(K6, "0:12=0; 13:hi=1")
  #
  mental.indicators.ALL <- data.frame(psu, sex1, sex2, K6, K6Case)
  #
  return(mental.indicators.ALL)
}


################################################################################
#
#' create_op_mental_males
#'
#' Create male older people indicators dataframe for mental health from survey
#' data collected using the standard RAM-OP questionnaire
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of male older people indicators on mental health
#'
#' @examples
#'
#' # Create mental health indicators dataset from RAM-OP survey data collected
#' # from Addis Ababa, Ethiopia
#' create_op_mental_males(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_mental_males <- function(svy) {
  mental.indicators.MALES <- subset(create_op_mental(svy = svy), sex1 == 1)
  return(mental.indicators.MALES)
}


################################################################################
#
#' create_op_mental_females
#'
#' Create female older people indicators dataframe for mental health from survey
#' data collected using the standard RAM-OP questionnaire
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of female older people indicators on mental health
#'
#' @examples
#'
#' # Create mental health indicators dataset from RAM-OP survey data collected
#' # from Addis Ababa, Ethiopia
#' create_op_mental_females(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_mental_females <- function(svy) {
  mental.indicators.FEMALES <- subset(create_op_mental(svy = svy), sex2 == 1)
  return(mental.indicators.FEMALES)
}


################################################################################
#
#' create_op_dementia
#'
#' Create older people indicators dataframe for dementia from survey data
#' collected using the standard RAM-OP questionnaire.
#'
#' @section Indicators: Brief Community Screening Instrument for Dementia (CSID)
#'
#' The CSID dementia screening tool is described in:
#'
#' \cite{Prince M, et al. (2010). A brief dementia screener suitable for use
#' by non-specialists in resource poor settings - The cross-cultural
#' derivation and validation of the brief Community Screening Instrument
#' for Dementia. International Journal of Geriatric Psychiatry, 26(9),
#' 899–907 \url{doi:10.1002/gps.2622}}
#'
#' \describe{
#' \item{\code{DS}}{Probable dementia by CSID screen}
#' }
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of older people indicators on dementia
#'
#' @examples
#'
#' # Create dementia indicators dataset from RAM-OP survey data
#' # collected from Addis Ababa, Ethiopia
#' create_op_dementia(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_dementia <- function(svy) {
  #
  psu <- svy$psu
  #
  sex1     <- bbw::recode(svy$d3, "1=1; 2=0; else=NA")
  sex2     <- bbw::recode(svy$d3, "1=0; 2=1; else=NA")
  #
  #  Recode scored components to 0 / 1 (with 1 = correct)
  #
  svy$ds1  <- bbw::recode(svy$ds1,  "1=1; else=0") # Nose
  svy$ds2  <- bbw::recode(svy$ds2,  "1=1; else=0") # Hammer
  svy$ds3  <- bbw::recode(svy$ds3,  "1=1; else=0") # Day of week
  svy$ds4  <- bbw::recode(svy$ds4,  "1=1; else=0") # Season
  svy$ds5  <- bbw::recode(svy$ds5,  "1=1; else=0") # Point to window then door
  svy$ds6a <- bbw::recode(svy$ds6a, "1=1; else=0") # Memory "CHILD"
  svy$ds6b <- bbw::recode(svy$ds6b, "1=1; else=0") # Memory "HOUSE"
  svy$ds6c <- bbw::recode(svy$ds6c, "1=1; else=0") # Memory "ROAD"
  #
  #  Sum correct items into CSID score
  #
  scoreCSID <- svy$ds1 + svy$ds2 + svy$ds3 + svy$ds4 + svy$ds5 + svy$ds6a + svy$ds6b + svy$ds6c
  #
  #  Classify dementia :
  #
  DS <- bbw::recode(scoreCSID, "0:4=1; 5:8=0")
  #
  dementia.indicators.ALL <- data.frame(psu, sex1, sex2, DS)
  #
  return(dementia.indicators.ALL)
}


################################################################################
#
#' create_op_dementia_males
#'
#' Create male older people indicators dataframe for dementia from survey
#' data collected using the standard RAM-OP questionnaire
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of male older people indicators on dementia
#'
#' @examples
#'
#' # Create dementia indicators dataset from RAM-OP survey data collected
#' # from Addis Ababa, Ethiopia
#' create_op_dementia_males(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_dementia_males <- function(svy) {
  dementia.indicators.MALES <- subset(create_op_dementia(svy = svy), sex1 == 1)
  return(dementia.indicators.MALES)
}


################################################################################
#
#' create_op_dementia_females
#'
#' Create female older people indicators dataframe for dementia from survey
#' data collected using the standard RAM-OP questionnaire
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of female older people indicators on dementia
#'
#' @examples
#'
#' # Create dementia indicators dataset from RAM-OP survey data collected
#' # from Addis Ababa, Ethiopia
#' create_op_dementia_females(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_dementia_females <- function(svy) {
  dementia.indicators.FEMALES <- subset(create_op_dementia(svy = svy), sex2 == 1)
  return(dementia.indicators.FEMALES)
}


################################################################################
#
#' create_op_health
#'
#' Create older people indicators dataframe for health and health-seeking
#' behaviours from survey data collected using the standard RAM-OP questionnaire.
#'
#' @section Indicators: Health and health-seeking indicators
#'
#' \describe{
#' \item{\code{H1}}{Chronic condition}
#' \item{\code{H2}}{Takes drugs regularly for chronic condition}
#' \item{\code{H31}}{No drugs available}
#' \item{\code{H32}}{Too expensive / no money}
#' \item{\code{H33}}{Too old to look for care}
#' \item{\code{H34}}{Use traditional medicine}
#' \item{\code{H35}}{Drugs don't help}
#' \item{\code{H36}}{No-one to help me}
#' \item{\code{H37}}{No need}
#' \item{\code{H38}}{Other}
#' \item{\code{H39}}{No reason given}
#' \item{\code{H4}}{Recent disease episode}
#' \item{\code{H5}}{Accessed care for recent disease episode}
#' \item{\code{H61}}{No drugs available}
#' \item{\code{H62}}{Too expensive / no money}
#' \item{\code{H63}}{Too old to look for care}
#' \item{\code{H64}}{Use traditional medicine}
#' \item{\code{H65}}{Drugs don't help}
#' \item{\code{H66}}{No-one to help me}
#' \item{\code{H67}}{No need}
#' \item{\code{H68}}{Other}
#' \item{\code{H69}}{No reason given}
#' }
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of older people indicators on health and health-seeking
#'     behaviour
#'
#' @examples
#'
#' # Create health and health-seeking behaviour indicators dataset from RAM-OP
#' # survey data collected from Addis Ababa, Ethiopia
#' create_op_health(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_health <- function(svy) {
  #
  psu <- svy$psu
  #
  sex1     <- bbw::recode(svy$d3, "1=1; 2=0; else=NA")
  sex2     <- bbw::recode(svy$d3, "1=0; 2=1; else=NA")
  #
  #  Health indicators : CHRONIC CONDITIONS
  #
  svy$h1 <- bbw::recode(svy$h1, "1=1; else=2")
  H1 <- bbw::recode(svy$h1, "1=1; else=0")
  H2 <- ifelse(H1 == 0, NA, bbw::recode(svy$h2, "1=1; else=0"))
  H3 <- ifelse(H2 == 1, NA, bbw::recode(svy$h3, "NA=9"))
  #
  # Indicators for main reason for NOT taking drugs for chronic condition
  #
  H31 <- bbw::recode(H3, "1=1; NA=NA; else=0")
  H32 <- bbw::recode(H3, "2=1; NA=NA; else=0")
  H33 <- bbw::recode(H3, "3=1; NA=NA; else=0")
  H34 <- bbw::recode(H3, "4=1; NA=NA; else=0")
  H35 <- bbw::recode(H3, "5=1; NA=NA; else=0")
  H36 <- bbw::recode(H3, "6=1; NA=NA; else=0")
  H37 <- bbw::recode(H3, "7=1; NA=NA; else=0")
  H38 <- bbw::recode(H3, "8=1; NA=NA; else=0")
  H39 <- bbw::recode(H3, "9=1; NA=NA; else=0")
  #
  ##############################################################################
  #
  #  Health indicators : RECENT DISEASE EPISODE
  #
  svy$h4 <- bbw::recode(svy$h4, "1=1; else=2")
  H4 <- bbw::recode(svy$h4, "1=1; else=0")
  H5 <- ifelse(H4 == 0, NA, bbw::recode(svy$h5, "1=1; else=0"))
  H6 <- ifelse(H5 == 1, NA, bbw::recode(svy$h6, "NA=9"))
  #
  # Indicators for main reason for NOT accessing care for recent disease episode
  #
  H61 <- bbw::recode(H6, "1=1; NA=NA; else=0")
  H62 <- bbw::recode(H6, "2=1; NA=NA; else=0")
  H63 <- bbw::recode(H6, "3=1; NA=NA; else=0")
  H64 <- bbw::recode(H6, "4=1; NA=NA; else=0")
  H65 <- bbw::recode(H6, "5=1; NA=NA; else=0")
  H66 <- bbw::recode(H6, "6=1; NA=NA; else=0")
  H67 <- bbw::recode(H6, "7=1; NA=NA; else=0")
  H68 <- bbw::recode(H6, "8=1; NA=NA; else=0")
  H69 <- bbw::recode(H6, "9=1; NA=NA; else=0")
  #
  health.indicators.ALL <- data.frame(psu, sex1, sex2,
                                      H1, H2, H31, H32, H33, H34, H35, H36, H37,
                                      H38, H39, H4, H5, H61, H62, H63, H64, H65,
                                      H66, H67, H68, H69)
  #
  return(health.indicators.ALL)
}


################################################################################
#
#' create_op_health_males
#'
#' Create male older people indicators dataframe for health and health-seeking
#' behaviours from survey data collected using the standard RAM-OP questionnaire
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of male older people indicators on health and
#'     health-seeking behaviours
#'
#' @examples
#'
#' # Create health and health-seeking behaviours indicators dataset from RAM-OP
#' # survey data collected from Addis Ababa, Ethiopia
#' create_op_health_males(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_health_males <- function(svy) {
  health.indicators.MALES <- subset(create_op_health(svy = svy), sex1 == 1)
  return(health.indicators.MALES)
}


################################################################################
#
#' create_op_health_females
#'
#' Create female older people indicators dataframe for health and health-seeking
#' behaviours from survey data collected using the standard RAM-OP questionnaire
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of female older people indicators on health and
#'     health-seeking behaviours
#'
#' @examples
#'
#' # Create health and health-seeking behaviours indicators dataset from RAM-OP
#' # survey data collected from Addis Ababa, Ethiopia
#' create_op_health_females(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_health_females <- function(svy) {
  health.indicators.FEMALES <- subset(create_op_health(svy = svy), sex2 == 1)
  return(health.indicators.FEMALES)
}


################################################################################
#
#' create_op_income
#'
#' Create older people indicators dataframe for income from survey data collected
#' using the standard RAM-OP questionnaire.
#'
#' @section Indicators: Income and income sources
#'
#' \describe{
#' \item{\code{M1}}{Has a personal income}
#' \item{\code{M2A}}{Agriculture / fishing / livestock}
#' \item{\code{M2B}}{Wages / salary}
#' \item{\code{M2C}}{Sale of charcoal / bricks / &c.}
#' \item{\code{M2D}}{Trading (e.g. market or shop)}
#' \item{\code{M2E}}{Investments}
#' \item{\code{M2F}}{Spending savings / sale of assets}
#' \item{\code{M2G}}{Charity}
#' \item{\code{M2H}}{Cash transfer / Social security}
#' \item{\code{M2I}}{Other}
#' }
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of older people indicators on income
#'
#' @examples
#'
#' # Create income indicators dataset from RAM-OP survey data collected from
#' # Addis Ababa, Ethiopia
#' create_op_income(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_income <- function(svy) {
  #
  psu <- svy$psu
  #
  sex1     <- bbw::recode(svy$d3, "1=1; 2=0; else=NA")
  sex2     <- bbw::recode(svy$d3, "1=0; 2=1; else=NA")
  #
  #  Income and income sources
  #
  #  Create binary indicators
  #
  M1  <- bbw::recode(svy$m1,  "1=1; else=0") # Has a personal income
  M2A <- bbw::recode(svy$m2a, "1=1; else=0") # Agriculture / fishing / livestock
  M2B <- bbw::recode(svy$m2b, "1=1; else=0") # Wages / salary
  M2C <- bbw::recode(svy$m2c, "1=1; else=0") # Sale of charcoal / bricks / &c.
  M2D <- bbw::recode(svy$m2d, "1=1; else=0") # Trading (e.g. market or shop)
  M2E <- bbw::recode(svy$m2e, "1=1; else=0") # Investments
  M2F <- bbw::recode(svy$m2f, "1=1; else=0") # Spending savings / sale of assets
  M2G <- bbw::recode(svy$m2g, "1=1; else=0") # Charity
  M2H <- bbw::recode(svy$m2h, "1=1; else=0") # Cash transfer / social security
  M2I <- bbw::recode(svy$m2i, "1=1; else=0") # Other
  #
  ##############################################################################
  #
  #  Check for any income (return 'correct' result in M1)
  #
  checkForIncome <- M1 + M2A + M2B + M2C + M2D + M2E + M2F + M2G + M2H + M2I
  M1 <- ifelse(checkForIncome > 0, 1, 0)
  #
  income.indicators.ALL <- data.frame(psu, sex1, sex2,M1, M2A, M2B, M2C, M2D,
                                      M2E, M2F, M2G, M2H, M2I)
  #
  return(income.indicators.ALL)
}


################################################################################
#
#' create_op_income_males
#'
#' Create male older people indicators dataframe for income from survey data
#' collected using the standard RAM-OP questionnaire
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of male older people indicators on income
#'
#' @examples
#'
#' # Create income indicators dataset from RAM-OP survey data collected from
#' # Addis Ababa, Ethiopia
#' create_op_income_males(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_income_males <- function(svy) {
  income.indicators.MALES <- subset(create_op_income(svy = svy), sex1 == 1)
  return(income.indicators.MALES)
}


################################################################################
#
#' create_op_income_females
#'
#' Create female older people indicators dataframe for income from survey data
#' collected using the standard RAM-OP questionnaire
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of female older people indicators on income
#'
#' @examples
#'
#' # Create income indicators dataset from RAM-OP survey data collected from
#' # Addis Ababa, Ethiopia
#' create_op_income_females(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_income_females <- function(svy) {
  income.indicators.FEMALES <- subset(create_op_income(svy = svy), sex2 == 1)
  return(income.indicators.FEMALES)
}


################################################################################
#
#' create_op_wash
#'
#' Create older people indicators dataframe for water, sanitation and hygiene
#' from survey data collected using the standard RAM-OP questionnaire.
#'
#' @section Indicators: Water, sanitation and hygiene (WASH) indicators
#'
#' These are a (core) subset of indicators from:
#'
#' \cite{WHO / UNICEF (2006). Core Questions on Drinking-water and Sanitation
#' for Household Surveys. Geneva, WHO / UNICEF
#' \url{http://www.who.int/water_sanitation_health/monitoring/household_surveys/en/}}
#'
#' \describe{
#' \item{\code{W1}}{Improved source of drinking water}
#' \item{\code{W2}}{Safe drinking water (improved source OR adequate treatment)}
#' \item{\code{W3}}{Improved sanitation facility}
#' \item{\code{W4}}{Improved non-shared sanitation facility}
#' }
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of older people indicators on water, sanitation and
#'     hygiene
#'
#' @examples
#'
#' # Create water, sanitation and hygiene indicators dataset from RAM-OP survey
#' # data collected from Addis Ababa, Ethiopia
#' create_op_wash(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_wash <- function(svy) {
  #
  psu <- svy$psu
  #
  sex1     <- bbw::recode(svy$d3, "1=1; 2=0; else=NA")
  sex2     <- bbw::recode(svy$d3, "1=0; 2=1; else=NA")
  #
  ##############################################################################
  #
  #  Water, Sanitation, and Hygiene (WASH) indicators
  #
  #  Recode WASH data
  #
  svy$w1 <- bbw::recode(svy$w1, "1=1; else=0")
  svy$w2 <- bbw::recode(svy$w2, "1=1; else=0")
  svy$w3 <- bbw::recode(svy$w3, "1=1; else=0")
  svy$w4 <- bbw::recode(svy$w4, "1=1; else=0")
  #
  ##############################################################################
  #
  #  Create WASH indicators
  #
  W1 <- svy$w1
  W2 <- ifelse(svy$w1 == 1 | svy$w2 == 1, 1, 0)
  W3 <- svy$w3
  W4 <- ifelse(svy$w3 == 1 & svy$w4 != 1, 1, 0)
  #
  wash.indicators.ALL <- data.frame(psu, sex1, sex2, W1, W2, W3, W4)
  #
  return(wash.indicators.ALL)
}


################################################################################
#
#' create_op_wash_males
#'
#' Create male older people indicators dataframe for water, sanitation and
#' hygiene from survey data collected using the standard RAM-OP questionnaire
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of male older people indicators on water, sanitation and
#'     hygiene
#'
#' @examples
#'
#' # Create water, sanitation and hygiene indicators dataset from RAM-OP survey
#' # data collected from Addis Ababa, Ethiopia
#' create_op_wash_males(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_wash_males <- function(svy) {
  wash.indicators.MALES <- subset(create_op_wash(svy = svy), sex1 == 1)
  return(wash.indicators.MALES)
}


################################################################################
#
#' create_op_wash_females
#'
#' Create female older people indicators dataframe for water, sanitation and
#' hygiene from survey data collected using the standard RAM-OP questionnaire
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of female older people indicators on water, sanitation
#'     and hygiene
#'
#' @examples
#'
#' # Create water, sanitation and hygiene indicators dataset from RAM-OP survey
#' # data collected from Addis Ababa, Ethiopia
#' create_op_wash_females(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_wash_females <- function(svy) {
  wash.indicators.FEMALES <- subset(create_op_wash(svy = svy), sex2 == 1)
  return(wash.indicators.FEMALES)
}


################################################################################
#
#' create_op_anthro
#'
#' Create older people indicators dataframe for anthropometry from survey data
#' collected using the standard RAM-OP questionnaire.
#'
#' @section Indicators: Anthropometry and screening
#'
#' \describe{
#' \item{\code{MUAC}}{Mid-upper arm circumference (mm)}
#' }
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of older people indicators on anthropometry
#'
#' @examples
#'
#' # Create anthropometry indicators dataset from RAM-OP survey data collected
#' # from Addis Ababa, Ethiopia
#' create_op_anthro(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_anthro <- function(svy) {
  #
  psu <- svy$psu
  #
  sex1     <- bbw::recode(svy$d3, "1=1; 2=0; else=NA")
  sex2     <- bbw::recode(svy$d3, "1=0; 2=1; else=NA")
  #
  ##############################################################################
  #
  #  Anthropometry and screening
  #
  #  Censor REFUSAL, NOT APPLICABLE, and MISSING values codes in MUAC and Oedema
  #
  MUAC <- bbw::recode(svy$as1, "777=NA; 888=NA; 999=NA")
  #
  anthro.indicators.ALL <- data.frame(psu, sex1, sex2, MUAC)
  #
  return(anthro.indicators.ALL)
}


################################################################################
#
#' create_op_anthro_males
#'
#' Create male older people indicators dataframe for anthropometry from survey
#' data collected using the standard RAM-OP questionnaire
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of male older people indicators on anthropometry
#'
#' @examples
#'
#' # Create anthropometry indicators dataset from RAM-OP survey data collected
#' # from Addis Ababa, Ethiopia
#' create_op_anthro_males(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_anthro_males <- function(svy) {
  anthro.indicators.MALES <- subset(create_op_anthro(svy = svy), sex1 == 1)
  return(anthro.indicators.MALES)
}


################################################################################
#
#' create_op_anthro_females
#'
#' Create female older people indicators dataframe for anthropometry from survey
#' data collected using the standard RAM-OP questionnaire
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of female older people indicators on anthropometry
#'
#' @examples
#'
#' # Create anthropometry indicators dataset from RAM-OP survey data collected
#' # from Addis Ababa, Ethiopia
#' create_op_anthro_females(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_anthro_females <- function(svy) {
  anthro.indicators.FEMALES <- subset(create_op_anthro(svy = svy), sex2 == 1)
  return(anthro.indicators.FEMALES)
}


################################################################################
#
#' create_op_oedema
#'
#' Create older people indicators dataframe for oedema prevalence from survey
#' data collected using the standard RAM-OP questionnaire.
#'
#' @section Indicators: Oedema prevalence
#'
#' \describe{
#' \item{\code{oedema}}{Bilateral pitting oedema (may not be nutritional)}
#' }
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of older people indicators on oedema prevalence
#'
#' @examples
#'
#' # Create oedema prevalence indicators dataset from RAM-OP survey data
#' # collected from Addis Ababa, Ethiopia
#' create_op_oedema(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_oedema <- function(svy) {
  #
  psu <- svy$psu
  #
  sex1     <- bbw::recode(svy$d3, "1=1; 2=0; else=NA")
  sex2     <- bbw::recode(svy$d3, "1=0; 2=1; else=NA")
  #
  ##############################################################################
  #
  #  Screening
  #
  #  Censor REFUSAL, NOT APPLICABLE, and MISSING values codes in MUAC and Oedema
  #
  oedema <- bbw::recode(svy$as3, "1=1; else=0")
  #
  oedema.indicators.ALL <- data.frame(psu, sex1, sex2, oedema)
  #
  return(oedema.indicators.ALL)
}


################################################################################
#
#' create_op_oedema_males
#'
#' Create male older people indicators dataframe for oedema prevalence from
#' survey data collected using the standard RAM-OP questionnaire
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of male older people indicators on oedema prevalence
#'
#' @examples
#'
#' # Create oedema prevalence indicators dataset from RAM-OP survey data
#' # collected from Addis Ababa, Ethiopia
#' create_op_oedema_males(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_oedema_males <- function(svy) {
  oedema.indicators.MALES <- subset(create_op_oedema(svy = svy), sex1 == 1)
  return(oedema.indicators.MALES)
}


################################################################################
#
#' create_op_oedema_females
#'
#' Create female older people indicators dataframe for oedema prevalence from
#' survey data collected using the standard RAM-OP questionnaire
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of female older people indicators on oedema prevalence
#'
#' @examples
#'
#' # Create oedema prevalence indicators dataset from RAM-OP survey data
#' # collected from Addis Ababa, Ethiopia
#' create_op_oedema_females(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_oedema_females <- function(svy) {
  oedema.indicators.FEMALES <- subset(create_op_oedema(svy = svy), sex2 == 1)
  return(oedema.indicators.FEMALES)
}


################################################################################
#
#' create_op_screening
#'
#' Create older people indicators dataframe for screening coverage from survey
#' data collected using the standard RAM-OP questionnaire.
#'
#' @section Indicators: Screening Coverage
#'
#' \describe{
#' \item{\code{screened}}{Either MUAC or oedema checked previously}
#' }
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of older people indicators on screening coverage
#'
#' @examples
#'
#' # Create screening coverage indicators dataset from RAM-OP survey data
#' # collected from Addis Ababa, Ethiopia
#' create_op_screening(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_screening <- function(svy) {
  #
  psu <- svy$psu
  #
  sex1     <- bbw::recode(svy$d3, "1=1; 2=0; else=NA")
  sex2     <- bbw::recode(svy$d3, "1=0; 2=1; else=NA")
  #
  ##############################################################################
  #
  #  Screening for GAM, MAM, SAM (i.e. either MUAC or oedema checked previously)
  #
  screened <- ifelse(svy$as2 == 1 | svy$as4 == 1, 1, 0)
  #
  screening.indicators.ALL <- data.frame(psu, sex1, sex2, screened)
  #
  return(screening.indicators.ALL)
}


################################################################################
#
#' create_op_screening_males
#'
#' Create male older people indicators dataframe for screening coverage from
#' survey data collected using the standard RAM-OP questionnaire
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of male older people indicators on screening coverage
#'
#' @examples
#'
#' # Create screening coverage indicators dataset from RAM-OP survey data
#' # collected from Addis Ababa, Ethiopia
#' create_op_screening_males(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_screening_males <- function(svy) {
  screening.indicators.MALES <- subset(create_op_screening(svy = svy), sex1 == 1)
  return(screening.indicators.MALES)
}


################################################################################
#
#' create_op_screening_females
#'
#' Create female older people indicators dataframe for screening coverage from
#' survey data collected using the standard RAM-OP questionnaire
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of female older people indicators on screening coverage
#'
#' @examples
#'
#' # Create screening coverage indicators dataset from RAM-OP survey data
#' # collected from Addis Ababa, Ethiopia
#' create_op_screening_females(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_screening_females <- function(svy) {
  screening.indicators.FEMALES <- subset(create_op_screening(svy = svy), sex2 == 1)
  return(screening.indicators.FEMALES)
}


################################################################################
#
#' create_op_visual
#'
#' Create older people indicators dataframe for visual impairment from survey
#' data collected using the standard RAM-OP questionnaire.
#'
#' @section Indicators: Visual impairment by "Tumbling E" method
#'
#' The "Tumbling E" method is described in:
#'
#' \cite{Taylor HR (1978). Applying new design principles to the construction of an
#' illiterate E Chart. Am J Optom & Physiol Optics 55:348}
#'
#' \describe{
#' \item{\code{poorVA}}{Poor visual acuity (correct in < 3 of 4 tests)}
#' }
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of older people indicators on visual impairment
#'
#' @examples
#'
#' # Create visual impairment indicators dataset from RAM-OP survey data
#' # collected from Addis Ababa, Ethiopia
#' create_op_visual(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_visual <- function(svy) {
  #
  psu <- svy$psu
  #
  sex1     <- bbw::recode(svy$d3, "1=1; 2=0; else=NA")
  sex2     <- bbw::recode(svy$d3, "1=0; 2=1; else=NA")
  #
  ##############################################################################
  #
  #  Visual impairment by "Tumbling E" method
  #
  #  Create binary indicators
  #
  svy$va2a <- bbw::recode(svy$va2a, "1=1; else=0")
  svy$va2b <- bbw::recode(svy$va2b, "1=1; else=0")
  svy$va2c <- bbw::recode(svy$va2c, "1=1; else=0")
  svy$va2d <- bbw::recode(svy$va2d, "1=1; else=0")
  sumVA <- svy$va2a + svy$va2b + svy$va2c + svy$va2d
  poorVA <-  ifelse(sumVA < 3, 1, 0)
  #
  visual.indicators.ALL <- data.frame(psu, sex1, sex2, poorVA)
  #
  return(visual.indicators.ALL)
}


################################################################################
#
#' create_op_visual_males
#'
#' Create male older people indicators dataframe for visual impairment from
#' survey data collected using the standard RAM-OP questionnaire
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of male older people indicators on visual impairment
#'
#' @examples
#'
#' # Create visual impairment indicators dataset from RAM-OP survey data
#' # collected from Addis Ababa, Ethiopia
#' create_op_visual_males(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_visual_males <- function(svy) {
  visual.indicators.MALES <- subset(create_op_visual(svy = svy), sex1 == 1)
  return(visual.indicators.MALES)
}


################################################################################
#
#' create_op_visual_females
#'
#' Create female older people indicators dataframe for visual impairment from
#' survey data collected using the standard RAM-OP questionnaire
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of female older people indicators on visual impairment
#'
#' @examples
#'
#' # Create visual impairment indicators dataset from RAM-OP survey data
#' # collected from Addis Ababa, Ethiopia
#' create_op_visual_females(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_visual_females <- function(svy) {
  visual.indicators.FEMALES <- subset(create_op_visual(svy = svy), sex2 == 1)
  return(visual.indicators.FEMALES)
}


################################################################################
#
#' create_op_misc
#'
#' Create older people indicators dataframe for miscellaneous indicators from
#' survey data collected using the standard RAM-OP questionnaire.
#'
#' @section Indicators: Miscellaneous indicators
#'
#' \describe{
#' \item{\code{chew}}{Problems chewing food}
#' \item{\code{food}}{Anyone in HH receives a ration}
#' \item{\code{NFRI}}{Anyone in HH received non-food relief item(s) in previous month}
#' }
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of older people miscellaneous indicators
#'
#' @examples
#'
#' # Create miscellaneous indicators dataset from RAM-OP survey data
#' # collected from Addis Ababa, Ethiopia
#' create_op_misc(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_misc <- function(svy) {
  #
  psu <- svy$psu
  #
  sex1     <- bbw::recode(svy$d3, "1=1; 2=0; else=NA")
  sex2     <- bbw::recode(svy$d3, "1=0; 2=1; else=NA")
  #
  ##############################################################################
  #
  #  Miscellaneous indicators
  #
  chew <- bbw::recode(svy$a8, "1=1; else=0")
  food <- bbw::recode(svy$f6, "1=1; else=0")
  NFRI <- bbw::recode(svy$f7, "1=1; else=0")
  #
  misc.indicators.ALL <- data.frame(psu, sex1, sex2, chew, food, NFRI)
  #
  return(misc.indicators.ALL)
}


################################################################################
#
#' create_op_misc_males
#'
#' Create male older people indicators dataframe for miscellaneous indicators
#' from survey data collected using the standard RAM-OP questionnaire
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of male older people miscellaneous indicators
#'
#' @examples
#'
#' # Create miscellaneous indicators dataset from RAM-OP survey data
#' # collected from Addis Ababa, Ethiopia
#' create_op_misc_males(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_misc_males <- function(svy) {
  misc.indicators.MALES <- subset(create_op_misc(svy = svy), sex1 == 1)
  return(misc.indicators.MALES)
}


################################################################################
#
#' create_op_misc_females
#'
#' Create female older people indicators dataframe for miscellaneous indicators
#' from survey data collected using the standard RAM-OP questionnaire
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#'
#' @return A dataframe of female older people miscellaneous indicators
#'
#' @examples
#'
#' # Create miscellaneous indicators dataset from RAM-OP survey data
#' # collected from Addis Ababa, Ethiopia
#' create_op_misc_females(testSVY)
#'
#' @export
#'
#
################################################################################

create_op_misc_females <- function(svy) {
  misc.indicators.FEMALES <- subset(create_op_misc(svy = svy), sex2 == 1)
  return(misc.indicators.FEMALES)
}


################################################################################
#
#' create_op_all
#'
#' Create older people indicators dataframe from survey data collected
#' using the standard RAM-OP questionnaire.
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#' @param indicators A character vector of indicator names
#'
#' @return A dataframe of older people indicators
#'
#' @examples
#'
#' create_op_all(svy = testSVY)
#'
#' @export
#'
#
################################################################################

create_op_all <- function(svy, indicators = c("demo", "food", "hunger",
                                              "disability", "adl", "mental",
                                              "dementia", "health", "income",
                                              "wash", "anthro", "oedema",
                                              "screening", "visual", "misc")) {
  #
  #
  #
  psu <- svy$psu
  sex1     <- bbw::recode(svy$d3, "1=1; 2=0; else=NA")
  sex2     <- bbw::recode(svy$d3, "1=0; 2=1; else=NA")
  indicators.ALL <- data.frame(psu, sex1, sex2)
  #
  #
  #
  if("demo" %in% indicators) {
    indicators.ALL <- data.frame(indicators.ALL,
                                 subset(create_op_demo(svy = svy),
                                        select = c(-psu, -sex1, -sex2)))
  }
  #
  #
  #
  if("food" %in% indicators) {
    indicators.ALL <- data.frame(indicators.ALL,
                                 subset(create_op_food(svy = svy),
                                        select = c(-psu, -sex1, -sex2)))
  }
  #
  #
  #
  if("hunger" %in% indicators) {
    indicators.ALL <- data.frame(indicators.ALL,
                                 subset(create_op_hunger(svy = svy),
                                        select = c(-psu, -sex1, -sex2)))
  }
  #
  #
  #
  if("disability" %in% indicators) {
    indicators.ALL <- data.frame(indicators.ALL,
                                 subset(create_op_disability(svy = svy),
                                        select = c(-psu, -sex1, -sex2)))
  }
  #
  #
  #
  if("adl" %in% indicators) {
    indicators.ALL <- data.frame(indicators.ALL,
                                 subset(create_op_adl(svy = svy),
                                        select = c(-psu, -sex1, -sex2)))
  }
  #
  #
  #
  if("mental" %in% indicators) {
    indicators.ALL <- data.frame(indicators.ALL,
                                 subset(create_op_mental(svy = svy),
                                        select = c(-psu, -sex1, -sex2)))
  }
  #
  #
  #
  if("dementia" %in% indicators) {
    indicators.ALL <- data.frame(indicators.ALL,
                                 subset(create_op_dementia(svy = svy),
                                        select = c(-psu, -sex1, -sex2)))
  }
  #
  #
  #
  if("health" %in% indicators) {
    indicators.ALL <- data.frame(indicators.ALL,
                                 subset(create_op_health(svy = svy),
                                        select = c(-psu, -sex1, -sex2)))
  }
  #
  #
  #
  if("income" %in% indicators) {
    indicators.ALL <- data.frame(indicators.ALL,
                                 subset(create_op_income(svy = svy),
                                        select = c(-psu, -sex1, -sex2)))
  }
  #
  #
  #
  if("wash" %in% indicators) {
    indicators.ALL <- data.frame(indicators.ALL,
                                 subset(create_op_wash(svy = svy),
                                        select = c(-psu, -sex1, -sex2)))
  }
  #
  #
  #
  if("anthro" %in% indicators) {
    indicators.ALL <- data.frame(indicators.ALL,
                                 subset(create_op_anthro(svy = svy),
                                        select = c(-psu, -sex1, -sex2)))
  }
  #
  #
  #
  if("oedema" %in% indicators) {
    indicators.ALL <- data.frame(indicators.ALL,
                                 subset(create_op_oedema(svy = svy),
                                        select = c(-psu, -sex1, -sex2)))
  }
  #
  #
  #
  if("screening" %in% indicators) {
    indicators.ALL <- data.frame(indicators.ALL,
                                 subset(create_op_screening(svy = svy),
                                        select = c(-psu, -sex1, -sex2)))
  }
  #
  #
  #
  if("visual" %in% indicators) {
    indicators.ALL <- data.frame(indicators.ALL,
                                 subset(create_op_visual(svy = svy),
                                        select = c(-psu, -sex1, -sex2)))
  }
  #
  #
  #
  if("misc" %in% indicators) {
    indicators.ALL <- data.frame(indicators.ALL,
                                 subset(create_op_misc(svy = svy),
                                        select = c(-psu, -sex1, -sex2)))
  }
  #
  #
  #
  return(indicators.ALL)
}


################################################################################
#
#' createOP
#'
#' Create older people indicators dataframe from survey data collected
#' using the standard RAM-OP questionnaire.
#'
#' @section Indicators:
#'
#' \strong{Demographic}
#' \describe{
#' \item{\code{psu}}{Primary sampling unit}
#' \item{\code{resp1}}{Respondent is SUBJECT}
#' \item{\code{resp2}}{Respondent is FAMILY CARER}
#' \item{\code{resp3}}{Respondent is OTHER CARER}
#' \item{\code{resp4}}{Respondent is OTHER}
#' \item{\code{age}}{Age of respondent (years)}
#' \item{\code{ageGrp1}}{Age of respondent is between 50 and 59 years}
#' \item{\code{ageGrp2}}{Age of respondent is between 50 and 59 years}
#' \item{\code{ageGrp3}}{Age of respondent is between 50 and 59 years}
#' \item{\code{ageGrp4}}{Age of respondent is between 50 and 59 years}
#' \item{\code{ageGrp5}}{Age of respondent is between 50 and 59 years}
#' \item{\code{sex1}}{Male}
#' \item{\code{sex2}}{Female}
#' \item{\code{marital1}}{Marital status = SINGLE}
#' \item{\code{marital2}}{Marital status = MARRIED}
#' \item{\code{marital3}}{Marital status = LIVING TOGETHER}
#' \item{\code{marital4}}{Marital status = DIVORCED}
#' \item{\code{marital5}}{Marital status = SEPARATED}
#' \item{\code{marital6}}{Marital status = OTHER}
#' \item{\code{alone}}{Respondent lives alone}
#' }
#'
#'
#' \strong{Dietary intake indicators}
#'
#' These dietary intake indicators have been purpose-built for older people but
#' the basic approach used is described in:
#'
#' \cite{Kennedy G, Ballard T, Dop M C (2011). Guidelines for Measuring Household
#' and Individual Dietary Diversity. Rome, FAO
#' \url{http://www.fao.org/docrep/014/i1983e/i1983e00.htm}}
#'
#' and extended to include indicators of probable adequate intake of a number of
#' nutrients / micronutrients.
#'
#' \describe{
#' \item{\code{MF}}{Meal frequenct}
#' \item{\code{DDS}}{Dietary Diversity Score (count of 11 groups)}
#' \item{\code{FG01}}{Cereals}
#' \item{\code{FG02}}{Roots and tubers}
#' \item{\code{FG03}}{Fruits and vegetables}
#' \item{\code{FG04}}{All meat}
#' \item{\code{FG05}}{Eggs}
#' \item{\code{FG06}}{Fish}
#' \item{\code{FG07}}{Legumes, nuts and seeds}
#' \item{\code{FG08}}{Milk and milk products}
#' \item{\code{FG09}}{Fats}
#' \item{\code{FG10}}{Sugar}
#' \item{\code{FG11}}{Other}
#' \item{\code{proteinRich}}{Protein rich foods}
#' \item{\code{pProtein}}{Protein rich plant sources of protein}
#' \item{\code{aProtein}}{Protein rich animal sources of protein}
#' \item{\code{pVitA}}{Plant sources of vitamin A}
#' \item{\code{aVitA}}{Animal sources of vitamin A}
#' \item{\code{xVitA}}{Any source of vitamin A}
#' \item{\code{ironRich}}{Iron rich foods}
#' \item{\code{caRich}}{Calcium rich foods}
#' \item{\code{znRich}}{Zinc rich foods}
#' \item{\code{vitB1}}{Vitamin B1-rich foods}
#' \item{\code{vitB2}}{Vitamin B2-rich foods}
#' \item{\code{vitB3}}{Vitamin B3-rich foods}
#' \item{\code{vitB6}}{Vitamin B6-rich foods}
#' \item{\code{vitB12}}{Vitamin B12-rich foods}
#' \item{\code{vitBcomplex}}{Vitamin B1/B2/B3/B6/B12-rich foods}
#' }
#'
#' \strong{Household Hunger Scale (HHS)}
#'
#' The HHS is described in:
#'
#' \cite{Ballard T, Coates J, Swindale A, Deitchler M (2011). Household Hunger
#' Scale: Indicator Definition and Measurement Guide. Washington DC,
#' FANTA-2 Bridge, FHI 360
#' \url{https://www.fantaproject.org/monitoring-and-evaluation/household-hunger-scale-hhs}}
#'
#' \describe{
#' \item{\code{HHS1}}{Little or no hunger in household}
#' \item{\code{HHS2}}{Moderate hunger in household}
#' \item{\code{HHS3}}{Severe hunger in household}
#' }
#'
#' \strong{Katz "Index of Independence in Activities of Daily Living" (ADL) score}
#'
#' The Katz ADL score is described in:
#'
#' \cite{Katz S, Ford AB, Moskowitz RW, Jackson BA, Jaffe MW (1963). Studies
#' of illness in the aged. The Index of ADL: a standardized measure of
#' biological and psychosocial function. JAMA, 1963, 185(12):914-9
#' \url{doi:10.1001/jama.1963.03060120024016}}
#'
#' \cite{Katz S, Down TD, Cash HR, Grotz, RC (1970). Progress in the development
#' of the index of ADL. The Gerontologist, 10(1), 20-30
#' \url{doi:10.1093/geront/10.4_Part_1.274}}
#'
#' \cite{Katz S (1983). Assessing self-maintenance: Activities of daily living,
#' mobility and instrumental activities of daily living. JAGS, 31(12),
#' 721-726 \url{doi:10.1111/j.1532-5415.1983.tb03391.x}}
#'
#' \describe{
#' \item{\code{ADL01}}{Bathing}
#' \item{\code{ADL02}}{Dressing}
#' \item{\code{ADL03}}{Toileting}
#' \item{\code{ADL04}}{Transferring (mobility)}
#' \item{\code{ADL05}}{Continence}
#' \item{\code{ADL06}}{Feeding}
#' \item{\code{scoreADL}}{ADL Score}
#' \item{\code{classADL1}}{Severity of dependence 1}
#' \item{\code{classADL2}}{Severity of dependence 2}
#' \item{\code{classADL3}}{Severity of dependence 3}
#' \item{\code{hasHelp}}{Have someone to help with everyday activities}
#' \item{\code{unmetNeed}}{Need help but has no helper}
#' }
#'
#' \strong{K6 Short form psychological distress score}
#'
#' The K6 score is described in:
#'
#' \cite{Kessler RC, Andrews G, Colpe LJ, Hiripi E, Mroczek, DK, Normand SLT,
#' et al. (2002). Short screening scales to monitor population prevalences
#' and trends in non-specific psychological distress. Psychological
#' Medicine, 32(6), 959–976 \url{doi:10.1017/S0033291702006074}}
#'
#' \describe{
#' \item{\code{K6}}{K6 score}
#' \item{\code{K6Case}}{K6 score > 12  (in serious psychological distress)}
#' }
#'
#' \strong{Brief Community Screening Instrument for Dementia (CSID)}
#'
#' The CSID dementia screening tool is described in:
#'
#' \cite{Prince M, et al. (2010). A brief dementia screener suitable for use
#' by non-specialists in resource poor settings - The cross-cultural
#' derivation and validation of the brief Community Screening Instrument
#' for Dementia. International Journal of Geriatric Psychiatry, 26(9),
#' 899–907 \url{doi:10.1002/gps.2622}}
#'
#' \describe{
#' \item{\code{DS}}{Probable dementia by CSID screen}
#' }
#'
#' \strong{Health and health-seeking indicators}
#'
#' \describe{
#' \item{\code{H1}}{Chronic condition}
#' \item{\code{H2}}{Takes drugs regularly for chronic condition}
#' \item{\code{H31}}{No drugs available}
#' \item{\code{H32}}{Too expensive / no money}
#' \item{\code{H33}}{Too old to look for care}
#' \item{\code{H34}}{Use traditional medicine}
#' \item{\code{H35}}{Drugs don't help}
#' \item{\code{H36}}{No-one to help me}
#' \item{\code{H37}}{No need}
#' \item{\code{H38}}{Other}
#' \item{\code{H39}}{No reason given}
#' \item{\code{H4}}{Recent disease episode}
#' \item{\code{H5}}{Accessed care for recent disease episode}
#' \item{\code{H61}}{No drugs available}
#' \item{\code{H62}}{Too expensive / no money}
#' \item{\code{H63}}{Too old to look for care}
#' \item{\code{H64}}{Use traditional medicine}
#' \item{\code{H65}}{Drugs don't help}
#' \item{\code{H66}}{No-one to help me}
#' \item{\code{H67}}{No need}
#' \item{\code{H68}}{Other}
#' \item{\code{H69}}{No reason given}
#' }
#'
#' \strong{Income and income sources}
#'
#' \describe{
#' \item{\code{M1}}{Has a personal income}
#' \item{\code{M2A}}{Agriculture / fishing / livestock}
#' \item{\code{M2B}}{Wages / salary}
#' \item{\code{M2C}}{Sale of charcoal / bricks / &c.}
#' \item{\code{M2D}}{Trading (e.g. market or shop)}
#' \item{\code{M2E}}{Investments}
#' \item{\code{M2F}}{Spending savings / sale of assets}
#' \item{\code{M2G}}{Charity}
#' \item{\code{M2H}}{Cash transfer / Social security}
#' \item{\code{M2I}}{Other}
#' }
#'
#' \strong{Water, sanitation and hygiene (WASH) indicators}
#'
#' These are a (core) subset of indicators from:
#'
#' \cite{WHO / UNICEF (2006). Core Questions on Drinking-water and Sanitation
#' for Household Surveys. Geneva, WHO / UNICEF
#' \url{http://www.who.int/water_sanitation_health/monitoring/household_surveys/en/}}
#'
#' \describe{
#' \item{\code{W1}}{Improved source of drinking water}
#' \item{\code{W2}}{Safe drinking water (improved source OR adequate treatment)}
#' \item{\code{W3}}{Improved sanitation facility}
#' \item{\code{W4}}{Improved non-shared sanitation facility}
#' }
#'
#' \strong{Anthropometry and screening}
#'
#' \describe{
#' \item{\code{MUAC}}{Mid-upper arm circumference (mm)}
#' \item{\code{oedema}}{Bilateral pitting oedema (may not be nutritional)}
#' \item{\code{screened}}{Either MUAC or oedema checked previously}
#' }
#'
#' \strong{Visual impairment by "Tumbling E" method}
#'
#' The "Tumbling E" method is described in:
#'
#' \cite{Taylor HR (1978). Applying new design principles to the construction of an
#' illiterate E Chart. Am J Optom & Physiol Optics 55:348}
#'
#' \describe{
#' \item{\code{poorVA}}{Poor visual acuity (correct in < 3 of 4 tests)}
#' }
#'
#' \strong{Miscellaneous indicators}
#'
#' \describe{
#' \item{\code{chew}}{Problems chewing food}
#' \item{\code{food}}{Anyone in HH receives a ration}
#' \item{\code{NFRI}}{Anyone in HH received non-food relief item(s) in previous month}
#' }
#'
#' \strong{Washington Group on Disability}
#'
#' See:
#'
#'   \url{http://www.washingtongroup-disability.com}
#'   \url{https://www.cdc.gov/nchs/washington_group/wg_documents.htm}
#'
#' for details.
#'
#' \describe{
#' \item{\code{wgVisionD0}}{Vision domain 0}
#' \item{\code{wgVisionD1}}{Vision domain 1}
#' \item{\code{wgVisionD2}}{Vision domain 2}
#' \item{\code{wgVisionD3}}{Vision domain 3}
#' \item{\code{wgHearingD0}}{Hearing domain 0}
#' \item{\code{wgHearingD1}}{Hearing domain 1}
#' \item{\code{wgHearingD2}}{Hearing domain 2}
#' \item{\code{wgHearingD3}}{Hearing domain 3}
#' \item{\code{wgMobilityD0}}{Mobility domain 0}
#' \item{\code{wgMobilityD1}}{Mobility domain 1}
#' \item{\code{wgMobilityD2}}{Mobility domain 2}
#' \item{\code{wgMobilityD3}}{Mobility domain 3}
#' \item{\code{wgRememberingD0}}{Remembering domain 0}
#' \item{\code{wgRememberingD1}}{Remembering domain 1}
#' \item{\code{wgRememberingD2}}{Remembering domain 2}
#' \item{\code{wgRememberingD3}}{Remembering domain 3}
#' \item{\code{wgSelfCareD0}}{Self-care domain 0}
#' \item{\code{wgSelfCareD1}}{Self-care domain 1}
#' \item{\code{wgSelfCareD2}}{Self-care domain 2}
#' \item{\code{wgSelfCareD3}}{Self-care domain 3}
#' \item{\code{wgCommunicatingD0}}{Communication domain 0}
#' \item{\code{wgCommunicatingD1}}{Communication domain 1}
#' \item{\code{wgCommunicatingD2}}{Communication domain 2}
#' \item{\code{wgCommunicatingD3}}{Communication domain 3}
#' \item{\code{wgP0}}{Overall 0}
#' \item{\code{wgP1}}{Overall 1}
#' \item{\code{wgP2}}{Overall 2}
#' \item{\code{wgP3}}{Overall 3}
#' \item{\code{wgPM}}{Any disability}
#' }
#'
#' @param svy A dataframe collected using the standard RAM-OP questionnaire
#' @return Three dataframes of Older People indicators each with 138 variables:
#' \describe{
#' \item{\code{indicators.ALL}}{Indicators dataframe for all respondents}
#' \item{\code{indicators.MALES}}{Indicators dataframe for male respondents}
#' \item{\code{indicators.FEMALES}}{Indicators dataframe for female repsondents}
#' }
#'
#' @examples
#'
#' # Create indicators dataset from RAM-OP survey data collected from
#' # Addis Ababa, Ethiopia
#' createOP(testSVY)
#'
#' @export
#'
#
################################################################################

createOP <- function(svy) {
  #
  # psu    Cluster (PSU) identifier
  #
  psu <- svy$psu
  #
  #
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
  #
  #  Dietary intake indicators
  #
  #  Meal frequency
  #
  MF <- bbw::recode(svy$f1, "9=0; NA=0")
  #
  #  Recode dietary diversity data
  #
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
  #
  #  Dietary diversity
  #
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
  #
  # Sum food groups to 'DDS'
  #
  DDS <- FG01 + FG02 + FG03 + FG04 + FG05 + FG06 + FG07 + FG08 + FG09 + FG10 + FG11
  #
  #  Protein rich foods in diet from aminal, plant, and all sources
  #
  aProtein <- ifelse(svy$f2j == 1 | svy$f2k == 1 | svy$f2q ==1 | svy$f2n == 1 | svy$f2a == 1 | svy$f2m == 1, 1, 0)
  pProtein <- ifelse(svy$f2h == 1 | svy$f2p == 1, 1, 0)
  proteinRich <- ifelse(aProtein == 1 | pProtein == 1, 1, 0)
  #
  #  Micronutrient intake (vitamin A, iron, calcium, zinc)
  #
  pVitA    <- ifelse(svy$f2d == 1 | svy$f2e == 1 | svy$f2f == 1, 1, 0)
  aVitA    <- ifelse(svy$f2a == 1 | svy$f2j == 1 | svy$f2m == 1 | svy$f2n == 1, 1, 0)
  xVitA    <- ifelse(pVitA == 1 | aVitA == 1, 1, 0)
  ironRich <- ifelse(svy$f2f == 1 | svy$f2j == 1 | svy$f2k == 1 | svy$f2l == 1, 1, 0)
  caRich   <- ifelse(svy$f2a == 1 | svy$f2m == 1, 1, 0)
  znRich   <- ifelse(svy$f2h == 1 | svy$f2j == 1 | svy$f2k == 1 | svy$f2l == 1 | svy$f2p == 1 | svy$f2q == 1, 1, 0)
  #
  #  Micronutrient intake (B vitamins)
  #
  vitB1  <- ifelse(svy$f2a == 1 | svy$f2e == 1 | svy$f2h == 1 | svy$f2j == 1 | svy$f2k == 1 | svy$f2l == 1 | svy$f2m == 1 | svy$f2n == 1 | svy$f2p == 1, 1, 0)
  vitB2  <- ifelse(svy$f2a == 1 | svy$f2f == 1 | svy$f2h == 1 | svy$f2j == 1 | svy$f2k == 1 | svy$f2l == 1 | svy$f2m == 1, 1, 0)
  vitB3  <- ifelse(svy$f2h == 1 | svy$f2j == 1 | svy$f2k == 1 | svy$f2l == 1, 1, 0)
  vitB6  <- ifelse(svy$f2d == 1 | svy$f2f == 1 | svy$f2h == 1 | svy$f2i == 1 | svy$f2k == 1 | svy$f2l == 1, 1, 0)
  vitB12 <- ifelse(svy$f2j == 1 | svy$f2k == 1 | svy$f2l == 1 | svy$f2m == 1 | svy$f2n == 1, 1, 0)
  vitBsources <- vitB1 + vitB2 + vitB3 + vitB6 + vitB12
  vitBcomplex <- ifelse(vitBsources == 5, 1, 0)
  #
  # Clean-up
  #
  rm(vitBsources)
  #
  #  Recode component variables
  #
  svy$f3 <- bbw::recode(svy$f3, "1=1; 2=1; 3=2; else=0")
  svy$f4 <- bbw::recode(svy$f4, "1=1; 2=1; 3=2; else=0")
  svy$f5 <- bbw::recode(svy$f5, "1=1; 2=1; 3=2; else=0")
  #
  #  Sum components and classify hunger into three separate indicator variables
  #
  sumHHS <- svy$f3 + svy$f4 + svy$f5
  HHS1 <- bbw::recode(sumHHS, "0:1=1; else=0")
  HHS2 <- bbw::recode(sumHHS, "2:3=1; else=0")
  HHS3 <- bbw::recode(sumHHS, "4:6=1; else=0")
  #
  #  Clean-up
  #
  rm(sumHHS)
  #
  #  Katz "Index of Independence in Activities of Daily Living" (ADL) score
  #
  #  Recode ADL (activities of daily living) score data
  #
  ADL01 <- bbw::recode(svy$a1, "2=1; else=0")    # Bathing
  ADL02 <- bbw::recode(svy$a2, "2=1; else=0")    # Dressing
  ADL03 <- bbw::recode(svy$a3, "2=1; else=0")    # Toileting
  ADL04 <- bbw::recode(svy$a4, "2=1; else=0")    # Transferring (mobility)
  ADL05 <- bbw::recode(svy$a5, "2=1; else=0")    # Continence
  ADL06 <- bbw::recode(svy$a6, "2=1; else=0")    # Feeding
  #
  #  Create ADL score (items summed over all six activities / dimensions)
  #
  scoreADL <- ADL01 + ADL02 + ADL03 + ADL04 + ADL05 + ADL06
  #
  #  Severity of dependence (from Katz ADL score)
  #
  classADL1 <- bbw::recode(scoreADL, "5:6=1; else=0")
  classADL2 <- bbw::recode(scoreADL, "3:4=1; else=0")
  classADL3 <- bbw::recode(scoreADL, "0:2=1; else=0")
  #
  #  Does the subject have someone to help with everyday activities?
  #
  hasHelp <- bbw::recode(svy$a7, "1=1; else=0")
  #
  #  Does the subject need help but has no helper?
  #
  #  Note : Denominator is entire sample so the indicator is the proportion of
  #         the population with unmet ADl help needs
  #
  unmetNeed <- ifelse(scoreADL < 6 & hasHelp == 0, 1, 0)
  #
  #  K6 : Short form psychological distress score
  #
  #  Recode DON'T KNOW, REFUSED, NA and MISSING values to 5 (NONE)
  #
  svy$k6a <- bbw::recode(svy$k6a, "6:9=5")
  svy$k6b <- bbw::recode(svy$k6b, "6:9=5")
  svy$k6c <- bbw::recode(svy$k6c, "6:9=5")
  svy$k6d <- bbw::recode(svy$k6d, "6:9=5")
  svy$k6e <- bbw::recode(svy$k6e, "6:9=5")
  svy$k6f <- bbw::recode(svy$k6f, "6:9=5")
  #
  #  Reverse coding & create K6 score (i.e. as the sum of individual item scores)
  #
  svy$k6a <- 5 - svy$k6a
  svy$k6b <- 5 - svy$k6b
  svy$k6c <- 5 - svy$k6d
  svy$k6d <- 5 - svy$k6d
  svy$k6e <- 5 - svy$k6e
  svy$k6f <- 5 - svy$k6f
  K6 <- svy$k6a + svy$k6b + svy$k6c + svy$k6d + svy$k6e + svy$k6f
  #
  #  Apply case-definition for serious psychological distress(i.e. K6 > 12)
  #
  K6Case <- bbw::recode(K6, "0:12=0; 13:hi=1")
  #
  #  Recode scored components to 0 / 1 (with 1 = correct)
  #
  svy$ds1  <- bbw::recode(svy$ds1,  "1=1; else=0") # Nose
  svy$ds2  <- bbw::recode(svy$ds2,  "1=1; else=0") # Hammer
  svy$ds3  <- bbw::recode(svy$ds3,  "1=1; else=0") # Day of week
  svy$ds4  <- bbw::recode(svy$ds4,  "1=1; else=0") # Season
  svy$ds5  <- bbw::recode(svy$ds5,  "1=1; else=0") # Point to window then door
  svy$ds6a <- bbw::recode(svy$ds6a, "1=1; else=0") # Memory "CHILD"
  svy$ds6b <- bbw::recode(svy$ds6b, "1=1; else=0") # Memory "HOUSE"
  svy$ds6c <- bbw::recode(svy$ds6c, "1=1; else=0") # Memory "ROAD"
  #
  #  Sum correct items into CSID score
  #
  scoreCSID <- svy$ds1 + svy$ds2 + svy$ds3 + svy$ds4 + svy$ds5 + svy$ds6a + svy$ds6b + svy$ds6c
  #
  #  Classify dementia :
  #
  DS <- bbw::recode(scoreCSID, "0:4=1; 5:8=0")
  #
  #  Clean-up
  #
  rm(scoreCSID)
  #
  #  Health indicators : CHRONIC CONDITIONS
  #
  svy$h1 <- bbw::recode(svy$h1, "1=1; else=2")
  H1 <- bbw::recode(svy$h1, "1=1; else=0")
  H2 <- ifelse(H1 == 0, NA, bbw::recode(svy$h2, "1=1; else=0"))
  H3 <- ifelse(H2 == 1, NA, bbw::recode(svy$h3, "NA=9"))
  #
  # Indicators for main reason for NOT taking drugs for chronic condition
  #
  H31 <- bbw::recode(H3, "1=1; NA=NA; else=0")
  H32 <- bbw::recode(H3, "2=1; NA=NA; else=0")
  H33 <- bbw::recode(H3, "3=1; NA=NA; else=0")
  H34 <- bbw::recode(H3, "4=1; NA=NA; else=0")
  H35 <- bbw::recode(H3, "5=1; NA=NA; else=0")
  H36 <- bbw::recode(H3, "6=1; NA=NA; else=0")
  H37 <- bbw::recode(H3, "7=1; NA=NA; else=0")
  H38 <- bbw::recode(H3, "8=1; NA=NA; else=0")
  H39 <- bbw::recode(H3, "9=1; NA=NA; else=0")
  #
  ##############################################################################
  #
  #  Health indicators : RECENT DISEASE EPISODE
  #
  svy$h4 <- bbw::recode(svy$h4, "1=1; else=2")
  H4 <- bbw::recode(svy$h4, "1=1; else=0")
  H5 <- ifelse(H4 == 0, NA, bbw::recode(svy$h5, "1=1; else=0"))
  H6 <- ifelse(H5 == 1, NA, bbw::recode(svy$h6, "NA=9"))
  #
  # Indicators for main reason for NOT accessing care for recent disease episode
  #
  H61 <- bbw::recode(H6, "1=1; NA=NA; else=0")
  H62 <- bbw::recode(H6, "2=1; NA=NA; else=0")
  H63 <- bbw::recode(H6, "3=1; NA=NA; else=0")
  H64 <- bbw::recode(H6, "4=1; NA=NA; else=0")
  H65 <- bbw::recode(H6, "5=1; NA=NA; else=0")
  H66 <- bbw::recode(H6, "6=1; NA=NA; else=0")
  H67 <- bbw::recode(H6, "7=1; NA=NA; else=0")
  H68 <- bbw::recode(H6, "8=1; NA=NA; else=0")
  H69 <- bbw::recode(H6, "9=1; NA=NA; else=0")
  #
  # Clean-up
  #
  rm(H3, H6)
  #
  #  Income and income sources
  #
  #  Create binary indicators
  #
  M1  <- bbw::recode(svy$m1,  "1=1; else=0") # Has a personal income
  M2A <- bbw::recode(svy$m2a, "1=1; else=0") # Agriculture / fishing / livestock
  M2B <- bbw::recode(svy$m2b, "1=1; else=0") # Wages / salary
  M2C <- bbw::recode(svy$m2c, "1=1; else=0") # Sale of charcoal / bricks / &c.
  M2D <- bbw::recode(svy$m2d, "1=1; else=0") # Trading (e.g. market or shop)
  M2E <- bbw::recode(svy$m2e, "1=1; else=0") # Investments
  M2F <- bbw::recode(svy$m2f, "1=1; else=0") # Spending savings / sale of assets
  M2G <- bbw::recode(svy$m2g, "1=1; else=0") # Charity
  M2H <- bbw::recode(svy$m2h, "1=1; else=0") # Cash transfer / social security
  M2I <- bbw::recode(svy$m2i, "1=1; else=0") # Other
  #
  ##############################################################################
  #
  #  Check for any income (return 'correct' result in M1)
  #
  checkForIncome <- M1 + M2A + M2B + M2C + M2D + M2E + M2F + M2G + M2H + M2I
  M1 <- ifelse(checkForIncome > 0, 1, 0)
  #
  ##############################################################################
  #
  # Clean-up
  #
  rm(checkForIncome)
  #
  ##############################################################################
  #
  #  Water, Sanitation, and Hygiene (WASH) indicators
  #
  #  Recode WASH data
  #
  svy$w1 <- bbw::recode(svy$w1, "1=1; else=0")
  svy$w2 <- bbw::recode(svy$w2, "1=1; else=0")
  svy$w3 <- bbw::recode(svy$w3, "1=1; else=0")
  svy$w4 <- bbw::recode(svy$w4, "1=1; else=0")
  #
  ##############################################################################
  #
  #  Create WASH indicators
  #
  W1 <- svy$w1
  W2 <- ifelse(svy$w1 == 1 | svy$w2 == 1, 1, 0)
  W3 <- svy$w3
  W4 <- ifelse(svy$w3 == 1 & svy$w4 != 1, 1, 0)
  #
  ##############################################################################
  #
  #  Anthropometry and screening
  #
  #  Censor REFUSAL, NOT APPLICABLE, and MISSING values codes in MUAC and Oedema
  #
  MUAC <- bbw::recode(svy$as1, "777=NA; 888=NA; 999=NA")
  oedema <- bbw::recode(svy$as3, "1=1; else=0")
  #
  ##############################################################################
  #
  #  Screening for GAM, MAM, SAM (i.e. either MUAC or oedema checked previously)
  #
  screened <- ifelse(svy$as2 == 1 | svy$as4 == 1, 1, 0)
  #
  ##############################################################################
  #
  #  Visual impairment by "Tumbling E" method
  #
  #  Create binary indicators
  #
  svy$va2a <- bbw::recode(svy$va2a, "1=1; else=0")
  svy$va2b <- bbw::recode(svy$va2b, "1=1; else=0")
  svy$va2c <- bbw::recode(svy$va2c, "1=1; else=0")
  svy$va2d <- bbw::recode(svy$va2d, "1=1; else=0")
  sumVA <- svy$va2a + svy$va2b + svy$va2c + svy$va2d
  poorVA <-  ifelse(sumVA < 3, 1, 0)
  #
  ##############################################################################
  #
  #  Clean-up
  #
  rm(sumVA)
  #
  ##############################################################################
  #
  #  Miscellaneous indicators
  #
  chew <- bbw::recode(svy$a8, "1=1; else=0")
  food <- bbw::recode(svy$f6, "1=1; else=0")
  NFRI <- bbw::recode(svy$f7, "1=1; else=0")
  #
  ##############################################################################
  #
  #  Washington Group (WG) short set of question designed to identify people with a
  #  disability in a census or survey format.
  #
  # Missing values
  #
  svy$wg1 <- bbw::recode(svy$wg1, "9=0; NA=0")
  svy$wg2 <- bbw::recode(svy$wg2, "9=0; NA=0")
  svy$wg3 <- bbw::recode(svy$wg3, "9=0; NA=0")
  svy$wg4 <- bbw::recode(svy$wg4, "9=0; NA=0")
  svy$wg5 <- bbw::recode(svy$wg5, "9=0; NA=0")
  svy$wg6 <- bbw::recode(svy$wg6, "9=0; NA=0")
  #
  ##############################################################################
  #
  # Vision domain
  #
  wgVisionD0 <- ifelse(svy$wg1 == 0, 1, 0)
  wgVisionD1 <- ifelse(svy$wg1 == 1 | svy$wg1 == 2 | svy$wg1 == 3, 1, 0)
  wgVisionD2 <- ifelse(svy$wg1 == 2 | svy$wg1 == 3, 1, 0)
  wgVisionD3 <- ifelse(svy$wg1 == 3, 1, 0)
  #
  ##############################################################################
  #
  # Hearing domain
  #
  wgHearingD0 <- ifelse(svy$wg2 == 0, 1, 0)
  wgHearingD1 <- ifelse(svy$wg2 == 1 | svy$wg2 == 2 | svy$wg2 == 3, 1, 0)
  wgHearingD2 <- ifelse(svy$wg2 == 2 | svy$wg2 == 3, 1, 0)
  wgHearingD3 <- ifelse(svy$wg2 == 3, 1, 0)
  #
  ##############################################################################
  #
  # Mobility domain
  #
  wgMobilityD0 <- ifelse(svy$wg3 == 0, 1, 0)
  wgMobilityD1 <- ifelse(svy$wg3 == 1 | svy$wg3 == 2 | svy$wg3 == 3, 1, 0)
  wgMobilityD2 <- ifelse(svy$wg3 == 2 | svy$wg3 == 3, 1, 0)
  wgMobilityD3 <- ifelse(svy$wg3 == 3, 1, 0)
  #
  ##############################################################################
  #
  # Remembering domain
  #
  wgRememberingD0 <- ifelse(svy$wg4 == 0, 1, 0)
  wgRememberingD1 <- ifelse(svy$wg4 == 1 | svy$wg4 == 2 | svy$wg4 == 3, 1, 0)
  wgRememberingD2 <- ifelse(svy$wg4 == 2 | svy$wg4 == 3, 1, 0)
  wgRememberingD3 <- ifelse(svy$wg4 == 3, 1, 0)
  #
  ##############################################################################
  #
  # Self-care domain
  #
  wgSelfCareD0 <- ifelse(svy$wg5 == 0, 1, 0)
  wgSelfCareD1 <- ifelse(svy$wg5 == 1 | svy$wg5 == 2 | svy$wg5 == 3, 1, 0)
  wgSelfCareD2 <- ifelse(svy$wg5 == 2 | svy$wg5 == 3, 1, 0)
  wgSelfCareD3 <- ifelse(svy$wg5 == 3, 1, 0)
  #
  ##############################################################################
  #
  # Communicating domain
  #
  wgCommunicatingD0 <- ifelse(svy$wg6 == 0, 1, 0)
  wgCommunicatingD1 <- ifelse(svy$wg6 == 1 | svy$wg6 == 2 | svy$wg6 == 3, 1, 0)
  wgCommunicatingD2 <- ifelse(svy$wg6 == 2 | svy$wg6 == 3, 1, 0)
  wgCommunicatingD3 <- ifelse(svy$wg6 == 3, 1, 0)
  #
  ##############################################################################
  #
  # Overall prevalence
  #
  wgP0 <- ifelse(wgVisionD0 + wgHearingD0 + wgMobilityD0 + wgRememberingD0 + wgSelfCareD0 + wgCommunicatingD0 == 6, 1, 0)
  wgP1 <- ifelse(wgVisionD1 + wgHearingD1 + wgMobilityD1 + wgRememberingD1 + wgSelfCareD1 + wgCommunicatingD1 >  0, 1, 0)
  wgP2 <- ifelse(wgVisionD2 + wgHearingD2 + wgMobilityD2 + wgRememberingD2 + wgSelfCareD2 + wgCommunicatingD2 >  0, 1, 0)
  wgP3 <- ifelse(wgVisionD3 + wgHearingD3 + wgMobilityD3 + wgRememberingD3 + wgSelfCareD3 + wgCommunicatingD3 >  0, 1, 0)
  wgPM <- ifelse(wgVisionD1 + wgHearingD1 + wgMobilityD1 + wgRememberingD1 + wgSelfCareD1 + wgCommunicatingD1 >  1, 1, 0)
  #
  ##############################################################################
  #
  #  Make summary data.frame for ALL respondents
  #
  indicators.ALL <- data.frame(psu, resp1, resp2, resp3, resp4,
    age, ageGrp1, ageGrp2, ageGrp3, ageGrp4, ageGrp5, sex1, sex2,
    marital1, marital2, marital3, marital4, marital5, marital6,
    alone,
    MF, DDS,
    FG01, FG02, FG03, FG04, FG05, FG06, FG07, FG08, FG09, FG10, FG11,
    proteinRich, pProtein, aProtein,
    pVitA, aVitA, xVitA,
    ironRich,
    caRich,
    znRich,
    vitB1, vitB2, vitB3, vitB6, vitB12, vitBcomplex,
    HHS1, HHS2, HHS3,
    ADL01, ADL02, ADL03, ADL04, ADL05, ADL06, scoreADL,
    classADL1, classADL2, classADL3, hasHelp, unmetNeed,
    K6, K6Case,
    DS,
    H1, H2, H31, H32, H33, H34, H35, H36, H37, H38, H39,
    H4, H5, H61, H62, H63, H64, H65, H66, H67, H68, H69,
    M1, M2A, M2B, M2C, M2D, M2E, M2F, M2G, M2H, M2I,
    W1, W2, W3, W4,
    MUAC, oedema, screened,
    poorVA,
    chew, food, NFRI,
    wgVisionD0, wgVisionD1, wgVisionD2, wgVisionD3,
    wgHearingD0, wgHearingD1, wgHearingD2, wgHearingD3,
    wgMobilityD0, wgMobilityD1, wgMobilityD2, wgMobilityD3,
    wgRememberingD0, wgRememberingD1, wgRememberingD2, wgRememberingD3,
    wgSelfCareD0, wgSelfCareD1, wgSelfCareD2, wgSelfCareD3,
    wgCommunicatingD0, wgCommunicatingD1, wgCommunicatingD2, wgCommunicatingD3,
    wgP0, wgP1, wgP2, wgP3, wgPM)
  #
  #
  #
  return(indicators.ALL)
}
