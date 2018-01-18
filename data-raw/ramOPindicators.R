################################################################################
#
# Read and process RAM-OP sample dataset from Addis Ababa, Ethiopia
#
################################################################################

svy <- read.csv("data-raw/testSVY.csv", header = TRUE, sep = ",")

svy$wg1 <- NA
svy$wg2 <- NA
svy$wg3 <- NA
svy$wg4 <- NA
svy$wg5 <- NA
svy$wg6 <- NA

svy <- subset(svy, select = -a9)

svyBackup <- testSVY <- svy

devtools::use_data(testSVY, overwrite = TRUE)

rm(testSVY)

################################################################################
#
#  Identifiers and survey administration data
#
#    psu    Cluster (PSU) identifier
#
psu <- svy$psu


################################################################################
#
#  Demography and situation indicators
#
#  Indicators are :
#
#    resp1     Respondent is SUBJECT
#    resp2     Respondent is FAMILY CARER
#    resp3     Respondent is OTHER CARER
#    resp4     Respondent is OTHER
#    age       Age of respondent (years)
#    ageGrp1   Age of respondent is between 50 and 59 years
#    ageGrp2   Age of respondent is between 60 and 69 years
#    ageGrp3   Age of respondent is between 70 and 79 years
#    ageGrp4   Age of respondent is between 80 and 89 years
#    ageGrp5   Age of respondent is 90 years or older
#    sex1      Sex = MALE
#    sex2      Sex = FEMALE
#    marital1  Marital status = SINGLE
#    marital2  Marital status = MARRIED
#    marital3  Marital status = LIVING TOGETHER
#    marital4  Marital status = DIVORCED
#    marital5  Marital status = WIDOWED
#    marital6  Marital status = OTHER
#    alone     Respondent lives alone
#
resp1    <- recode(svy$d1, "1=1; 5:9=1; NA=1; else=0")
resp2    <- recode(svy$d1, "2=1; else=0")
resp3    <- recode(svy$d1, "3=1; else=0")
resp4    <- recode(svy$d1, "4=1; else=0")
age      <- recode(svy$d2, "888=NA; 999=NA")
ageGrp1  <- recode(age,"50:59=1; NA=NA; else=0")
ageGrp2  <- recode(age,"60:69=1; NA=NA; else=0")
ageGrp3  <- recode(age,"70:79=1; NA=NA; else=0")
ageGrp4  <- recode(age,"80:89=1; NA=NA; else=0")
ageGrp5  <- recode(age,"90:hi=1; NA=NA; else=0")
sex1     <- recode(svy$d3, "1=1; 2=0; else=NA")
sex2     <- recode(svy$d3, "1=0; 2=1; else=NA")
marital1 <- recode(svy$d4, "1=1; else=0")
marital2 <- recode(svy$d4, "2=1; else=0")
marital3 <- recode(svy$d4, "3=1; else=0")
marital4 <- recode(svy$d4, "4=1; else=0")
marital5 <- recode(svy$d4, "5=1; else=0")
marital6 <- recode(svy$d4, "6=1; else=0")
alone    <- recode(svy$d5, "1=1; else=0")


################################################################################
#
#  Dietary intake indicators
#
#  Indicators are :
#
#    MF           Meal frequency
#    DDS          DDS (count of 11 groups)
#    FG01         Cereals
#    FG02         Roots and tubers
#    FG03         Fruits and vegetables
#    FG04         All meat
#    FG05         Eggs
#    FG06         Fish
#    FG07         Legumes, nuts, and seeds
#    FG08         Milk and milk products
#    FG09         Fats
#    FG10         Sugar
#    FG11         Other
#    aProtein	   Protein rich animal sources of protein
#    pProtein	   Protein rich plant sources of protein
#    proteinRich  Protein rich foods
#    pVitA        Plant sources of vitamin A
#    aVitA        Animal sources of vitamin A
#    xVitA        Any source of vitamin A
#    ironRich     Iron rich foods
#    caRich       Calcium rich foods
#    znRich       Zinc rich foods
#    vitB1        Vitamin B1-rich foods
#    vitB2        Vitamin B2-rich foods
#    vitB3        Vitamin B3-rich foods
#    vitB6        Vitamin B6-rich foods
#    vitB12       Vitamin B12-rich foods
#    vitBcomplex  Vitamin B1/B2/B3/B6/B12-rich foods
#
#  The basic approach used is described in:
#
#    Kennedy G, Ballard T, Dop M C (2011). Guidelines for Measuring Household
#    and Individual Dietary Diversity. Rome, FAO
#
#  and extended to include indicators of probable adequate intake of a number of
#  nutrients / micronutrients.
#

