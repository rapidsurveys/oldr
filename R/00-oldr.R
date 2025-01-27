#' 
#' An Implementation of Rapid Assessment Method for Older People (RAM-OP)
#'
#' [HelpAge International](https://www.helpage.org/), VALID International, and
#' [Brixton Health](http://www.brixtonhealth.com), with financial
#' assistance from the
#' [Humanitarian Innovation Fund (HIF)](http://www.elrha.org/hif/home/), have
#' developed a **Rapid Assessment Method for Older People (RAM-OP)** that
#' provides accurate and reliable estimates of the needs of older people. The
#' method uses simple procedures, in a short time frame (i.e. about two weeks
#' including training, data collection, data entry, and data analysis), and at
#' considerably lower cost than other methods.
#'
#' The **RAM-OP** method is based on the following principles:
#'
#' * Use of a familiar *“household survey”* design employing a two-stage cluster
#' sample design optimised to allow the use of a small primary sample
#' (`m >= 16` clusters) and a small overall (`n = 192`) sample.
#'
#' * Assessment of multiple dimensions of need in older people (including
#' prevalence of global, moderate and severe acute malnutrition) using,
#' whenever possible, standard and well-tested indicators and question sets.
#'
#' * Data analysis performed using modern computer-intensive methods to allow
#' estimates of indicator levels to be made with useful precision using a small
#' sample size.
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
#' @importFrom tibble tibble as_tibble
#' @importFrom rmarkdown render
#' @importFrom cli cli_abort cli_bullets
#' @importFrom tinytex pdflatex
#'
"_PACKAGE"

## quiets concerns of R CMD check re: globalVariables
if (getRversion() >= "2.15.1") utils::globalVariables(
  c("originalOrder", "sex1", "sex2")
)

