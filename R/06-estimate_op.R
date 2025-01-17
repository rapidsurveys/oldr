#'
#' Estimate all standard RAM-OP indicators
#'
#' @param x Indicators dataset produced by [create_op()] with primary sampling
#'   unit (PSU) in column named *"psu"*`
#' @param w A data frame with primary sampling unit (PSU) in column named
#'   *"psu"* and survey weight (i.e. PSU population) in column named *"pop"*.
#' @param indicators A character vector of indicator set names to estimate.
#'   Indicator set names are *"demo"*, *"anthro"*, *"food"*, *"hunger"*,
#'   *"disability"*, *"adl"*, *"mental"*, *"dementia"*, *"health"*, *"income"*, 
#'   *"wash"*, *"visual"*, and *"misc"*. Default is all indicator sets.
#' @param replicates Number of bootstrap replicates. Default is 399.
#'
#' @return A [tibble()] of boot estimates for all specified standard RAM-OP
#'   indicators
#'
#' @examples
#' estimate_op(x = create_op(testSVY), w = testPSU, replicates = 9)
#'
#' @export
#'

estimate_op <- function(x, w,
                        indicators = c("demo", "anthro", "food", 
                                       "hunger", "adl", "disability",
                                       "mental", "dementia", "health",
                                       "oedema", "screening", "income",
                                       "wash", "visual", "misc"),
                        replicates = 399) {
  ## Classic boot estimator
  classicIndicators <- indicators[indicators != "anthro"]

  ## Check if indicators more than anthro
  if(length(classicIndicators) != 0) {
    ## Bootstrap classic
    classicResults <- estimate_classic(
      x = x, w = w, indicators = classicIndicators, replicates = replicates
    )
  } else {
    ## Assign as NULL
    classicResults <- NULL
  }

  ## Check if anthro is an indicator
  if("anthro" %in% indicators) {
    ## Bootstrap probit
    probitResults <- estimate_probit(x = x, w = w, replicates = replicates)
  } else {
    ## Assign as NULL
    probitResults <- NULL
  }

  ## Concatenate results and structure
  resultsDF <- merge_op(
    x = classicResults, y = probitResults, prop2percent = TRUE
  )

  ## Convert to tibble
  resultsDF <- tibble::as_tibble(resultsDF)

  ## Return resultsDF
  resultsDF
}