################################################################################
#
#  Meal frequency
#
MF <- recode(svy$f1, "9=0; NA=0")

################################################################################
#
#  Recode dietary diversity data
#
svy$f2a <- recode(svy$f2a, "1=1; else=0")
svy$f2b <- recode(svy$f2b, "1=1; else=0")
svy$f2c <- recode(svy$f2c, "1=1; else=0")
svy$f2d <- recode(svy$f2d, "1=1; else=0")
svy$f2e <- recode(svy$f2e, "1=1; else=0")
svy$f2f <- recode(svy$f2f, "1=1; else=0")
svy$f2g <- recode(svy$f2g, "1=1; else=0")
svy$f2h <- recode(svy$f2h, "1=1; else=0")
svy$f2i <- recode(svy$f2i, "1=1; else=0")
svy$f2j <- recode(svy$f2j, "1=1; else=0")
svy$f2k <- recode(svy$f2k, "1=1; else=0")
svy$f2l <- recode(svy$f2l, "1=1; else=0")
svy$f2m <- recode(svy$f2m, "1=1; else=0")
svy$f2n <- recode(svy$f2n, "1=1; else=0")
svy$f2o <- recode(svy$f2o, "1=1; else=0")
svy$f2p <- recode(svy$f2p, "1=1; else=0")
svy$f2q <- recode(svy$f2q, "1=1; else=0")
svy$f2r <- recode(svy$f2r, "1=1; else=0")
svy$f2s <- recode(svy$f2s, "1=1; else=0")

################################################################################
#
#  Dietary diversity
#
#    Recode to ELEVEN standard food groups :
#
#      Var    Food group                               From ...
#      ----   ---------------------------------------  ---------------
#      FG01   Cereals                                  (f2c)
#      FG02   Roots and tubers                         (f2g)
#      FG03   Fruits and vegetables                    (f2d, f2f, f2i)
#      FG04   All meat                                 (f2j, f2k, f2q)
#      FG05   Eggs                                     (f2n)
#      FG06   Fish                                     (f2l)
#      FG07   Legumes, nuts, and seeds                 (f2h)
#      FG08   Milk and milk products                   (f2a, f2m)
#      FG09   Fats                                     (f2e, f2o)
#      FG10   Sugar                                    (f2r)
#      FG11   Other                                    (f2b, f2p, f2s)
#      ----   ---------------------------------------  ---------------
#
#    and sum into 'DDS' ...
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

################################################################################
#
#  Protein rich foods in diet from aminal, plant, and all sources
#
aProtein <- ifelse(svy$f2j == 1 | svy$f2k == 1 | svy$f2q ==1 | svy$f2n == 1 | svy$f2a == 1 | svy$f2m == 1, 1, 0)
pProtein <- ifelse(svy$f2h == 1 | svy$f2p == 1, 1, 0)
proteinRich <- ifelse(aProtein == 1 | pProtein == 1, 1, 0)

