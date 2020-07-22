################################################################################
#
#' An Implementation of Rapid Assessment Method for Older People (RAM-OP) in R
#'
#' \href{http://www.helpage.org}{HelpAge International},
#' \href{http://www.validinternational.org}{VALID International}, and
#' \href{http://www.brixtonhealth.com}{Brixton Health}, with financial
#' assistance from the
#' \href{http://www.elrha.org/hif/home/}{Humanitarian Innovation Fund (HIF)},
#' have developed a \strong{Rapid Assessment Method for Older People (RAM-OP)}
#' that provides accurate and reliable estimates of the needs of older people.
#' The method uses simple procedures, in a short time frame (i.e. about two
#' weeks including training, data collection, data entry, and data analysis),
#' and at considerably lower cost than other methods.
#'
#' The \strong{RAM-OP} method is based on the following principles:
#'
#' \enumerate{
#'   \item Use of a familiar *“household survey”* design employing a two-stage
#'     cluster sample design optimised to allow the use of a small primary sample
#'     (\eqn{m \geq 16} clusters) and a small overall (\eqn{n \geq 192}) sample.
#'
#'   \item Assessment of multiple dimensions of need in older people (including
#'     prevalence of global, moderate and severe acute malnutrition) using,
#'     whenever possible, standard and well-tested indicators and question sets.
#'
#'   \item Data analysis performed using modern computer-intensive methods to
#'     allow estimates of indicator levels to be made with useful precision using
#'     a small sample size.
#' }
#'
#' See the README at \href{GitHub}{https://github.com/rapidsurveys/oldr#readme}
#' for further details
#'
#' @docType package
#' @name oldr
#' @keywords internal
#' @importFrom utils browseURL
#' @importFrom stats runif na.omit pnorm sd quantile
#' @importFrom graphics axTicks axis barplot boxplot hist par
#' @importFrom grDevices dev.off png
#' @importFrom bbw bootBW bootClassic bootPROBIT
#' @importFrom car powerTransform bcPower
#' @importFrom withr with_par with_output_sink with_options
#' @importFrom tibble tibble
#' @importFrom rmarkdown render
#'
#
################################################################################
"_PACKAGE"

## quiets concerns of R CMD check re: globalVariables
if(getRversion() >= "2.15.1")  utils::globalVariables("originalOrder")


