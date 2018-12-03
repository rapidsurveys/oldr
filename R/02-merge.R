################################################################################
#
#' mergeEstimates
#'
#' Concatenate classic and PROBIT estimates into a single data.frame
#'
#' @param x Classic estimates data frame
#' @param y Probit estimates data frame
#' @return Data frame of combined classic and probit estimates
#' @examples
#'   #
#'   \dontrun{
#'   test <- mergeEstimates(x = classicEstimates,
#'                          y = probitEstimates)
#'   }
#' @export
#'
#
################################################################################

mergeEstimates <- function(x, y) {
  #
  # Merge rows
  #
  estimates <- rbind(classicEstimates, probitEstimates)
  #
  # Merge 'estimates' data.frame and 'language' data.frame in prepartion for reporting
  # and maintaining the original row ordering of the 'language' data.frame ...
  #
  language$originalOrder <- 1:nrow(estimates)
  estimates <- merge(estimates, language, by = "INDICATOR")
  estimates <- estimates[order(estimates$originalOrder), ]
  estimates <- subset(estimates, select = -originalOrder)
  return(estimates)
}