################################################################################
#
#  Micronutrient intake (vitamin A, iron, calcium, zinc)
#
#    pVitA     Respondent consumes plant sources of vitamin A
#    aVitA     Respondent consumes animal sources of vitamin A
#    xVitA     Respondent consumes any source of vitamin A
#    ironRich  Respondent consumes iron rich foods
#    caRich    Respondent consumes calcium rich foods
#    znRich    Respondent consumes zinc rich foods
#
pVitA    <- ifelse(svy$f2d == 1 | svy$f2e == 1 | svy$f2f == 1, 1, 0)
aVitA    <- ifelse(svy$f2a == 1 | svy$f2j == 1 | svy$f2m == 1 | svy$f2n == 1, 1, 0)
xVitA    <- ifelse(pVitA == 1 | aVitA == 1, 1, 0)
ironRich <- ifelse(svy$f2f == 1 | svy$f2j == 1 | svy$f2k == 1 | svy$f2l == 1, 1, 0)
caRich   <- ifelse(svy$f2a == 1 | svy$f2m == 1, 1, 0)
znRich   <- ifelse(svy$f2h == 1 | svy$f2j == 1 | svy$f2k == 1 | svy$f2l == 1 | svy$f2p == 1 | svy$f2q == 1, 1, 0)

#################################################################################
#
#  Micronutrient intake (B vitamins)
#
#	vitB1        Respondent consumes vitamin B1-rich foods
#	vitB2        Respondent consumes vitamin B2-rich foods
#	vitB3        Respondent consumes vitamin B3-rich foods
#	vitB6        Respondent consumes vitamin B6-rich foods
#	vitB12       Respondent consumes vitamin B12-rich foods
#	vitBcomplex  Respondent consumes vitamin B1/B2/B3/B6/B12-rich foods
#
vitB1  <- ifelse(svy$f2a == 1 | svy$f2e == 1 | svy$f2h == 1 | svy$f2j == 1 | svy$f2k == 1 | svy$f2l == 1 | svy$f2m == 1 | svy$f2n == 1 | svy$f2p == 1, 1, 0)
vitB2  <- ifelse(svy$f2a == 1 | svy$f2f == 1 | svy$f2h == 1 | svy$f2j == 1 | svy$f2k == 1 | svy$f2l == 1 | svy$f2m == 1, 1, 0)
vitB3  <- ifelse(svy$f2h == 1 | svy$f2j == 1 | svy$f2k == 1 | svy$f2l == 1, 1, 0)
vitB6  <- ifelse(svy$f2d == 1 | svy$f2f == 1 | svy$f2h == 1 | svy$f2i == 1 | svy$f2k == 1 | svy$f2l == 1, 1, 0)
vitB12 <- ifelse(svy$f2j == 1 | svy$f2k == 1 | svy$f2l == 1 | svy$f2m == 1 | svy$f2n == 1, 1, 0)
vitBsources <- vitB1 + vitB2 + vitB3 + vitB6 + vitB12
vitBcomplex <- ifelse(vitBsources == 5, 1, 0)

################################################################################
#
# Clean-up
#
rm(vitBsources)


################################################################################
#
#  Household Hunger Scale (HHS)
#
#  Indicators are :
#
#    HHS1  Little or no hunger in household
#    HHS2  Moderate hunger in household
#    HHS3  Severe hunger in household
#
#  The HHS is described in :
#
#    Ballard T, Coates J, Swindale A, Deitchler M (2011). Household Hunger
#    Scale: Indicator Definition and Measurement Guide. Washington DC,
#    FANTA-2 Bridge, FHI 360
#

################################################################################
#
#  Recode component variables
#
svy$f3 <- recode(svy$f3, "1=1; 2=1; 3=2; else=0")
svy$f4 <- recode(svy$f4, "1=1; 2=1; 3=2; else=0")
svy$f5 <- recode(svy$f5, "1=1; 2=1; 3=2; else=0")

################################################################################
#
#  Sum components and classify hunger into three separate indicator variables
#
sumHHS <- svy$f3 + svy$f4 + svy$f5
HHS1 <- recode(sumHHS, "0:1=1; else=0")
HHS2 <- recode(sumHHS, "2:3=1; else=0")
HHS3 <- recode(sumHHS, "4:6=1; else=0")

###############################################################################
#
#  Clean-up
#
rm(sumHHS)