################################################################################
#
#' RAM-OP Survey Dataset
#'
#' Dataset collected from a RAM-OP survey conducted in Addis Ababa, Ethiopia
#' in early 2014
#'
#' @format A data frame with 91 columns and 192 rows:
#' \describe{
#'   \item{\code{ad2}}{Team number}
#'   \item{\code{psu}}{PSU (cluster) number}
#'   \item{\code{hh}}{Household identifier}
#'   \item{\code{id}}{Person identifier}
#'   \item{\code{d1}}{Who is answering these questions?}
#'   \item{\code{d2}}{Age in years}
#'   \item{\code{d3}}{Sex}
#'   \item{\code{d4}}{Marital status}
#'   \item{\code{d5}}{Do you live alone?}
#'   \item{\code{f1}}{How many meals did you eat since this time yesterday?}
#'   \item{\code{f2a}}{Tinned, powdered or fresh milk?}
#'   \item{\code{f2b}}{Sweetened or flavoured water, soda drink, alcoholic
#'     drink, beer, tea or infusion, coffee, soup, or broth?}
#'   \item{\code{f2c}}{Any food made from grain such as millet, wheat, barley,
#'     sorghum, rice, maize, pasta, noodles, bread, pizza, porridge?}
#'   \item{\code{f2d}}{Any food made from fruits or vegetables that have yellow or
#'     orange flesh such as carrots, pumpkin, red sweet potatoes,
#'     mangoes, and papaya?}
#'   \item{\code{f2e}}{Any food made with red palm oil or red palm nuts?}
#'   \item{\code{f2f}}{Any dark green leafy vegetables such as cabbage, broccoli,
#'     spinach, moringa leaves, cassava leaves?}
#'   \item{\code{f2g}}{Any food made from roots or tubers such as white potatoes,
#'     white yams, false banana, cassava, manioc, onions, beets, turnips,
#'     and swedes?}
#'   \item{\code{f2h}}{Any food made from lentils, beans, peas, groundnuts, nuts,
#'     or seeds?}
#'   \item{\code{f2i}}{Any other fruits or vegetables such as banana, plantain,
#'     avocado, cauliflower, coconut?}
#'   \item{\code{f2j}}{Liver, kidney, heart, black pudding, blood, or other organ
#'     meats?}
#'   \item{\code{f2k}}{Any meat such as beef, pork, goat, lamb, mutton, veal,
#'     chicken, camel, or bush meat?}
#'   \item{\code{f2l}}{Fresh or dried fish, shellfish, or seafood?}
#'   \item{\code{f2m}}{Cheese, yoghurt, or other milk products?}
#'   \item{\code{f2n}}{Eggs?}
#'   \item{\code{f2o}}{Any food made with oil, fat, butter, or ghee?}
#'   \item{\code{f2p}}{Any mushrooms or fungi?}
#'   \item{\code{f2q}}{Grubs, snails, insects?}
#'   \item{\code{f2r}}{Sugar, honey and foods made with sugar or honey such as
#'     sweets, candies, chocolate, cakes, and biscuits?}
#'   \item{\code{f2s}}{Salt, pepper, herbs, spices, or sauces (hot sauce, soy
#'     sauce, ketchup)?}
#'   \item{\code{f3}}{In the past four weeks, how often was there ever no
#'     food to eat of any kind in your home because of lack of resources to
#'     get food?}
#'   \item{\code{f4}}{In the past four weeks, how often did you go to sleep
#'     at night hungry because there was not enough food?}
#'   \item{\code{f5}}{In the past four weeks, how often did you go a whole
#'     day and night without eating anything at all because there was not
#'     enough food?}
#'   \item{\code{f6}}{Are you or anyone in your household receiving a food
#'     ration on a regular basis?}
#'   \item{\code{f7}}{Have you or another member of your household received
#'     non-food relief items such as soap, bucket, water container, bedding,
#'     mosquito net, clothes, or plastic sheet in the previous four weeks?}
#'   \item{\code{a1}}{Have you or another member of your household received
#'     non-food relief items such as soap, bucket, water container, bedding,
#'     mosquito net, clothes, or plastic sheet in the previous four weeks?}
#'   \item{\code{a2}}{Do you need help getting dressed partially or completely
#'     (not including tying of shoes)?}
#'   \item{\code{a3}}{Do you need help going to the toilet or cleaning yourself
#'     after using the toilet or do you use a commode or bed-pan?}
#'   \item{\code{a4}}{Do you need someone (i.e. not a walking aid) to help you
#'     move from a bed to a chair?}
#'   \item{\code{a5}}{Are you partially or totally incontinent of bowel or
#'     bladder?}
#'   \item{\code{a6}}{Do you need partial or total help with eating?}
#'   \item{\code{a7}}{Is someone taking care of you or helping you with everyday
#'     activities such as shopping, cooking, bathing and dressing?}
#'   \item{\code{a8}}{Do you have problems chewing food?}
#'   \item{\code{k6a}}{About how often during the past four weeks did you
#'     feel nervous – all of the time, most of the time, some of the time, a
#'     little of the time, or none of the time?}
#'   \item{\code{k6b}}{During the past four weeks, about how often did you
#'     feel hopeless – all of the time, most of the time, some of the time, a
#'     little of the time, or none of the time?}
#'   \item{\code{k6c}}{During the past four weeks, about how often did you feel
#'     restless or fidgety – all of the time, most of the time, some of the time,
#'     a little of the time, or none of the time?}
#'   \item{\code{k6d}}{During the past four weeks, about how often did you
#'     feel so depressed that nothing could cheer you up – all of the time, most
#'     of the time, some of the time, a little of the time, or none of the time?}
#'   \item{\code{k6e}}{During the past four weeks, about how often did you feel
#'     that everything was an effort – all of the time, most of the time, some of
#'     the time, a little of the time, or none of the time?}
#'   \item{\code{k6f}}{During the past four weeks, about how often did you
#'     feel worthless – all of the time, most of the time, some of the time, a
#'     little of the time, or none of the time?}
#'   \item{\code{ds1}}{Point to nose and ask "What do you call this?"}
#'   \item{\code{ds2}}{What do you do with a hammer?}
#'   \item{\code{ds3}}{What day of the week is it?}
#'   \item{\code{ds4}}{What is the season?}
#'   \item{\code{ds5}}{Please point first to the window and then to the door.}
#'   \item{\code{ds6a}}{Child}
#'   \item{\code{ds6b}}{House}
#'   \item{\code{ds6c}}{Road}
#'   \item{\code{h1}}{Do you suffer from a long term disease that requires you to
#'     take regular medication?}
#'   \item{\code{h2}}{Do you take drugs regularly for this?}
#'   \item{\code{h3}}{Why not?}
#'   \item{\code{h4}}{Have you been ill in the past two weeks?}
#'   \item{\code{h5}}{Did you go to the pharmacy, dispensary, health centre,
#'     health post, clinic, or hospital?}
#'   \item{\code{h6}}{Why not?}
#'   \item{\code{m1}}{Do you have a personal source of income or money?}
#'   \item{\code{m2a}}{Where does your income or money come from?: Agriculture,
#'     livestock, or fishing}
#'   \item{\code{m2b}}{Where does your income or money come from?: Wages or
#'     salary}
#'   \item{\code{m2c}}{Where does your income or money come from?: Sale of
#'     charcoal, bricks, firewood, poles, etc.}
#'   \item{\code{m2d}}{Where does your income or money come from?: Trading
#'     (e.g. market, shop)}
#'   \item{\code{m2e}}{Where does your income or money come from?: Private
#'     pension, investments, interest, rents, etc.}
#'   \item{\code{m2f}}{Where does your income or money come from?: Spending
#'     savings; Sale of household goods, personal goods, or jewellery; Sale of
#'     livestock, land, or other assets}
#'   \item{\code{m2g}}{Where does your income or money come from?: Aid, gifts,
#'     charity (e.g. from church, mosque, temple), begging, borrowing, or sale of
#'     food aid or relief items}
#'   \item{\code{m2h}}{Where does your income or money come from?: Cash transfer
#'     (NGO, UNO, government); State pension, social security, benefits,
#'     welfare program}
#'   \item{\code{m2i}}{Where does your income or money come from?: Other}
#'   \item{\code{w1}}{What is your main source of drinking water?}
#'   \item{\code{w2}}{What do you usually do to the water to make it
#'     safer to drink?}
#'   \item{\code{w3}}{What kind of toilet facility do members of your household
#'     usually use?}
#'   \item{\code{w4}}{Do you share this toilet facility with other households?}
#'   \item{\code{as1}}{Mid-upper arm circumference (mm)}
#'   \item{\code{as2}}{Has someone measured your arm like this in the previous
#'     month?}
#'   \item{\code{as3}}{Bilateral pitting oedema}
#'   \item{\code{as4}}{Has someone examined your feet like this in the previous
#'     month?}
#'   \item{\code{va2a}}{Tumbling Es: first time}
#'   \item{\code{va2b}}{Tumbling Es: second time}
#'   \item{\code{va2c}}{Tumbling Es: third time}
#'   \item{\code{va2d}}{Tumbling Es: fourth time}
#'   \item{\code{wg1}}{Do you have difficulty seeing, even if wearing glasses?}
#'   \item{\code{wg2}}{Do you have difficulty hearing, even if using a hearing
#'     aid?}
#'   \item{\code{wg3}}{Do you have difficulty walking or climbing steps?}
#'   \item{\code{wg4}}{Do you have difficulty remembering or concentrating?}
#'   \item{\code{wg5}}{Do you have difficulty with self-care such as washing all
#'     over or dressing?}
#'   \item{\code{wg6}}{Using your usual (customary) language, do you have
#'     difficulty communicating, for example understanding or being understood?}
#' }
#'
#' @examples
#' testSVY
#'
#' @docType data
#' @keywords dataset
#'
#'
"testSVY"


