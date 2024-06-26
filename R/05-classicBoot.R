################################################################################
#
#' Function to apply bootstrap to RAM-OP indicators using a classical estimator.
#'
#' @param x Indicators dataset produced by \link{create_op_all} with primary
#'     sampling unit (PSU) in column named \code{PSU}
#' @param w A data frame with primary sampling unit (PSU) in column named
#'     \code{psu} and survey weight (i.e. PSU population) in column named
#'     \code{pop}
#' @param statistic A function operating on data in \code{x}; fixed to
#'     \link{bootClassic} function for means
#' @param indicators A character vector of indicator set names to estimate.
#'     Indicator set names are \code{demo}, \code{food}, \code{hunger},
#'     \code{disability}, \code{adl}, \code{mental}, \code{dementia},
#'     \code{health}, \code{income}, \code{wash}, \code{visual}, and \code{misc}.
#'     Default is all indicator sets.
#' @param params Parameters (named columns in \code{x}) passed to the function
#'     specified in \code{statistic}. This is equivalent to variables
#'     corresponding to the indicator sets specified in \code{indicators}. The
#'     function \link{get_variables} is used to specify these variables.
#' @param outputColumns Names of columns in output data frame. This defaults to
#'     values specified in \code{params}
#' @param replicates Number of bootstrap replicates
#'
#' @return Tibble of boot estimates using bootClassic mean function
#'
#' @examples
#'   #
#'   test <- estimate_classic(x = indicators.ALL,
#'                            w = testPSU,
#'                            replicates = 9)
#'
#'   test
#'
#' @export
#'
#
################################################################################

estimate_classic  <- function(x,
                              w,
                              statistic = bbw::bootClassic,
                              indicators = c("demo", "food", "hunger", "adl",
                                             "disability", "mental", "dementia",
                                             "health", "oedema", "screening",
                                             "income", "wash", "visual", "misc"),
                              params = get_variables(indicators),
                              outputColumns = params, replicates = 399) {
  ## Bootstrap for male values
  boot.MALES <- bbw::bootBW(x = x[x$sex1 == 1, ],
                            w = w,
                            statistic = statistic,
                            params = params,
                            outputColumns = outputColumns,
                            replicates = replicates)

  ## Get estimates from boot
  estimates.MALES <- data.frame(
    t(apply(X = boot.MALES,
            MARGIN = 2,
            FUN = quantile,
            probs = c(0.025, 0.5, 0.975), na.rm = TRUE)))

  ## Bootstrap for female values
  boot.FEMALES <- bbw::bootBW(x = x[x$sex2 == 1, ],
                              w = w,
                              statistic = statistic,
                              params = params,
                              outputColumns = outputColumns,
                              replicates = replicates)

  ## Get estimates from boot
  estimates.FEMALES <- data.frame(
    t(apply(X = boot.FEMALES,
            MARGIN = 2,
            FUN = quantile,
            probs = c(0.025, 0.5, 0.975), na.rm = TRUE)))

  ## Bootstrap for all values
  boot.ALL <- bbw::bootBW(x = x,
                          w = w,
                          statistic = statistic,
                          params = params,
                          outputColumns = outputColumns,
                          replicates = replicates)

  ## Get estimates from boot
  estimates.ALL <- data.frame(
    t(apply(X = boot.ALL,
            MARGIN = 2,
            FUN = quantile,
            probs = c(0.025, 0.5, 0.975), na.rm = TRUE)))

  ## Concatenate results
  classicEstimates <- data.frame(estimates.ALL,
                                 estimates.MALES,
                                 estimates.FEMALES)

  ## Clean-up column and row names
  classicEstimates$indicator <- row.names(classicEstimates)
  row.names(classicEstimates) <- NULL
  names(classicEstimates) <- c("LCL.ALL", "EST.ALL", "UCL.ALL",
                               "LCL.MALES", "EST.MALES", "UCL.MALES",
                               "LCL.FEMALES", "EST.FEMALES", "UCL.FEMALES",
                               "INDICATOR")

  ## Re-order columns
  classicEstimates <- classicEstimates[ , c("INDICATOR",
                                            "EST.ALL", "LCL.ALL", "UCL.ALL",
                                            "EST.MALES", "LCL.MALES", "UCL.MALES",
                                            "EST.FEMALES", "LCL.FEMALES",
                                            "UCL.FEMALES")]

  ## Convert to tibble
  classicEstimates <- tibble::tibble(classicEstimates)

  ## Return results
  classicEstimates
}