################################################################################
#
#  Katz "Index of Independence in Activities of Daily Living" (ADL) score
#
#  Indicators are :
#
#    ADL01      Bathing
#    ADL02      Dressing
#    ADL03      Toileting
#    ADL04      Transferring (mobility)
#    ADL05      Continence
#    ADL06      Feeding
#    scoreADL   ADL score
#    classADL1  Severity of dependence = INDEPENDENT
#    classADL2  Severity of dependence = PARTIAL DEPENDENCY
#    classADL3  Severity of dependence = SEVERE DEPENDENCY
#    hasHelp    Has someone to help with ADL
#    unmetNeed  Unmet need (dependency with NO helper)
#
#
#    The Katz ADL score is described in :
#
#      Katz S, Ford AB, Moskowitz RW, Jackson BA, Jaffe MW (1963). Studies
#      of illness in the aged. The Index of ADL: a standardized measure of
#      biological and psychosocial function. JAMA, 1963, 185(12):914-9
#
#      Katz S, Down TD, Cash HR, Grotz, RC (1970). Progress in the development
#      of the index of ADL. The Gerontologist, 10(1), 20-30
#
#      Katz S (1983). Assessing self-maintenance: Activities of daily living,
#      mobility and instrumental activities of daily living. JAGS, 31(12),
#      721-726
#

################################################################################
#
#  Recode ADL (activities of daily living) score data
#
#  Each item is scored :
#
#    1 = Independence
#    0 = Needs assistance or supervision
#
ADL01 <- recode(svy$a1, "2=1; else=0")    # Bathing
ADL02 <- recode(svy$a2, "2=1; else=0")    # Dressing
ADL03 <- recode(svy$a3, "2=1; else=0")    # Toileting
ADL04 <- recode(svy$a4, "2=1; else=0")    # Transferring (mobility)
ADL05 <- recode(svy$a5, "2=1; else=0")    # Continence
ADL06 <- recode(svy$a6, "2=1; else=0")    # Feeding

################################################################################
#
#  Create ADL score (items summed over all six activities / dimensions)
#
scoreADL <- ADL01 + ADL02 + ADL03 + ADL04 + ADL05 + ADL06

################################################################################
#
#  Severity of dependence (from Katz ADL score)
#
#    Indicator    Degree of severity    Related Scores
#    ---------    ------------------    ----------------
#    classADL1    Independent           scoreADL = 5,6
#    classADL2    Partial dependency    scoreADL = 3,4
#    classADL3    Severe dependency     scoreADL = 0,1,2
#    ---------    ------------------    ----------------
#
classADL1 <- recode(scoreADL, "5:6=1; else=0")
classADL2 <- recode(scoreADL, "3:4=1; else=0")
classADL3 <- recode(scoreADL, "0:2=1; else=0")

################################################################################
#
#  Does the subject have someone to help with everyday activities?
#
hasHelp <- recode(svy$a7, "1=1; else=0")

################################################################################
#
#  Does the subject need help but has no helper?
#
#  Note : Denominator is entire sample so the indicator is the proportion of
#         the population with unmet ADl help needs
#
unmetNeed <- ifelse(scoreADL < 6 & hasHelp == 0, 1, 0)


################################################################################
#
#  K6 : Short form psychological distress score
#
#  Indicators are :
#
#    K6      K6 score
#    K6Case  K6 score > 12  (in serious psychological distress)
#
#  The K6 score is described in :
#
#    Kessler RC, Andrews G, Colpe LJ, Hiripi E, Mroczek, DK, Normand SLT,
#    et al. (2002). Short screening scales to monitor population prevalences
#    and trends in non-specific psychological distress. Psychological
#    Medicine, 32(6), 959–976
#

################################################################################
#
#  Recode DON'T KNOW, REFUSED, NA and MISSING values to 5 (NONE)
#
svy$k6a <- recode(svy$k6a, "6:9=5")
svy$k6b <- recode(svy$k6b, "6:9=5")
svy$k6c <- recode(svy$k6c, "6:9=5")
svy$k6d <- recode(svy$k6d, "6:9=5")
svy$k6e <- recode(svy$k6e, "6:9=5")
svy$k6f <- recode(svy$k6f, "6:9=5")