################################################################################
#
#' RAM-OP Population Dataset
#'
#' This is a short and narrow file with one record per PSU and just two
#' variables
#'
#' @format A data frame with 2 columns and 16 rows:
#' \describe{
#'   \item{\code{psu}}{The PSU identifier. This must use the same coding system
#'     used to identify the PSUs that is used in the main RAM-OP dataset}
#'   \item{\code{pop}}{The population of the PSU}
#' }
#'
#' The PSU dataset is used during data analysis to weight data by PSU
#' population.
#'
#' @examples
#' testPSU
#'
#' @docType data
#' @keywords dataset
#'
#'
"testPSU"


################################################################################
#
#' RAM-OP Indicators Dataset - ALL
#'
#' Indicators dataset calculated from a dataset collected from a RAM-OP survey
#' conducted in Addis Ababa, Ethiopia in early 2014
#'
#' @format A data frame with 138 columns and 192 rows:
#' \describe{
#'   \item{\code{psu}}{Cluster (PSU) identifier}
#'   \item{\code{resp1}}{Respondent is SUBJECT}
#'   \item{\code{resp2}}{Respondent is FAMILY CARER}
#'   \item{\code{resp3}}{Respondent is OTHER CARER}
#'   \item{\code{resp4}}{Respondent is OTHER}
#'   \item{\code{age}}{Age of respondents (years)}
#'   \item{\code{ageGrp1}}{Age of respondent is between 50 and 59 years}
#'   \item{\code{ageGrp2}}{Age of respondent is between 60 and 69 years}
#'   \item{\code{ageGrp3}}{Age of respondent is between 70 and 79 years}
#'   \item{\code{ageGrp4}}{Age of respondent is between 80 and 89 years}
#'   \item{\code{ageGrp5}}{Age of respondent is 90 years or older}
#'   \item{\code{sex1}}{Sex = MALE}
#'   \item{\code{sex2}}{Sex = FEMALE}
#'   \item{\code{marital1}}{Marital status = SINGLE}
#'   \item{\code{marital2}}{Marital status = MARRIED}
#'   \item{\code{marital3}}{Marital status = LIVING TOGETHER}
#'   \item{\code{marital4}}{Marital status = DIVORCED}
#'   \item{\code{marital5}}{Marital status = WIDOWED}
#'   \item{\code{marital6}}{Marital status = OTHER}
#'   \item{\code{alone}}{Respondent lives alone}
#'   \item{\code{MF}}{Meal frequency}
#'   \item{\code{DDS}}{DDS (count of 11 groups)}
#'   \item{\code{FG01}}{Cereals}
#'   \item{\code{FG02}}{Roots and tubers}
#'   \item{\code{FG03}}{Fruits and vegetables}
#'   \item{\code{FG04}}{All meat}
#'   \item{\code{FG05}}{Eggs}
#'   \item{\code{FG06}}{Fish}
#'   \item{\code{FG07}}{Legumes, nuts, and seeds}
#'   \item{\code{FG08}}{Milk and milk products}
#'   \item{\code{FG09}}{Fats}
#'   \item{\code{FG10}}{Sugar}
#'   \item{\code{FG11}}{Other}
#'   \item{\code{proteinRich}}{Protein rich animal sources of protein}
#'   \item{\code{pProtein}}{Protein rich plant sources of protein}
#'   \item{\code{aProtein}}{Protein rich animal sources of protein}
#'   \item{\code{pVitA}}{Plant sources of vitamin A}
#'   \item{\code{aVitA}}{Animal sources of vitamin A}
#'   \item{\code{xVitA}}{Any source of vitamin A}
#'   \item{\code{ironRich}}{Iron rich foods}
#'   \item{\code{caRich}}{Calcium rich foods}
#'   \item{\code{znRich}}{Zinc rich foods}
#'   \item{\code{vitB1}}{Vitamin B1-rich foods}
#'   \item{\code{vitB2}}{Vitamin B2-rich foods}
#'   \item{\code{vitB3}}{Vitamin B3-rich foods}
#'   \item{\code{vitB6}}{Vitamin B6-rich foods}
#'   \item{\code{vitB12}}{Vitamin B12-rich foods}
#'   \item{\code{vitBcomplex}}{Vitamin B1/B2/B3/B6/B12-rich foods}
#'   \item{\code{HHS1}}{Little or no hunger in household}
#'   \item{\code{HHS2}}{Moderate hunger in household}
#'   \item{\code{HHS3}}{Severe hunger in household}
#'   \item{\code{ADL01}}{Bathing}
#'   \item{\code{ADL02}}{Dressing}
#'   \item{\code{ADL03}}{Toileting}
#'   \item{\code{ADL04}}{Transferring (mobility)}
#'   \item{\code{ADL05}}{Continence}
#'   \item{\code{ADL06}}{Feeding}
#'   \item{\code{scoreADL}}{ADL score}
#'   \item{\code{classADL1}}{Severity of dependence = INDEPENDENT}
#'   \item{\code{classADL2}}{Severity of dependence = PARTIAL DEPENDENCY}
#'   \item{\code{classADL3}}{Severity of dependence = SEVERE DEPENDENCY}
#'   \item{\code{hasHelp}}{Has someone to help with ADL}
#'   \item{\code{unmetNeed}}{Unmet need (dependency with NO helper)}
#'   \item{\code{K6}}{K6 score}
#'   \item{\code{K6Case}}{K6 score > 12  (in serious psychological distress)}
#'   \item{\code{DS}}{Probable dementia by CSID screen}
#'   \item{\code{H1}}{Chronic condition}
#'   \item{\code{H2}}{Takes drugs regularly for chronic condition}
#'   \item{\code{H31}}{Main reason for not taking drugs for chronic condition:
#'     No drugs available}
#'   \item{\code{H32}}{Main reason for not taking drugs for chronic condition:
#'     Too expensive / no money}
#'   \item{\code{H33}}{Main reason for not taking drugs for chronic condition:
#'     Too old to look for care}
#'   \item{\code{H34}}{Main reason for not taking drugs for chronic condition:
#'     Use traditional medicine}
#'   \item{\code{H35}}{Main reason for not taking drugs for chronic condition:
#'     Drugs don't help}
#'   \item{\code{H36}}{Main reason for not taking drugs for chronic condition:
#'     No one to help me}
#'   \item{\code{H37}}{Main reason for not taking drugs for chronic condition:
#'     No need}
#'   \item{\code{H38}}{Main reason for not taking drugs for chronic condition:
#'     Other}
#'   \item{\code{H39}}{Main reason for not taking drugs for chronic condition:
#'     No reason given}
#'   \item{\code{H4}}{Recent disease episode}
#'   \item{\code{H5}}{Accessed care for recent disease episode}
#'   \item{\code{H61}}{Main reason for not accessing care for recent disease
#'     episode: No drugs available}
#'   \item{\code{H62}}{Main reason for not accessing care for recent disease
#'     episode: Too expensive / no money}
#'   \item{\code{H63}}{Main reason for not accessing care for recent disease
#'     episode: Too old to look for care}
#'   \item{\code{H64}}{Main reason for not accessing care for recent disease
#'     episode: Use traditional medicine}
#'   \item{\code{H65}}{Main reason for not accessing care for recent disease
#'     episode: Drugs don't help}
#'   \item{\code{H66}}{Main reason for not accessing care for recent disease
#'     episode: No one to help me}
#'   \item{\code{H67}}{Main reason for not accessing care for recent disease
#'     episode: No need}
#'   \item{\code{H68}}{Main reason for not accessing care for recent disease
#'     episode: Other}
#'   \item{\code{H69}}{Main reason for not accessing care for recent disease
#'     episode: No reason given}
#'   \item{\code{M1}}{Has a personal income}
#'   \item{\code{M2A}}{Agriculture / fishing / livestock}
#'   \item{\code{M2B}}{Wages / salary}
#'   \item{\code{M2C}}{Sale of charcoal / bricks / etc}
#'   \item{\code{M2D}}{Trading (e.g. market or shop)}
#'   \item{\code{M2E}}{Investments}
#'   \item{\code{M2F}}{Spending savings / sale of assets}
#'   \item{\code{M2G}}{Charity}
#'   \item{\code{M2H}}{Cash transfer / Social security}
#'   \item{\code{M2I}}{Other}
#'   \item{\code{W1}}{Improved source of drinking water}
#'   \item{\code{W2}}{Safe drinking water (improved source OR adequate
#'     treatment)}
#'   \item{\code{W3}}{Improved sanitation facility}
#'   \item{\code{W4}}{Improved non-shared sanitation facility}
#'   \item{\code{MUAC}}{Mid-upper arm circumference (mm)}
#'   \item{\code{oedema}}{Presence of oedema}
#'   \item{\code{screened}}{Screened with oedema check and MUAC measurement in
#'     previous month}
#'   \item{\code{poorVA}}{Poor visual acuity}
#'   \item{\code{chew}}{Problems chewing food}
#'   \item{\code{food}}{Anyone in household receives a ration}
#'   \item{\code{NFRI}}{Anyone in HH received non-food relief item(s) in
#'     previous month}
#'   \item{\code{wgVisionD0}}{Vision domain 0}
#'   \item{\code{wgVisionD1}}{Vision domain 1}
#'   \item{\code{wgVisionD2}}{Vision domain 2}
#'   \item{\code{wgVisionD3}}{Vision domain 3}
#'   \item{\code{wgHearingD0}}{Hearing domain 0}
#'   \item{\code{wgHearingD1}}{Hearing domain 1}
#'   \item{\code{wgHearingD2}}{Hearing domain 2}
#'   \item{\code{wgHearingD3}}{Hearing domain 3}
#'   \item{\code{wgMobilityD0}}{Mobility domain 0}
#'   \item{\code{wgMobilityD1}}{Mobility domain 1}
#'   \item{\code{wgMobilityD2}}{Mobility domain 2}
#'   \item{\code{wgMobilityD3}}{Mobility domain 3}
#'   \item{\code{wgRememberingD0}}{Remembering domain 0}
#'   \item{\code{wgRememberingD1}}{Remembering domain 1}
#'   \item{\code{wgRememberingD2}}{Remembering domain 2}
#'   \item{\code{wgRememberingD3}}{Remembering domain 3}
#'   \item{\code{wgSelfCareD0}}{Self-care domain 0}
#'   \item{\code{wgSelfCareD1}}{Self-care domain 1}
#'   \item{\code{wgSelfCareD2}}{Self-care domain 2}
#'   \item{\code{wgSelfCareD3}}{Self-care domain 3}
#'   \item{\code{wgCommunicatingD0}}{Communicating domain 0}
#'   \item{\code{wgCommunicatingD1}}{Communicating domain 1}
#'   \item{\code{wgCommunicatingD2}}{Communicating domain 2}
#'   \item{\code{wgCommunicatingD3}}{Communicating domain 3}
#'   \item{\code{wgP0}}{Overall prevalence 0}
#'   \item{\code{wgP1}}{Overall prevalence 1}
#'   \item{\code{wgP2}}{Overall prevalence 2}
#'   \item{\code{wgP3}}{Overall prevalence 3}
#'   \item{\code{wgPM}}{Overall prevalence}
#' }
#'
#' @examples
#' indicators.ALL
#'
#' @docType data
#' @keywords dataset
#'
#'
"indicators.ALL"


