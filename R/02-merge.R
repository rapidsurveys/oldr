################################################################################
#
#' Concatenate classic and PROBIT estimates into a single data.frame
#'
#' @param x Classic estimates data frame
#' @param y Probit estimates data frame
#' @return Data frame of combined classic and probit estimates
#' @examples
#'   #
#'   \dontrun{
#'   test <- merge_estimates(x = classicEstimates,
#'                           y = probitEstimates)
#'   }
#' @export
#'
#
################################################################################

merge_estimates <- function(x, y) {

  ## Merge rows
  estimates <- rbind(x, y)

  ## Merge 'estimates' data.frame and 'language' data.frame in prepartion for
  ## reporting and maintaining the original row ordering of the 'language'
  ## data.frame ...
  temp <- subset(language, subset = INDICATOR %in% estimates$INDICATOR)

  temp$originalOrder <- seq_len(nrow(estimates))

  estimates <- merge(temp, estimates, by = "INDICATOR")
  estimates <- estimates[order(estimates$originalOrder), ]
  estimates <- subset(estimates, select = -originalOrder)

  ## Convert to tibble
  estimates <- tibble::tibble(estimates)

  ## Return
  return(estimates)
}
