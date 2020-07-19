################################################################################
#
#'
#' Estimate all standard RAM-OP indicators
#'
#' @param x Indicators dataset produced by \link{create_op_all} with primary
#'     sampling unit (PSU) in column named \code{PSU}
#' @param w A data frame with primary sampling unit (PSU) in column named
#'     \code{psu} and survey weight (i.e. PSU population) in column named
#'     \code{pop}
#' @param indicators A character vector of indicator set names to estimate.
#'     Indicator set names are \code{demo}, \code{anthro}, \code{food},
#'     \code{hunger}, \code{disability}, \code{adl}, \code{mental},
#'     \code{dementia}, \code{health}, \code{income}, \code{wash},
#'     \code{visual}, and \code{misc}. Default is all indicator sets.
#' @param replicates Number of bootstrap replicates. Default is 399.
#'
#' @return Tibble of boot estimates for all specified standard RAM-OP indicators
#'
#' @examples
#' estimate_op_all(x = create_op_all(testSVY),
#'                 w = testPSU,
#'                 replicates = 9)
#'
#' @export
#'
#
################################################################################

estimate_op_all <- function(x, w,
                            indicators = c("demo", "anthro", "food", "hunger",
                                           "adl", "disability", "mental",
                                           "dementia", "health", "oedema",
                                           "screening", "income", "wash",
                                           "visual", "misc"),
                            replicates = 399) {
  ## Classic boot estimator
  classicIndicators <- indicators[indicators != "anthro"]

  ## Check if indicators more than anthro
  if(length(classicIndicators) != 0) {
    ## Bootstrap classic
    classicResults <- estimateClassic(x = x, w = w,
                                     indicators = classicIndicators,
                                     replicates = replicates)
  } else {
    ## Assign as NULL
    classicResults <- NULL
  }

  ## Check if anthro is an indicator
  if("anthro" %in% indicators) {
    ## Bootstrap probit
    probitResults <- estimateProbit(x = x, w = w, replicates = replicates)
  } else {
    ## Assign as NULL
    probitResults <- NULL
  }

  ## Concatenate results and structure
  resultsDF <- mergeEstimates(x = classicResults, y = probitResults)

  ## Convert to tibble
  resultsDF <- tibble::tibble(resultsDF)

  ## Return resultsDF
  return(resultsDF)
}