################################################################################
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

################################################################################
#
#  Apply case-definition for serious psychological distress(i.e. K6 > 12)
#
K6Case <- recode(K6, "0:12=0; 13:hi=1")


################################################################################
#
#  Brief Community Screening Instrument for Dementia (CSID)
#
#  Indicators are :
#
#    DS  Probable dementia by CSID screen
#
#  The CSID dementia screening tool is described in :
#
#      Prince M, et al. (2010). A brief dementia screener suitable for use
#      by non-specialists in resource poor settings - The cross-cultural
#      derivation and validation of the brief Community Screening Instrument
#      for Dementia. International Journal of Geriatric Psychiatry, 26(9),
#      899–907
#

################################################################################
#
#  Recode scored components to 0 / 1 (with 1 = correct)
#
svy$ds1  <- recode(svy$ds1,  "1=1; else=0") # Nose
svy$ds2  <- recode(svy$ds2,  "1=1; else=0") # Hammer
svy$ds3  <- recode(svy$ds3,  "1=1; else=0") # Day of week
svy$ds4  <- recode(svy$ds4,  "1=1; else=0") # Season
svy$ds5  <- recode(svy$ds5,  "1=1; else=0") # Point to window then door
svy$ds6a <- recode(svy$ds6a, "1=1; else=0") # Memory "CHILD"
svy$ds6b <- recode(svy$ds6b, "1=1; else=0") # Memory "HOUSE"
svy$ds6c <- recode(svy$ds6c, "1=1; else=0") # Memory "ROAD"

################################################################################
#
#  Sum correct items into CSID score
#
scoreCSID <- svy$ds1 + svy$ds2 + svy$ds3 + svy$ds4 + svy$ds5 + svy$ds6a + svy$ds6b + svy$ds6c

#################################################################################
#
#  Classify dementia :
#
#    0 = Normal (not probable dementia)
#    1 = Probable dementia
#
DS <- recode(scoreCSID, "0:4=1; 5:8=0")

################################################################################
#
#  Clean-up
#
rm(scoreCSID)


################################################################################
#
#  Health and health-seeking indicators
#
#  Indicators are :
#
#    H1   Chronic condition
#
#    H2   Takes drugs regularly for chronic condition
#
#    H3x  Main reason for not taking drugs for chronic condition where :
#
#           x = 1    No drugs available
#           x = 2    Too expensive / no money
#           x = 3    Too old to look for care
#           x = 4    Use traditional medicine
#           x = 5    Drugs don't help
#           x = 6    No-one to help me
#           x = 7    No need
#           x = 8    Other
#           x = 9    No reason given
#
#    H4   Recent disease episode
#
#    H5   Accessed care for recent disease episode
#
#    H6x  Main reason for not accessing care for recent disease episode where :
#
#           x = 1    No drugs available
#           x = 2    Too expensive / no money
#           x = 3    Too old to look for care
#           x = 4    Use traditional medicine
#           x = 5    Drugs don't help
#           x = 6    No-one to help me
#           x = 7    No need
#           x = 8    Other
#           x = 9    No reason given
#

################################################################################
#
#  Health indicators : CHRONIC CONDITIONS
#
svy$h1 <- recode(svy$h1, "1=1; else=2")
H1 <- recode(svy$h1, "1=1; else=0")
H2 <- ifelse(H1 == 0, NA, recode(svy$h2, "1=1; else=0"))
H3 <- ifelse(H2 == 1, NA, recode(svy$h3, "NA=9"))
#
# Indicators for main reason for NOT taking drugs for chronic condition
#
H31 <- recode(H3, "1=1; NA=NA; else=0")
H32 <- recode(H3, "2=1; NA=NA; else=0")
H33 <- recode(H3, "3=1; NA=NA; else=0")
H34 <- recode(H3, "4=1; NA=NA; else=0")
H35 <- recode(H3, "5=1; NA=NA; else=0")
H36 <- recode(H3, "6=1; NA=NA; else=0")
H37 <- recode(H3, "7=1; NA=NA; else=0")
H38 <- recode(H3, "8=1; NA=NA; else=0")
H39 <- recode(H3, "9=1; NA=NA; else=0")

