#' 
#' Concatenate classic and PROBIT estimates into a single data.frame
#'
#' @param x Classic estimates data frame
#' @param y Probit estimates data frame
#' @param prop2percent Logical. Should proportion type indicators be converted
#'   to percentage? Default is FALSE.
#'
#' @returns A [data.frame()] of combined classic and probit estimates.
#'
#' @author Ernest Guevarra
#'
#' @examples
#' indicators <- c(
#'   "demo", "anthro", "food", "hunger", "adl", "disability",
#'   "mental", "dementia", "health", "oedema", "screening", "income",
#'   "wash", "visual", "misc"
#' )
#' 
#' classicIndicators <- indicators[indicators != "anthro"]
#' 
#' ## Bootstrap classic
#' classicEstimates <- estimate_classic(
#'   x = indicators.ALL, w = testPSU, 
#'   indicators = classicIndicators, replicates = 9
#' )
#' 
#' probitEstimates <- estimate_probit(
#'   x = indicators.ALL, w = testPSU, replicates = 9
#' )
#' 
#' merge_op(x = classicEstimates, y = probitEstimates)
#'
#' @export
#'

merge_op <- function(x, y, prop2percent = FALSE) {

  ## Merge rows
  estimates <- rbind(x, y)

  ## Merge 'estimates' data.frame and 'language' data.frame in preparation for
  ## reporting and maintaining the original row ordering of the 'language'
  ## data.frame ...
  temp <- subset(language, subset = language$INDICATOR %in% estimates$INDICATOR)

  temp$originalOrder <- seq_len(nrow(estimates))

  estimates <- merge(temp, estimates, by = "INDICATOR")
  estimates <- estimates[order(estimates$originalOrder), ]
  estimates <- subset(estimates, select = -originalOrder)

  if (prop2percent) {
    estimates$EST.ALL <- ifelse(
      estimates$TYPE == "Proportion", 
      estimates$EST.ALL * 100, 
      estimates$EST.ALL
    )
    
    estimates$LCL.ALL <- ifelse(
      estimates$TYPE == "Proportion",
      estimates$LCL.ALL * 100, 
      estimates$LCL.ALL
    )
    
    estimates$UCL.ALL <- ifelse(
      estimates$TYPE == "Proportion",
      estimates$UCL.ALL * 100,
      estimates$UCL.ALL
    )

    estimates$EST.MALES <- ifelse(
      estimates$TYPE == "Proportion",
      estimates$EST.MALES * 100, 
      estimates$EST.MALES
    )
    
    estimates$LCL.MALES <- ifelse(
      estimates$TYPE == "Proportion",
      estimates$LCL.MALES * 100, 
      estimates$LCL.MALES
    )
    
    estimates$UCL.MALES <- ifelse(
      estimates$TYPE == "Proportion",
      estimates$UCL.MALES * 100, 
      estimates$UCL.MALES
    )
    
    estimates$EST.FEMALES <- ifelse(
      estimates$TYPE == "Proportion",
      estimates$EST.FEMALES * 100, 
      estimates$EST.FEMALES
    )
    
    estimates$LCL.FEMALES <- ifelse(
      estimates$TYPE == "Proportion",
      estimates$LCL.FEMALES * 100, 
      estimates$LCL.FEMALES
    )
    
    estimates$UCL.FEMALES <- ifelse(
      estimates$TYPE == "Proportion",
      estimates$UCL.FEMALES * 100, 
      estimates$UCL.FEMALES
    )
  }

  ## Convert to tibble
  estimates <- tibble::as_tibble(estimates)

  ## Return
  estimates
}