################################################################################
#
#' RAM-OP Indicators Dataset - FEMALES
#'
#' Indicators dataset calculated from a dataset collected from a RAM-OP survey
#' conducted in Addis Ababa, Ethiopia in early 2014. This indicator dataset is
#' from the subset of women/females of the total sample.
#'
#' @format A data frame with 138 columns and 113 rows:
#' \describe{
#'   \item{\code{psu}}{Cluster (PSU) identifier}
#'   \item{\code{resp1}}{Respondent is SUBJECT}
#'   \item{\code{resp2}}{Respondent is FAMILY CARER}
#'   \item{\code{resp3}}{Respondent is OTHER CARER}
#'   \item{\code{resp4}}{Respondent is OTHER}
#'   \item{\code{age}}{Age of respondents (years)}
#'   \item{\code{ageGrp1}}{Age of respondent is between 50 and 59 years}
#'   \item{\code{ageGrp2}}{Age of respondent is between 60 and 69 years}
#'   \item{\code{ageGrp3}}{Age of respondent is between 70 and 79 years}
#'   \item{\code{ageGrp4}}{Age of respondent is between 80 and 89 years}
#'   \item{\code{ageGrp5}}{Age of respondent is 90 years or older}
#'   \item{\code{sex1}}{Sex = MALE}
#'   \item{\code{sex2}}{Sex = FEMALE}
#'   \item{\code{marital1}}{Marital status = SINGLE}
#'   \item{\code{marital2}}{Marital status = MARRIED}
#'   \item{\code{marital3}}{Marital status = LIVING TOGETHER}
#'   \item{\code{marital4}}{Marital status = DIVORCED}
#'   \item{\code{marital5}}{Marital status = WIDOWED}
#'   \item{\code{marital6}}{Marital status = OTHER}
#'   \item{\code{alone}}{Respondent lives alone}
#'   \item{\code{MF}}{Meal frequency}
#'   \item{\code{DDS}}{DDS (count of 11 groups)}
#'   \item{\code{FG01}}{Cereals}
#'   \item{\code{FG02}}{Roots and tubers}
#'   \item{\code{FG03}}{Fruits and vegetables}
#'   \item{\code{FG04}}{All meat}
#'   \item{\code{FG05}}{Eggs}
#'   \item{\code{FG06}}{Fish}
#'   \item{\code{FG07}}{Legumes, nuts, and seeds}
#'   \item{\code{FG08}}{Milk and milk products}
#'   \item{\code{FG09}}{Fats}
#'   \item{\code{FG10}}{Sugar}
#'   \item{\code{FG11}}{Other}
#'   \item{\code{proteinRich}}{Protein rich animal sources of protein}
#'   \item{\code{pProtein}}{Protein rich plant sources of protein}
#'   \item{\code{aProtein}}{Protein rich animal sources of protein}
#'   \item{\code{pVitA}}{Plant sources of vitamin A}
#'   \item{\code{aVitA}}{Animal sources of vitamin A}
#'   \item{\code{xVitA}}{Any source of vitamin A}
#'   \item{\code{ironRich}}{Iron rich foods}
#'   \item{\code{caRich}}{Calcium rich foods}
#'   \item{\code{znRich}}{Zinc rich foods}
#'   \item{\code{vitB1}}{Vitamin B1-rich foods}
#'   \item{\code{vitB2}}{Vitamin B2-rich foods}
#'   \item{\code{vitB3}}{Vitamin B3-rich foods}
#'   \item{\code{vitB6}}{Vitamin B6-rich foods}
#'   \item{\code{vitB12}}{Vitamin B12-rich foods}
#'   \item{\code{vitBcomplex}}{Vitamin B1/B2/B3/B6/B12-rich foods}
#'   \item{\code{HHS1}}{Little or no hunger in household}
#'   \item{\code{HHS2}}{Moderate hunger in household}
#'   \item{\code{HHS3}}{Severe hunger in household}
#'   \item{\code{ADL01}}{Bathing}
#'   \item{\code{ADL02}}{Dressing}
#'   \item{\code{ADL03}}{Toileting}
#'   \item{\code{ADL04}}{Transferring (mobility)}
#'   \item{\code{ADL05}}{Continence}
#'   \item{\code{ADL06}}{Feeding}
#'   \item{\code{scoreADL}}{ADL score}
#'   \item{\code{classADL1}}{Severity of dependence = INDEPENDENT}
#'   \item{\code{classADL2}}{Severity of dependence = PARTIAL DEPENDENCY}
#'   \item{\code{classADL3}}{Severity of dependence = SEVERE DEPENDENCY}
#'   \item{\code{hasHelp}}{Has someone to help with ADL}
#'   \item{\code{unmetNeed}}{Unmet need (dependency with NO helper)}
#'   \item{\code{K6}}{K6 score}
#'   \item{\code{K6Case}}{K6 score > 12  (in serious psychological distress)}
#'   \item{\code{DS}}{Probable dementia by CSID screen}
#'   \item{\code{H1}}{Chronic condition}
#'   \item{\code{H2}}{Takes drugs regularly for chronic condition}
#'   \item{\code{H31}}{Main reason for not taking drugs for chronic condition:
#'     No drugs available}
#'   \item{\code{H32}}{Main reason for not taking drugs for chronic condition:
#'     Too expensive / no money}
#'   \item{\code{H33}}{Main reason for not taking drugs for chronic condition:
#'     Too old to look for care}
#'   \item{\code{H34}}{Main reason for not taking drugs for chronic condition:
#'     Use traditional medicine}
#'   \item{\code{H35}}{Main reason for not taking drugs for chronic condition:
#'     Drugs don't help}
#'   \item{\code{H36}}{Main reason for not taking drugs for chronic condition:
#'     No one to help me}
#'   \item{\code{H37}}{Main reason for not taking drugs for chronic condition:
#'     No need}
#'   \item{\code{H38}}{Main reason for not taking drugs for chronic condition:
#'     Other}
#'   \item{\code{H39}}{Main reason for not taking drugs for chronic condition:
#'     No reason given}
#'   \item{\code{H4}}{Recent disease episode}
#'   \item{\code{H5}}{Accessed care for recent disease episode}
#'   \item{\code{H61}}{Main reason for not accessing care for recent disease
#'     episode: No drugs available}
#'   \item{\code{H62}}{Main reason for not accessing care for recent disease
#'     episode: Too expensive / no money}
#'   \item{\code{H63}}{Main reason for not accessing care for recent disease
#'     episode: Too old to look for care}
#'   \item{\code{H64}}{Main reason for not accessing care for recent disease
#'     episode: Use traditional medicine}
#'   \item{\code{H65}}{Main reason for not accessing care for recent disease
#'     episode: Drugs don't help}
#'   \item{\code{H66}}{Main reason for not accessing care for recent disease
#'     episode: No one to help me}
#'   \item{\code{H67}}{Main reason for not accessing care for recent disease
#'     episode: No need}
#'   \item{\code{H68}}{Main reason for not accessing care for recent disease
#'     episode: Other}
#'   \item{\code{H69}}{Main reason for not accessing care for recent disease
#'     episode: No reason given}
#'   \item{\code{M1}}{Has a personal income}
#'   \item{\code{M2A}}{Agriculture / fishing / livestock}
#'   \item{\code{M2B}}{Wages / salary}
#'   \item{\code{M2C}}{Sale of charcoal / bricks / etc}
#'   \item{\code{M2D}}{Trading (e.g. market or shop)}
#'   \item{\code{M2E}}{Investments}
#'   \item{\code{M2F}}{Spending savings / sale of assets}
#'   \item{\code{M2G}}{Charity}
#'   \item{\code{M2H}}{Cash transfer / Social security}
#'   \item{\code{M2I}}{Other}
#'   \item{\code{W1}}{Improved source of drinking water}
#'   \item{\code{W2}}{Safe drinking water (improved source OR adequate
#'     treatment)}
#'   \item{\code{W3}}{Improved sanitation facility}
#'   \item{\code{W4}}{Improved non-shared sanitation facility}
#'   \item{\code{MUAC}}{Mid-upper arm circumference (mm)}
#'   \item{\code{oedema}}{Presence of oedema}
#'   \item{\code{screened}}{Screened with oedema check and MUAC measurement in
#'     previous month}
#'   \item{\code{poorVA}}{Poor visual acuity}
#'   \item{\code{chew}}{Problems chewing food}
#'   \item{\code{food}}{Anyone in household receives a ration}
#'   \item{\code{NFRI}}{Anyone in HH received non-food relief item(s) in
#'     previous month}
#'   \item{\code{wgVisionD0}}{Vision domain 0}
#'   \item{\code{wgVisionD1}}{Vision domain 1}
#'   \item{\code{wgVisionD2}}{Vision domain 2}
#'   \item{\code{wgVisionD3}}{Vision domain 3}
#'   \item{\code{wgHearingD0}}{Hearing domain 0}
#'   \item{\code{wgHearingD1}}{Hearing domain 1}
#'   \item{\code{wgHearingD2}}{Hearing domain 2}
#'   \item{\code{wgHearingD3}}{Hearing domain 3}
#'   \item{\code{wgMobilityD0}}{Mobility domain 0}
#'   \item{\code{wgMobilityD1}}{Mobility domain 1}
#'   \item{\code{wgMobilityD2}}{Mobility domain 2}
#'   \item{\code{wgMobilityD3}}{Mobility domain 3}
#'   \item{\code{wgRememberingD0}}{Remembering domain 0}
#'   \item{\code{wgRememberingD1}}{Remembering domain 1}
#'   \item{\code{wgRememberingD2}}{Remembering domain 2}
#'   \item{\code{wgRememberingD3}}{Remembering domain 3}
#'   \item{\code{wgSelfCareD0}}{Self-care domain 0}
#'   \item{\code{wgSelfCareD1}}{Self-care domain 1}
#'   \item{\code{wgSelfCareD2}}{Self-care domain 2}
#'   \item{\code{wgSelfCareD3}}{Self-care domain 3}
#'   \item{\code{wgCommunicatingD0}}{Communicating domain 0}
#'   \item{\code{wgCommunicatingD1}}{Communicating domain 1}
#'   \item{\code{wgCommunicatingD2}}{Communicating domain 2}
#'   \item{\code{wgCommunicatingD3}}{Communicating domain 3}
#'   \item{\code{wgP0}}{Overall prevalence 0}
#'   \item{\code{wgP1}}{Overall prevalence 1}
#'   \item{\code{wgP2}}{Overall prevalence 2}
#'   \item{\code{wgP3}}{Overall prevalence 3}
#'   \item{\code{wgPM}}{Overall prevalence}
#' }
#'
#' @examples
#' indicators.FEMALES
#'
#' @docType data
#' @keywords dataset
#'
#
"indicators.FEMALES"