################################################################################
#
#  Health indicators : RECENT DISEASE EPISODE
#
svy$h4 <- recode(svy$h4, "1=1; else=2")
H4 <- recode(svy$h4, "1=1; else=0")
H5 <- ifelse(H4 == 0, NA, recode(svy$h5, "1=1; else=0"))
H6 <- ifelse(H5 == 1, NA, recode(svy$h6, "NA=9"))
#
#
# Indicators for main reason for NOT accessing care for recent disease episode
#
H61 <- recode(H6, "1=1; NA=NA; else=0")
H62 <- recode(H6, "2=1; NA=NA; else=0")
H63 <- recode(H6, "3=1; NA=NA; else=0")
H64 <- recode(H6, "4=1; NA=NA; else=0")
H65 <- recode(H6, "5=1; NA=NA; else=0")
H66 <- recode(H6, "6=1; NA=NA; else=0")
H67 <- recode(H6, "7=1; NA=NA; else=0")
H68 <- recode(H6, "8=1; NA=NA; else=0")
H69 <- recode(H6, "9=1; NA=NA; else=0")

#
# Clean-up
#
rm(H3, H6)


###############################################################################
#
#  Income and income sources
#
#  Indicators are :
#
#    M1   Has a personal income
#    M2A  Agriculture / fishing / livestock
#    M2B  Wages / salary
#    M2C  Sale of charcoal / bricks / &c.
#    M2D  Trading (e.g. market or shop)
#    M2E  Investments
#    M2F  Spending savings / sale of assets
#    M2G  Charity
#    M2H  Cash transfer / Social security
#    M2I  Other
#

################################################################################
#
#  Create binary indicators
#
M1  <- recode(svy$m1,  "1=1; else=0") # Has a personal income
M2A <- recode(svy$m2a, "1=1; else=0") # Agriculture / fishing / livestock
M2B <- recode(svy$m2b, "1=1; else=0") # Wages / salary
M2C <- recode(svy$m2c, "1=1; else=0") # Sale of charcoal / bricks / &c.
M2D <- recode(svy$m2d, "1=1; else=0") # Trading (e.g. market or shop)
M2E <- recode(svy$m2e, "1=1; else=0") # Investments
M2F <- recode(svy$m2f, "1=1; else=0") # Spending savings / sale of assets
M2G <- recode(svy$m2g, "1=1; else=0") # Charity
M2H <- recode(svy$m2h, "1=1; else=0") # Cash transfer / social security
M2I <- recode(svy$m2i, "1=1; else=0") # Other

################################################################################
#
#  Check for any income (return 'correct' result in M1)
#
checkForIncome <- M1 + M2A + M2B + M2C + M2D + M2E + M2F + M2G + M2H + M2I
M1 <- ifelse(checkForIncome > 0, 1, 0)

################################################################################
#
# Clean-up
#
rm(checkForIncome)


################################################################################
#
#  Water, Sanitation, and Hygiene (WASH) indicators
#
#  Indicators are :
#
#      W1  Improved source of drinking water
#      W2  Safe drinking water (improved source OR adequate treatment)
#      W3  Improved sanitation facility
#      W4  Improved non-shared sanitation facility
#
#  These are a (core) subset of indicators from :
#
#     WHO / UNICEF (2006). Core Questions on Drinking-water and Sanitation
#     for Household Surveys. Geneva, WHO / UNICEF
#

################################################################################
#
#  Recode WASH data
#
svy$w1 <- recode(svy$w1, "1=1; else=0")
svy$w2 <- recode(svy$w2, "1=1; else=0")
svy$w3 <- recode(svy$w3, "1=1; else=0")
svy$w4 <- recode(svy$w4, "1=1; else=0")

################################################################################
#
#  Create WASH indicators
#
W1 <- svy$w1
W2 <- ifelse(svy$w1 == 1 | svy$w2 == 1, 1, 0)
W3 <- svy$w3
W4 <- ifelse(svy$w3 == 1 & svy$w4 != 1, 1, 0)