################################################################################
#
#' RAM-OP Indicators Dataset - MALES
#'
#' Indicators dataset calculated from a dataset collected from a RAM-OP survey
#' conducted in Addis Ababa, Ethiopia in early 2014. This indicator dataset is
#' from the subset of men/males of the total sample.
#'
#' @format A data frame with 138 columns and 113 rows:
#' \describe{
#'   \item{\code{psu}}{Cluster (PSU) identifier}
#'   \item{\code{resp1}}{Respondent is SUBJECT}
#'   \item{\code{resp2}}{Respondent is FAMILY CARER}
#'   \item{\code{resp3}}{Respondent is OTHER CARER}
#'   \item{\code{resp4}}{Respondent is OTHER}
#'   \item{\code{age}}{Age of respondents (years)}
#'   \item{\code{ageGrp1}}{Age of respondent is between 50 and 59 years}
#'   \item{\code{ageGrp2}}{Age of respondent is between 60 and 69 years}
#'   \item{\code{ageGrp3}}{Age of respondent is between 70 and 79 years}
#'   \item{\code{ageGrp4}}{Age of respondent is between 80 and 89 years}
#'   \item{\code{ageGrp5}}{Age of respondent is 90 years or older}
#'   \item{\code{sex1}}{Sex = MALE}
#'   \item{\code{sex2}}{Sex = FEMALE}
#'   \item{\code{marital1}}{Marital status = SINGLE}
#'   \item{\code{marital2}}{Marital status = MARRIED}
#'   \item{\code{marital3}}{Marital status = LIVING TOGETHER}
#'   \item{\code{marital4}}{Marital status = DIVORCED}
#'   \item{\code{marital5}}{Marital status = WIDOWED}
#'   \item{\code{marital6}}{Marital status = OTHER}
#'   \item{\code{alone}}{Respondent lives alone}
#'   \item{\code{MF}}{Meal frequency}
#'   \item{\code{DDS}}{DDS (count of 11 groups)}
#'   \item{\code{FG01}}{Cereals}
#'   \item{\code{FG02}}{Roots and tubers}
#'   \item{\code{FG03}}{Fruits and vegetables}
#'   \item{\code{FG04}}{All meat}
#'   \item{\code{FG05}}{Eggs}
#'   \item{\code{FG06}}{Fish}
#'   \item{\code{FG07}}{Legumes, nuts, and seeds}
#'   \item{\code{FG08}}{Milk and milk products}
#'   \item{\code{FG09}}{Fats}
#'   \item{\code{FG10}}{Sugar}
#'   \item{\code{FG11}}{Other}
#'   \item{\code{proteinRich}}{Protein rich animal sources of protein}
#'   \item{\code{pProtein}}{Protein rich plant sources of protein}
#'   \item{\code{aProtein}}{Protein rich animal sources of protein}
#'   \item{\code{pVitA}}{Plant sources of vitamin A}
#'   \item{\code{aVitA}}{Animal sources of vitamin A}
#'   \item{\code{xVitA}}{Any source of vitamin A}
#'   \item{\code{ironRich}}{Iron rich foods}
#'   \item{\code{caRich}}{Calcium rich foods}
#'   \item{\code{znRich}}{Zinc rich foods}
#'   \item{\code{vitB1}}{Vitamin B1-rich foods}
#'   \item{\code{vitB2}}{Vitamin B2-rich foods}
#'   \item{\code{vitB3}}{Vitamin B3-rich foods}
#'   \item{\code{vitB6}}{Vitamin B6-rich foods}
#'   \item{\code{vitB12}}{Vitamin B12-rich foods}
#'   \item{\code{vitBcomplex}}{Vitamin B1/B2/B3/B6/B12-rich foods}
#'   \item{\code{HHS1}}{Little or no hunger in household}
#'   \item{\code{HHS2}}{Moderate hunger in household}
#'   \item{\code{HHS3}}{Severe hunger in household}
#'   \item{\code{ADL01}}{Bathing}
#'   \item{\code{ADL02}}{Dressing}
#'   \item{\code{ADL03}}{Toileting}
#'   \item{\code{ADL04}}{Transferring (mobility)}
#'   \item{\code{ADL05}}{Continence}
#'   \item{\code{ADL06}}{Feeding}
#'   \item{\code{scoreADL}}{ADL score}
#'   \item{\code{classADL1}}{Severity of dependence = INDEPENDENT}
#'   \item{\code{classADL2}}{Severity of dependence = PARTIAL DEPENDENCY}
#'   \item{\code{classADL3}}{Severity of dependence = SEVERE DEPENDENCY}
#'   \item{\code{hasHelp}}{Has someone to help with ADL}
#'   \item{\code{unmetNeed}}{Unmet need (dependency with NO helper)}
#'   \item{\code{K6}}{K6 score}
#'   \item{\code{K6Case}}{K6 score > 12  (in serious psychological distress)}
#'   \item{\code{DS}}{Probable dementia by CSID screen}
#'   \item{\code{H1}}{Chronic condition}
#'   \item{\code{H2}}{Takes drugs regularly for chronic condition}
#'   \item{\code{H31}}{Main reason for not taking drugs for chronic condition:
#'     No drugs available}
#'   \item{\code{H32}}{Main reason for not taking drugs for chronic condition:
#'     Too expensive / no money}
#'   \item{\code{H33}}{Main reason for not taking drugs for chronic condition:
#'     Too old to look for care}
#'   \item{\code{H34}}{Main reason for not taking drugs for chronic condition:
#'     Use traditional medicine}
#'   \item{\code{H35}}{Main reason for not taking drugs for chronic condition:
#'     Drugs don't help}
#'   \item{\code{H36}}{Main reason for not taking drugs for chronic condition:
#'     No one to help me}
#'   \item{\code{H37}}{Main reason for not taking drugs for chronic condition:
#'     No need}
#'   \item{\code{H38}}{Main reason for not taking drugs for chronic condition:
#'     Other}
#'   \item{\code{H39}}{Main reason for not taking drugs for chronic condition:
#'     No reason given}
#'   \item{\code{H4}}{Recent disease episode}
#'   \item{\code{H5}}{Accessed care for recent disease episode}
#'   \item{\code{H61}}{Main reason for not accessing care for recent disease
#'     episode: No drugs available}
#'   \item{\code{H62}}{Main reason for not accessing care for recent disease
#'     episode: Too expensive / no money}
#'   \item{\code{H63}}{Main reason for not accessing care for recent disease
#'     episode: Too old to look for care}
#'   \item{\code{H64}}{Main reason for not accessing care for recent disease
#'     episode: Use traditional medicine}
#'   \item{\code{H65}}{Main reason for not accessing care for recent disease
#'     episode: Drugs don't help}
#'   \item{\code{H66}}{Main reason for not accessing care for recent disease
#'     episode: No one to help me}
#'   \item{\code{H67}}{Main reason for not accessing care for recent disease
#'     episode: No need}
#'   \item{\code{H68}}{Main reason for not accessing care for recent disease
#'     episode: Other}
#'   \item{\code{H69}}{Main reason for not accessing care for recent disease
#'     episode: No reason given}
#'   \item{\code{M1}}{Has a personal income}
#'   \item{\code{M2A}}{Agriculture / fishing / livestock}
#'   \item{\code{M2B}}{Wages / salary}
#'   \item{\code{M2C}}{Sale of charcoal / bricks / etc}
#'   \item{\code{M2D}}{Trading (e.g. market or shop)}
#'   \item{\code{M2E}}{Investments}
#'   \item{\code{M2F}}{Spending savings / sale of assets}
#'   \item{\code{M2G}}{Charity}
#'   \item{\code{M2H}}{Cash transfer / Social security}
#'   \item{\code{M2I}}{Other}
#'   \item{\code{W1}}{Improved source of drinking water}
#'   \item{\code{W2}}{Safe drinking water (improved source OR adequate
#'     treatment)}
#'   \item{\code{W3}}{Improved sanitation facility}
#'   \item{\code{W4}}{Improved non-shared sanitation facility}
#'   \item{\code{MUAC}}{Mid-upper arm circumference (mm)}
#'   \item{\code{oedema}}{Presence of oedema}
#'   \item{\code{screened}}{Screened with oedema check and MUAC measurement in
#'     previous month}
#'   \item{\code{poorVA}}{Poor visual acuity}
#'   \item{\code{chew}}{Problems chewing food}
#'   \item{\code{food}}{Anyone in household receives a ration}
#'   \item{\code{NFRI}}{Anyone in HH received non-food relief item(s) in
#'     previous month}
#'   \item{\code{wgVisionD0}}{Vision domain 0}
#'   \item{\code{wgVisionD1}}{Vision domain 1}
#'   \item{\code{wgVisionD2}}{Vision domain 2}
#'   \item{\code{wgVisionD3}}{Vision domain 3}
#'   \item{\code{wgHearingD0}}{Hearing domain 0}
#'   \item{\code{wgHearingD1}}{Hearing domain 1}
#'   \item{\code{wgHearingD2}}{Hearing domain 2}
#'   \item{\code{wgHearingD3}}{Hearing domain 3}
#'   \item{\code{wgMobilityD0}}{Mobility domain 0}
#'   \item{\code{wgMobilityD1}}{Mobility domain 1}
#'   \item{\code{wgMobilityD2}}{Mobility domain 2}
#'   \item{\code{wgMobilityD3}}{Mobility domain 3}
#'   \item{\code{wgRememberingD0}}{Remembering domain 0}
#'   \item{\code{wgRememberingD1}}{Remembering domain 1}
#'   \item{\code{wgRememberingD2}}{Remembering domain 2}
#'   \item{\code{wgRememberingD3}}{Remembering domain 3}
#'   \item{\code{wgSelfCareD0}}{Self-care domain 0}
#'   \item{\code{wgSelfCareD1}}{Self-care domain 1}
#'   \item{\code{wgSelfCareD2}}{Self-care domain 2}
#'   \item{\code{wgSelfCareD3}}{Self-care domain 3}
#'   \item{\code{wgCommunicatingD0}}{Communicating domain 0}
#'   \item{\code{wgCommunicatingD1}}{Communicating domain 1}
#'   \item{\code{wgCommunicatingD2}}{Communicating domain 2}
#'   \item{\code{wgCommunicatingD3}}{Communicating domain 3}
#'   \item{\code{wgP0}}{Overall prevalence 0}
#'   \item{\code{wgP1}}{Overall prevalence 1}
#'   \item{\code{wgP2}}{Overall prevalence 2}
#'   \item{\code{wgP3}}{Overall prevalence 3}
#'   \item{\code{wgPM}}{Overall prevalence}
#' }
#'
#' @examples
#' indicators.MALES
#'
#' @docType data
#' @keywords dataset
#'
#
"indicators.MALES"