################################################################################
#
#  Anthropometry and screening
#
#  Indicators are :
#
#    MUAC      MUAC
#    oedema    Bilateral pitting oedema (may not be nutritional)
#    screened  Either MUAC or oedema checked previously
#

################################################################################
#
#  Censor REFUSAL, NOT APPLICABLE, and MISSING values codes in MUAC and Oedema
#
MUAC <- recode(svy$as1, "777=NA; 888=NA; 999=NA")
oedema <- recode(svy$as3, "1=1; else=0")

################################################################################
#
#  Screening for GAM, MAM, SAM (i.e. either MUAC or oedema checked previously)
#
screened <- ifelse(svy$as2 == 1 | svy$as4 == 1, 1, 0)


################################################################################
#
#  Visual impairment by "Tumbling E" method
#
#  Indicators are :
#
#    poorVA  Poor visual acuity (correct in < 3 of 4 tests)
#
#  Refusal and blindness are treated as test failures
#
#  The "Tumbling E" method is described in :
#
#    Taylor HR (1978). Applying new design principles to the construction of an
#    illiterate E Chart. Am J Optom & Physiol Optics 55:348
#

################################################################################
#
#  Create binary indicators
#
svy$va2a <- recode(svy$va2a, "1=1; else=0")
svy$va2b <- recode(svy$va2b, "1=1; else=0")
svy$va2c <- recode(svy$va2c, "1=1; else=0")
svy$va2d <- recode(svy$va2d, "1=1; else=0")
sumVA <- svy$va2a + svy$va2b + svy$va2c + svy$va2d
poorVA <-  ifelse(sumVA < 3, 1, 0)

###############################################################################
#
#  Clean-up
#
rm(sumVA)


################################################################################
#
#  Miscellaneous indicators
#
#  Indicators are :
#
#    chew  Problems chewing food
#    food  Anyone in HH receives a ration
#    NFRI  Anyone in HH received non-food relief item(s) in previous month
#
chew <- recode(svy$a8, "1=1; else=0")
food <- recode(svy$f6, "1=1; else=0")
NFRI <- recode(svy$f7, "1=1; else=0")


################################################################################
#
#  Washington Group (WG) short set of question designed to identify people with a
#  disability in a census or survey format.
#
#  See:
#
#    http://www.washingtongroup-disability.com
#
#    https://www.cdc.gov/nchs/washington_group/wg_documents.htm
#
#  for details.
#

################################################################################
#
# Missing values
#
svy$wg1 <- recode(svy$wg1, "9=0; NA=0")
svy$wg2 <- recode(svy$wg2, "9=0; NA=0")
svy$wg3 <- recode(svy$wg3, "9=0; NA=0")
svy$wg4 <- recode(svy$wg4, "9=0; NA=0")
svy$wg5 <- recode(svy$wg5, "9=0; NA=0")
svy$wg6 <- recode(svy$wg6, "9=0; NA=0")

################################################################################
#
# Vision domain
#
wgVisionD0 <- ifelse(svy$wg1 == 0, 1, 0)
wgVisionD1 <- ifelse(svy$wg1 == 1 | svy$wg1 == 2 | svy$wg1 == 3, 1, 0)
wgVisionD2 <- ifelse(svy$wg1 == 2 | svy$wg1 == 3, 1, 0)
wgVisionD3 <- ifelse(svy$wg1 == 3, 1, 0)

################################################################################
#
# Hearing domain
#
wgHearingD0 <- ifelse(svy$wg2 == 0, 1, 0)
wgHearingD1 <- ifelse(svy$wg2 == 1 | svy$wg2 == 2 | svy$wg2 == 3, 1, 0)
wgHearingD2 <- ifelse(svy$wg2 == 2 | svy$wg2 == 3, 1, 0)
wgHearingD3 <- ifelse(svy$wg2 == 3, 1, 0)

################################################################################
#
# Mobility domain
#
wgMobilityD0 <- ifelse(svy$wg3 == 0, 1, 0)
wgMobilityD1 <- ifelse(svy$wg3 == 1 | svy$wg3 == 2 | svy$wg3 == 3, 1, 0)
wgMobilityD2 <- ifelse(svy$wg3 == 2 | svy$wg3 == 3, 1, 0)
wgMobilityD3 <- ifelse(svy$wg3 == 3, 1, 0)


################################################################################
#
# Remembering domain
#
wgRememberingD0 <- ifelse(svy$wg4 == 0, 1, 0)
wgRememberingD1 <- ifelse(svy$wg4 == 1 | svy$wg4 == 2 | svy$wg4 == 3, 1, 0)
wgRememberingD2 <- ifelse(svy$wg4 == 2 | svy$wg4 == 3, 1, 0)
wgRememberingD3 <- ifelse(svy$wg4 == 3, 1, 0)

################################################################################
#
# Self-care domain
#
wgSelfCareD0 <- ifelse(svy$wg5 == 0, 1, 0)
wgSelfCareD1 <- ifelse(svy$wg5 == 1 | svy$wg5 == 2 | svy$wg5 == 3, 1, 0)
wgSelfCareD2 <- ifelse(svy$wg5 == 2 | svy$wg5 == 3, 1, 0)
wgSelfCareD3 <- ifelse(svy$wg5 == 3, 1, 0)

################################################################################
#
# Communicating domain
#
wgCommunicatingD0 <- ifelse(svy$wg6 == 0, 1, 0)
wgCommunicatingD1 <- ifelse(svy$wg6 == 1 | svy$wg6 == 2 | svy$wg6 == 3, 1, 0)
wgCommunicatingD2 <- ifelse(svy$wg6 == 2 | svy$wg6 == 3, 1, 0)
wgCommunicatingD3 <- ifelse(svy$wg6 == 3, 1, 0)

################################################################################
#
# Overall prevalence
#
wgP0 <- ifelse(wgVisionD0 + wgHearingD0 + wgMobilityD0 + wgRememberingD0 + wgSelfCareD0 + wgCommunicatingD0 == 6, 1, 0)
wgP1 <- ifelse(wgVisionD1 + wgHearingD1 + wgMobilityD1 + wgRememberingD1 + wgSelfCareD1 + wgCommunicatingD1 >  0, 1, 0)
wgP2 <- ifelse(wgVisionD2 + wgHearingD2 + wgMobilityD2 + wgRememberingD2 + wgSelfCareD2 + wgCommunicatingD2 >  0, 1, 0)
wgP3 <- ifelse(wgVisionD3 + wgHearingD3 + wgMobilityD3 + wgRememberingD3 + wgSelfCareD3 + wgCommunicatingD3 >  0, 1, 0)
wgPM <- ifelse(wgVisionD1 + wgHearingD1 + wgMobilityD1 + wgRememberingD1 + wgSelfCareD1 + wgCommunicatingD1 >  1, 1, 0)


################################################################################
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
                             ADL01, ADL02, ADL03, ADL04, ADL05, ADL06, scoreADL, classADL1, classADL2, classADL3, hasHelp, unmetNeed,
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

devtools::use_data(indicators.ALL, overwrite = TRUE)

#
# Subset summary data.frames for MALES and FEMALES
#
indicators.MALES   <- subset(indicators.ALL, sex1 == 1)
indicators.FEMALES <- subset(indicators.ALL, sex2 == 1)

devtools::use_data(indicators.MALES, overwrite = TRUE)
devtools::use_data(indicators.FEMALES, overwrite = TRUE)

#
# Clean-up
#
rm(psu, resp1, resp2, resp3, resp4,
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
   ADL01, ADL02,  ADL03, ADL04, ADL05, ADL06, scoreADL, classADL1, classADL2, classADL3, hasHelp, unmetNeed,
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
gc()

#
# Restore 'svy' from back-up copy (i.e. to undo recoding used when making indicators)
#
svy <- svyBackup

rm(svyBackup)
